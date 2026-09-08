using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.Recruiter
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager
                .ConnectionStrings["Success24Connection"]
                .ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckRecruiter();

                LoadRecruiterProfile();

                LoadStatistics();

                LoadRecentJobs();
            }

        }
        // =========================================
        // CHECK LOGIN
        // =========================================

        private int GetRecruiterId()
        {
            if (Session["UserId"] == null)
            {
                return 0;
            }


            int userId;

            if (!int.TryParse(
                Convert.ToString(
                    Session["UserId"]),
                out userId))
            {
                return 0;
            }


            const string query = @"
                SELECT RecruiterId
                FROM RecruiterProfiles
                WHERE UserId = @UserId
                  AND IsVerified = 1;";


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
                cmd.Parameters.Add(
                    "@UserId",
                    SqlDbType.Int
                ).Value = userId;


                con.Open();


                object result =
                    cmd.ExecuteScalar();


                if (
                    result == null ||
                    result == DBNull.Value)
                {
                    return 0;
                }


                return Convert.ToInt32(result);
            }
        }


        private void CheckRecruiter()
        {
            int recruiterId =
                GetRecruiterId();


            if (recruiterId == 0)
            {
                Session.Clear();

                Response.Redirect(
                    "~/Recruiter/Login.aspx"
                );

                return;
            }


            Session["RecruiterId"] =
                recruiterId;
        }


        // =========================================
        // LOAD PROFILE
        // =========================================

        private void LoadRecruiterProfile()
        {
            if (Session["UserId"] == null)
            {
                return;
            }


            int userId =
                Convert.ToInt32(
                    Session["UserId"]
                );


            const string query = @"
                SELECT
                    U.FullName,
                    U.Email,
                    U.Mobile,
                    U.IsActive,

                    RP.Designation,
                    RP.IsVerified

                FROM Users U

                INNER JOIN RecruiterProfiles RP
                    ON U.UserId = RP.UserId

                WHERE U.UserId = @UserId
                  AND U.UserRole = 'Recruiter';";


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
                cmd.Parameters.Add(
                    "@UserId",
                    SqlDbType.Int
                ).Value = userId;


                con.Open();


                using (
                    SqlDataReader reader =
                        cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string fullName =
                            Convert.ToString(
                                reader["FullName"]
                            );


                        string designation =
                            Convert.ToString(
                                reader["Designation"]
                            );


                        string email =
                            Convert.ToString(
                                reader["Email"]
                            );


                        string mobile =
                            Convert.ToString(
                                reader["Mobile"]
                            );


                        bool isVerified =
                            Convert.ToBoolean(
                                reader["IsVerified"]
                            );


                        if (
                            string.IsNullOrWhiteSpace(
                                fullName))
                        {
                            fullName = "Recruiter";
                        }


                        if (
                            string.IsNullOrWhiteSpace(
                                designation))
                        {
                            designation = "Recruiter";
                        }


                        lblWelcomeName.Text =
                            Server.HtmlEncode(
                                fullName
                            );


                        lblProfileName.Text =
                            Server.HtmlEncode(
                                fullName
                            );


                        lblDesignation.Text =
                            Server.HtmlEncode(
                                designation
                            );


                        lblEmail.Text =
                            Server.HtmlEncode(
                                email
                            );


                        lblMobile.Text =
                            Server.HtmlEncode(
                                string.IsNullOrWhiteSpace(
                                    mobile)
                                    ? "Not provided"
                                    : mobile
                            );


                        lblVerification.Text =
                            isVerified
                                ? "Verified"
                                : "Not Verified";


                        string initial =
                            fullName.Substring(
                                0,
                                1
                            ).ToUpper();


                        lblProfileInitial.Text =
                            Server.HtmlEncode(
                                initial
                            );
                    }
                }
            }
        }


        // =========================================
        // STATISTICS
        // =========================================

        private void LoadStatistics()
        {
            int recruiterId =
                Convert.ToInt32(
                    Session["RecruiterId"]
                );


            // -------------------------------------
            // TOTAL JOBS
            // -------------------------------------

            const string totalJobsQuery = @"
                SELECT COUNT(*)
                FROM Jobs
                WHERE RecruiterId = @RecruiterId;";


            lblTotalJobs.Text =
                ExecuteCount(
                    totalJobsQuery,
                    recruiterId
                ).ToString();


            // -------------------------------------
            // ACTIVE JOBS
            // -------------------------------------

            const string activeJobsQuery = @"
                SELECT COUNT(*)
                FROM Jobs
                WHERE RecruiterId = @RecruiterId
                  AND JobStatus = 'Active';";


            lblActiveJobs.Text =
                ExecuteCount(
                    activeJobsQuery,
                    recruiterId
                ).ToString();


            // -------------------------------------
            // FEATURED JOBS
            // -------------------------------------

            const string featuredJobsQuery = @"
                SELECT COUNT(*)
                FROM Jobs
                WHERE RecruiterId = @RecruiterId
                  AND IsFeatured = 1;";


            lblFeaturedJobs.Text =
                ExecuteCount(
                    featuredJobsQuery,
                    recruiterId
                ).ToString();


            // -------------------------------------
            // APPLICATIONS
            //
            // Applications table may not yet exist.
            // Keep zero until that table is created.
            // -------------------------------------

            lblApplications.Text = "0";
        }


        private int ExecuteCount(
            string query,
            int recruiterId)
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
                cmd.Parameters.Add(
                    "@RecruiterId",
                    SqlDbType.Int
                ).Value = recruiterId;


                con.Open();


                object result =
                    cmd.ExecuteScalar();


                if (
                    result == null ||
                    result == DBNull.Value)
                {
                    return 0;
                }


                return Convert.ToInt32(
                    result
                );
            }
        }


        // =========================================
        // RECENT JOBS
        // =========================================

        private void LoadRecentJobs()
        {
            int recruiterId =
                Convert.ToInt32(
                    Session["RecruiterId"]
                );


            const string query = @"
                SELECT TOP 5

                    J.JobId,

                    J.JobTitle,

                    J.EmploymentType,

                    J.WorkMode,

                    J.City,

                    J.JobStatus,

                    J.CreatedAt,

                    C.CompanyName

                FROM Jobs J

                INNER JOIN Companies C
                    ON J.CompanyId = C.CompanyId

                WHERE J.RecruiterId = @RecruiterId

                ORDER BY
                    J.CreatedAt DESC;";


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
                cmd.Parameters.Add(
                    "@RecruiterId",
                    SqlDbType.Int
                ).Value = recruiterId;


                using (
                    SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                {
                    DataTable dt =
                        new DataTable();


                    da.Fill(dt);


                    gvRecentJobs.DataSource =
                        dt;

                    gvRecentJobs.DataBind();
                }
            }
        }


        // =========================================
        // STATUS CLASS
        // =========================================

        protected string GetStatusClass(
            object statusObject)
        {
            string status =
                Convert.ToString(
                    statusObject
                );


            if (
                string.Equals(
                    status,
                    "Active",
                    StringComparison.OrdinalIgnoreCase))
            {
                return "status status-active";
            }


            if (
                string.Equals(
                    status,
                    "Closed",
                    StringComparison.OrdinalIgnoreCase))
            {
                return "status status-closed";
            }


            return "status status-draft";
        }

    }
}