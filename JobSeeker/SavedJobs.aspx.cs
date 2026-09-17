using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.JobSeeker
{
    public partial class SavedJobs : System.Web.UI.Page
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

                LoadSavedJobs();
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
                }
            );

            if (result == null || result == DBNull.Value)
            {
                return 0;
            }

            return Convert.ToInt32(result);
        }

        private void LoadSavedJobs()
        {
            string query = @"SELECT SJ.SavedJobId,SJ.JobId,SJ.SavedAt,J.JobTitle,J.EmploymentType,J.WorkMode,J.City,J.State,J.MinSalary,J.MaxSalary,J.SalaryVisible,J.ApplicationDeadline,J.JobStatus,C.CompanyName,C.CompanyLogo FROM SavedJobs SJ INNER JOIN Jobs J ON SJ.JobId = J.JobId LEFT JOIN Companies C ON J.CompanyId = C.CompanyId WHERE SJ.JobSeekerId = @JobSeekerId ORDER BY SJ.SavedAt DESC";
            DataTable dt = Utility._GetDataTable24(query,new SqlParameter("@JobSeekerId", SqlDbType.Int)
                {
                    Value = JobSeekerId
                }
            );

            if (dt.Rows.Count > 0)
            {
                rptSavedJobs.DataSource = dt;
                rptSavedJobs.DataBind();
                pnlSavedJobs.Visible = true;
                pnlEmpty.Visible = false;
            }
            else
            {
                rptSavedJobs.DataSource = null;
                rptSavedJobs.DataBind();
                pnlSavedJobs.Visible = false;
                pnlEmpty.Visible = true;
            }
        }

        protected void btnRemove_Command(object sender,CommandEventArgs e)
        {
            int savedJobId;

            if (!int.TryParse(
                Convert.ToString(e.CommandArgument),
                out savedJobId))
            {
                return;
            }

            string query = @"DELETE FROM SavedJobs WHERE SavedJobId = @SavedJobId AND JobSeekerId = @JobSeekerId";
            Utility.ExecuteQuery24(query,new SqlParameter("@SavedJobId", SqlDbType.Int)
                {
                    Value = savedJobId
                },
                new SqlParameter("@JobSeekerId", SqlDbType.Int)
                {
                    Value = JobSeekerId
                });

            LoadSavedJobs();
        }

        public string GetCompanyLogo(object logo)
        {
            string value = Convert.ToString(logo);
            if (string.IsNullOrWhiteSpace(value))
            {
                return "";
            }

            if (value.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || value.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
            {
                return value;
            }

            if (value.StartsWith("~/"))
            {
                return ResolveUrl(value);
            }

            if (value.StartsWith("/"))
            {
                return value;
            }

            return ResolveUrl("~/Uploads/CompanyLogos/" + value);
        }

        public string GetCompanyInitial(object companyName)
        {
            string name = Convert.ToString(companyName).Trim();
            if (string.IsNullOrEmpty(name))
            {
                return "C";
            }

            return name.Substring(0, 1).ToUpper();
        }

        public bool GetSalaryVisibility(object salaryVisible)
        {
            if (salaryVisible == null || salaryVisible == DBNull.Value)
            {
                return false;
            }

            bool visible;

            if (bool.TryParse(Convert.ToString(salaryVisible),out visible))
            {
                return visible;
            }

            return Convert.ToInt32(salaryVisible) == 1;
        }

        public string GetSalary(object minSalary, object maxSalary)
        {
            decimal min = 0;
            decimal max = 0;

            if (minSalary != null && minSalary != DBNull.Value)
            {
                decimal.TryParse(Convert.ToString(minSalary),out min);
            }

            if (maxSalary != null && maxSalary != DBNull.Value)
            {
                decimal.TryParse(Convert.ToString(maxSalary),out max);
            }

            if (min > 0 && max > 0)
            {
                return FormatSalary(min) + " - " + FormatSalary(max);
            }

            if (min > 0)
            {
                return FormatSalary(min);
            }

            if (max > 0)
            {
                return FormatSalary(max);
            }

            return "Not Disclosed";
        }

        private string FormatSalary(decimal salary)
        {
            if (salary >= 10000000)
            {
                return "₹" + (salary / 10000000).ToString("0.##") + " Cr";
            }

            if (salary >= 100000)
            {
                return "₹" + (salary / 100000).ToString("0.##") + " LPA";
            }

            return "₹" + salary.ToString("0");
        }

        public string FormatDate(object date)
        {
            if (date == null || date == DBNull.Value)
            {
                return "";
            }

            DateTime value;
            if (DateTime.TryParse(Convert.ToString(date),out value))
            {
                return value.ToString("dd MMM yyyy");
            }

            return Convert.ToString(date);
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
                return ResolveUrl("~/" + location + "/" + company + "/Jobs/" + title);
            }

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