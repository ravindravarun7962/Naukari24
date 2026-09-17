using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.Recruiter
{
    public partial class CandidateProfile : System.Web.UI.Page
    {

        private int JobSeekerId
        {
            get
            {
                int id;

                if (int.TryParse(Request.QueryString["JobSeekerId"],out id))
                {
                    return id;
                }

                return 0;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckRecruiter();
            if (!IsPostBack)
            {
                if (JobSeekerId <= 0)
                {
                    Response.Redirect(ResolveUrl("~/Recruiter/SearchCandidates.aspx"));
                    return;
                }

                LoadCandidateProfile();
                LoadSkills();
                LoadResume();
            }

        }

        private void CheckRecruiter()
        { 
            if (Session["UserId"] == null ||  Session["RecruiterId"] == null)
            {
                Response.Redirect(ResolveUrl("~/Recruiter/Login.aspx"));
            }
        }


        /* =========================================
           PROFILE
        ========================================== */

        private void LoadCandidateProfile()
        {
            const string query = @"SELECT U.UserId,U.FullName,U.Email,U.Mobile, JSP.JobSeekerId,JSP.Headline,JSP.ProfessionalSummary,JSP.CurrentCity,JSP.CurrentState,JSP.PreferredRole,JSP.PreferredLocation,JSP.PreferredIndustry,JSP.PreferredShift FROM Users U INNER JOIN JobSeekerProfiles JSP ON U.UserId = JSP.UserId WHERE JSP.JobSeekerId = @JobSeekerId;";
            DataRow row = Utility._GetDataRow24(query,new SqlParameter("@JobSeekerId",SqlDbType.Int)
                {
                    Value = JobSeekerId
                }
            );


            if (row == null)
            {
                Response.Redirect(ResolveUrl("~/Recruiter/SearchCandidates.aspx"));
                return;
            }


            string fullName = Convert.ToString(row["FullName"]);
            lblCandidateName.Text = fullName;
            lblFullName.Text = fullName;
            lblEmail.Text = Convert.ToString(row["Email"]);
            lblMobile.Text = Convert.ToString(row["Mobile"]);
            lblCandidateId.Text = Convert.ToString(row["JobSeekerId"]);
            string headline = Convert.ToString(row["Headline"]);
            lblHeadline.Text = string.IsNullOrWhiteSpace(headline)? "Job Seeker" : headline;
            string city = Convert.ToString(row["CurrentCity"]);
            string state = Convert.ToString(row["CurrentState"]);
            string location = BuildLocation(city, state);
            lblLocation.Text = string.IsNullOrWhiteSpace(location)? "Location not available" : location;
            lblCurrentLocation.Text = string.IsNullOrWhiteSpace(location)? "Not available" : location;
            string summary = Convert.ToString(row["ProfessionalSummary"]);
            lblProfessionalSummary.Text = string.IsNullOrWhiteSpace(summary)? "No professional summary available." : Server.HtmlEncode(summary).Replace("\r\n","<br />").Replace("\n","<br />");
            lblPreferredRole.Text = GetValueOrDefault(row["PreferredRole"]);
            lblPreferredLocation.Text = GetValueOrDefault(row["PreferredLocation"]);
            lblPreferredIndustry.Text = GetValueOrDefault(row["PreferredIndustry"]);
            lblPreferredShift.Text = GetValueOrDefault(row["PreferredShift"]);
            if (!string.IsNullOrWhiteSpace(fullName))
            {
                lblInitial.Text = fullName.Substring(0, 1).ToUpper();
            }
        }

        /* =========================================
           SKILLS
        ========================================== */

        private void LoadSkills()
        {
            const string query = @"SELECT JS.JobSeekerSkillId,JS.SkillId,S.SkillName,JS.ExperienceMonths FROM JobSeekerSkills JS INNER JOIN Skills S ON JS.SkillId = S.SkillId WHERE JS.JobSeekerId = @JobSeekerId ORDER BY S.SkillName ASC;";
            DataTable dt =
                Utility._GetDataTable24(query,new SqlParameter("@JobSeekerId",SqlDbType.Int)
                {
                    Value = JobSeekerId

                });

            rptSkills.DataSource = dt;
            rptSkills.DataBind();
            pnlNoSkills.Visible = dt.Rows.Count == 0;
        }

        /* =========================================
           RESUME
        ========================================== */

        private void LoadResume()
        {
            const string query = @" SELECT TOP 1 ResumeId,OriginalFileName,FilePath,UploadedAt FROM JobSeekerResumes WHERE JobSeekerId = @JobSeekerId AND IsPrimary = 1 ORDER BY UploadedAt DESC;";
            DataRow row =
                Utility._GetDataRow24(query,new SqlParameter("@JobSeekerId",SqlDbType.Int)
                    {
                        Value = JobSeekerId
                    }
                );


            if (row == null)
            {
                pnlResume.Visible = false;
                pnlNoResume.Visible = true;
                lnkResumeTop.Visible = false;
                return;
            }


            string fileName = Convert.ToString(row["OriginalFileName"]);
            string filePath = Convert.ToString(row["FilePath"]);
            DateTime uploadedAt = Convert.ToDateTime(row["UploadedAt"]);
            lblResumeName.Text = Server.HtmlEncode(fileName);
            lblResumeDate.Text = "Uploaded " + uploadedAt.ToString("dd MMM yyyy");
            string resumeUrl = ResolveResumeUrl(filePath);

            if (!string.IsNullOrWhiteSpace(resumeUrl))
            {
                lnkResume.NavigateUrl = resumeUrl;
                lnkResumeTop.NavigateUrl = resumeUrl;
                pnlResume.Visible = true;
                pnlNoResume.Visible = false;
                lnkResumeTop.Visible = true;
            }
            else
            {
                pnlResume.Visible = false;
                pnlNoResume.Visible = true;
                lnkResumeTop.Visible = false;
            }
        }

        /* =========================================
           HELPERS
        ========================================== */

        private string BuildLocation(string city,string state)
        {
            city = (city ?? "").Trim();
            state = (state ?? "").Trim();

            if (!string.IsNullOrWhiteSpace(city) && !string.IsNullOrWhiteSpace(state))
            {
                return city + ", " + state;
            }


            if (!string.IsNullOrWhiteSpace(city))
            {
                return city;
            }


            return state;
        }


        private string GetValueOrDefault(object value)
        {
            string text = Convert.ToString(value);
            return string.IsNullOrWhiteSpace(text)? "Not specified" : text.Trim();
        }


        private string ResolveResumeUrl(string filePath)
        {
            if (string.IsNullOrWhiteSpace(filePath))
            return "";

            filePath = filePath.Trim();

            if (filePath.StartsWith("http://",StringComparison.OrdinalIgnoreCase) || filePath.StartsWith("https://",StringComparison.OrdinalIgnoreCase))
            {
                return filePath;
            }


            if (filePath.StartsWith("~/"))
            {
                return ResolveUrl(filePath);
            }


            if (filePath.StartsWith("/"))
            {
                return ResolveUrl("~" + filePath);
            }


            return ResolveUrl("~/" + filePath.TrimStart('/'));
        }
    }
}