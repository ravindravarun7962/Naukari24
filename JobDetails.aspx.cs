using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Success24_Job_Portal
{
    public partial class JobDetails : System.Web.UI.Page
    {
        private int JobId
        {
            get
            {
                int jobId;

                if (int.TryParse(Request.QueryString["JobId"],out jobId))
                {
                    return jobId;
                }

                return 0;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadJobDetails();
            }
        }

        // =========================================
        // LOAD JOB DETAILS
        // =========================================

        private void LoadJobDetails()
        {
            if (JobId == 0)
            {
                ShowJobNotFound();
                return;
            }


            const string query = @"SELECT TOP 1 J.JobId,J.JobTitle,J.JobDescription,J.Responsibilities,J.Requirements,J.EmploymentType,J.WorkMode,J.MinExperienceMonths,J.MaxExperienceMonths,J.MinSalary,J.MaxSalary,J.SalaryVisible,J.City,J.State,J.NumberOfOpenings,J.EducationRequirement,J.ApplicationDeadline,J.JobStatus,J.CreatedAt,C.CompanyName,C.CompanyLogo,C.Website,C.Industry,C.CompanySize,C.Description AS CompanyDescription FROM Jobs J INNER JOIN Companies C ON J.CompanyId = C.CompanyId WHERE J.JobId = @JobId AND J.JobStatus = 'Active' AND C.IsActive = 1 AND (J.ApplicationDeadline IS NULL OR J.ApplicationDeadline >= CAST(GETDATE() AS DATE));";
            try
            {
                DataRow row = Utility._GetDataRow24(query,new SqlParameter("@JobId",SqlDbType.Int)
                {
                    Value = JobId

                });

                if (row == null)
                {
                    ShowJobNotFound();
                    return;
                }


                BindJobDetails(row);
            }
            catch (Exception)
            {
                ShowJobNotFound();
            }
        }


        // =========================================
        // BIND JOB DETAILS
        // =========================================

        private void BindJobDetails(DataRow row)
        {
            pnlJobDetails.Visible = true;
            pnlJobNotFound.Visible = false;

            // -----------------------------------------
            // JOB TITLE
            // -----------------------------------------

            lblJobTitle.Text = Html(row["JobTitle"]);
            // -----------------------------------------
            // COMPANY
            // -----------------------------------------

            string companyName = GetString(row["CompanyName"]);
            lblCompanyName.Text = Html(companyName);
            lblCompanyInitial.Text =GetCompanyInitial(companyName);
            // -----------------------------------------
            // LOCATION
            // -----------------------------------------

            string location = GetLocation(row["City"],row["State"]);
            lblLocation.Text = location;
            lblSidebarLocation.Text = location;

            // -----------------------------------------
            // EXPERIENCE
            // -----------------------------------------

            string experience = GetExperience(row["MinExperienceMonths"],row["MaxExperienceMonths"]);
            lblExperience.Text = experience;
            lblSidebarExperience.Text = experience;

            // -----------------------------------------
            // SALARY
            // -----------------------------------------

            bool salaryVisible = row["SalaryVisible"] != DBNull.Value && Convert.ToBoolean(row["SalaryVisible"]);
            pnlSalary.Visible = salaryVisible;
            if (salaryVisible)
            {
                lblSalary.Text = GetSalary(row["MinSalary"],row["MaxSalary"]);
            }


            // -----------------------------------------
            // JOB DESCRIPTION
            // -----------------------------------------

            litJobDescription.Text = FormatMultilineText(row["JobDescription"]);
            // -----------------------------------------
            // RESPONSIBILITIES
            // -----------------------------------------
             
            string responsibilities = GetString(row["Responsibilities"]);
            if (string.IsNullOrWhiteSpace(responsibilities))
            {
                pnlResponsibilities.Visible =false;
            }
            else
            {
                pnlResponsibilities.Visible =true;
                litResponsibilities.Text = FormatMultilineText(responsibilities);
            }


            // -----------------------------------------
            // REQUIREMENTS
            // -----------------------------------------

            string requirements = GetString(row["Requirements"]);

            if (string.IsNullOrWhiteSpace(requirements))
            {
                pnlRequirements.Visible =false;
            }
            else
            {
                pnlRequirements.Visible =true;
                litRequirements.Text =FormatMultilineText(requirements);
            }


            // -----------------------------------------
            // EMPLOYMENT TYPE
            // -----------------------------------------

            lblEmploymentType.Text =Html(row["EmploymentType"]);

            // -----------------------------------------
            // POSTED DATE
            // -----------------------------------------

            lblPostedDate.Text =GetPostedDate(row["CreatedAt"]);
            // -----------------------------------------
            // DEADLINE
            // -----------------------------------------

            if (row["ApplicationDeadline"] == DBNull.Value)
            {
                lblDeadline.Text ="No deadline";
            }
            else
            {
                DateTime deadline =Convert.ToDateTime(row["ApplicationDeadline"]);
                lblDeadline.Text =deadline.ToString("dd MMM yyyy");
            }
        }


        // =========================================
        // JOB NOT FOUND
        // =========================================

        private void ShowJobNotFound()
        {
            pnlJobDetails.Visible =false;
            pnlJobNotFound.Visible =true;
        }


       
        // =========================================
        // COMPANY INITIAL
        // =========================================

        private string GetCompanyInitial(string companyName)
        {
            if (string.IsNullOrWhiteSpace(companyName))
            {
                return "C";
            }


            return Html(
                companyName.Substring(
                    0,
                    1
                ).ToUpper()
            );
        }


        // =========================================
        // LOCATION
        // =========================================

        private string GetLocation(object city,object state)
        {
            string cityText =GetString(city);
            string stateText =GetString(state);
            if (!string.IsNullOrWhiteSpace(cityText) && !string.IsNullOrWhiteSpace(stateText))
            {
                return Html(
                    cityText +
                    ", " +
                    stateText
                );
            }


            if (!string.IsNullOrWhiteSpace(cityText))
            {
                return Html(cityText);
            }


            if (!string.IsNullOrWhiteSpace(stateText))
            {
                return Html(stateText);
            }


            return "Not specified";
        }


        // =========================================
        // EXPERIENCE
        // =========================================

        private string GetExperience(object minValue,object maxValue)
        {
            int minMonths =GetInt(minValue);
            int maxMonths =GetInt(maxValue);
            if (minMonths == 0 && maxMonths == 0)
            {
                return "Any experience";
            }

            string min =FormatExperience(minMonths);
            string max =FormatExperience(maxMonths);

            if (minMonths > 0 && maxMonths > 0)
            {
                return
                    min +
                    " - " +
                    max;
            }


            if (minMonths > 0)
            {
                return
                    min +
                    "+";
            }


            return
                "Up to " +
                max;
        }


        private string FormatExperience(int months)
        {
            if (months < 12)
            {
                return
                    months +
                    (
                        months == 1
                            ? " month"
                            : " months"
                    );
            }


            decimal years =
                Math.Round(
                    months / 12m,
                    1
                );


            return
                years.ToString("0.#") +
                (
                    years == 1
                        ? " year"
                        : " years"
                );
        }


        // =========================================
        // SALARY
        // =========================================

        private string GetSalary(object minValue,object maxValue)
        {
            decimal min =GetDecimal(minValue);
            decimal max =GetDecimal(maxValue);


            if (min > 0 && max > 0)
            {
                return
                    FormatSalary(min)
                    +
                    " - "
                    +
                    FormatSalary(max);
            }


            if (min > 0)
            {
                return
                    FormatSalary(min)
                    +
                    "+";
            }


            if (max > 0)
            {
                return
                    "Up to "
                    +
                    FormatSalary(max);
            }


            return
                "Salary not disclosed";
        }


        private string FormatSalary(decimal salary)
        {
            if (salary >= 10000000)
            {
                return
                    "₹" +
                    (salary / 10000000m)
                        .ToString("0.##")
                    +
                    " Cr";
            }


            if (salary >= 100000)
            {
                return
                    "₹" +
                    (salary / 100000m)
                        .ToString("0.##")
                    +
                    " L";
            }


            if (salary >= 1000)
            {
                return
                    "₹" +
                    (salary / 1000m)
                        .ToString("0.##")
                    +
                    "K";
            }


            return
                "₹" +
                salary.ToString("0");
        }


        // =========================================
        // POSTED DATE
        // =========================================

        private string GetPostedDate(object dateValue)
        {
            if (dateValue == null || dateValue == DBNull.Value)
            {
                return "";
            }


            DateTime createdAt = Convert.ToDateTime(dateValue);
            TimeSpan difference =DateTime.Now -createdAt;
            if (difference.TotalMinutes < 60)
            {
                return "Posted just now";
            }


            if (difference.TotalHours < 24)
            {
                int hours =
                    (int)difference.TotalHours;


                return
                    hours +
                    (
                        hours == 1
                            ? " hour"
                            : " hours"
                    )
                    +
                    " ago";
            }


            if (difference.TotalDays < 7)
            {
                int days =
                    (int)difference.TotalDays;


                return
                    days +
                    (
                        days == 1
                            ? " day"
                            : " days"
                    )
                    +
                    " ago";
            }


            return
                "Posted " +
                createdAt.ToString(
                    "dd MMM yyyy"
                );
        }


        // =========================================
        // MULTILINE TEXT
        // =========================================

        private string FormatMultilineText(object value)
        {
            string text =GetString(value);
            if (string.IsNullOrWhiteSpace(text))
            {
                return "";
            }


            return
                Html(text)
                .Replace(
                    Environment.NewLine,
                    "<br />"
                )
                .Replace(
                    "\n",
                    "<br />"
                );
        }


        // =========================================
        // HTML ENCODE
        // =========================================

        private string Html(object value)
        {
            return Server.HtmlEncode(
                GetString(value)
            );
        }


        // =========================================
        // STRING
        // =========================================

        private string GetString(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "";
            }


            return Convert.ToString(value).Trim();
        }


        // =========================================
        // INT
        // =========================================

        private int GetInt(object value)
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


        // =========================================
        // DECIMAL
        // =========================================

        private decimal GetDecimal(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return 0;
            }

            decimal result;


            if (decimal.TryParse(Convert.ToString(value),out result))
            {
                return result;
            }


            return 0;
        }


        // =========================================
        // MESSAGE
        // =========================================

        private void ShowMessage(string message,bool success)
        {
            lblMessage.Text =
                Server.HtmlEncode(
                    message
                );


            lblMessage.CssClass =
                success
                    ? "job-message job-success"
                    : "job-message job-error";


            lblMessage.Visible =
                true;
        }

        private bool IsJobAvailable(int jobId)
        {
            const string query = @"SELECT COUNT(*) FROM Jobs J INNER JOIN Companies C ON J.CompanyId = C.CompanyId WHERE J.JobId = @JobId AND J.JobStatus = 'Active' AND C.IsActive = 1 AND (J.ApplicationDeadline IS NULL OR J.ApplicationDeadline >= CAST(GETDATE() AS DATE));";

            int count = Convert.ToInt32(Utility.ExecuteScalar24(query,new SqlParameter("@JobId",SqlDbType.Int)
                    {
                        Value = jobId
                    })
            );

            return count > 0;
        }

        private bool HasAlreadyApplied(int jobId, int jobSeekerId)
        {
            const string query = @" SELECT COUNT(1) FROM Applications WHERE JobId = @JobId AND JobSeekerId = @JobSeekerId AND ApplicationStatus <> 'Withdrawn';";

            int count = Convert.ToInt32(Utility.ExecuteScalar24(query,new SqlParameter("@JobId",SqlDbType.Int)
                    {
                        Value = jobId
                    },

                    new SqlParameter("@JobSeekerId",SqlDbType.Int)
                    {
                        Value = jobSeekerId
                    }
                )
            );


            return count > 0;
        }

        private void InsertApplication(int jobId, int jobSeekerId)
        {
            const string query = @"INSERT INTO Applications (JobId,JobSeekerId,ResumeId,CoverLetter,ApplicationStatus,AppliedAt,UpdatedAt) VALUES (@JobId,@JobSeekerId,NULL,NULL,'Applied',SYSDATETIME(),SYSDATETIME());";

            Utility.ExecuteQuery24(query,new SqlParameter("@JobId",SqlDbType.Int)
                {
                    Value = jobId
                },

                new SqlParameter("@JobSeekerId",SqlDbType.Int)
                {
                    Value = jobSeekerId
                }
            );
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            // =====================================================
            // CHECK JOB ID
            // =====================================================

            if (JobId <= 0)
            {
                ShowJobNotFound();
                return;
            }


            // =====================================================
            // CHECK LOGIN
            // =====================================================

            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Login.aspx?ReturnUrl=" +
                    Server.UrlEncode(Request.RawUrl)
                );

                return;
            }


            // =====================================================
            // GET JOB SEEKER USER ID
            // =====================================================

            int userId;

            if (!int.TryParse(Convert.ToString(Session["UserId"]),out userId))
            {
                Response.Redirect(
                    "~/Login.aspx?ReturnUrl=" +
                    Server.UrlEncode(Request.RawUrl)
                );

                return;
            }


            try
            {
                // =================================================
                // CHECK WHETHER JOB IS AVAILABLE
                // =================================================

                if (!IsJobAvailable(JobId))
                {
                    ShowMessage(
                        "This job is no longer available.",
                        false
                    );

                    btnApply.Enabled = false;
                    btnApply.Text = "Job Closed";

                    return;
                }


                // =================================================
                // CHECK ALREADY APPLIED
                // =================================================

                if (HasAlreadyApplied(JobId,userId))
                {
                    ShowMessage(
                        "You have already applied for this job.",
                        false
                    );

                    btnApply.Enabled = false;

                    btnApply.Text = "Already Applied";

                    return;
                }


                // =================================================
                // INSERT APPLICATION
                // =================================================

                InsertApplication(JobId,userId);

                // =================================================
                // SUCCESS
                // =================================================

                ShowMessage(
                    "Your application has been submitted successfully.",
                    true
                );


                btnApply.Enabled = false;
                btnApply.Text = "Applied";
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Unable to submit application: " +
                    ex.Message,
                    false
                );
            }
        }
    }
    
}