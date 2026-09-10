using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace Success24_Job_Portal.Recruiter
{
    public partial class ApplicantDetails : System.Web.UI.Page
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

                LoadApplicantDetails();
            }
        }

        // =========================================
        // CHECK RECRUITER
        // =========================================

        private int GetRecruiterId()
        {
            if (Session["UserId"] == null)
                return 0;

            int userId;

            if (!int.TryParse(
                Convert.ToString(Session["UserId"]),
                out userId))
            {
                return 0;
            }

            const string query = @"
                SELECT RecruiterId
                FROM RecruiterProfiles
                WHERE UserId = @UserId
                  AND IsVerified = 1;";


            using (SqlConnection con =
                new SqlConnection(connectionString))

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

                if (result == null ||
                    result == DBNull.Value)
                {
                    return 0;
                }

                return Convert.ToInt32(result);
            }
        }


        private void CheckRecruiter()
        {
            int recruiterId = GetRecruiterId();

            if (recruiterId == 0)
            {
                Session.Clear();

                Response.Redirect(
                    "~/Recruiter/Login.aspx"
                );

                return;
            }

            Session["RecruiterId"] = recruiterId;
        }


        // =========================================
        // LOAD APPLICANT
        // =========================================

        private void LoadApplicantDetails()
        {
            int applicationId;

            if (!int.TryParse(
                Request.QueryString["ApplicationId"],
                out applicationId))
            {
                ShowMessage(
                    "Invalid application ID.",
                    false
                );

                return;
            }


            int recruiterId =
                Convert.ToInt32(
                    Session["RecruiterId"]
                );


            const string query = @"
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

                    C.CompanyName,

                    U.FullName,
                    U.Email,
                    U.Mobile,

                    R.OriginalFileName,
                    R.FilePath

                FROM Applications A

                INNER JOIN Jobs J
                    ON A.JobId = J.JobId

                INNER JOIN Companies C
                    ON J.CompanyId = C.CompanyId

                INNER JOIN Users U
                    ON A.JobSeekerId = U.UserId

                LEFT JOIN JobSeekerResumes R
                    ON A.ResumeId = R.ResumeId

                WHERE A.ApplicationId = @ApplicationId
                  AND J.RecruiterId = @RecruiterId;";


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
                    cmd.Parameters.Add(
                        "@ApplicationId",
                        SqlDbType.Int
                    ).Value = applicationId;

                    cmd.Parameters.Add(
                        "@RecruiterId",
                        SqlDbType.Int
                    ).Value = recruiterId;


                    con.Open();


                    using (
                        SqlDataReader reader =
                            cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            ShowMessage(
                                "Application not found or you are not authorized to view it.",
                                false
                            );

                            return;
                        }


                        // =================================
                        // CANDIDATE
                        // =================================

                        string fullName =
                            GetString(
                                reader["FullName"],
                                "Candidate"
                            );


                        lblCandidateName.Text =
                            Server.HtmlEncode(
                                fullName
                            );


                        lblFullName.Text =
                            Server.HtmlEncode(
                                fullName
                            );


                        lblInitial.Text =
                            Server.HtmlEncode(
                                fullName.Substring(0, 1)
                                    .ToUpper()
                            );


                        // =================================
                        // CONTACT
                        // =================================

                        lblEmail.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader["Email"],
                                    "Not available"
                                )
                            );


                        lblCandidateEmail.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader["Email"],
                                    "Not available"
                                )
                            );


                        lblMobile.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader["Mobile"],
                                    "Not available"
                                )
                            );


                        // =================================
                        // JOB
                        // =================================

                        lblJobTitle.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader["JobTitle"],
                                    "Not specified"
                                )
                            );


                        lblCompany.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader["CompanyName"],
                                    "Not specified"
                                )
                            );


                        // =================================
                        // STATUS
                        // =================================

                        lblStatus.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader["ApplicationStatus"],
                                    "Pending"
                                )
                            );


                        // =================================
                        // APPLIED DATE
                        // =================================

                        if (
                            reader["AppliedAt"] !=
                            DBNull.Value)
                        {
                            DateTime appliedAt =
                                Convert.ToDateTime(
                                    reader["AppliedAt"]
                                );

                            lblAppliedDate.Text =
                                Server.HtmlEncode(
                                    appliedAt.ToString(
                                        "dd MMM yyyy, hh:mm tt"
                                    )
                                );
                        }
                        else
                        {
                            lblAppliedDate.Text =
                                "Not available";
                        }

                        // =================================
                        // APPLICATION TIMELINE
                        // =================================

                        // Applied
                        if (reader["AppliedAt"] != DBNull.Value)
                        {
                            DateTime appliedAt =
                                Convert.ToDateTime(
                                    reader["AppliedAt"]
                                );

                            lblAppliedTimeline.Text =
                                appliedAt.ToString(
                                    "dd MMM yyyy, hh:mm tt"
                                );
                        }


                        // Viewed
                        if (reader["ViewedAt"] != DBNull.Value)
                        {
                            DateTime viewedAt =
                                Convert.ToDateTime(
                                    reader["ViewedAt"]
                                );

                            pnlViewed.Visible = true;

                            lblViewedTimeline.Text =
                                viewedAt.ToString(
                                    "dd MMM yyyy, hh:mm tt"
                                );
                        }


                        // Shortlisted
                        if (reader["ShortlistedAt"] != DBNull.Value)
                        {
                            DateTime shortlistedAt =
                                Convert.ToDateTime(
                                    reader["ShortlistedAt"]
                                );

                            pnlShortlisted.Visible = true;

                            lblShortlistedTimeline.Text =
                                shortlistedAt.ToString(
                                    "dd MMM yyyy, hh:mm tt"
                                );
                        }


                        // Rejected
                        if (reader["RejectedAt"] != DBNull.Value)
                        {
                            DateTime rejectedAt =
                                Convert.ToDateTime(
                                    reader["RejectedAt"]
                                );

                            pnlRejected.Visible = true;

                            lblRejectedTimeline.Text =
                                rejectedAt.ToString(
                                    "dd MMM yyyy, hh:mm tt"
                                );
                        }


                        // Current status
                        lblCurrentStatusTimeline.Text =
                            GetString(
                                reader["ApplicationStatus"],
                                "Pending"
                            );

                        // =================================
                        // COVER LETTER
                        // =================================

                        string coverLetter =
                            GetString(
                                reader["CoverLetter"]
                            );


                        if (!string.IsNullOrWhiteSpace(
                            coverLetter))
                        {
                            pnlCoverLetter.Visible = true;
                            lblNoCoverLetter.Visible = false;

                            lblCoverLetter.Text =
                                Server.HtmlEncode(
                                    coverLetter
                                );
                        }
                        else
                        {
                            pnlCoverLetter.Visible = false;
                            lblNoCoverLetter.Visible = true;
                        }


                        // =================================
                        // RESUME
                        // =================================

                        string resumeName =
                            GetString(
                                reader["OriginalFileName"]
                            );


                        string resumePath =
                            GetString(
                                reader["FilePath"]
                            );


                        if (!string.IsNullOrWhiteSpace(
                            resumePath))
                        {
                            lblResumeName.Text =
                                Server.HtmlEncode(
                                    string.IsNullOrWhiteSpace(
                                        resumeName)
                                        ? "Resume"
                                        : resumeName
                                );


                            lnkResume.NavigateUrl =
                                ResolveUrl(
                                    resumePath
                                );

                            lnkResume.Visible = true;
                        }
                        else
                        {
                            lblResumeName.Text =
                                "No resume attached.";

                            lnkResume.Visible = false;
                        }
                    }
                }


                // =================================
                // BACK LINK
                // =================================

                lnkBack.NavigateUrl =
                    ResolveUrl(
                        "~/Recruiter/Applications.aspx"
                    );
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error loading applicant: " +
                    ex.Message,
                    false
                );
            }
        }


        // =========================================
        // STRING HELPER
        // =========================================

        private string GetString(
            object value,
            string defaultValue = "")
        {
            if (
                value == null ||
                value == DBNull.Value)
            {
                return defaultValue;
            }


            string text =
                Convert.ToString(value);


            return string.IsNullOrWhiteSpace(text)
                ? defaultValue
                : text.Trim();
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