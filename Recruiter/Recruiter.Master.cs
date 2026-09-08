using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.Recruiter
{
    public partial class Recruiter : System.Web.UI.MasterPage
    {
        private readonly string connectionString =
           ConfigurationManager
               .ConnectionStrings[
                   "Success24Connection"
               ]
               .ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = Session["UserId"] != null;

            // Show recruiter layout only after successful login
            recruiterSidebar.Visible = isLoggedIn;
            recruiterTopbar.Visible = isLoggedIn;

            // Full width when user is not logged in
            if (!isLoggedIn)
            {
                recruiterMain.Style["margin-left"] = "0";
                recruiterMain.Style["width"] = "100%";
            }

            if (isLoggedIn && !IsPostBack)
            {
                LoadRecruiterInformation();
            }
        }

        private void LoadRecruiterInformation()
        {
            if (Session["UserId"] == null)
            {
                return;
            }


            int userId;

            if (!int.TryParse(
                Convert.ToString(
                    Session["UserId"]
                ),
                out userId))
            {
                return;
            }


            const string query = @"
                SELECT
                    FullName
                FROM Users
                WHERE UserId = @UserId;";


            try
            {
                using (
                    SqlConnection con =
                        new SqlConnection(
                            connectionString))
                using (
                    SqlCommand cmd =
                        new SqlCommand(
                            query,
                            con))
                {
                    cmd.Parameters.AddWithValue(
                        "@UserId",
                        userId
                    );

                    con.Open();


                    object result =
                        cmd.ExecuteScalar();


                    string name =
                        result == null ||
                        result == DBNull.Value
                            ? "Recruiter"
                            : Convert.ToString(
                                result
                            ).Trim();


                    if (
                        string.IsNullOrWhiteSpace(
                            name))
                    {
                        name = "Recruiter";
                    }


                    lblRecruiterName.Text =
                        Server.HtmlEncode(name);

                    lblTopRecruiterName.Text =
                        Server.HtmlEncode(name);


                    string initial =
                        name.Substring(
                            0,
                            1
                        ).ToUpper();


                    lblUserInitial.Text =
                        Server.HtmlEncode(initial);

                    lblTopInitial.Text =
                        Server.HtmlEncode(initial);
                }
            }
            catch
            {
                lblRecruiterName.Text =
                    "Recruiter";

                lblTopRecruiterName.Text =
                    "Recruiter";

                lblUserInitial.Text =
                    "R";

                lblTopInitial.Text =
                    "R";
            }
        }


      
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect(
                "~/Login.aspx"
            );
        }
    }
}