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
    public partial class Jobs : System.Web.UI.Page
    {
        private readonly string connectionString =
           ConfigurationManager
               .ConnectionStrings[
                   "Success24Connection"
               ]
               .ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadJobs();
            }
        }

        // =========================================
        // LOAD JOBS
        // =========================================

        private void LoadJobs()
        {
            string keyword =
                txtKeyword.Text.Trim();


            string location =
                txtLocation.Text.Trim();


            string orderBy =
                GetOrderBy();


            string query = @"
                SELECT

                    J.JobId,
                    J.JobTitle,

                    J.City,
                    J.State,

                    J.MinExperienceMonths,
                    J.MaxExperienceMonths,

                    J.MinSalary,
                    J.MaxSalary,

                    J.SalaryVisible,

                    J.CreatedAt,

                    C.CompanyName

                FROM Jobs J

                INNER JOIN Companies C
                    ON J.CompanyId = C.CompanyId

                WHERE J.JobStatus = 'Active'

                AND C.IsActive = 1

                AND
                (
                    J.ApplicationDeadline IS NULL

                    OR

                    J.ApplicationDeadline >=
                        CAST(GETDATE() AS DATE)
                )

                AND
                (
                    @Keyword = ''

                    OR

                    J.JobTitle LIKE
                        '%' + @Keyword + '%'

                    OR

                    C.CompanyName LIKE
                        '%' + @Keyword + '%'
                )

                AND
                (
                    @Location = ''

                    OR

                    J.City LIKE
                        '%' + @Location + '%'

                    OR

                    J.State LIKE
                        '%' + @Location + '%'
                )

                ORDER BY "
                + orderBy;


            DataTable dt =
                new DataTable();


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
                        "@Keyword",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        keyword;


                    cmd.Parameters.Add(
                        "@Location",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        location;


                    using (
                        SqlDataAdapter da =
                            new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }


                rptJobs.DataSource =
                    dt;

                rptJobs.DataBind();


                int count =
                    dt.Rows.Count;


                lblJobCount.Text =
                    count == 1
                        ? "1 job found"
                        : count + " jobs found";


                pnlJobs.Visible =
                    count > 0;


                pnlNoJobs.Visible =
                    count == 0;
            }
            catch
            {
                rptJobs.DataSource =
                    null;

                rptJobs.DataBind();


                pnlJobs.Visible =
                    false;

                pnlNoJobs.Visible =
                    true;


                lblJobCount.Text =
                    "Unable to load jobs.";
            }
        }

        // =========================================
        // SORT
        // =========================================

        private string GetOrderBy()
        {
            switch (
                ddlSort.SelectedValue
            )
            {
                case "oldest":

                    return
                        "J.CreatedAt ASC";


                case "salary":

                    return
                        "ISNULL(J.MaxSalary, 0) DESC, " +
                        "J.CreatedAt DESC";


                default:

                    return
                        "J.CreatedAt DESC";
            }
        }

        // =========================================
        // COMPANY INITIAL
        // =========================================

        public string GetCompanyInitial(
            object companyName)
        {
            string name =
                Convert.ToString(
                    companyName
                ).Trim();


            if (
                string.IsNullOrWhiteSpace(
                    name))
            {
                return "C";
            }


            return Server.HtmlEncode(
                name.Substring(
                    0,
                    1
                ).ToUpper()
            );
        }


        // =========================================
        // LOCATION
        // =========================================

        public string GetLocation(
            object city,
            object state)
        {
            string cityText =
                Convert.ToString(
                    city
                ).Trim();


            string stateText =
                Convert.ToString(
                    state
                ).Trim();


            if (
                !string.IsNullOrWhiteSpace(
                    cityText)
                &&
                !string.IsNullOrWhiteSpace(
                    stateText))
            {
                return Server.HtmlEncode(
                    cityText +
                    ", " +
                    stateText
                );
            }


            if (
                !string.IsNullOrWhiteSpace(
                    cityText))
            {
                return Server.HtmlEncode(
                    cityText
                );
            }


            if (
                !string.IsNullOrWhiteSpace(
                    stateText))
            {
                return Server.HtmlEncode(
                    stateText
                );
            }


            return "Not specified";
        }


        // =========================================
        // EXPERIENCE
        // =========================================

        public string GetExperience(
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

        public string GetSalary(
            object minValue,
            object maxValue)
        {
            if (
                minValue == DBNull.Value &&
                maxValue == DBNull.Value)
            {
                return
                    "Salary not disclosed";
            }


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
        // DATE
        // =========================================

        public string GetPostedDate(
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
                return
                    "Posted just now";
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
        // HELPERS
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
                    Convert.ToString(
                        value
                    ),
                    out result))
            {
                return result;
            }


            return 0;
        }


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
                    Convert.ToString(
                        value
                    ),
                    out result))
            {
                return result;
            }


            return 0;
        }
    

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadJobs();
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadJobs();
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtKeyword.Text = "";
            txtLocation.Text = "";

            ddlSort.SelectedValue =
                "newest";


            LoadJobs();
        }
    }
}