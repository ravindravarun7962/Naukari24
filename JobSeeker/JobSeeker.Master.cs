using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.JobSeeker
{
    public partial class JobSeeker : System.Web.UI.MasterPage
    {
        private readonly string connectionString =
           ConfigurationManager
               .ConnectionStrings["Success24Connection"]
               .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // =========================================
            // AUTHENTICATION
            // =========================================

            if (Session["UserId"] == null ||
                Session["UserRole"] == null)
            {
                RedirectToLogin();

                return;
            }


            string role =
                Session["UserRole"]
                    .ToString()
                    .Trim();


            // =========================================
            // AUTHORIZATION
            // =========================================

            if (!role.Equals(
                    "JobSeeker",
                    StringComparison.OrdinalIgnoreCase))
            {
                Session.Clear();
                Session.Abandon();

                RedirectToLogin();
                return;
            }


            if (!IsPostBack)
            {
                LoadUserInformation();

                LoadNotificationCount();

                LoadProfileCompletion();
            }
        }


        // =============================================
        // USER INFORMATION
        // =============================================

        private void LoadUserInformation()
        {
            string fullName =
                Convert.ToString(Session["FullName"]);


            if (string.IsNullOrWhiteSpace(fullName))
            {
                fullName = "User";
            }


            lblUserName.Text =
                Server.HtmlEncode(fullName);


            lblMobileUserName.Text =
                Server.HtmlEncode(fullName);


            lblUserInitial.Text =
                Server.HtmlEncode(
                    fullName.Substring(0, 1).ToUpper()
                );
        }


        // =============================================
        // NOTIFICATION COUNT
        // =============================================

        private void LoadNotificationCount()
        {
            try
            {
                int userId =
                    Convert.ToInt32(Session["UserId"]);


                string query = @"
                    SELECT COUNT(*)
                    FROM Notifications
                    WHERE UserId = @UserId
                    AND IsRead = 0";


                using (SqlConnection con =
                       new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd =
                           new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add(
                            "@UserId",
                            SqlDbType.Int
                        ).Value = userId;


                        con.Open();


                        int count =
                            Convert.ToInt32(
                                cmd.ExecuteScalar()
                            );


                        if (count > 0)
                        {
                            lblNotificationCount.Text =
                                count > 99
                                    ? "99+"
                                    : count.ToString();

                            lblNotificationCount.Visible = true;
                        }
                        else
                        {
                            lblNotificationCount.Visible = false;
                        }
                    }
                }
            }
            catch
            {
                lblNotificationCount.Visible = false;
            }
        }


        // =============================================
        // PROFILE COMPLETION
        // =============================================

        private void LoadProfileCompletion()
        {
            try
            {
                int userId =
                    Convert.ToInt32(Session["UserId"]);


                string query = @"
                    SELECT ISNULL(ProfileCompletion, 0)
                    FROM JobSeekerProfiles
                    WHERE UserId = @UserId";


                using (SqlConnection con =
                       new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd =
                           new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add(
                            "@UserId",
                            SqlDbType.Int
                        ).Value = userId;


                        con.Open();


                        object result =
                            cmd.ExecuteScalar();


                        int completion = 0;


                        if (result != null &&
                            result != DBNull.Value)
                        {
                            completion =
                                Convert.ToInt32(result);
                        }


                        // Safety
                        completion =
                            Math.Max(
                                0,
                                Math.Min(100, completion)
                            );


                        lblProfileCompletion.Text =
                            completion + "%";


                        profileProgressBar.Style["width"] =
                            completion + "%";


                        profileProgressBar.Attributes["aria-valuenow"] =
                            completion.ToString();

                        profileProgressBar.Attributes["aria-valuemin"] =
                            "0";

                        profileProgressBar.Attributes["aria-valuemax"] =
                            "100";
                    }
                }
            }
            catch
            {
                lblProfileCompletion.Text = "0%";

                profileProgressBar.Style["width"] = "0%";
            }
        }


        // =============================================
        // LOGIN REDIRECT
        // =============================================

        private void RedirectToLogin()
        {
            Response.Redirect(
                "~/Login.aspx",
                false
            );

            Context.ApplicationInstance
                .CompleteRequest();
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            RedirectToLogin();
        }
    }
    
}