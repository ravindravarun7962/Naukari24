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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Already logged in
                if (Session["UserId"] != null)
                {
                    RedirectUserByRole();

                    return;
                }


                // Registration success
                if (Request.QueryString["registered"] == "1")
                {
                    ShowSuccess(
                        "Your account has been created successfully. Please login."
                    );
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string email = txtEmail.Text.Trim().ToLowerInvariant();
            string password = txtPassword.Text;

            try
            {
                string query = @"SELECT TOP 1 UserId,FullName,Email,PasswordHash,UserRole,IsActive FROM Users WHERE Email = @Email";
                DataRow row =
                    Utility._GetDataRow24(query,new SqlParameter("@Email",SqlDbType.NVarChar,150)
                        {
                            Value = email
                        }
                    );


                // ==========================
                // USER NOT FOUND
                // ==========================

                if (row == null)
                {
                    ShowError("Invalid email address or password.");
                    return;
                }

                int userId = Convert.ToInt32(row["UserId"]);
                string fullName = Convert.ToString(row["FullName"]);
                string userEmail = Convert.ToString(row["Email"]);
                string passwordHash = Convert.ToString(row["PasswordHash"]);
                string userRole = Convert.ToString(row["UserRole"]);
                bool isActive = Convert.ToBoolean(row["IsActive"]);
                // ==========================
                // CHECK ACTIVE
                // ==========================

                if (!isActive)
                {
                    ShowError("Your account is currently inactive. Please contact support.");
                    return;
                }

                // ==========================
                // VERIFY PASSWORD
                // ==========================
                bool validPassword;

                try
                {
                    validPassword = BCrypt.Net.BCrypt.Verify(password,passwordHash);
                }
                catch
                {
                    validPassword = false;
                }

                if (!validPassword)
                {
                    ShowError("Invalid email address or password.");
                    return;
                }

                // ==========================
                // CREATE SESSION
                // ==========================

                Session.Clear();
                Session["UserId"] = userId;
                Session["FullName"] = fullName;
                Session["Email"] = userEmail;
                Session["UserRole"] = userRole;


                // ==========================
                // REDIRECT
                // ==========================

                RedirectUserByRole();
            }
            catch (Exception)
            {
                ShowError("Something went wrong. Please try again.");
            }

        }


        // =============================================
        // REDIRECT USER BY ROLE
        // =============================================

        private void RedirectUserByRole()
        {
            if (Session["UserRole"] == null)
            {
                Response.Redirect("~/Login.aspx",false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            string role = Session["UserRole"].ToString().Trim();
            switch (role.ToLowerInvariant())
            {
                case "jobseeker":

                    Response.Redirect("~/JobSeeker/Dashboard.aspx",false);
                    break;

                case "recruiter":

                    Response.Redirect("~/Recruiter/Dashboard.aspx",false);
                    break;

                case "admin":

                    Response.Redirect("~/Admin/Dashboard.aspx",false);
                    break;


                default:

                    Session.Clear();
                    Response.Redirect("~/Login.aspx",false);
                    break;
            }

            Context.ApplicationInstance.CompleteRequest();
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.Style["background"] = "#fff2f2";
            lblMessage.Style["color"] = "#c62828";
            lblMessage.Style["border"] = "1px solid #ffd5d5";
        }

        private void ShowSuccess(string message)
        {
            lblMessage.Text = message;
            lblMessage.Style["background"] = "#ecfdf3";
            lblMessage.Style["color"] = "#16794b";
            lblMessage.Style["border"] = "1px solid #b7ebcf";
        }

    }
}
