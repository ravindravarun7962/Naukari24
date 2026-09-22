using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckResetAccess();
            }

        }

        // =========================================================
        // CHECK RESET ACCESS
        // =========================================================

        private void CheckResetAccess()
        {
            if (Session["PasswordResetVerified"] == null || Session["PasswordResetUserId"] == null)
            {
                Response.Redirect("~/ForgotPassword.aspx",false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            bool verified = Convert.ToBoolean(Session["PasswordResetVerified"]);

            if (!verified)
            {
                Response.Redirect("~/ForgotPassword.aspx",false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }



        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;


            // =============================================
            // CHECK RESET SESSION
            // =============================================

            if (Session["PasswordResetVerified"] == null || Session["PasswordResetUserId"] == null)
            {
                Response.Redirect("~/ForgotPassword.aspx",false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }


            bool verified = Convert.ToBoolean(Session["PasswordResetVerified"]);
            if (!verified)
            {
                Response.Redirect("~/ForgotPassword.aspx",false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }


            int userId;

            if (!int.TryParse(Convert.ToString(Session["PasswordResetUserId"]),out userId))
            {
                ShowError("Your password reset session has expired. " + "Please start again.");
                ClearResetSession();
                return;
            }

            string newPassword = txtNewPassword.Text;

            try
            {
                // =============================================
                // VERIFY USER STILL EXISTS
                // =============================================

                const string userQuery = @"SELECT TOP 1 UserId,IsActive FROM Users WHERE UserId = @UserId;";
                DataRow userRow =
                    Utility._GetDataRow24(userQuery,new SqlParameter("@UserId",SqlDbType.Int)
                        {
                            Value = userId
                        }
                    );


                if (userRow == null)
                {
                    ShowError("Unable to reset your password. " + "Please start the process again.");
                    ClearResetSession();
                    return;
                }

                bool isActive = Convert.ToBoolean(userRow["IsActive"]);

                if (!isActive)
                {
                    ShowError("Your account is currently inactive. " + "Please contact support.");
                    ClearResetSession();
                    return;
                }


                // =============================================
                // HASH NEW PASSWORD
                // =============================================

                string passwordHash = BCrypt.Net.BCrypt.HashPassword(newPassword);

                // =============================================
                // UPDATE PASSWORD
                // =============================================

                const string updateQuery = @"UPDATE Users SET PasswordHash = @PasswordHash WHERE UserId = @UserId;";

                int affectedRows =
                    Utility.ExecuteQuery24(updateQuery,new SqlParameter("@PasswordHash",SqlDbType.NVarChar,255)
                        {
                            Value = passwordHash
                        },

                        new SqlParameter("@UserId",SqlDbType.Int)
                        {
                            Value = userId
                        }
                    );


                if (affectedRows <= 0)
                {
                    ShowError("Password could not be updated. " + "Please try again.");
                    return;
                }


                // =============================================
                // INVALIDATE ANY REMAINING RESET TOKENS
                // =============================================

                const string invalidateTokensQuery = @"UPDATE PasswordResetTokens SET IsUsed = 1 WHERE UserId = @UserId AND IsUsed = 0;";

                Utility.ExecuteQuery24(invalidateTokensQuery,new SqlParameter("@UserId",SqlDbType.Int)
                    {
                        Value = userId
                    }
                );


                // =============================================
                // CLEAR RESET SESSION
                // =============================================

                ClearResetSession();


                // =============================================
                // REDIRECT TO LOGIN
                // =============================================

                Response.Redirect("~/Login.aspx?reset=success",false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception)
            {
                ShowError("Something went wrong while resetting " + "your password. Please try again.");
            }
        }


        // =========================================================
        // CLEAR PASSWORD RESET SESSION
        // =========================================================

        private void ClearResetSession()
        {
            Session.Remove("PasswordResetEmail");
            Session.Remove("PasswordResetUserId");
            Session.Remove("PasswordResetVerified");
        }


        // =========================================================
        // ERROR MESSAGE
        // =========================================================

        private void ShowError(string message)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;
            lblMessage.Style["background"] = "#fff2f2";
            lblMessage.Style["color"] = "#c62828";
            lblMessage.Style["border"] = "1px solid #ffd5d5";
        }
    }
}