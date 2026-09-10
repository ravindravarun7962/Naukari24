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
    public partial class Applications : Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["Success24Connection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckRecruiter();
                LoadJobHeader();
                LoadStatistics();

                LoadApplications();
            }
        }

        private void LoadJobHeader()
        {
            int recruiterId =
                Convert.ToInt32(
                    Session["RecruiterId"]
                );

            int jobId = 0;

            if (!string.IsNullOrWhiteSpace(
                Request.QueryString["JobId"]))
            {
                int.TryParse(
                    Request.QueryString["JobId"],
                    out jobId
                );
            }

            // Normal Applications page
            if (jobId <= 0)
            {
                lblPageTitle.Text = "Applications";
                return;
            }

            const string query = @"
        SELECT J.JobTitle
        FROM Jobs J
        WHERE J.JobId = @JobId
          AND J.RecruiterId = @RecruiterId;";

            using (
                SqlConnection con =
                    new SqlConnection(connectionString))
            using (
                SqlCommand cmd =
                    new SqlCommand(query, con))
            {
                cmd.Parameters.Add(
                    "@JobId",
                    SqlDbType.Int
                ).Value = jobId;

                cmd.Parameters.Add(
                    "@RecruiterId",
                    SqlDbType.Int
                ).Value = recruiterId;

                con.Open();

                object result =
                    cmd.ExecuteScalar();

                if (result != null &&
                    result != DBNull.Value)
                {
                    lblPageTitle.Text =
                        "Applications for: " +
                        Server.HtmlEncode(
                            Convert.ToString(result)
                        );
                }
                else
                {
                    lblPageTitle.Text =
                        "Applications";
                }
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

            // =====================================
            // GET JOB ID FROM URL
            // =====================================

            int jobId = 0;

            if (!string.IsNullOrWhiteSpace(Request.QueryString["JobId"]))
            {
                int.TryParse(
                    Request.QueryString["JobId"],
                    out jobId
                );
            }

            // =====================================
            // TOTAL APPLICATIONS
            // =====================================

            lblTotalApplications.Text =
                GetApplicationCount(
                    recruiterId,
                    jobId,
                    ""
                ).ToString();

            // =====================================
            // PENDING / NEW APPLICATIONS
            // Applied + Pending
            // =====================================

            lblPending.Text =
                GetPendingApplicationCount(
                    recruiterId,
                    jobId
                ).ToString();

            // =====================================
            // SHORTLISTED
            // =====================================

            lblShortlisted.Text =
                GetApplicationCount(
                    recruiterId,
                    jobId,
                    "Shortlisted"
                ).ToString();

            // =====================================
            // SELECTED
            // =====================================

            lblSelected.Text =
                GetApplicationCount(
                    recruiterId,
                    jobId,
                    "Selected"
                ).ToString();
        }


        private int GetApplicationCount(
            int recruiterId,
            int jobId,
            string status)
        {
            string query = @"
        SELECT COUNT(*)
        FROM Applications A

        INNER JOIN Jobs J
            ON A.JobId = J.JobId

        WHERE J.RecruiterId = @RecruiterId
    ";

            // =====================================
            // JOB FILTER
            // =====================================

            if (jobId > 0)
            {
                query += @"
            AND A.JobId = @JobId";
            }

            // =====================================
            // STATUS FILTER
            // =====================================

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

                // =====================================
                // JOB ID PARAMETER
                // =====================================

                if (jobId > 0)
                {
                    cmd.Parameters.Add(
                        "@JobId",
                        SqlDbType.Int
                    ).Value = jobId;
                }

                // =====================================
                // STATUS PARAMETER
                // =====================================

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
        // =========================================================
        // GET PENDING / NEW APPLICATION COUNT
        // =========================================================

        private int GetPendingApplicationCount(
     int recruiterId,
     int jobId)
        {
            string query = @"
        SELECT COUNT(*)
        FROM Applications A

        INNER JOIN Jobs J
            ON A.JobId = J.JobId

        WHERE J.RecruiterId = @RecruiterId

        AND
        (
            A.ApplicationStatus = 'Applied'
            OR A.ApplicationStatus = 'Pending'
        )
    ";

            // =====================================
            // JOB FILTER
            // =====================================

            if (jobId > 0)
            {
                query += @"
            AND A.JobId = @JobId";
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

                // =====================================
                // JOB ID PARAMETER
                // =====================================

                if (jobId > 0)
                {
                    cmd.Parameters.Add(
                        "@JobId",
                        SqlDbType.Int
                    ).Value = jobId;
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

            // =====================================
            // GET JOB ID FROM URL
            // =====================================

            int jobId = 0;

            if (!string.IsNullOrWhiteSpace(Request.QueryString["JobId"]))
            {
                int.TryParse(
                    Request.QueryString["JobId"],
                    out jobId
                );
            }

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
            // JOB FILTER
            // =====================================

            if (jobId > 0)
            {
                query += @"
            AND A.JobId = @JobId";
            }

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
                // =====================================
                // RECRUITER
                // =====================================

                cmd.Parameters.Add(
                    "@RecruiterId",
                    SqlDbType.Int
                ).Value = recruiterId;


                // =====================================
                // JOB ID
                // =====================================

                if (jobId > 0)
                {
                    cmd.Parameters.Add(
                        "@JobId",
                        SqlDbType.Int
                    ).Value = jobId;
                }


                // =====================================
                // STATUS
                // =====================================

                if (!string.IsNullOrWhiteSpace(status))
                {
                    cmd.Parameters.Add(
                        "@Status",
                        SqlDbType.NVarChar,
                        50
                    ).Value = status;
                }


                // =====================================
                // SEARCH
                // =====================================

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
                    "ddlStatus")
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

        private void UpdateApplicationStatus(int applicationId, string status)
        {
            int recruiterId = Convert.ToInt32(Session["RecruiterId"]);

            string connectionString =
                ConfigurationManager.ConnectionStrings["Success24Connection"].ConnectionString;

            // First verify that this application belongs to one of this recruiter's jobs
            string checkQuery = @"
        SELECT COUNT(*)
        FROM Applications A
        INNER JOIN Jobs J ON A.JobId = J.JobId
        WHERE A.ApplicationId = @ApplicationId
          AND J.RecruiterId = @RecruiterId;";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(checkQuery, con))
                {
                    cmd.Parameters.Add("@ApplicationId", SqlDbType.Int).Value = applicationId;
                    cmd.Parameters.Add("@RecruiterId", SqlDbType.Int).Value = recruiterId;

                    con.Open();

                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    if (count == 0)
                    {
                        ShowMessage("You are not authorized to update this application.", false);
                        return;
                    }
                }
            }

            // Update application status and preserve timeline dates
            string updateQuery = @"
        UPDATE Applications
        SET
            ApplicationStatus = @Status,
            UpdatedAt = SYSDATETIME(),

            ViewedAt =
                CASE
                    WHEN @Status IN
                    ('Viewed', 'Shortlisted', 'Interview',
                     'Selected', 'Hired', 'Rejected', 'Withdrawn')
                    THEN ISNULL(ViewedAt, SYSDATETIME())
                    ELSE ViewedAt
                END,

            ShortlistedAt =
                CASE
                    WHEN @Status = 'Shortlisted'
                    THEN ISNULL(ShortlistedAt, SYSDATETIME())
                    ELSE ShortlistedAt
                END,

            RejectedAt =
                CASE
                    WHEN @Status = 'Rejected'
                    THEN ISNULL(RejectedAt, SYSDATETIME())
                    ELSE RejectedAt
                END

        WHERE ApplicationId = @ApplicationId;";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.Add("@ApplicationId", SqlDbType.Int).Value = applicationId;
                    cmd.Parameters.Add("@Status", SqlDbType.NVarChar, 50).Value = status;

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        ShowMessage("Application status updated successfully.", true);

                        LoadStatistics();
                        LoadApplications();
                    }
                    else
                    {
                        ShowMessage("Unable to update application status.", false);
                    }
                }
            }
        }

        // =========================================
        // STATUS CSS
        // =========================================

        protected string GetStatusClass(string status)
        {
            switch ((status ?? "").Trim().ToLower())
            {
                case "applied":
                case "pending":
                    return "status-pending";

                case "viewed":
                    return "status-viewed";

                case "shortlisted":
                    return "status-shortlisted";

                case "interview":
                    return "status-interview";

                case "selected":
                    return "status-selected";

                case "hired":
                    return "status-hired";

                case "rejected":
                    return "status-rejected";

                case "withdrawn":
                    return "status-withdrawn";

                default:
                    return "status-pending";
            }
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

        protected void gvApplications_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (
               e.Row.RowType !=
               DataControlRowType.DataRow)
            {
                return;
            }


            DropDownList ddl =
                e.Row.FindControl(
                    "ddlStatus")
                as DropDownList;


            if (ddl == null)
            {
                return;
            }


            object value =
                DataBinder.Eval(
                    e.Row.DataItem,
                    "ApplicationStatus"
                );


            string status =
                value == null ||
                value == DBNull.Value
                    ? "Pending"
                    : Convert.ToString(value).Trim();


            // =====================================================
            // CHECK WHETHER DATABASE STATUS EXISTS IN DROPDOWN
            // =====================================================

            ListItem item =
                ddl.Items.FindByValue(status);


            if (item != null)
            {
                ddl.ClearSelection();

                item.Selected = true;
            }
            else
            {
                // Safe fallback
                ListItem pendingItem =
                    ddl.Items.FindByValue("Pending");

                if (pendingItem != null)
                {
                    ddl.ClearSelection();

                    pendingItem.Selected = true;
                }
            }
        }
    }
}
