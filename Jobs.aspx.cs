using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class Jobs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadJobs();
            }
        }

        // =========================================
        // LOAD CATEGORIES
        // =========================================
        private void LoadCategories()
        {
            ddlSearchCategory.Items.Clear();
            ddlSearchCategory.Items.Add(
                new ListItem(
                    "All Categories",
                    ""
                )
            );

            const string query = @"SELECT CategoryId,CategoryName FROM JobCategories WHERE IsActive = 1 ORDER BY CategoryName;";
            DataTable dt = Utility._GetDataTable24(query);                                               
            foreach (DataRow row in dt.Rows)
            {
                ddlSearchCategory.Items.Add(
                    new ListItem(
                        Convert.ToString(row["CategoryName"]),
                        Convert.ToString(row["CategoryId"])
                    )
                );
            }
        }


        private string CreateCompanySlug(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
                return "";

            text = text.Trim();
            System.Text.StringBuilder result = new System.Text.StringBuilder();
            foreach (char c in text)
            {
                if (char.IsLetterOrDigit(c))
                {
                    result.Append(c);
                }
                else if (c == ' ' || c == '_' || c == '-')
                {
                    if (result.Length > 0 && result[result.Length - 1] != '_')
                    {
                        result.Append('_');
                    }
                }
            }

            return result.ToString().Trim('_');
        }


        private string CreatePositionSlug(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
                return "";

            text = text.Trim();
            System.Text.StringBuilder result = new System.Text.StringBuilder();
            foreach (char c in text)
            {
                if (char.IsLetterOrDigit(c))
                {
                    result.Append(c);
                }
                else if (c == ' ' || c == '-' || c == '_')
                {
                    if (result.Length > 0 && result[result.Length - 1] != '-')
                    {
                        result.Append('-');
                    }
                }
            }

            return result.ToString().Trim('-');
        }


        private string CreateCitySlug(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
                return "";

            return text.Trim().Replace(" ", "-");
        }


        protected string GetJobDetailsUrl(
            object cityObject,
            object stateObject,
            object companyObject,
            object jobTitleObject)
        {
            return Utility.GetJobDetailsUrl(
                Convert.ToString(cityObject),
                Convert.ToString(companyObject),
                Convert.ToString(jobTitleObject)
            );
        }

        // =========================================
        // LOAD JOBS
        // =========================================

        private void LoadJobs()
        {
            string search = txtSearch.Text.Trim();
            string location = txtLocation.Text.Trim();
            string category = ddlSearchCategory.SelectedValue;
            string employmentType = ddlEmploymentType.SelectedValue;
            string workMode = ddlWorkMode.SelectedValue;
            string experience = ddlExperience.SelectedValue;
            int categoryId = 0;
            int experienceMonths = 0;
            if (!string.IsNullOrEmpty(category))
            {
                int.TryParse(category,out categoryId);
            }


            if (!string.IsNullOrEmpty(experience))
            {
                int.TryParse(experience,out experienceMonths);
            }

            const string query = @"SELECT J.JobId,J.JobTitle,J.EmploymentType,J.WorkMode,J.MinExperienceMonths,J.MaxExperienceMonths,J.MinSalary,J.MaxSalary,J.SalaryVisible,J.City,J.State,J.CreatedAt,C.CompanyName,JC.CategoryName FROM Jobs J INNER JOIN Companies C ON J.CompanyId = C.CompanyId LEFT JOIN JobCategories JC ON J.CategoryId = JC.CategoryId WHERE J.JobStatus = 'Active' AND C.IsActive = 1 AND (J.ApplicationDeadline IS NULL OR J.ApplicationDeadline >=CAST(GETDATE() AS DATE)) AND (@Search = '' OR J.JobTitle LIKE '%' + @Search + '%' OR J.JobDescription LIKE '%' + @Search + '%' OR J.Requirements LIKE '%' + @Search + '%' OR C.CompanyName LIKE '%' + @Search + '%' ) AND (@Location = '' OR J.City LIKE '%' + @Location + '%' OR J.State LIKE '%' + @Location + '%') AND (@CategoryId = 0 OR J.CategoryId = @CategoryId) AND (@EmploymentType = '' OR J.EmploymentType =@EmploymentType ) AND (@WorkMode = '' OR J.WorkMode =@WorkMode) AND (@ExperienceMonths = 0 OR J.MaxExperienceMonths >=@ExperienceMonths) ORDER BY J.CreatedAt DESC;";
            DataTable dt =Utility._GetDataTable24(query,new SqlParameter("@Search",SqlDbType.NVarChar,200)
                    {
                        Value = search
                    },

                    new SqlParameter("@Location",SqlDbType.NVarChar,100)
                    {
                        Value = location
                    },

                    new SqlParameter("@CategoryId",SqlDbType.Int)
                    {
                        Value = categoryId
                    },

                    new SqlParameter("@EmploymentType",SqlDbType.NVarChar,50)
                    {
                        Value = employmentType
                    },

                    new SqlParameter("@WorkMode",SqlDbType.NVarChar,50)
                    {
                        Value = workMode
                    },

                    new SqlParameter("@ExperienceMonths",SqlDbType.Int)
                    {
                        Value = experienceMonths
                    }
                );


            rptJobs.DataSource = dt;
            rptJobs.DataBind();
            int count = dt.Rows.Count;
            lblResultCount.Text =
                count == 1
                    ? "1 job found"
                    : count + " jobs found";

            pnlNoJobs.Visible = count == 0;
        }

     

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadJobs();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            txtLocation.Text = "";

            ddlSearchCategory.SelectedIndex = 0;
            ddlEmploymentType.SelectedIndex = 0;
            ddlWorkMode.SelectedIndex = 0;
            ddlExperience.SelectedIndex = 0;

            LoadJobs();
        }

        // =========================================
        // COMPANY INITIAL
        // =========================================

        protected string GetCompanyInitial(object value)
        {
            string companyName = Convert.ToString(value).Trim();

            if (string.IsNullOrEmpty(companyName))
                return "C";

            return Server.HtmlEncode(
                companyName.Substring(0, 1).ToUpper()
            );
        }

        // =========================================
        // LOCATION
        // =========================================

        protected string GetLocation(object city, object state)
        {
            string cityText = Convert.ToString(city).Trim();
            string stateText = Convert.ToString(state).Trim();

            if (!string.IsNullOrEmpty(cityText) &&
                !string.IsNullOrEmpty(stateText))
            {
                return Server.HtmlEncode(
                    cityText + ", " + stateText
                );
            }

            if (!string.IsNullOrEmpty(cityText))
                return Server.HtmlEncode(cityText);

            if (!string.IsNullOrEmpty(stateText))
                return Server.HtmlEncode(stateText);

            return "Not specified";
        }

        // =========================================
        // EXPERIENCE
        // =========================================

        protected string GetExperience(object minValue,object maxValue)
        {
            int min = GetInt(minValue);
            int max = GetInt(maxValue);

            if (min == 0 && max == 0)
                return "Fresher";

            if (min > 0 && max > 0)
            {
                return FormatExperience(min)
                       + " - "
                       + FormatExperience(max);
            }

            if (min > 0)
                return FormatExperience(min) + "+";

            return "Up to " + FormatExperience(max);
        }

        private string FormatExperience(int months)
        {
            if (months < 12)
            {
                return months +
                    (months == 1
                        ? " month"
                        : " months");
            }

            decimal years = Math.Round(
                months / 12m,
                1
            );

            return years.ToString("0.#") +
                (years == 1
                    ? " year"
                    : " years");
        }

        // =========================================
        // SALARY
        // =========================================

        protected string GetSalary(object minValue,object maxValue)
        {
            decimal min = GetDecimal(minValue);
            decimal max = GetDecimal(maxValue);

            if (min > 0 && max > 0)
            {
                return FormatSalary(min)
                       + " - "
                       + FormatSalary(max);
            }

            if (min > 0)
                return FormatSalary(min) + "+";

            if (max > 0)
                return "Up to " + FormatSalary(max);

            return "Not disclosed";
        }

        private string FormatSalary(decimal salary)
        {
            if (salary >= 10000000)
            {
                return "₹" +
                       (salary / 10000000m)
                       .ToString("0.##") +
                       " Cr";
            }

            if (salary >= 100000)
            {
                return "₹" +
                       (salary / 100000m)
                       .ToString("0.##") +
                       " L";
            }

            if (salary >= 1000)
            {
                return "₹" +
                       (salary / 1000m)
                       .ToString("0.##") +
                       "K";
            }

            return "₹" + salary.ToString("0");
        }

        // =========================================
        // HELPERS
        // =========================================

        private int GetInt(object value)
        {
            if (value == null || value == DBNull.Value)
                return 0;

            int result;

            if (int.TryParse(
                Convert.ToString(value),
                out result))
            {
                return result;
            }

            return 0;
        }

        private decimal GetDecimal(object value)
        {
            if (value == null || value == DBNull.Value)
                return 0;

            decimal result;

            if (decimal.TryParse(
                Convert.ToString(value),
                out result))
            {
                return result;
            }

            return 0;
        }

    }
}