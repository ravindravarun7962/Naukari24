using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.JobSeeker
{
    public partial class Applications : System.Web.UI.Page
    {
        private int UserId
        {
            get
            {
                if (Session["UserId"] == null)
                {
                    return 0;
                }

                return Convert.ToInt32(Session["UserId"]);
            }
        }


        private int JobSeekerId
        {
            get
            {
                if (ViewState["JobSeekerId"] == null)
                {
                    return 0;
                }

                return Convert.ToInt32(ViewState["JobSeekerId"]);
            }

            set
            {
                ViewState["JobSeekerId"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            // ==========================================
            // AUTHENTICATION
            // ==========================================

            if (Session["UserId"] == null || Session["UserRole"] == null)
            {
                RedirectToLogin();

                return;
            }

            string role = Session["UserRole"].ToString().Trim();
            // ==========================================
            // AUTHORIZATION
            // ==========================================

            if (!role.Equals("JobSeeker",StringComparison.OrdinalIgnoreCase))
            {
                Session.Clear();
                Session.Abandon();
                RedirectToLogin();

                return;
            }


            if (!IsPostBack)
            {
                JobSeekerId = GetJobSeekerId();
                LoadStatistics();
                LoadApplications();
            }
        }


        // =============================================
        // JOB SEEKER ID
        // =============================================

        private int GetJobSeekerId()
        {
            if (UserId == 0)
            {
                return 0;
            }

            const string query = @"SELECT TOP 1 JobSeekerId FROM JobSeekerProfiles WHERE UserId = @UserId;";
            object result =
                Utility.ExecuteScalar24(query,new SqlParameter("@UserId",SqlDbType.Int)
                    {
                        Value = UserId
                    }
                );


            if (result == null || result == DBNull.Value)
            {
                return 0;
            }


            return Convert.ToInt32(result);
        }


        // =============================================
        // STATISTICS
        // =============================================

        private void LoadStatistics()
        {
            const string query = @"
                SELECT

                    COUNT(*) AS TotalApplications,

                    SUM(
                        CASE
                            WHEN ApplicationStatus = 'Viewed'
                            THEN 1
                            ELSE 0
                        END
                    ) AS ViewedApplications,

                    SUM(
                        CASE
                            WHEN ApplicationStatus = 'Shortlisted'
                            THEN 1
                            ELSE 0
                        END
                    ) AS ShortlistedApplications,

                    SUM(
                        CASE
                            WHEN ApplicationStatus = 'Interview'
                            THEN 1
                            ELSE 0
                        END
                    ) AS InterviewApplications

                FROM Applications

                WHERE JobSeekerId = @JobSeekerId;";


            DataRow row =
                Utility._GetDataRow24(query,new SqlParameter("@JobSeekerId",SqlDbType.Int)
                    {
                        Value = JobSeekerId
                    }
                );


            if (row == null)
            {
                lblTotalApplications.Text = "0";
                lblViewedApplications.Text = "0";
                lblShortlistedApplications.Text = "0";
                lblInterviewApplications.Text = "0";
                return;
            }

            lblTotalApplications.Text = GetIntValue(row["TotalApplications"]).ToString();
            lblViewedApplications.Text = GetIntValue(row["ViewedApplications"]).ToString();
            lblShortlistedApplications.Text = GetIntValue(row["ShortlistedApplications"]).ToString();
            lblInterviewApplications.Text = GetIntValue(row["InterviewApplications"]).ToString();
        }


        // =============================================
        // LOAD APPLICATIONS
        // =============================================

        private void LoadApplications()
        {
            string status = ddlStatus.SelectedValue;
            string query = @"SELECT A.ApplicationId,A.JobId,A.ApplicationStatus,A.AppliedAt,J.JobTitle,J.City,J.State,J.EmploymentType,J.WorkMode,C.CompanyName,C.CompanyLogo FROM Applications A INNER JOIN Jobs J ON A.JobId = J.JobId INNER JOIN Companies C ON J.CompanyId = C.CompanyId WHERE A.JobSeekerId =@JobSeekerId";
            if (!string.Equals(status,"All",StringComparison.OrdinalIgnoreCase))
            {
                query += @"
                    AND A.ApplicationStatus =
                        @ApplicationStatus";
            }


            query += @"

                ORDER BY
                    A.AppliedAt DESC;";


            if (string.Equals(status,"All",StringComparison.OrdinalIgnoreCase))
            {
                DataTable dt =
                    Utility._GetDataTable24(query,new SqlParameter("@JobSeekerId",SqlDbType.Int)
                        {
                            Value = JobSeekerId
                        }
                    );

                BindApplications(dt);
            }
            else
            {
                DataTable dt =
                    Utility._GetDataTable24(query,new SqlParameter("@JobSeekerId",SqlDbType.Int)
                        {
                            Value = JobSeekerId
                        },

                        new SqlParameter("@ApplicationStatus",SqlDbType.NVarChar,50)
                        {
                            Value = status
                        }
                    );

                BindApplications(dt);
            }
        }


        // =============================================
        // BIND APPLICATIONS
        // =============================================

        private void BindApplications(DataTable dt)
        {
            rptApplications.DataSource = dt;
            rptApplications.DataBind();
            bool hasApplications = dt != null && dt.Rows.Count > 0;
            pnlNoApplications.Visible = !hasApplications;
        }


        // =============================================
        // STATUS FILTER
        // =============================================

        protected void ddlStatus_SelectedIndexChanged(object sender,EventArgs e)
        {
            LoadApplications();
        }


        // =============================================
        // STATUS CLASS
        // =============================================

        public string GetStatusClass(string status)
        {
            if (string.IsNullOrWhiteSpace(status))
            {
                return "status-badge status-pending";
            }


            switch (status.Trim().ToLowerInvariant())
            {
                case "applied":
                    return "status-badge status-applied";

                case "viewed":
                    return "status-badge status-viewed";

                case "shortlisted":
                    return "status-badge status-shortlisted";

                case "interview":
                    return "status-badge status-interview";

                case "selected":
                    return "status-badge status-selected";

                case "hired":
                    return "status-badge status-hired";

                case "rejected":
                    return "status-badge status-rejected";

                case "withdrawn":
                    return "status-badge status-withdrawn";

                case "pending":
                    return "status-badge status-pending";

                default:
                    return "status-badge status-pending";
            }
        }


        // =============================================
        // COMPANY LOGO
        // =============================================

        public string GetCompanyLogo(object value)
        {
            string logo = Convert.ToString(value);
            if (string.IsNullOrWhiteSpace(logo))
            {
                return "";
            }

            return ResolveUrl(logo);
        }


        // =============================================
        // COMPANY INITIAL
        // =============================================

        public string GetCompanyInitial(object value)
        {
            string companyName =Convert.ToString(value);
            if (string.IsNullOrWhiteSpace(companyName))
            {
                return "C";
            }

            return Server.HtmlEncode(companyName.Trim().Substring(0, 1).ToUpper());
        }


        // =============================================
        // DATE FORMAT
        // =============================================

        public string FormatDate(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "";
            }

            DateTime date;

            if (!DateTime.TryParse(Convert.ToString(value),out date))
            {
                return "";
            }

            return Server.HtmlEncode(date.ToString("dd MMM yyyy"));
        }


        // =============================================
        // JOB URL
        // =============================================

        public string GetJobUrl(object jobId,object city,object companyName,object jobTitle)
        {
            string id = Convert.ToString(jobId);
            string cityName = Convert.ToString(city);
            string company = Convert.ToString(companyName);
            string title = Convert.ToString(jobTitle);
            if (string.IsNullOrWhiteSpace(id))
            {
                return ResolveUrl("~/Jobs.aspx");
            }


            if (string.IsNullOrWhiteSpace(cityName) || string.IsNullOrWhiteSpace(company) || string.IsNullOrWhiteSpace(title))
            {
                return ResolveUrl("~/JobDetails.aspx?JobId=" + HttpUtility.UrlEncode(id));
            }

            string citySlug = Slugify(cityName);
            string companySlug = Slugify(company);
            string titleSlug = Slugify(title);
            return ResolveUrl("~/" + citySlug + "/" + companySlug + "/Jobs/" + titleSlug);
        }


        // =============================================
        // SLUGIFY
        // =============================================

        private string Slugify(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return "";
            }

            string slug = value.Trim().ToLowerInvariant();
            slug = Regex.Replace(slug,@"[^a-z0-9]+","-");
            slug = slug.Trim('-');
            return slug;
        }


        // =============================================
        // GET INTEGER
        // =============================================

        private int GetIntValue(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return 0;
            }

            int result;

            if (int.TryParse(Convert.ToString(value),out result))
            {
                return result;
            }


            return 0;
        }

        // =============================================
        // LOGIN REDIRECT
        // =============================================

        private void RedirectToLogin()
        {
            Response.Redirect("~/Login.aspx",false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }

}
    