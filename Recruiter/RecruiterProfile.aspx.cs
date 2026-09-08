using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;


namespace Success24_Job_Portal.Recruiter
{
    public partial class RecruiterProfile : Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["Success24Connection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Recruiter/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadRecruiterProfile();
            }
        }

        // =========================================
        // LOAD PROFILE
        // =========================================

        private void LoadRecruiterProfile()
        {
            int userId;
            if (!int.TryParse(Convert.ToString(Session["UserId"]),out userId))
            {
                Response.Redirect("~/Recruiter/Login.aspx");

                return;
            }


            const string query = @"SELECT U.UserId,U.FullName,U.Email,U.Mobile, R.RecruiterId,R.Designation,R.ProfilePhoto,R.IsVerified FROM Users U INNER JOIN RecruiterProfiles R ON U.UserId = R.UserId WHERE U.UserId = @UserId AND U.UserRole = 'Recruiter';";
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query,con))
                {
                    cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = userId;
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            Response.Redirect("~/Recruiter/Login.aspx");
                            return;
                        }


                        // =================================
                        // BASIC DATA
                        // =================================

                        string fullName = GetString(reader["FullName"],"Recruiter");
                        string email = GetString(reader["Email"],"Not available");
                        string mobile = GetString(reader["Mobile"],"Not added");
                        string designation = GetString(reader["Designation"],"Recruiter");

                        // =================================
                        // HEADER
                        // =================================

                        lblFullName.Text = Server.HtmlEncode(fullName);
                        lblDesignation.Text = Server.HtmlEncode(designation);
                        lblEmail.Text = Server.HtmlEncode(email);
                        lblMobile.Text = Server.HtmlEncode(mobile);
                        // =================================
                        // CONTACT INFORMATION
                        // =================================

                        lblInfoName.Text = Server.HtmlEncode(fullName);
                        lblInfoEmail.Text = Server.HtmlEncode(email);
                        lblInfoMobile.Text = Server.HtmlEncode(mobile);
                        lblInfoDesignation.Text = Server.HtmlEncode(designation);
                        // =================================
                        // RECRUITER ID
                        // =================================

                        lblRecruiterId.Text = Convert.ToString(reader["RecruiterId"]);

                        // =================================
                        // ACCOUNT STATUS
                        // =================================

                        bool isVerified = reader["IsVerified"] !=DBNull.Value && Convert.ToBoolean(reader["IsVerified"]);
                        if (isVerified)
                        {
                            lblAccountStatus.Text = "Verified";
                        }
                        else
                        {
                            lblAccountStatus.Text = "Pending Verification";
                        }

                        pnlVerified.Visible = isVerified;

                        // =================================
                        // PROFILE PHOTO
                        // =================================

                        string photo = GetString(reader["ProfilePhoto"]);
                        if (!string.IsNullOrWhiteSpace(
                            photo))
                        {
                            imgProfile.ImageUrl = ResolveUrl(photo);
                            imgProfile.Visible = true;
                            lblInitial.Visible = false;
                        }
                        else
                        {
                            imgProfile.Visible = false;

                            lblInitial.Text =
                                Server.HtmlEncode(
                                    fullName
                                        .Substring(
                                            0,
                                            1
                                        )
                                        .ToUpper()
                                );

                            lblInitial.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(
                    "<div style='padding:20px;color:red;background:#fff;'>" +
                    "<h3>Profile Error</h3>" +
                    "<pre>" +
                    Server.HtmlEncode(
                        ex.ToString()
                    ) +
                    "</pre>" +
                    "</div>"
                );
            }
        }


        // =========================================
        // GET STRING
        // =========================================

        private string GetString(object value,string defaultValue = "")
        {
            if (value == null || value == DBNull.Value)
            {
                return defaultValue;
            }

            string text = Convert.ToString(value);
            return string.IsNullOrWhiteSpace(text)? defaultValue: text.Trim();
        }

    }
}