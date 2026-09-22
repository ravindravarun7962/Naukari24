using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.JobSeeker
{
    public partial class Settings : System.Web.UI.Page
    {
        private int UserId
        {
            get
            {
                int userId;
                if (!int.TryParse(Convert.ToString(Session["UserId"]),out userId))
                {
                    return 0;
                }

                return userId;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                RedirectToLogin();
                return;
            }

            if (!string.Equals(Convert.ToString(Session["UserRole"]),"JobSeeker",StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (UserId <= 0)
                {
                    RedirectToLogin();
                    return;
                }

                LoadAccountInformation();
                LoadNotificationPreferences();
            }

        }

        private void LoadAccountInformation()
        {
            string query = @"SELECT UserId,FullName,Email,Mobile,IsActive FROM Users WHERE UserId = @UserId";
            DataRow row = Utility._GetDataRow24(query,new SqlParameter("@UserId", SqlDbType.Int)
                {
                    Value = UserId
                }
            );

            if (row == null)
            {
                RedirectToLogin();
                return;
            }

            txtFullName.Text = Convert.ToString(row["FullName"]);
            txtEmail.Text = Convert.ToString(row["Email"]);
            txtMobile.Text = Convert.ToString(row["Mobile"]);
            bool isActive = false;

            if (row["IsActive"] != DBNull.Value)
            {
                isActive = Convert.ToBoolean(row["IsActive"]);
            }

            txtAccountStatus.Text = isActive ? "Active" : "Inactive";
        }

        private void LoadNotificationPreferences()
        {
            string query = @"SELECT JobAlerts,ApplicationUpdates,InterviewNotifications FROM JobSeekerNotificationPreferences WHERE UserId = @UserId";
            DataRow row = Utility._GetDataRow24(query,new SqlParameter("@UserId", SqlDbType.Int)
                {
                    Value = UserId
                }
            );

            if (row != null)
            {
                chkJobAlerts.Checked = Convert.ToBoolean(row["JobAlerts"]);

                chkApplicationUpdates.Checked = Convert.ToBoolean(row["ApplicationUpdates"]);

                chkInterviewNotifications.Checked = Convert.ToBoolean(row["InterviewNotifications"]);
            }
            else
            {
                chkJobAlerts.Checked = true;
                chkApplicationUpdates.Checked = true;
                chkInterviewNotifications.Checked = true;
            }
        }


        protected void btnSaveAccount_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            if (string.IsNullOrWhiteSpace(fullName))
            {
                ShowMessage("Please enter your full name.",false);
                return;
            }

            string query = @"UPDATE Users SET FullName = @FullName WHERE UserId = @UserId";
            int result = Utility.ExecuteQuery24(query,new SqlParameter("@FullName",SqlDbType.NVarChar, 100)
                {
                    Value = fullName
                },
                new SqlParameter("@UserId",SqlDbType.Int)
                {
                    Value = UserId
                }
            );

            if (result > 0)
            {
                Session["FullName"] = fullName;
                ShowMessage("Account information updated successfully.",true);
                LoadAccountInformation();
            }
            else
            {
                ShowMessage("Unable to update account information.",false);
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string currentPassword = txtCurrentPassword.Text;
            string newPassword = txtNewPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (string.IsNullOrWhiteSpace(currentPassword))
            {
                ShowMessage("Please enter your current password.",false);
                return;
            }

            if (string.IsNullOrWhiteSpace(newPassword))
            {
                ShowMessage("Please enter your new password.",false);
                return;
            }

            if (newPassword.Length < 6)
            {
                ShowMessage("New password must contain at least 6 characters.",false);
                return;
            }

            if (newPassword != confirmPassword)
            {
                ShowMessage("New password and confirm password do not match.",false);
                return;
            }

            string query = @"SELECT PasswordHash FROM Users WHERE UserId = @UserId";
            object result = Utility.ExecuteScalar24(query,new SqlParameter("@UserId",SqlDbType.Int)
                {
                    Value = UserId
                }
            );

            if (result == null || result == DBNull.Value)
            {
                ShowMessage("Unable to verify your account.",false);
                return;
            }

            string passwordHash = Convert.ToString(result);
            bool isValidPassword = false;

            try
            {
                isValidPassword = BCrypt.Net.BCrypt.Verify(currentPassword,passwordHash);
            }
            catch
            {
                isValidPassword = false;
            }

            if (!isValidPassword)
            {
                ShowMessage("Current password is incorrect.",false);
                return;
            }

            string newPasswordHash = BCrypt.Net.BCrypt.HashPassword(newPassword);
            string updateQuery = @"UPDATE Users SET PasswordHash = @PasswordHash WHERE UserId = @UserId";
            int updated = Utility.ExecuteQuery24(updateQuery,new SqlParameter("@PasswordHash",SqlDbType.NVarChar, 500)
                {
                    Value = newPasswordHash
                },
                new SqlParameter("@UserId",SqlDbType.Int)
                {
                    Value = UserId
                }
            );

            if (updated > 0)
            {
                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";
                ShowMessage("Password changed successfully.",true);
            }
            else
            {
                ShowMessage("Unable to change password.",false);
            }

        }

        protected void btnSaveNotifications_Click(object sender, EventArgs e)
        {
            string checkQuery = @"SELECT COUNT(*) FROM JobSeekerNotificationPreferences WHERE UserId = @UserId";
            bool exists = Utility.Exists24(checkQuery,new SqlParameter("@UserId", SqlDbType.Int)
                {
                    Value = UserId
                }
            );

            if (exists)
            {
                string updateQuery = @"UPDATE JobSeekerNotificationPreferences SET JobAlerts = @JobAlerts, ApplicationUpdates = @ApplicationUpdates, InterviewNotifications = @InterviewNotifications, UpdatedAt = GETDATE() WHERE UserId = @UserId";
                Utility.ExecuteQuery24(updateQuery,new SqlParameter("@JobAlerts",SqlDbType.Bit)
                    {
                        Value = chkJobAlerts.Checked
                    },
                    new SqlParameter("@ApplicationUpdates",SqlDbType.Bit)
                    {
                        Value = chkApplicationUpdates.Checked
                    },
                    new SqlParameter("@InterviewNotifications",SqlDbType.Bit)
                    {
                        Value = chkInterviewNotifications.Checked
                    },
                    new SqlParameter("@UserId",SqlDbType.Int)
                    {
                        Value = UserId
                    }
                );
            }
            else
            {
                string insertQuery = @"INSERT INTO JobSeekerNotificationPreferences (UserId,JobAlerts,ApplicationUpdates,InterviewNotifications,CreatedAt) VALUES (@UserId,@JobAlerts,@ApplicationUpdates,@InterviewNotifications,GETDATE())";
                Utility.ExecuteQuery24(insertQuery,new SqlParameter("@UserId",SqlDbType.Int)
                    {
                        Value = UserId
                    },
                    new SqlParameter("@JobAlerts",SqlDbType.Bit)
                    {
                        Value = chkJobAlerts.Checked
                    },
                    new SqlParameter("@ApplicationUpdates",SqlDbType.Bit)
                    {
                        Value = chkApplicationUpdates.Checked
                    },
                    new SqlParameter("@InterviewNotifications",SqlDbType.Bit)
                    {
                        Value = chkInterviewNotifications.Checked
                    }
                );
            }

            ShowMessage("Notification preferences saved successfully.",true);
        }

        protected void btnDeactivate_Click(object sender, EventArgs e)
        {
            string query = @"UPDATE Users SET IsActive = 0 WHERE UserId = @UserId";
            int result = Utility.ExecuteQuery24(query,new SqlParameter("@UserId",SqlDbType.Int)
                {
                    Value = UserId
                }
            );

            if (result > 0)
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("~/Login.aspx?Message=AccountDeactivated");
            }
            else
            {
                ShowMessage("Unable to deactivate your account.",false);
            }
        }

        private void ShowMessage(string message,bool success)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;

            if (success)
            {
                lblMessage.CssClass = "alert alert-success alert-message d-block";
            }
            else
            {
                lblMessage.CssClass = "alert alert-danger alert-message d-block";
            }
        }

        private void RedirectToLogin()
        {
            Response.Redirect("~/Login.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.RawUrl));
        }

    }
}
