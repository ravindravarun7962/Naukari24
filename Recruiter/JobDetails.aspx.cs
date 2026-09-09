using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.Recruiter
{
    public partial class JobDetails : System.Web.UI.Page
    {
        private readonly string connectionString =
           ConfigurationManager
               .ConnectionStrings[
                   "Success24Connection"
               ]
               .ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Recruiter/Login.aspx"
                );

                return;
            }


            if (!IsPostBack)
            {
                LoadJobDetails();
            }
        }

        // =========================================
        // LOAD JOB
        // =========================================

        private void LoadJobDetails()
        {
            int jobId;

            if (!int.TryParse(
                Request.QueryString["JobId"],
                out jobId))
            {
                ShowError(
                    "Invalid job ID."
                );

                return;
            }


            const string query = @"
                SELECT
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
                    J.IsFeatured,

                    C.CompanyName,

                    JC.CategoryName

                FROM Jobs J

                LEFT JOIN Companies C
                    ON J.CompanyId = C.CompanyId

                LEFT JOIN JobCategories JC
                    ON J.CategoryId = JC.CategoryId

                WHERE J.JobId = @JobId;";


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
                    ).Value = jobId;


                    con.Open();


                    using (
                        SqlDataReader reader =
                            cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            ShowError(
                                "Job not found."
                            );

                            return;
                        }


                        // =================================
                        // BASIC INFORMATION
                        // =================================

                        string jobTitle =
                            GetString(
                                reader["JobTitle"],
                                "Job Opportunity"
                            );


                        string companyName =
                            GetString(
                                reader["CompanyName"],
                                "Company"
                            );


                        string category =
                            GetString(
                                reader["CategoryName"],
                                "Other"
                            );


                        lblJobTitle.Text =
                            Server.HtmlEncode(
                                jobTitle
                            );


                        lblCompanyName.Text =
                            Server.HtmlEncode(
                                companyName
                            );


                        lblCategory.Text =
                            Server.HtmlEncode(
                                category
                            );


                        // =================================
                        // COMPANY INITIAL
                        // =================================

                        lblCompanyInitial.Text =
                            Server.HtmlEncode(
                                companyName
                                    .Substring(
                                        0,
                                        1
                                    )
                                    .ToUpper()
                            );


                        // =================================
                        // LOCATION
                        // =================================

                        string city =
                            GetString(
                                reader["City"]
                            );


                        string state =
                            GetString(
                                reader["State"]
                            );


                        lblLocation.Text =
                            Server.HtmlEncode(
                                BuildLocation(
                                    city,
                                    state
                                )
                            );


                        lblCity.Text =
                            Server.HtmlEncode(
                                string.IsNullOrWhiteSpace(city)
                                    ? "Not specified"
                                    : city
                            );


                        lblState.Text =
                            Server.HtmlEncode(
                                string.IsNullOrWhiteSpace(state)
                                    ? "Not specified"
                                    : state
                            );


                        // =================================
                        // WORK INFORMATION
                        // =================================

                        lblEmploymentType.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader["EmploymentType"],
                                    "Not specified"
                                )
                            );


                        lblWorkMode.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader["WorkMode"],
                                    "Not specified"
                                )
                            );


                        lblExperience.Text =
                            FormatExperienceRange(
                                reader[
                                    "MinExperienceMonths"
                                ],
                                reader[
                                    "MaxExperienceMonths"
                                ]
                            );


                        // =================================
                        // SALARY
                        // =================================

                        bool salaryVisible =
                            reader[
                                "SalaryVisible"
                            ] != DBNull.Value &&
                            Convert.ToBoolean(
                                reader[
                                    "SalaryVisible"
                                ]
                            );


                        lblSalary.Text =
                            salaryVisible
                                ? FormatSalaryRange(
                                    reader["MinSalary"],
                                    reader["MaxSalary"]
                                  )
                                : "Not disclosed";


                        // =================================
                        // DESCRIPTION
                        // =================================

                        lblJobDescription.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader[
                                        "JobDescription"
                                    ],
                                    "No job description provided."
                                )
                            );


                        lblResponsibilities.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader[
                                        "Responsibilities"
                                    ],
                                    "No responsibilities specified."
                                )
                            );


                        lblRequirements.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader[
                                        "Requirements"
                                    ],
                                    "No requirements specified."
                                )
                            );


                        // =================================
                        // JOB DETAILS
                        // =================================

                        lblEducation.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader[
                                        "EducationRequirement"
                                    ],
                                    "Not specified"
                                )
                            );


                        lblOpenings.Text =
                            reader[
                                "NumberOfOpenings"
                            ] == DBNull.Value
                                ? "Not specified"
                                : Convert.ToString(
                                    reader[
                                        "NumberOfOpenings"
                                    ]
                                );


                        lblMinExperience.Text =
                            FormatMonths(
                                reader[
                                    "MinExperienceMonths"
                                ]
                            );


                        lblMaxExperience.Text =
                            FormatMonths(
                                reader[
                                    "MaxExperienceMonths"
                                ]
                            );


                        // =================================
                        // DEADLINE
                        // =================================

                        if (
                            reader[
                                "ApplicationDeadline"
                            ] != DBNull.Value)
                        {
                            DateTime deadline =
                                Convert.ToDateTime(
                                    reader[
                                        "ApplicationDeadline"
                                    ]
                                );


                            lblDeadline.Text =
                                Server.HtmlEncode(
                                    deadline.ToString(
                                        "dd MMM yyyy"
                                    )
                                );
                        }
                        else
                        {
                            lblDeadline.Text =
                                "No deadline";
                        }


                        // =================================
                        // STATUS
                        // =================================

                        lblJobStatus.Text =
                            Server.HtmlEncode(
                                GetString(
                                    reader[
                                        "JobStatus"
                                    ],
                                    "Draft"
                                )
                            );


                        // =================================
                        // FEATURED
                        // =================================

                        bool featured =
                            reader[
                                "IsFeatured"
                            ] != DBNull.Value &&
                            Convert.ToBoolean(
                                reader[
                                    "IsFeatured"
                                ]
                            );


                        pnlFeatured.Visible =
                            featured;


                        // =================================
                        // EDIT LINK
                        // =================================

                        lnkApply.NavigateUrl =
                            ResolveUrl(
                                "~/Recruiter/JobPost.aspx?JobId=" +
                                jobId
                            );
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError(
                    "Error loading job: " +
                    ex.Message
                );
            }
        }


        // =========================================
        // EXPERIENCE
        // =========================================

        private string FormatExperienceRange(
            object minValue,
            object maxValue)
        {
            string min =
                FormatMonths(
                    minValue
                );


            string max =
                FormatMonths(
                    maxValue
                );


            bool hasMin =
                min != "Not specified";


            bool hasMax =
                max != "Not specified";


            if (hasMin && hasMax)
            {
                return min +
                       " - " +
                       max;
            }


            if (hasMin)
            {
                return min + "+";
            }


            if (hasMax)
            {
                return "Up to " + max;
            }


            return "Any experience";
        }


        private string FormatMonths(
            object value)
        {
            if (
                value == null ||
                value == DBNull.Value)
            {
                return "Not specified";
            }


            int months =
                Convert.ToInt32(value);


            if (months <= 0)
            {
                return "Fresher";
            }


            int years =
                months / 12;


            int remainingMonths =
                months % 12;


            if (
                years > 0 &&
                remainingMonths > 0)
            {
                return years +
                       (years == 1
                           ? " Year "
                           : " Years ") +
                       remainingMonths +
                       (remainingMonths == 1
                           ? " Month"
                           : " Months");
            }


            if (years > 0)
            {
                return years +
                       (years == 1
                           ? " Year"
                           : " Years");
            }


            return months +
                   (months == 1
                       ? " Month"
                       : " Months");
        }


        // =========================================
        // SALARY
        // =========================================

        private string FormatSalaryRange(
            object minValue,
            object maxValue)
        {
            bool hasMin =
                minValue != null &&
                minValue != DBNull.Value;


            bool hasMax =
                maxValue != null &&
                maxValue != DBNull.Value;


            if (!hasMin && !hasMax)
            {
                return "Not disclosed";
            }


            if (hasMin && hasMax)
            {
                decimal min =
                    Convert.ToDecimal(
                        minValue
                    );

                decimal max =
                    Convert.ToDecimal(
                        maxValue
                    );


                return FormatCurrency(min) +
                       " - " +
                       FormatCurrency(max) +
                       " / year";
            }


            if (hasMin)
            {
                return FormatCurrency(
                    Convert.ToDecimal(
                        minValue
                    )
                ) +
                "+ / year";
            }


            return "Up to " +
                   FormatCurrency(
                       Convert.ToDecimal(
                           maxValue
                       )
                   ) +
                   " / year";
        }


        private string FormatCurrency(
            decimal value)
        {
            return "₹" +
                value.ToString(
                    "N0",
                    System.Globalization
                        .CultureInfo
                        .GetCultureInfo(
                            "en-IN"
                        )
                );
        }


        // =========================================
        // LOCATION
        // =========================================

        private string BuildLocation(
            string city,
            string state)
        {
            if (
                !string.IsNullOrWhiteSpace(city) &&
                !string.IsNullOrWhiteSpace(state))
            {
                return city +
                       ", " +
                       state;
            }


            if (!string.IsNullOrWhiteSpace(city))
            {
                return city;
            }


            if (!string.IsNullOrWhiteSpace(state))
            {
                return state;
            }


            return "Location not specified";
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
                Convert.ToString(
                    value
                );


            return string.IsNullOrWhiteSpace(
                text)
                ? defaultValue
                : text.Trim();
        }


        // =========================================
        // ERROR
        // =========================================

        private void ShowError(
            string message)
        {
            lblMessage.Text =
                Server.HtmlEncode(
                    message
                );

            lblMessage.Visible =
                true;
        }

    }
}