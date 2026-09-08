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
    public partial class Applications : System.Web.UI.Page
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

                LoadStatistics();

                LoadApplications();
            }
        }

        // =========================================
        // CHECK RECRUITER LOGIN
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
        // LOAD STATISTICS
        // =========================================

        private void LoadStatistics()
        {
            int recruiterId =
                Convert.ToInt32(
                    Session["RecruiterId"]
                );


            // TOTAL

            lblTotalApplications.Text =
                GetApplicationCount(
                    recruiterId,
                    ""
                ).ToString();


            // PENDING

            lblPending.Text =
                GetApplicationCount(
                    recruiterId,
                    "Pending"
                ).ToString();


            // SHORTLISTED

            lblShortlisted.Text =
                GetApplicationCount(
                    recruiterId,
                    "Shortlisted"
                ).ToString();


            // SELECTED

            lblSelected.Text =
                GetApplicationCount(
                    recruiterId,
                    "Selected"
                ).ToString();
        }


        private int GetApplicationCount(
            int recruiterId,
            string status)
        {
            string query = @"
                SELECT COUNT(*)
                FROM Applications A

                INNER JOIN Jobs J
                    ON A.JobId = J.JobId

                WHERE J.RecruiterId = @RecruiterId
            ";


            if (!string.IsNullOrWhiteSpace(status))
            {
                query += @"
                    AND A.ApplicationStatus = @Status";
            }


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


                if (!string.IsNullOrWhiteSpace(status))
                {
                    cmd.Parameters.Add(
                        "@Status",
                        SqlDbType.NVarChar,
                        50
                    ).Value = status;
                }


                con.Open();


                return Convert.ToInt32(
                    cmd.ExecuteScalar()
                );
            }
        }


        // =========================================
        // LOAD APPLICATIONS
        // =========================================

        private void LoadApplications()
        {
            int recruiterId =
                Convert.ToInt32(
                    Session["RecruiterId"]
                );


            string search =
                txtSearch.Text.Trim();


            string status =
                ddlStatus.SelectedValue;


            string query = @"
                SELECT

                    A.ApplicationId,

                    A.JobId,

                    A.JobSeekerId,

                    A.ResumeId,

                    A.CoverLetter,

                    A.ApplicationStatus,

                    A.AppliedAt,

                    A.ViewedAt,

                    A.ShortlistedAt,

                    A.RejectedAt,

                    A.UpdatedAt,

                    J.JobTitle,

                    J.City AS JobCity,

                    J.State AS JobState,

                    C.CompanyName,

                    U.FullName,

                    U.Email,

                    U.Mobile

                FROM Applications A

                INNER JOIN Jobs J
                    ON A.JobId = J.JobId

                INNER JOIN Companies C
                    ON J.CompanyId = C.CompanyId

                INNER JOIN Users U
                    ON A.JobSeekerId = U.UserId

                WHERE J.RecruiterId = @RecruiterId
            ";


            // =====================================
            // STATUS FILTER
            // =====================================

            if (!string.IsNullOrWhiteSpace(status))
            {
                query += @"
                    AND A.ApplicationStatus = @Status";
            }


            // =====================================
            // SEARCH
            // =====================================

            if (!string.IsNullOrWhiteSpace(search))
            {
                query += @"
                    AND
                    (
                        U.FullName LIKE @Search
                        OR U.Email LIKE @Search
                        OR J.JobTitle LIKE @Search
                        OR C.CompanyName LIKE @Search
                    )";
            }


            query += @"
                ORDER BY
                    A.AppliedAt DESC;";


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


                if (!string.IsNullOrWhiteSpace(status))
                {
                    cmd.Parameters.Add(
                        "@Status",
                        SqlDbType.NVarChar,
                        50
                    ).Value = status;
                }


                if (!string.IsNullOrWhiteSpace(search))
                {
                    cmd.Parameters.Add(
                        "@Search",
                        SqlDbType.NVarChar,
                        300
                    ).Value =
                        "%" + search + "%";
                }


                using (
                    SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                {
                    DataTable dt =
                        new DataTable();


                    da.Fill(dt);


                    gvApplications.DataSource =
                        dt;

                    gvApplications.DataBind();
                }
            }
        }



        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadApplications();

        }

        protected void gvApplications_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (
                e.CommandName !=
                "UpdateStatus")
            {
                return;
            }


            int applicationId;


            if (!int.TryParse(
                Convert.ToString(
                    e.CommandArgument),
                out applicationId))
            {
                ShowMessage(
                    "Invalid application.",
                    false
                );

                return;
            }


            GridViewRow row =
                (GridViewRow)
                ((Control)e.CommandSource)
                .NamingContainer;


            DropDownList ddl =
                row.FindControl(
                    "ddlApplicationStatus")
                    as DropDownList;


            if (ddl == null)
            {
                ShowMessage(
                    "Unable to find application status.",
                    false
                );

                return;
            }


            string newStatus =
                ddl.SelectedValue;


            UpdateApplicationStatus(
                applicationId,
                newStatus
            );
        }


        // =========================================
        // UPDATE STATUS IN DATABASE
        // =========================================

        private void UpdateApplicationStatus(
            int applicationId,
            string newStatus)
        {
            int recruiterId =
                Convert.ToInt32(
                    Session["RecruiterId"]
                );


            try
            {
                const string verifyQuery = @"
                    SELECT COUNT(*)

                    FROM Applications A

                    INNER JOIN Jobs J
                        ON A.JobId = J.JobId

                    WHERE A.ApplicationId =
                          @ApplicationId

                      AND J.RecruiterId =
                          @RecruiterId;";


                using (
                    SqlConnection con =
                        new SqlConnection(
                            connectionString))
                {
                    con.Open();


                    // =================================
                    // SECURITY CHECK
                    // =================================

                    using (
                        SqlCommand verifyCmd =
                            new SqlCommand(
                                verifyQuery,
                                con))
                    {
                        verifyCmd.Parameters.Add(
                            "@ApplicationId",
                            SqlDbType.Int
                        ).Value =
                            applicationId;


                        verifyCmd.Parameters.Add(
                            "@RecruiterId",
                            SqlDbType.Int
                        ).Value =
                            recruiterId;


                        int exists =
                            Convert.ToInt32(
                                verifyCmd.ExecuteScalar()
                            );


                        if (exists == 0)
                        {
                            ShowMessage(
                                "You are not authorized to update this application.",
                                false
                            );

                            return;
                        }
                    }


                    // =================================
                    // UPDATE QUERY
                    // =================================

                    string updateQuery = @"
                        UPDATE Applications

                        SET
                            ApplicationStatus =
                                @Status,

                            UpdatedAt =
                                SYSDATETIME(),

                            ViewedAt =
                                CASE
                                    WHEN @Status <> 'Pending'
                                    THEN
                                        ISNULL(
                                            ViewedAt,
                                            SYSDATETIME()
                                        )
                                    ELSE
                                        ViewedAt
                                END,

                            ShortlistedAt =
                                CASE
                                    WHEN @Status = 'Shortlisted'
                                    THEN
                                        SYSDATETIME()

                                    ELSE
                                        ShortlistedAt
                                END,

                            RejectedAt =
                                CASE
                                    WHEN @Status = 'Rejected'
                                    THEN
                                        SYSDATETIME()

                                    ELSE
                                        RejectedAt
                                END

                        WHERE ApplicationId =
                              @ApplicationId;";


                    using (
                        SqlCommand cmd =
                            new SqlCommand(
                                updateQuery,
                                con))
                    {
                        cmd.Parameters.Add(
                            "@ApplicationId",
                            SqlDbType.Int
                        ).Value =
                            applicationId;


                        cmd.Parameters.Add(
                            "@Status",
                            SqlDbType.NVarChar,
                            50
                        ).Value =
                            newStatus;


                        cmd.ExecuteNonQuery();
                    }
                }


                ShowMessage(
                    "Application status updated successfully.",
                    true
                );


                LoadStatistics();

                LoadApplications();
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Unable to update application: " +
                    ex.Message,
                    false
                );
            }
        }


        // =========================================
        // STATUS CSS
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
                    "Pending",
                    StringComparison.OrdinalIgnoreCase))
            {
                return "status status-pending";
            }


            if (
                string.Equals(
                    status,
                    "Shortlisted",
                    StringComparison.OrdinalIgnoreCase))
            {
                return "status status-shortlisted";
            }


            if (
                string.Equals(
                    status,
                    "Interview",
                    StringComparison.OrdinalIgnoreCase))
            {
                return "status status-interview";
            }


            if (
                string.Equals(
                    status,
                    "Selected",
                    StringComparison.OrdinalIgnoreCase))
            {
                return "status status-selected";
            }


            if (
                string.Equals(
                    status,
                    "Rejected",
                    StringComparison.OrdinalIgnoreCase))
            {
                return "status status-rejected";
            }


            return "status status-withdrawn";
        }


        // =========================================
        // MESSAGE
        // =========================================

        private void ShowMessage(
            string message,
            bool success)
        {
            lblMessage.Text =
                Server.HtmlEncode(message);

            lblMessage.Visible = true;

            lblMessage.CssClass =
                success
                    ? "message success"
                    : "message error";
        }

    }
}
