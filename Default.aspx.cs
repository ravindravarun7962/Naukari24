using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class Default : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["Success24Connection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeaturedJobs();
            }
        }

        private string CreateSlug(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
            {
                return "";
            }


            text = text.Trim();


            // Convert multiple spaces to one space
            while (text.Contains("  "))
            {
                text = text.Replace("  ", " ");
            }


            // Replace common URL characters
            text = text.Replace(".", "");
            text = text.Replace("/", "-");
            text = text.Replace("\\", "-");
            text = text.Replace("&", "and");
            text = text.Replace("+", "plus");


            // Replace spaces with hyphens
            text = text.Replace(" ", "-");


            // Remove duplicate hyphens
            while (text.Contains("--"))
            {
                text = text.Replace("--", "-");
            }


            return text.Trim('-');
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtKeyword.Text.Trim();
            string location = txtLocation.Text.Trim();

            // If both are empty
            if (string.IsNullOrWhiteSpace(keyword) &&
                string.IsNullOrWhiteSpace(location))
            {
                Response.Redirect(
                    ResolveUrl("~/Jobs.aspx")
                );

                return;
            }


            // If location is empty
            if (string.IsNullOrWhiteSpace(location))
            {
                string keywordSlug =
                    CreateSlug(keyword);

                Response.Redirect(
                    ResolveUrl(
                        "~/Jobseeker/Looking-for-" +
                        keywordSlug
                    )
                );

                return;
            }


            // If keyword is empty
            if (string.IsNullOrWhiteSpace(keyword))
            {
                string citySlug =
                    CreateSlug(location);

                Response.Redirect(
                    ResolveUrl(
                        "~/" +
                        citySlug +
                        "/Jobseeker"
                    )
                );

                return;
            }


            // Both keyword and location
            string city =
                CreateSlug(location);

            string keywordText =
                CreateSlug(keyword);


            string url =
                "~/" +
                city +
                "/Jobseeker/Looking-for-" +
                keywordText;


            Response.Redirect(
                ResolveUrl(url)
            );
        }

        // =========================================================
        // LOAD FEATURED / LATEST JOBS
        // =========================================================

        private void LoadFeaturedJobs()
        {
            const string query = @" SELECT TOP 6 J.JobId,J.JobTitle,J.EmploymentType,J.WorkMode,J.MinExperienceMonths,J.MaxExperienceMonths,J.MinSalary,J.MaxSalary,J.SalaryVisible,J.City,J.State,J.CreatedAt,C.CompanyName,JC.CategoryName FROM Jobs J INNER JOIN Companies C ON J.CompanyId = C.CompanyId LEFT JOIN JobCategories JC ON J.CategoryId = JC.CategoryId WHERE J.JobStatus = 'Active' AND C.IsActive = 1 AND (J.ApplicationDeadline IS NULL OR J.ApplicationDeadline >=CAST(GETDATE() AS DATE)) ORDER BY J.CreatedAt DESC;";
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    DataTable dt = new DataTable();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }

                    rptFeaturedJobs.DataSource = dt;
                    rptFeaturedJobs.DataBind();
                    pnlNoFeaturedJobs.Visible = dt.Rows.Count == 0;
                }
            }
            catch (Exception)
            {
                rptFeaturedJobs.DataSource = null;
                rptFeaturedJobs.DataBind();
                pnlNoFeaturedJobs.Visible = true;
            }
        }


        // =========================================================
        // COMPANY INITIAL
        // =========================================================

        protected string GetCompanyInitial(object value)
        {
            string companyName =
                Convert.ToString(value).Trim();


            if (string.IsNullOrWhiteSpace(companyName))
            {
                return "C";
            }


            return Server.HtmlEncode(companyName.Substring(0, 1).ToUpper());
        }


        // =========================================================
        // LOCATION
        // =========================================================

        protected string GetLocation(object city,object state)
        {
            string cityText = Convert.ToString(city).Trim();
            string stateText = Convert.ToString(state).Trim();
            if (!string.IsNullOrWhiteSpace(cityText) && !string.IsNullOrWhiteSpace(stateText))
            {
                return Server.HtmlEncode(
                    cityText +
                    ", " +
                    stateText
                );
            }


            if (!string.IsNullOrWhiteSpace(cityText))
            {
                return Server.HtmlEncode(cityText);
            }


            if (!string.IsNullOrWhiteSpace(stateText))
            {
                return Server.HtmlEncode(stateText);
            }


            return "Not specified";
        }


        // =========================================================
        // EXPERIENCE
        // =========================================================

        protected string GetExperience(object minValue,object maxValue)
        {
            int minMonths = GetInt(minValue);
            int maxMonths = GetInt(maxValue);
            if (minMonths == 0 && maxMonths == 0)
            {
                return "Fresher";
            }


            if (minMonths > 0 && maxMonths > 0)
            {
                return
                    FormatExperience(minMonths)
                    +
                    " - "
                    +
                    FormatExperience(maxMonths);
            }


            if (minMonths > 0)
            {
                return
                    FormatExperience(minMonths)
                    +
                    "+";
            }


            return
                "Up to " +
                FormatExperience(maxMonths);
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
                years.ToString("0.#")
                +
                (
                    years == 1
                        ? " year"
                        : " years"
                );
        }


        // =========================================================
        // SALARY
        // =========================================================

        protected string GetSalary(object minValue,object maxValue)
        {
            decimal min =
                GetDecimal(minValue);


            decimal max =
                GetDecimal(maxValue);


            if (
                min > 0 &&
                max > 0
            )
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
                    "Up to " +
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


        // =========================================================
        // POSTED DATE
        // =========================================================

        protected string GetPostedDate(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "";
            }


            DateTime createdAt = Convert.ToDateTime(value);
            TimeSpan difference = DateTime.Now -createdAt;

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
                int days = (int)difference.TotalDays;
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


        // =========================================================
        // INTEGER
        // =========================================================

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


        // =========================================================
        // DECIMAL
        // =========================================================

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

    }
}