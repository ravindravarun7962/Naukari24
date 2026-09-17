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

namespace Success24_Job_Portal.JobSeeker
{
    public partial class Profile : System.Web.UI.Page
    {
        private int UserId
        {
            get
            {
                return Convert.ToInt32(
                    Session["UserId"]
                );
            }
        }


        private int JobSeekerId
        {
            get;
            set;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfile();
            }
        }
        private void LoadProfile()
        {
            try
            {
                JobSeekerId = GetJobSeekerId();


                if (JobSeekerId == 0)
                {
                    Response.Redirect(
                        "~/JobSeeker/Dashboard.aspx",
                        false
                    );

                    Context.ApplicationInstance
                        .CompleteRequest();

                    return;
                }


                LoadBasicInformation();

                LoadExperience();

                LoadEducation();

                LoadSkills();

                LoadProjects();

                LoadResume();
            }
            catch (Exception ex)
            {
                Response.Write(
                    "<div style='padding:20px;color:red;background:white;'>" +
                    "<h3>Profile Error</h3>" +
                    "<pre>" +
                    Server.HtmlEncode(ex.ToString()) +
                    "</pre>" +
                    "</div>"
                );
            }
        }


        // ==========================================
        // JOB SEEKER ID
        // ==========================================

        private int GetJobSeekerId()
        {
            const string query = @"
        SELECT JobSeekerId
        FROM JobSeekerProfiles
        WHERE UserId = @UserId;";

            object result =
                Utility.ExecuteScalar24(
                    query,
                    new SqlParameter(
                        "@UserId",
                        SqlDbType.Int
                    )
                    {
                        Value = UserId
                    }
                );

            if (result == null ||
                result == DBNull.Value)
            {
                return 0;
            }

            return Convert.ToInt32(result);
        }

        // ==========================================
        // BASIC INFORMATION
        // ==========================================

        private void LoadBasicInformation()
        {
            const string query = @"
                SELECT
                    U.FullName,
                    U.Email,
                    U.Mobile,

                    P.ProfilePhoto,
                    P.Headline,
                    P.ProfessionalSummary,

                    P.CurrentCity,
                    P.CurrentState,

                    P.CurrentDesignation,
                    P.CurrentCompany,

                    P.TotalExperienceMonths,

                    P.CurrentSalary,
                    P.ExpectedSalary,

                    P.NoticePeriodDays,
                    P.PreferredEmploymentType,

                    P.PreferredLocation,
                    P.PreferredRole,

                    P.ProfileCompletion

                FROM Users U

                INNER JOIN JobSeekerProfiles P
                    ON U.UserId = P.UserId

                WHERE U.UserId = @UserId;";


            DataRow reader =
     Utility._GetDataRow24(
         query,
         new SqlParameter(
             "@UserId",
             SqlDbType.Int
         )
         {
             Value = UserId
         }
     );

            if (reader == null)
            {
                return;
            }

            string fullName =
                GetString(
                    reader["FullName"],
                    "User"
                );


            lblFullName.Text =
                Server.HtmlEncode(fullName);


            lblProfileInitial.Text =
                Server.HtmlEncode(
                    fullName.Substring(0, 1)
                        .ToUpper()
                );


            lblEmail.Text =
                Server.HtmlEncode(
                    GetString(
                        reader["Email"]
                    )
                );


            lblMobile.Text =
                Server.HtmlEncode(
                    GetString(
                        reader["Mobile"],
                        "Not added"
                    )
                );


            lblHeadline.Text =
                Server.HtmlEncode(
                    GetString(
                        reader["Headline"],
                        "Add your professional headline"
                    )
                );


            string city =
                GetString(reader["CurrentCity"]);

            string state =
                GetString(reader["CurrentState"]);


            lblLocation.Text =
                Server.HtmlEncode(
                    BuildLocation(
                        city,
                        state
                    )
                );


            string about =
                GetString(reader["ProfessionalSummary"]);


            if (string.IsNullOrWhiteSpace(about))
            {
                pnlAbout.Visible = false;
                pnlNoAbout.Visible = true;
            }
            else
            {
                pnlAbout.Visible = true;
                pnlNoAbout.Visible = false;

                lblAbout.Text =
                    Server.HtmlEncode(about);
            }


            lblDesignation.Text =
                SafeDisplay(
                    reader["CurrentDesignation"]
                );


            lblCompany.Text =
                SafeDisplay(
                    reader["CurrentCompany"]
                );


            lblExperience.Text =
                FormatExperience(
                    reader["TotalExperienceMonths"]
                );


            lblCurrentSalary.Text =
                FormatSalary(
                    reader["CurrentSalary"]
                );


            lblExpectedSalary.Text =
                FormatSalary(
                    reader["ExpectedSalary"]
                );


            lblNoticePeriod.Text =
                reader["NoticePeriodDays"] == DBNull.Value
                    ? "Not added"
                    : Convert.ToString(
                        reader["NoticePeriodDays"]
                      ) + " Days";


            lblEmploymentType.Text =
                SafeDisplay(
                    reader["PreferredEmploymentType"]
                );


            lblPreferredLocation.Text =
                SafeDisplay(
                    reader["PreferredLocation"]
                );


            lblPreferredRole.Text =
                SafeDisplay(
                    reader["PreferredRole"]
                );


            int completion =
                reader["ProfileCompletion"] ==
                DBNull.Value
                    ? 0
                    : Convert.ToInt32(
                        reader["ProfileCompletion"]
                    );


            lblCompletion.Text =
                completion + "%";


            // PROFILE PHOTO

            string photo =
                GetString(
                    reader["ProfilePhoto"]
                );


            if (!string.IsNullOrWhiteSpace(photo))
            {
                imgProfile.ImageUrl =
                    ResolveUrl(photo);

                imgProfile.Visible = true;
                pnlProfileInitial.Visible = false;
            }
            else
            {
                imgProfile.Visible = false;
                pnlProfileInitial.Visible = true;
            }
        }
        


        // ==========================================
        // EXPERIENCE
        // ==========================================

        private void LoadExperience()
        {
            const string query = @"
    SELECT
        ExperienceId,
        CompanyName,
        Designation,
        StartDate,
        EndDate,
        IsCurrentJob,
        JobDescription

    FROM JobSeekerExperiences

    WHERE JobSeekerId = @JobSeekerId

    ORDER BY
        IsCurrentJob DESC,
        StartDate DESC;";


            DataTable dt =
                GetTable(
                    query,
                    "@JobSeekerId",
                    JobSeekerId
                );


            rptExperience.DataSource = dt;
            rptExperience.DataBind();


            pnlNoExperience.Visible =
                dt.Rows.Count == 0;
        }


        // ==========================================
        // EDUCATION
        // ==========================================

        private void LoadEducation()
        {
            const string query = @"
                SELECT
                    EducationId,
                    Qualification,
                    CourseName,
                    Specialization,
                    InstituteName,
                    StartYear,
                    PassingYear

                FROM JobSeekerEducation

                WHERE JobSeekerId = @JobSeekerId

                ORDER BY
                    PassingYear DESC,
                    EducationId DESC;";


            DataTable dt =
                GetTable(
                    query,
                    "@JobSeekerId",
                    JobSeekerId
                );


            rptEducation.DataSource = dt;
            rptEducation.DataBind();


            pnlNoEducation.Visible =
                dt.Rows.Count == 0;
        }


        // ==========================================
        // SKILLS
        // ==========================================

        private void LoadSkills()
        {
            const string query = @"
            SELECT
                JS.JobSeekerSkillId,
                S.SkillName

            FROM JobSeekerSkills JS

            INNER JOIN Skills S
                ON JS.SkillId = S.SkillId

            WHERE JS.JobSeekerId = @JobSeekerId

            ORDER BY S.SkillName;";


            DataTable dt =
                GetTable(
                    query,
                    "@JobSeekerId",
                    JobSeekerId
                );


            rptSkills.DataSource = dt;
            rptSkills.DataBind();


            pnlNoSkills.Visible =
                dt.Rows.Count == 0;
        }


        // ==========================================
        // PROJECTS
        // ==========================================

        private void LoadProjects()
        {
            const string query = @"
    SELECT
        ProjectId,
        ProjectTitle,
        ProjectDescription,
        ProjectUrl

    FROM JobSeekerProjects

    WHERE JobSeekerId = @JobSeekerId

    ORDER BY ProjectId DESC;";


            DataTable dt =
                GetTable(
                    query,
                    "@JobSeekerId",
                    JobSeekerId
                );


            rptProjects.DataSource = dt;
            rptProjects.DataBind();


            pnlNoProjects.Visible =
                dt.Rows.Count == 0;
        }


        // ==========================================
        // RESUME
        // ==========================================

        private void LoadResume()
        {
            const string query = @"
       SELECT TOP 1
            OriginalFileName,
            FilePath,
            UploadedAt
        FROM JobSeekerResumes
        WHERE JobSeekerId = @JobSeekerId
          AND IsPrimary = 1
        ORDER BY UploadedAt DESC;";


            DataRow reader =
      Utility._GetDataRow24(
          query,
          new SqlParameter(
              "@JobSeekerId",
              SqlDbType.Int
          )
          {
              Value = JobSeekerId
          }
      );

            if (reader != null)
            {
                pnlResume.Visible = true;
                pnlNoResume.Visible = false;


                // Resume Name

                lblResumeName.Text =
                    Server.HtmlEncode(
                        GetString(
                            reader["OriginalFileName"],
                            "Resume"
                        )
                    );


                // Upload Date

                if (reader["UploadedAt"] !=
                    DBNull.Value)
                {
                    DateTime uploaded =
                        Convert.ToDateTime(
                            reader["UploadedAt"]
                        );


                    lblResumeDate.Text =
                        "Updated " +
                        uploaded.ToString(
                            "dd MMM yyyy"
                        );
                }
                else
                {
                    lblResumeDate.Text = "";
                }


                // Resume Path

                string path =
                    GetString(
                        reader["FilePath"]
                    );


                lnkResume.NavigateUrl =
                    string.IsNullOrWhiteSpace(path)
                        ? "#"
                        : ResolveUrl(path);
            }
            else
            {
                pnlResume.Visible = false;
                pnlNoResume.Visible = true;
            }
        }



        // ==========================================
        // COMMON DATATABLE
        // ==========================================

        private DataTable GetTable(
     string query,
     string parameterName,
     int parameterValue)
        {
            return Utility._GetDataTable24(
                query,
                new SqlParameter(
                    parameterName,
                    SqlDbType.Int
                )
                {
                    Value = parameterValue
                }
            );
        }


        // ==========================================
        // REPEATER HELPERS
        // ==========================================

        public string GetExperiencePeriod(
            object startDate,
            object endDate,
            object isCurrent)
        {
            if (startDate == DBNull.Value)
            {
                return "";
            }


            DateTime start =
                Convert.ToDateTime(startDate);


            bool current =
                isCurrent != DBNull.Value &&
                Convert.ToBoolean(isCurrent);


            string startText =
                start.ToString("MMM yyyy");


            string endText;


            if (current)
            {
                endText = "Present";
            }
            else if (endDate != DBNull.Value)
            {
                endText =
                    Convert.ToDateTime(endDate)
                        .ToString("MMM yyyy");
            }
            else
            {
                endText = "";
            }


            return Server.HtmlEncode(
                startText +
                " - " +
                endText
            );
        }


        public string GetEducationTitle(
     object qualification,
     object courseName)
        {
            string qualificationText =
                GetString(qualification);

            string courseText =
                GetString(courseName);

            if (!string.IsNullOrWhiteSpace(qualificationText) &&
                !string.IsNullOrWhiteSpace(courseText))
            {
                return Server.HtmlEncode(
                    qualificationText +
                    " - " +
                    courseText
                );
            }

            return Server.HtmlEncode(
                string.IsNullOrWhiteSpace(qualificationText)
                    ? "Education"
                    : qualificationText
            );
        }


        public string GetEducationPeriod(
            object startYear,
            object endYear)
        {
            string start =
                startYear == DBNull.Value
                    ? ""
                    : Convert.ToString(startYear);


            string end =
                endYear == DBNull.Value
                    ? ""
                    : Convert.ToString(endYear);


            if (!string.IsNullOrWhiteSpace(start) &&
                !string.IsNullOrWhiteSpace(end))
            {
                return Server.HtmlEncode(
                    start + " - " + end
                );
            }


            return Server.HtmlEncode(
                !string.IsNullOrWhiteSpace(end)
                    ? end
                    : start
            );
        }


        public string GetSafeExternalUrl(
            object value)
        {
            string url =
                GetString(value);


            if (string.IsNullOrWhiteSpace(url))
            {
                return "#";
            }


            Uri uri;


            if (Uri.TryCreate(
                    url,
                    UriKind.Absolute,
                    out uri) &&
                (
                    uri.Scheme ==
                    Uri.UriSchemeHttp ||
                    uri.Scheme ==
                    Uri.UriSchemeHttps
                ))
            {
                return Server.HtmlEncode(
                    uri.AbsoluteUri
                );
            }


            return "#";
        }


        // ==========================================
        // FORMATTERS
        // ==========================================

        private string FormatExperience(
            object value)
        {
            if (value == DBNull.Value)
            {
                return "Not added";
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


            if (years > 0 &&
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


            return remainingMonths +
                   (remainingMonths == 1
                       ? " Month"
                       : " Months");
        }


        private string FormatSalary(
            object value)
        {
            if (value == DBNull.Value)
            {
                return "Not added";
            }


            decimal salary =
                Convert.ToDecimal(value);


            if (salary <= 0)
            {
                return "Not added";
            }


            return "₹" +
                   salary.ToString(
                       "N0",
                       CultureInfo.GetCultureInfo(
                           "en-IN"
                       )
                   ) +
                   " / year";
        }


        private string BuildLocation(
            string city,
            string state)
        {
            if (!string.IsNullOrWhiteSpace(city) &&
                !string.IsNullOrWhiteSpace(state))
            {
                return city + ", " + state;
            }


            if (!string.IsNullOrWhiteSpace(city))
            {
                return city;
            }


            if (!string.IsNullOrWhiteSpace(state))
            {
                return state;
            }


            return "Location not added";
        }


        private string SafeDisplay(
            object value)
        {
            string text =
                GetString(value);


            return Server.HtmlEncode(
                string.IsNullOrWhiteSpace(text)
                    ? "Not added"
                    : text
            );
        }


        private string GetString(
            object value,
            string defaultValue = "")
        {
            if (value == null ||
                value == DBNull.Value)
            {
                return defaultValue;
            }


            string text =
                Convert.ToString(value);


            return string.IsNullOrWhiteSpace(text)
                ? defaultValue
                : text.Trim();
        }
    }
}