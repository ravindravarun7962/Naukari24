using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class JobDetails : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager
                .ConnectionStrings["Success24Connection"]
                .ConnectionString;


        private int JobId
        {
            get
            {
                int jobId;

                if (int.TryParse(
                    Request.QueryString["JobId"],
                    out jobId))
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


            const string query = @"
                SELECT TOP 1

                    J.JobId,
                    J.JobTitle,
                    J.JobDescription,
                    J.Responsibilities,
                    J.Requirements,
                    J.EmploymentType,
                    J.WorkMode,

                    J.MinExperienceMonths,
                    J.MaxExperienceMonths,

                    J.MinSalary,
                    J.MaxSalary,
                    J.SalaryVisible,

                    J.City,
                    J.State,

                    J.NumberOfOpenings,
                    J.EducationRequirement,

                    J.ApplicationDeadline,
                    J.JobStatus,
                    J.CreatedAt,

                    C.CompanyName,
                    C.CompanyLogo,
                    C.Website,
                    C.Industry,
                    C.CompanySize,
                    C.Description AS CompanyDescription

                FROM Jobs J

                INNER JOIN Companies C
                    ON J.CompanyId = C.CompanyId

                WHERE J.JobId = @JobId

                  AND J.JobStatus = 'Active'

                  AND C.IsActive = 1

                  AND
                  (
                      J.ApplicationDeadline IS NULL

                      OR

                      J.ApplicationDeadline >=
                          CAST(GETDATE() AS DATE)
                  );";


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
                        "@JobId",
                        SqlDbType.Int
                    ).Value = JobId;


                    con.Open();


                    using (
                        SqlDataReader reader =
                            cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            ShowJobNotFound();
                            return;
                        }


                        BindJobDetails(reader);
                    }
                }
            }
            catch (Exception)
            {
                ShowJobNotFound();
            }
        }


        // =========================================
        // BIND JOB DETAILS
        // =========================================

        private void BindJobDetails(
            SqlDataReader reader)
        {
            pnlJobDetails.Visible = true;
            pnlJobNotFound.Visible = false;


            // -----------------------------------------
            // JOB TITLE
            // -----------------------------------------

            lblJobTitle.Text =
                Html(
                    reader["JobTitle"]
                );


            // -----------------------------------------
            // COMPANY
            // -----------------------------------------

            string companyName =
                GetString(
                    reader["CompanyName"]
                );


            lblCompanyName.Text =
                Html(companyName);


            lblCompanyInitial.Text =
                GetCompanyInitial(
                    companyName
                );


            // -----------------------------------------
            // LOCATION
            // -----------------------------------------

            string location =
                GetLocation(
                    reader["City"],
                    reader["State"]
                );


            lblLocation.Text =
                location;


            lblSidebarLocation.Text =
                location;


            // -----------------------------------------
            // EXPERIENCE
            // -----------------------------------------

            string experience =
                GetExperience(
                    reader["MinExperienceMonths"],
                    reader["MaxExperienceMonths"]
                );


            lblExperience.Text =
                experience;


            lblSidebarExperience.Text =
                experience;


            // -----------------------------------------
            // SALARY
            // -----------------------------------------

            bool salaryVisible =
                reader["SalaryVisible"] !=
                DBNull.Value
                &&
                Convert.ToBoolean(
                    reader["SalaryVisible"]
                );


            pnlSalary.Visible =
                salaryVisible;


            if (salaryVisible)
            {
                lblSalary.Text =
                    GetSalary(
                        reader["MinSalary"],
                        reader["MaxSalary"]
                    );
            }


            // -----------------------------------------
            // JOB DESCRIPTION
            // -----------------------------------------

            litJobDescription.Text =
                FormatMultilineText(
                    reader["JobDescription"]
                );


            // -----------------------------------------
            // RESPONSIBILITIES
            // -----------------------------------------

            string responsibilities =
                GetString(
                    reader["Responsibilities"]
                );


            if (
                string.IsNullOrWhiteSpace(
                    responsibilities))
            {
                pnlResponsibilities.Visible =
                    false;
            }
            else
            {
                pnlResponsibilities.Visible =
                    true;

                litResponsibilities.Text =
                    FormatMultilineText(
                        responsibilities
                    );
            }


            // -----------------------------------------
            // REQUIREMENTS
            // -----------------------------------------

            string requirements =
                GetString(
                    reader["Requirements"]
                );


            if (
                string.IsNullOrWhiteSpace(
                    requirements))
            {
                pnlRequirements.Visible =
                    false;
            }
            else
            {
                pnlRequirements.Visible =
                    true;

                litRequirements.Text =
                    FormatMultilineText(
                        requirements
                    );
            }


            // -----------------------------------------
            // EMPLOYMENT TYPE
            // -----------------------------------------

            lblEmploymentType.Text =
                Html(
                    reader["EmploymentType"]
                );


            // -----------------------------------------
            // POSTED DATE
            // -----------------------------------------

            lblPostedDate.Text =
                GetPostedDate(
                    reader["CreatedAt"]
                );


            // -----------------------------------------
            // DEADLINE
            // -----------------------------------------

            if (
                reader["ApplicationDeadline"] ==
                DBNull.Value)
            {
                lblDeadline.Text =
                    "No deadline";
            }
            else
            {
                DateTime deadline =
                    Convert.ToDateTime(
                        reader["ApplicationDeadline"]
                    );

                lblDeadline.Text =
                    deadline.ToString(
                        "dd MMM yyyy"
                    );
            }
        }


        // =========================================
        // JOB NOT FOUND
        // =========================================

        private void ShowJobNotFound()
        {
            pnlJobDetails.Visible =
                false;

            pnlJobNotFound.Visible =
                true;
        }


       
        // =========================================
        // COMPANY INITIAL
        // =========================================

        private string GetCompanyInitial(
            string companyName)
        {
            if (
                string.IsNullOrWhiteSpace(
                    companyName))
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

        private string GetLocation(
            object city,
            object state)
        {
            string cityText =
                GetString(city);


            string stateText =
                GetString(state);


            if (
                !string.IsNullOrWhiteSpace(
                    cityText)
                &&
                !string.IsNullOrWhiteSpace(
                    stateText))
            {
                return Html(
                    cityText +
                    ", " +
                    stateText
                );
            }


            if (
                !string.IsNullOrWhiteSpace(
                    cityText))
            {
                return Html(cityText);
            }


            if (
                !string.IsNullOrWhiteSpace(
                    stateText))
            {
                return Html(stateText);
            }


            return "Not specified";
        }


        // =========================================
        // EXPERIENCE
        // =========================================

        private string GetExperience(
            object minValue,
            object maxValue)
        {
            int minMonths =
                GetInt(minValue);


            int maxMonths =
                GetInt(maxValue);


            if (
                minMonths == 0 &&
                maxMonths == 0)
            {
                return "Any experience";
            }


            string min =
                FormatExperience(
                    minMonths
                );


            string max =
                FormatExperience(
                    maxMonths
                );


            if (
                minMonths > 0 &&
                maxMonths > 0)
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


        private string FormatExperience(
            int months)
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

        private string GetSalary(
            object minValue,
            object maxValue)
        {
            decimal min =
                GetDecimal(minValue);


            decimal max =
                GetDecimal(maxValue);


            if (
                min > 0 &&
                max > 0)
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


        private string FormatSalary(
            decimal salary)
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

        private string GetPostedDate(
            object dateValue)
        {
            if (
                dateValue == null ||
                dateValue == DBNull.Value)
            {
                return "";
            }


            DateTime createdAt =
                Convert.ToDateTime(
                    dateValue
                );


            TimeSpan difference =
                DateTime.Now -
                createdAt;


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

        private string FormatMultilineText(
            object value)
        {
            string text =
                GetString(value);


            if (
                string.IsNullOrWhiteSpace(
                    text))
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

        private string Html(
            object value)
        {
            return Server.HtmlEncode(
                GetString(value)
            );
        }


        // =========================================
        // STRING
        // =========================================

        private string GetString(
            object value)
        {
            if (
                value == null ||
                value == DBNull.Value)
            {
                return "";
            }


            return Convert
                .ToString(value)
                .Trim();
        }


        // =========================================
        // INT
        // =========================================

        private int GetInt(
            object value)
        {
            if (
                value == null ||
                value == DBNull.Value)
            {
                return 0;
            }


            int result;


            if (
                int.TryParse(
                    Convert.ToString(value),
                    out result))
            {
                return result;
            }


            return 0;
        }


        // =========================================
        // DECIMAL
        // =========================================

        private decimal GetDecimal(
            object value)
        {
            if (
                value == null ||
                value == DBNull.Value)
            {
                return 0;
            }


            decimal result;


            if (
                decimal.TryParse(
                    Convert.ToString(value),
                    out result))
            {
                return result;
            }


            return 0;
        }


        // =========================================
        // MESSAGE
        // =========================================

        private void ShowMessage(
            string message,
            bool success)
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
    

        protected void btnApply_Click(object sender, EventArgs e)
        {
            if (JobId == 0)
            {
                ShowJobNotFound();
                return;
            }

            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Login.aspx?ReturnUrl=" +
                    Server.UrlEncode(Request.RawUrl)
                );
                return;
            }

            int userId;

            if (!int.TryParse(Session["UserId"].ToString(), out userId))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["Success24Connection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Check whether user already applied
                string checkQuery = @"
            SELECT COUNT(1)
            FROM Applications
            WHERE JobId = @JobId
              AND JobSeekerId = @JobSeekerId";

                using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.AddWithValue("@JobId", JobId);
                    checkCmd.Parameters.AddWithValue("@JobSeekerId", userId);

                    int alreadyApplied = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (alreadyApplied > 0)
                    {
                        ShowMessage(
                            "You have already applied for this job.",
                            false
                        );
                        return;
                    }
                }

                // Insert application
                string insertQuery = @"
            INSERT INTO Applications
            (
                JobId,
                JobSeekerId,
                ApplicationStatus,
                AppliedAt
            )
            VALUES
            (
                @JobId,
                @JobSeekerId,
                'Applied',
                GETDATE()
            )";

                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@JobId", JobId);
                    cmd.Parameters.AddWithValue("@JobSeekerId", userId);

                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        ShowMessage(
                            "Your application has been submitted successfully.",
                            true
                        );
                    }
                    else
                    {
                        ShowMessage(
                            "Unable to submit your application. Please try again.",
                            false
                        );
                    }
                }
            }
        }
    }
}