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
    public partial class SearchCandidates : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["Success24Connection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckRecruiter();

            if (!IsPostBack)
            {
                LoadCandidates();
            }
        }

        // =====================================================
        // CHECK RECRUITER LOGIN
        // =====================================================

        private void CheckRecruiter()
        {
            bool loggedIn =
                Session["UserId"] != null &&
                Session["RecruiterId"] != null;

            if (!loggedIn)
            {
                Response.Redirect(
                    "~/Recruiter/Login.aspx",
                    false
                );

                Context.ApplicationInstance.CompleteRequest();
            }
        }



        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadCandidates();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtKeyword.Text = "";
            txtSkill.Text = "";
            txtLocation.Text = "";

            ddlExperience.ClearSelection();

            if (ddlExperience.Items.Count > 0)
            {
                ddlExperience.SelectedIndex = 0;
            }

            LoadCandidates();
        }

        // =====================================================
        // LOAD CANDIDATES
        // =====================================================

        private void LoadCandidates()
        {
            DataTable dt =
                new DataTable();

            string keyword =
                txtKeyword.Text.Trim();

            string skill =
                txtSkill.Text.Trim();

            string location =
                txtLocation.Text.Trim();

            int experienceYears = -1;

            if (!string.IsNullOrWhiteSpace(
                ddlExperience.SelectedValue))
            {
                int.TryParse(
                    ddlExperience.SelectedValue,
                    out experienceYears
                );
            }


            string query = @"

                SELECT DISTINCT

                    JSP.JobSeekerId,

                    U.UserId,

                    U.FullName,

                    U.Email,

                    U.Mobile,

                    JSP.Headline,

                    JSP.ProfessionalSummary,

                    JSP.CurrentCity,

                    JSP.CurrentState,

                    JSP.PreferredRole,

                    JSP.ProfilePhoto,

                    ISNULL(EXP.TotalExperienceMonths, 0)
                        AS ExperienceMonths,

                    RES.FilePath AS ResumePath

                FROM JobSeekerProfiles JSP

                INNER JOIN Users U
                    ON JSP.UserId = U.UserId


                OUTER APPLY
                (
                    SELECT
                        SUM(
                            DATEDIFF(
                                MONTH,
                                E.StartDate,
                                ISNULL(
                                    E.EndDate,
                                    CAST(GETDATE() AS DATE)
                                )
                            )
                        ) AS TotalExperienceMonths

                    FROM JobSeekerExperiences E

                    WHERE E.JobSeekerId =
                          JSP.JobSeekerId

                ) EXP


                OUTER APPLY
                (
                    SELECT TOP 1

                        R.FilePath

                    FROM JobSeekerResumes R

                    WHERE R.JobSeekerId =
                          JSP.JobSeekerId

                    ORDER BY
                        R.IsPrimary DESC,
                        R.UploadedAt DESC

                ) RES


                WHERE

                    1 = 1

                    AND
                    (
                        @Keyword = ''

                        OR U.FullName LIKE '%' + @Keyword + '%'

                        OR JSP.Headline LIKE '%' + @Keyword + '%'

                        OR JSP.ProfessionalSummary LIKE '%' + @Keyword + '%'

                        OR JSP.PreferredRole LIKE '%' + @Keyword + '%'
                    )


                    AND
                    (
                        @Location = ''

                        OR JSP.CurrentCity LIKE '%' + @Location + '%'

                        OR JSP.CurrentState LIKE '%' + @Location + '%'
                    )


                    AND
                    (
                        @ExperienceYears = -1

                        OR
                        (
                            @ExperienceYears = 0
                            AND ISNULL(
                                EXP.TotalExperienceMonths,
                                0
                            ) = 0
                        )

                        OR
                        (
                            @ExperienceYears > 0

                            AND ISNULL(
                                EXP.TotalExperienceMonths,
                                0
                            )
                            >=
                            (@ExperienceYears * 12)
                        )
                    )


                    AND
                    (
                        @Skill = ''

                        OR EXISTS
                        (
                            SELECT 1

                            FROM JobSeekerSkills JS

                            INNER JOIN Skills S
                                ON JS.SkillId = S.SkillId

                            WHERE JS.JobSeekerId =
                                  JSP.JobSeekerId

                              AND S.SkillName LIKE
                                  '%' + @Skill + '%'
                        )
                    )


                ORDER BY
                    U.FullName ASC;
            ";


            try
            {
                using (
                    SqlConnection con =
                        new SqlConnection(
                            connectionString
                        )
                )
                using (
                    SqlCommand cmd =
                        new SqlCommand(
                            query,
                            con
                        )
                )
                {
                    cmd.Parameters.Add(
                        "@Keyword",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        keyword;


                    cmd.Parameters.Add(
                        "@Skill",
                        SqlDbType.NVarChar,
                        100
                    ).Value =
                        skill;


                    cmd.Parameters.Add(
                        "@Location",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        location;


                    cmd.Parameters.Add(
                        "@ExperienceYears",
                        SqlDbType.Int
                    ).Value =
                        experienceYears;


                    using (
                        SqlDataAdapter da =
                            new SqlDataAdapter(cmd)
                    )
                    {
                        da.Fill(dt);
                    }
                }


                rptCandidates.DataSource =
                    dt;

                rptCandidates.DataBind();


                lblCandidateCount.Text =
                    dt.Rows.Count.ToString();


                pnlNoCandidates.Visible =
                    dt.Rows.Count == 0;


                pnlMessage.Visible = false;
            }
            catch (Exception ex)
            {
                rptCandidates.DataSource =
                    null;

                rptCandidates.DataBind();

                lblCandidateCount.Text =
                    "0";

                pnlNoCandidates.Visible =
                    true;

                ShowMessage(
                    "Unable to search candidates. " +
                    ex.Message,
                    false
                );
            }
        }


        // =====================================================
        // GET SKILLS
        // =====================================================

        protected DataTable GetSkills(
            object jobSeekerIdObject)
        {
            DataTable dt =
                new DataTable();

            int jobSeekerId;

            if (!int.TryParse(
                Convert.ToString(
                    jobSeekerIdObject
                ),
                out jobSeekerId))
            {
                return dt;
            }


            const string query = @"

                SELECT

                    S.SkillName

                FROM JobSeekerSkills JS

                INNER JOIN Skills S
                    ON JS.SkillId = S.SkillId

                WHERE JS.JobSeekerId =
                      @JobSeekerId

                ORDER BY
                    S.SkillName ASC;
            ";


            try
            {
                using (
                    SqlConnection con =
                        new SqlConnection(
                            connectionString
                        )
                )
                using (
                    SqlCommand cmd =
                        new SqlCommand(
                            query,
                            con
                        )
                )
                {
                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value =
                        jobSeekerId;


                    using (
                        SqlDataAdapter da =
                            new SqlDataAdapter(cmd)
                    )
                    {
                        da.Fill(dt);
                    }
                }
            }
            catch
            {
                // Do not break candidate card
                // if skills cannot be loaded.
            }


            return dt;
        }


        // =====================================================
        // INITIAL
        // =====================================================

        protected string GetInitial(
            object nameObject)
        {
            string name =
                Convert.ToString(
                    nameObject
                ).Trim();


            if (string.IsNullOrWhiteSpace(name))
            {
                return "U";
            }


            return name
                .Substring(0, 1)
                .ToUpper();
        }


        // =====================================================
        // EXPERIENCE TEXT
        // =====================================================

        protected string GetExperienceText(
            object monthsObject)
        {
            int months = 0;

            if (!int.TryParse(
                Convert.ToString(
                    monthsObject
                ),
                out months))
            {
                months = 0;
            }


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
                return
                    years +
                    " yr " +
                    remainingMonths +
                    " mo";
            }


            if (years > 0)
            {
                return
                    years +
                    (
                        years == 1
                            ? " year"
                            : " years"
                    );
            }


            return
                months +
                (
                    months == 1
                        ? " month"
                        : " months"
                );
        }


        // =====================================================
        // TRUNCATE SUMMARY
        // =====================================================

        protected string TruncateText(
            object valueObject,
            int maxLength)
        {
            string value =
                Convert.ToString(
                    valueObject
                );


            if (string.IsNullOrWhiteSpace(value))
            {
                return
                    "Candidate has not added a professional summary.";
            }


            value =
                value.Trim();


            if (value.Length <= maxLength)
            {
                return value;
            }


            return
                value.Substring(
                    0,
                    maxLength
                ).TrimEnd() +
                "...";
        }


        // =====================================================
        // RESUME URL
        // =====================================================

        protected string GetResumeUrl(
            object pathObject)
        {
            string path =
                Convert.ToString(
                    pathObject
                ).Trim();


            if (string.IsNullOrWhiteSpace(path))
            {
                return "#";
            }


            return ResolveUrl(path);
        }


        // =====================================================
        // MESSAGE
        // =====================================================

        private void ShowMessage(
            string message,
            bool success)
        {
            pnlMessage.Visible =
                true;

            lblMessage.Text =
                message;

            pnlMessage.CssClass =
                success
                    ? "candidate-message success"
                    : "candidate-message error";
        }

    }
}