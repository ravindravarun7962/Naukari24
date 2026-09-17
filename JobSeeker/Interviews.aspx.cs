using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.JobSeeker
{
    public partial class Interviews : Page
    {
        private int JobSeekerId
        {
            get
            {
                if (ViewState["JobSeekerId"] == null)
                {
                    int id = GetJobSeekerId();
                    if (id > 0)
                    {
                        ViewState["JobSeekerId"] = id;
                    }

                    return id;
                }

                return Convert.ToInt32(ViewState["JobSeekerId"]);
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
                int jobSeekerId = JobSeekerId;

                if (jobSeekerId <= 0)
                {
                    RedirectToLogin();
                    return;
                }

                LoadInterviews();
            }

        }
        private int GetJobSeekerId()
        {
            int userId;

            if (!int.TryParse(Convert.ToString(Session["UserId"]),out userId))
            {
                return 0;
            }
             
            string query = @"SELECT JobSeekerId FROM JobSeekerProfiles WHERE UserId = @UserId";
            object result = Utility.ExecuteScalar24(query,new SqlParameter("@UserId", SqlDbType.Int)
                {
                    Value = userId
                });

            if (result == null || result == DBNull.Value)
            {
                return 0;
            }

            return Convert.ToInt32(result);
        }

        private void LoadInterviews()
        {
            string query = @"SELECT I.InterviewId,I.ApplicationId,I.InterviewType,I.InterviewDate,I.InterviewMode,I.MeetingLink,I.Location,I.Instructions,I.InterviewStatus,I.Feedback,I.CreatedAt,I.UpdatedAt,A.JobId,J.JobTitle,J.EmploymentType,J.WorkMode,J.City,J.State,C.CompanyName,C.CompanyLogo FROM Interviews I INNER JOIN Applications A ON I.ApplicationId = A.ApplicationId INNER JOIN Jobs J ON A.JobId = J.JobId LEFT JOIN Companies C ON J.CompanyId = C.CompanyId WHERE A.JobSeekerId = @JobSeekerId ORDER BY CASE WHEN I.InterviewDate >= GETDATE() THEN 0 ELSE 1 END, I.InterviewDate ASC";
            DataTable dt = Utility._GetDataTable24(query,new SqlParameter("@JobSeekerId", SqlDbType.Int)
                {
                    Value = JobSeekerId
                }
            );

            if (dt.Rows.Count > 0)
            {
                rptInterviews.DataSource = dt;
                rptInterviews.DataBind();
                pnlInterviews.Visible = true;
                pnlEmpty.Visible = false;
            }
            else
            {
                rptInterviews.DataSource = null;
                rptInterviews.DataBind();
                pnlInterviews.Visible = false;
                pnlEmpty.Visible = true;
            }
        }

        public string GetMonth(object date)
        {
            DateTime value;

            if (DateTime.TryParse(Convert.ToString(date),out value))
            {
                return value.ToString("MMM");
            }

            return "";
        }

        public string GetDay(object date)
        {
            DateTime value;
            if (DateTime.TryParse(Convert.ToString(date),out value))
            {
                return value.ToString("dd");
            }

            return "";
        }

        public string GetYear(object date)
        {
            DateTime value;
            if (DateTime.TryParse(Convert.ToString(date),out value))
            {
                return value.ToString("yyyy");
            }

            return "";
        }

        public string FormatDate(object date)
        {
            DateTime value;

            if (DateTime.TryParse(Convert.ToString(date),out value))
            {
                return value.ToString("dd MMM yyyy");
            }

            return "";
        }

        public string FormatTime(object date)
        {
            DateTime value;

            if (DateTime.TryParse(Convert.ToString(date),out value))
            {
                return value.ToString("hh:mm tt");
            }

            return "";
        }

        public string GetInterviewLocation(object location)
        {
            string value = Convert.ToString(location);

            if (string.IsNullOrWhiteSpace(value))
            {
                return "Online";
            }

            return value;
        }

        public string GetStatusClass(object status)
        {
            string value = Convert.ToString(status);
            if (string.IsNullOrWhiteSpace(value))
            {
                return "status-pending";
            }

            switch (value.ToLowerInvariant())
            {
                case "scheduled":
                    return "status-scheduled";

                case "completed":
                    return "status-completed";

                case "cancelled":
                case "canceled":
                    return "status-cancelled";

                case "selected":
                    return "status-selected";

                case "rejected":
                    return "status-rejected";

                case "pending":
                    return "status-pending";

                default:
                    return "status-pending";
            }
        }

        public bool HasInterviewLink(object link)
        {
            string value = Convert.ToString(link);
            return !string.IsNullOrWhiteSpace(value);
        }

        public string GetInterviewLink(object link)
        {
            string value = Convert.ToString(link);
            if (string.IsNullOrWhiteSpace(value))
            {
                return "#";
            }

            if (value.StartsWith("http://",StringComparison.OrdinalIgnoreCase) || value.StartsWith("https://",StringComparison.OrdinalIgnoreCase))
            {
                return value;
            }

            return ResolveUrl(value);
        }

        public string GetJobUrl(object jobId,object jobTitle,object companyName,object city)
        {
            int id = 0;

            int.TryParse(Convert.ToString(jobId),out id);
            string title = Slugify(Convert.ToString(jobTitle));
            string company = Slugify(Convert.ToString(companyName));
            string location = Slugify(Convert.ToString(city));

            if (id > 0 && !string.IsNullOrEmpty(title) && !string.IsNullOrEmpty(company) && !string.IsNullOrEmpty(location))
            {
                return ResolveUrl("~/" + location + "/" + company + "/Jobs/" + title);            }

            return ResolveUrl("~/JobDetails.aspx?JobId=" + id);
        }

        private string Slugify(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return "";
            }

            value = value.Trim().ToLowerInvariant();
            value = Regex.Replace(value,@"[^a-z0-9\s-]","");
            value = Regex.Replace(value,@"\s+","-");
            value = Regex.Replace(value,@"-+","-");
            return value.Trim('-');
        }

        private void RedirectToLogin()
        {
            Response.Redirect("~/Login.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.RawUrl));
        }

    }
}