using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly string connectionString =
           ConfigurationManager
               .ConnectionStrings["Success24Connection"]
               .ConnectionString;


        private int UserId
        {
            get
            {
                return Convert.ToInt32(
                    Session["UserId"]
                );
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadWelcome();

                LoadProfileCompletion();

                LoadDashboardCounts();

                LoadRecentApplications();

                LoadUpcomingInterview();

                LoadLatestJobs();
            }

        }

        // =========================================
        // WELCOME
        // =========================================

        private void LoadWelcome()
        {
            int hour = DateTime.Now.Hour;

            if (hour < 12)
            {
                lblGreeting.Text = "Good morning";
            }
            else if (hour < 17)
            {
                lblGreeting.Text = "Good afternoon";
            }
            else
            {
                lblGreeting.Text = "Good evening";
            }


            string fullName =
                Convert.ToString(
                    Session["FullName"]
                );


            if (string.IsNullOrWhiteSpace(fullName))
            {
                fullName = "User";
            }


            string firstName =
                fullName.Split(' ')[0];


            lblName.Text =
                Server.HtmlEncode(firstName);
        }


        // =========================================
        // GET JOB SEEKER ID
        // =========================================

        private int GetJobSeekerId()
        {
            string query = @"
                SELECT JobSeekerId
                FROM JobSeekerProfiles
                WHERE UserId = @UserId";


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            {
                cmd.Parameters.Add(
                    "@UserId",
                    SqlDbType.Int
                ).Value = UserId;


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


        // =========================================
        // PROFILE COMPLETION
        // =========================================

        private void LoadProfileCompletion()
        {
            string query = @"
                SELECT ISNULL(ProfileCompletion, 0)
                FROM JobSeekerProfiles
                WHERE UserId = @UserId";


            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@UserId",
                        SqlDbType.Int
                    ).Value = UserId;


                    con.Open();


                    object result =
                        cmd.ExecuteScalar();


                    int completion = 0;


                    if (result != null &&
                        result != DBNull.Value)
                    {
                        completion =
                            Convert.ToInt32(result);
                    }


                    completion =
                        Math.Max(
                            0,
                            Math.Min(100, completion)
                        );


                    lblDashboardProfileCompletion.Text =
                        completion + "%";


                    dashboardProfileProgressBar
                        .Style["width"] =
                        completion + "%";


                    if (completion >= 100)
                    {
                        pnlProfileCompletion.Visible = false;
                    }
                }
            }
            catch
            {
                lblDashboardProfileCompletion.Text =
                    "0%";

                dashboardProfileProgressBar
                    .Style["width"] =
                    "0%";
            }
        }


        // =========================================
        // DASHBOARD COUNTS
        // =========================================

        private void LoadDashboardCounts()
        {
            int jobSeekerId =
                GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                return;
            }


            string query = @"
                SELECT

                (
                    SELECT COUNT(*)
                    FROM Applications
                    WHERE JobSeekerId = @JobSeekerId
                )
                AS TotalApplications,

                (
                    SELECT COUNT(*)
                    FROM Applications
                    WHERE JobSeekerId = @JobSeekerId
                    AND ApplicationStatus = 'Shortlisted'
                )
                AS TotalShortlisted,

                (
                    SELECT COUNT(*)
                    FROM Interviews I
                    INNER JOIN Applications A
                        ON I.ApplicationId = A.ApplicationId
                    WHERE A.JobSeekerId = @JobSeekerId
                    AND I.InterviewStatus = 'Scheduled'
                    AND I.InterviewDate >= SYSDATETIME()
                )
                AS TotalInterviews,

                (
                    SELECT COUNT(*)
                    FROM SavedJobs
                    WHERE JobSeekerId = @JobSeekerId
                )
                AS TotalSavedJobs;";


            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value = jobSeekerId;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblApplications.Text =
                                Convert.ToString(
                                    reader["TotalApplications"]
                                );


                            lblShortlisted.Text =
                                Convert.ToString(
                                    reader["TotalShortlisted"]
                                );


                            lblInterviews.Text =
                                Convert.ToString(
                                    reader["TotalInterviews"]
                                );


                            lblSavedJobs.Text =
                                Convert.ToString(
                                    reader["TotalSavedJobs"]
                                );
                        }
                    }
                }
            }
            catch
            {
                lblApplications.Text = "0";
                lblShortlisted.Text = "0";
                lblInterviews.Text = "0";
                lblSavedJobs.Text = "0";
            }
        }


        // =========================================
        // RECENT APPLICATIONS
        // =========================================

        private void LoadRecentApplications()
        {
            int jobSeekerId =
                GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                pnlNoApplications.Visible = true;

                return;
            }


            string query = @"
                SELECT TOP 5

                    A.ApplicationId,
                    A.ApplicationStatus,
                    A.AppliedAt,

                    J.JobId,
                    J.JobTitle,
                    J.City,
                    J.State,

                    C.CompanyName

                FROM Applications A

                INNER JOIN Jobs J
                    ON A.JobId = J.JobId

                INNER JOIN Companies C
                    ON J.CompanyId = C.CompanyId

                WHERE A.JobSeekerId = @JobSeekerId

                ORDER BY A.AppliedAt DESC;";


            DataTable dt =
                new DataTable();


            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value = jobSeekerId;


                    using (SqlDataAdapter da =
                           new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }


                rptRecentApplications.DataSource = dt;
                rptRecentApplications.DataBind();


                pnlNoApplications.Visible =
                    dt.Rows.Count == 0;
            }
            catch
            {
                pnlNoApplications.Visible = true;
            }
        }


        // =========================================
        // UPCOMING INTERVIEW
        // =========================================

        private void LoadUpcomingInterview()
        {
            int jobSeekerId =
                GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                pnlUpcomingInterview.Visible = false;
                pnlNoInterview.Visible = true;

                return;
            }


            string query = @"
                SELECT TOP 1

                    I.InterviewDate,
                    I.InterviewMode,

                    J.JobTitle,

                    C.CompanyName

                FROM Interviews I

                INNER JOIN Applications A
                    ON I.ApplicationId = A.ApplicationId

                INNER JOIN Jobs J
                    ON A.JobId = J.JobId

                INNER JOIN Companies C
                    ON J.CompanyId = C.CompanyId

                WHERE A.JobSeekerId = @JobSeekerId

                AND I.InterviewStatus = 'Scheduled'

                AND I.InterviewDate >= SYSDATETIME()

                ORDER BY I.InterviewDate ASC;";


            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value = jobSeekerId;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            DateTime interviewDate =
                                Convert.ToDateTime(
                                    reader["InterviewDate"]
                                );


                            lblInterviewMonth.Text =
                                interviewDate
                                    .ToString("MMM")
                                    .ToUpper();


                            lblInterviewDay.Text =
                                interviewDate
                                    .ToString("dd");


                            lblInterviewDate.Text =
                                interviewDate
                                    .ToString(
                                        "dddd, dd MMM yyyy"
                                    );


                            lblInterviewTime.Text =
                                interviewDate
                                    .ToString("hh:mm tt");


                            lblInterviewJobTitle.Text =
                                Server.HtmlEncode(
                                    Convert.ToString(
                                        reader["JobTitle"]
                                    )
                                );


                            lblInterviewCompany.Text =
                                Server.HtmlEncode(
                                    Convert.ToString(
                                        reader["CompanyName"]
                                    )
                                );


                            string mode =
                                Convert.ToString(
                                    reader["InterviewMode"]
                                );


                            lblInterviewMode.Text =
                                string.IsNullOrWhiteSpace(mode)
                                    ? "Not specified"
                                    : Server.HtmlEncode(mode);


                            pnlUpcomingInterview.Visible =
                                true;


                            pnlNoInterview.Visible =
                                false;
                        }
                        else
                        {
                            pnlUpcomingInterview.Visible =
                                false;

                            pnlNoInterview.Visible =
                                true;
                        }
                    }
                }
            }
            catch
            {
                pnlUpcomingInterview.Visible = false;

                pnlNoInterview.Visible = true;
            }
        }


        // =========================================
        // LATEST JOBS
        // =========================================

        private void LoadLatestJobs()
        {
            string query = @"
                SELECT TOP 6

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
                    OR J.ApplicationDeadline >=
                       CAST(GETDATE() AS DATE)
                )

                ORDER BY J.CreatedAt DESC;";


            DataTable dt =
                new DataTable();


            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                using (SqlDataAdapter da =
                       new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }


                rptLatestJobs.DataSource = dt;
                rptLatestJobs.DataBind();


                pnlNoJobs.Visible =
                    dt.Rows.Count == 0;
            }
            catch
            {
                pnlNoJobs.Visible = true;
            }
        }


        // =========================================
        // REPEATER HELPERS
        // =========================================

        public string GetCompanyInitial(
            object companyName)
        {
            string name =
                Convert.ToString(companyName);


            if (string.IsNullOrWhiteSpace(name))
            {
                return "C";
            }


            return Server.HtmlEncode(
                name.Substring(0, 1).ToUpper()
            );
        }


        public string GetLocation(
            object city,
            object state)
        {
            string cityText =
                Convert.ToString(city);

            string stateText =
                Convert.ToString(state);


            if (!string.IsNullOrWhiteSpace(cityText) &&
                !string.IsNullOrWhiteSpace(stateText))
            {
                return cityText + ", " + stateText;
            }


            if (!string.IsNullOrWhiteSpace(cityText))
            {
                return cityText;
            }


            if (!string.IsNullOrWhiteSpace(stateText))
            {
                return stateText;
            }


            return "Not specified";
        }


        public string GetStatusClass(
            string status)
        {
            if (string.IsNullOrWhiteSpace(status))
            {
                return "status-applied";
            }


            switch (status.ToLowerInvariant())
            {
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
                    return "status-applied";
            }
        }


        public string GetTimeAgo(object value)
        {
            if (value == null ||
                value == DBNull.Value)
            {
                return "";
            }


            DateTime date =
                Convert.ToDateTime(value);


            TimeSpan difference =
                DateTime.Now - date;


            if (difference.TotalMinutes < 1)
            {
                return "just now";
            }


            if (difference.TotalMinutes < 60)
            {
                int minutes =
                    (int)difference.TotalMinutes;

                return minutes +
                       (minutes == 1
                           ? " minute ago"
                           : " minutes ago");
            }


            if (difference.TotalHours < 24)
            {
                int hours =
                    (int)difference.TotalHours;

                return hours +
                       (hours == 1
                           ? " hour ago"
                           : " hours ago");
            }


            if (difference.TotalDays < 7)
            {
                int days =
                    (int)difference.TotalDays;

                return days +
                       (days == 1
                           ? " day ago"
                           : " days ago");
            }


            return date.ToString(
                "dd MMM yyyy"
            );
        }


        public string GetExperienceText(
            object minValue,
            object maxValue)
        {
            int min =
                minValue == DBNull.Value
                    ? 0
                    : Convert.ToInt32(minValue);


            int max =
                maxValue == DBNull.Value
                    ? 0
                    : Convert.ToInt32(maxValue);


            if (min == 0 && max == 0)
            {
                return "Fresher";
            }


            double minYears =
                min / 12.0;

            double maxYears =
                max / 12.0;


            if (max == 0)
            {
                return FormatYears(minYears) +
                       "+ Years";
            }


            return FormatYears(minYears) +
                   "-" +
                   FormatYears(maxYears) +
                   " Years";
        }


        private string FormatYears(double years)
        {
            if (years ==
                Math.Floor(years))
            {
                return ((int)years)
                    .ToString();
            }


            return years.ToString("0.#");
        }


        public string GetSalaryText(
            object minValue,
            object maxValue,
            object visibleValue)
        {
            bool visible =
                visibleValue != DBNull.Value &&
                Convert.ToBoolean(visibleValue);


            if (!visible)
            {
                return "Salary not disclosed";
            }


            if (minValue == DBNull.Value &&
                maxValue == DBNull.Value)
            {
                return "Salary not disclosed";
            }


            decimal min =
                minValue == DBNull.Value
                    ? 0
                    : Convert.ToDecimal(minValue);


            decimal max =
                maxValue == DBNull.Value
                    ? 0
                    : Convert.ToDecimal(maxValue);


            if (min > 0 && max > 0)
            {
                return "₹" +
                       FormatSalary(min) +
                       " - ₹" +
                       FormatSalary(max);
            }


            if (min > 0)
            {
                return "₹" +
                       FormatSalary(min) +
                       "+";
            }


            return "Up to ₹" +
                   FormatSalary(max);
        }


        private string FormatSalary(decimal salary)
        {
            if (salary >= 100000)
            {
                decimal lakh =
                    salary / 100000M;


                return lakh.ToString("0.#") +
                       " LPA";
            }


            return salary.ToString(
                "N0",
                CultureInfo.GetCultureInfo("en-IN")
            );
        }
    }
}