using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.JobSeeker
{
    public partial class EditProfile : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["Success24Connection"].ConnectionString;


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
                LoadBasicInformation();
                LoadProfessionalDetails();
                LoadJobPreferences();
                LoadSkills();
                LoadExperiences();
                LoadEducation();
                BindEducationYears();
                LoadProjects();
                RecalculateProfileCompletion();

            }
        }
        private void LoadProjects()
        {
            int jobSeekerId = GetJobSeekerId();

            if (jobSeekerId == 0)
            {
                pnlProjectList.Visible = false;
                pnlNoProjects.Visible = true;
                lblProjectCount.Text = "0";
                return;
            }

            const string query = @"SELECT ProjectId,ProjectTitle,ProjectRole,ClientCompany,StartDate,EndDate,IsCurrentProject,ProjectUrl,Technologies,ProjectDescription FROM JobSeekerProjects WHERE JobSeekerId = @JobSeekerId ORDER BY IsCurrentProject DESC,ISNULL(StartDate, '19000101') DESC,ProjectId DESC;";
            try
            {
                DataTable dt = new DataTable();

                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value = jobSeekerId;
                    using (SqlDataAdapter da =new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }

                rptProjects.DataSource = dt;
                rptProjects.DataBind();
                lblProjectCount.Text = dt.Rows.Count.ToString();
                pnlProjectList.Visible = dt.Rows.Count > 0;
                pnlNoProjects.Visible = dt.Rows.Count == 0;
            }
            catch (Exception ex)
            {
                pnlProjectList.Visible = false;
                pnlNoProjects.Visible = true;
                lblProjectCount.Text = "0";

                ShowMessage("Unable to load projects: " + ex.Message,false);
            }
        }
        private void BindEducationYears()
        {
            ddlEducationStartYear.Items.Clear();
            ddlEducationPassingYear.Items.Clear();
            ddlEducationStartYear.Items.Add(new ListItem("Start Year",""));
            ddlEducationPassingYear.Items.Add(new ListItem("Passing Year",""));
            int currentYear = DateTime.Now.Year;

            // Allow upcoming education completion
            // up to 6 years.

            for (int year = currentYear + 6; year >= 1970; year--)
            {
                string value = year.ToString();
                ddlEducationStartYear.Items.Add(new ListItem(value,value));
                ddlEducationPassingYear.Items.Add(new ListItem(value,value));
            }
        }

        private void LoadEducation()
        {
            try
            {
                int jobSeekerId = GetJobSeekerId();
                if (jobSeekerId == 0)
                {
                    pnlEducationList.Visible = false;
                    pnlNoEducation.Visible = true;
                    lblEducationCount.Text = "0";
                    return;
                }

                const string query = @"SELECT EducationId,Qualification,CourseName,Specialization,InstituteName,EducationType,StartYear,PassingYear,ScoreType,Score FROM JobSeekerEducation WHERE JobSeekerId =@JobSeekerId ORDER BY ISNULL(PassingYear, 0) DESC, EducationId DESC;";
                DataTable dt = new DataTable();


                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value =jobSeekerId;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }

                rptEducation.DataSource =dt;
                rptEducation.DataBind();
                lblEducationCount.Text = dt.Rows.Count.ToString();
                pnlEducationList.Visible = dt.Rows.Count > 0;
                pnlNoEducation.Visible = dt.Rows.Count == 0;
            }
            catch
            {
                pnlEducationList.Visible = false;
                pnlNoEducation.Visible = true;
                lblEducationCount.Text = "0";
                ShowMessage("Unable to load education details.",false);
            }
        }
        private void LoadExperiences()
        {
            try
            {
                int jobSeekerId = GetJobSeekerId();

                if (jobSeekerId == 0)
                {
                    pnlExperienceList.Visible = false;
                    pnlNoExperience.Visible = true;
                    lblExperienceCount.Text = "0";
                    return;
                }

                const string query = @"SELECT ExperienceId,Designation,CompanyName,EmploymentType,Location,StartDate,EndDate,IsCurrentJob,JobDescription FROM JobSeekerExperiences WHERE JobSeekerId = @JobSeekerId ORDER BY IsCurrentJob DESC,StartDate DESC;";

                DataTable dt = new DataTable();


                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value =jobSeekerId;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }

                rptExperiences.DataSource = dt;
                rptExperiences.DataBind();
                lblExperienceCount.Text = dt.Rows.Count.ToString();
                pnlExperienceList.Visible = dt.Rows.Count > 0;
                pnlNoExperience.Visible = dt.Rows.Count == 0;
            }
            catch
            {
                pnlExperienceList.Visible = false;
                pnlNoExperience.Visible = true;
                lblExperienceCount.Text = "0";
                ShowMessage("Unable to load work experience.",false);
            }
        }
        // ==========================================
        // LOAD BASIC INFORMATION
        // ==========================================

        private void LoadBasicInformation()
        {
            const string query = @" SELECT U.FullName,U.Email,U.Mobile,P.ProfilePhoto,P.Headline,P.ProfessionalSummary,P.CurrentCity,P.CurrentState FROM Users U LEFT JOIN JobSeekerProfiles P ON U.UserId = P.UserId WHERE U.UserId = @UserId;";

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd =new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            return;
                        }

                        string fullName = GetString(reader["FullName"]);
                        txtFullName.Text = fullName;
                        txtEmail.Text = GetString(reader["Email"]);
                        txtMobile.Text = GetString(reader["Mobile"]);
                        txtHeadline.Text = GetString(reader["Headline"]);
                        txtAbout.Text = GetString(reader["ProfessionalSummary"]);
                        txtCity.Text = GetString(reader["CurrentCity"]);
                        string state = GetString(reader["CurrentState"]);
                        if (!string.IsNullOrWhiteSpace(state) && ddlState.Items.FindByValue(state) != null)
                        {
                            ddlState.SelectedValue = state;
                        }

                        // INITIAL

                        if (!string.IsNullOrWhiteSpace(fullName))
                        {
                            lblProfileInitial.Text = Server.HtmlEncode(fullName.Substring(0, 1).ToUpper());
                        }
                        else
                        {
                            lblProfileInitial.Text = "U";
                        }

                        // PROFILE PHOTO

                        string photo = GetString(reader["ProfilePhoto"]);
                        if (!string.IsNullOrWhiteSpace(photo))
                        {
                            imgProfilePreview.ImageUrl = ResolveUrl(photo);
                            imgProfilePreview.Visible = true;
                            pnlProfileInitial.Visible = false;
                        }
                        else
                        {
                            imgProfilePreview.Visible = false;
                            pnlProfileInitial.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, false);
            }
        }

        // ==========================================
        // SAVE BASIC INFORMATION
        // ==========================================

        protected void btnSaveBasic_Click(object sender,EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }


            string fullName = txtFullName.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string headline = txtHeadline.Text.Trim();
            string about = txtAbout.Text.Trim();
            string city = txtCity.Text.Trim();
            string state = ddlState.SelectedValue.Trim();


            if (fullName.Length > 100 || mobile.Length > 15 || headline.Length > 150 || about.Length > 1500 || city.Length > 100 || state.Length > 100)
            {
                ShowMessage("One or more fields exceed the allowed length.",false);
                return;
            }
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();
                try
                {
                    // ==================================
                    // UPDATE USERS
                    // ==================================

                    const string userQuery = @"UPDATE Users SET FullName = @FullName,Mobile = @Mobile WHERE UserId = @UserId;";
                    using (SqlCommand cmd = new SqlCommand(userQuery,con,transaction))
                    {
                        cmd.Parameters.Add("@FullName",SqlDbType.NVarChar,100).Value = fullName;
                        cmd.Parameters.Add("@Mobile",SqlDbType.NVarChar,15).Value = mobile;
                        cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                        cmd.ExecuteNonQuery();
                    }

                    // ==================================
                    // UPDATE PROFILE
                    // ==================================

                    const string profileQuery = @"UPDATE JobSeekerProfiles SET Headline = @Headline,ProfessionalSummary = @ProfessionalSummary,CurrentCity = @CurrentCity,CurrentState = @CurrentState,UpdatedAt = SYSDATETIME() WHERE UserId = @UserId;";

                    using (SqlCommand cmd =new SqlCommand(profileQuery,con,transaction))
                    {
                        cmd.Parameters.Add("@Headline",SqlDbType.NVarChar,150).Value = DbValue(headline);
                        cmd.Parameters.Add("@ProfessionalSummary",SqlDbType.NVarChar,1500).Value = DbValue(about);
                        cmd.Parameters.Add("@CurrentCity",SqlDbType.NVarChar,100).Value = DbValue(city);
                        cmd.Parameters.Add("@CurrentState",SqlDbType.NVarChar,100).Value = DbValue(state);
                        cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                        int affected = cmd.ExecuteNonQuery();

                        // Profile row doesn't exist?
                        // Create it.

                        if (affected == 0)
                        {
                            const string insertQuery = @" INSERT INTO JobSeekerProfiles (UserId,Headline,ProfessionalSummary,CurrentCity,CurrentState,ProfileCompletion,CreatedAt,UpdatedAt) VALUES (@UserId,@Headline,@ProfessionalSummary,@CurrentCity,@CurrentState,0,SYSDATETIME(),SYSDATETIME());";

                            using (SqlCommand insertCmd = new SqlCommand(insertQuery,con,transaction))
                            {
                                insertCmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                                insertCmd.Parameters.Add("@Headline",SqlDbType.NVarChar,150).Value = DbValue(headline);
                                insertCmd.Parameters.Add("@ProfessionalSummary",SqlDbType.NVarChar,1500).Value = DbValue(about);
                                insertCmd.Parameters.Add("@CurrentCity",SqlDbType.NVarChar,100).Value = DbValue(city);
                                insertCmd.Parameters.Add("@CurrentState",SqlDbType.NVarChar,100).Value = DbValue(state);
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                    }

                    transaction.Commit();
                    // Keep Master Page session name updated.

                    Session["FullName"] = fullName;
                    ShowMessage("Basic information updated successfully.",true);
                    RecalculateProfileCompletion();
                    LoadBasicInformation();
                }
                catch
                {
                    try
                    {
                        transaction.Rollback();
                    }
                    catch
                    {
                    }


                    ShowMessage("Unable to update profile. Please try again.",false);
                }
            }
        }

        private void LoadProfessionalDetails()
        {
            const string query = @"SELECT CandidateType,CurrentDesignation,CurrentCompany,TotalExperienceMonths,CurrentSalary,ExpectedSalary,NoticePeriodDays,PreferredEmploymentType,PreferredWorkMode FROM JobSeekerProfiles WHERE UserId = @UserId;";
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            rbFresher.Checked = true;
                            return;
                        }


                        string candidateType = GetString(reader["CandidateType"]);
                        if (candidateType.Equals("Experienced",StringComparison.OrdinalIgnoreCase))
                        {
                            rbExperienced.Checked = true;
                        }
                        else
                        {
                            rbFresher.Checked = true;
                        }

                        txtCurrentDesignation.Text = GetString(reader["CurrentDesignation"]);
                        txtCurrentCompany.Text = GetString(reader["CurrentCompany"]);
                        // EXPERIENCE
                        int totalMonths = 0;
                        if (reader["TotalExperienceMonths"] != DBNull.Value)
                        {
                            totalMonths =    Convert.ToInt32(reader["TotalExperienceMonths"]);
                        }

                        int years = totalMonths / 12;
                        int months = totalMonths % 12;
                        if (years > 20)
                        {
                            years = 20;
                        }


                        if (ddlExperienceYears.Items.FindByValue(years.ToString()) != null)
                        {
                            ddlExperienceYears.SelectedValue = years.ToString();
                        }


                        if (ddlExperienceMonths.Items.FindByValue(months.ToString()) != null)
                        {
                            ddlExperienceMonths.SelectedValue = months.ToString();
                        }


                        // SALARY
                        if (reader["CurrentSalary"] != DBNull.Value)
                        {
                            txtCurrentSalary.Text = Convert.ToDecimal(reader["CurrentSalary"]).ToString("0");
                        }


                        if (reader["ExpectedSalary"] != DBNull.Value)
                        {
                            txtExpectedSalary.Text = Convert.ToDecimal(reader["ExpectedSalary"]).ToString("0");
                        }

                        SelectDropDownValue(ddlNoticePeriod,GetString(reader["NoticePeriodDays"]));
                        SelectDropDownValue(ddlEmploymentType,GetString(reader["PreferredEmploymentType"]));
                        SelectDropDownValue(ddlWorkMode,GetString(reader["PreferredWorkMode"]));
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, false);
            }
        }


        // ==========================================
        // PROFILE PHOTO UPLOAD
        // ==========================================

        protected void btnUploadPhoto_Click(object sender,EventArgs e)
        {
            if (!fuProfilePhoto.HasFile)
            {
                ShowMessage("Please select a profile photo.",false);
                return;
            }

            try
            {
                HttpPostedFile file =fuProfilePhoto.PostedFile;
                if (file == null || file.ContentLength <= 0)
                {
                    ShowMessage("Invalid profile photo.",false);
                    return;
                }

                // Maximum 2 MB

                const int maxSize = 2 * 1024 * 1024;
                if (file.ContentLength > maxSize)
                {
                    ShowMessage("Profile photo must be smaller than 2 MB.",false);
                    return;
                }

                string extension = Path.GetExtension(file.FileName).ToLowerInvariant();
                string[] allowedExtensions =
                {
                    ".jpg",
                    ".jpeg",
                    ".png"
                };


                if (Array.IndexOf(allowedExtensions,extension) < 0)
                {
                    ShowMessage("Only JPG, JPEG and PNG files are allowed.",false);
                    return;
                }


                // Validate MIME type too.

                string contentType =file.ContentType.ToLowerInvariant();
                if (contentType != "image/jpeg" && contentType != "image/png")
                {
                    ShowMessage("Invalid image format.",false);
                    return;
                }

                string folderVirtual ="~/Uploads/ProfilePhotos/";
                string folderPhysical = Server.MapPath(folderVirtual);
                if (!Directory.Exists(folderPhysical))
                {
                    Directory.CreateDirectory(folderPhysical);
                }

                string newFileName = "profile_" +UserId +"_" +Guid.NewGuid().ToString("N") + extension;
                string physicalPath = Path.Combine(folderPhysical,newFileName);
                file.SaveAs(physicalPath);
                string databasePath = folderVirtual + newFileName;
                UpdateProfilePhoto(databasePath);
                RecalculateProfileCompletion();
                ShowMessage("Profile photo updated successfully.",true);
                LoadBasicInformation();
            }
            catch(Exception ex)
            {
                ShowMessage("Upload Error: " + ex.ToString(), false);
            }
        }


        // ==========================================
        // UPDATE PROFILE PHOTO
        // ==========================================

        private void UpdateProfilePhoto(
            string photoPath)
        {
            const string query = @"UPDATE JobSeekerProfiles SET ProfilePhoto = @ProfilePhoto,UpdatedAt = SYSDATETIME() WHERE UserId = @UserId;";
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@ProfilePhoto",SqlDbType.NVarChar,500).Value = photoPath;
                cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                con.Open();
                int affected = cmd.ExecuteNonQuery();
                if (affected == 0)
                {
                    const string insertQuery = @"INSERT INTO JobSeekerProfiles (UserId,ProfilePhoto,ProfileCompletion,CreatedAt,UpdatedAt) VALUES (@UserId,@ProfilePhoto,0,SYSDATETIME(),SYSDATETIME());";

                    using (SqlCommand insertCmd = new SqlCommand(insertQuery,con))
                    {
                        insertCmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                        insertCmd.Parameters.Add("@ProfilePhoto",SqlDbType.NVarChar,500).Value = photoPath;
                        insertCmd.ExecuteNonQuery();
                    }
                }
            }
        }


        // ==========================================
        // MESSAGE
        // ==========================================

        private void ShowMessage(string message,bool success)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = Server.HtmlEncode(message);
            if (success)
            {
                messageBox.Attributes["class"] = "profile-message success";
                messageIcon.Attributes["class"] = "bi bi-check-circle";
            }
            else
            {
                messageBox.Attributes["class"] = "profile-message error";
                messageIcon.Attributes["class"] = "bi bi-exclamation-circle";
            }
        }


        // ==========================================
        // HELPERS
        // ==========================================

        private object DbValue(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return DBNull.Value;
            }

            return value.Trim();
        }


        private string GetString(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "";
            }

            return Convert.ToString(value).Trim();
        }

        private void RecalculateProfileCompletion()
        {
            int jobSeekerId = GetJobSeekerId();
            if (jobSeekerId == 0)
            {
                return;
            }

            int completion = 0;

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    // ==========================================
                    // 1. BASIC INFORMATION - 20%
                    // ==========================================

                    const string basicQuery = @"SELECT U.FullName,U.Mobile,P.ProfilePhoto,P.Headline,P.ProfessionalSummary,P.CurrentCity,P.CurrentState FROM Users U INNER JOIN JobSeekerProfiles P ON U.UserId = P.UserId WHERE U.UserId = @UserId;";
                    bool basicComplete = false;
                    using (SqlCommand cmd = new SqlCommand(basicQuery,con))
                    {
                        cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                bool fullName =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader["FullName"]
                                        )
                                    );

                                bool mobile =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader["Mobile"]
                                        )
                                    );

                                bool photo =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader["ProfilePhoto"]
                                        )
                                    );

                                bool headline =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader["Headline"]
                                        )
                                    );

                                bool summary =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader["ProfessionalSummary"]
                                        )
                                    );

                                bool city =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader["CurrentCity"]
                                        )
                                    );

                                bool state =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader["CurrentState"]
                                        )
                                    );

                                if (fullName && mobile && photo && headline && summary && city && state)
                                {
                                    basicComplete = true;
                                }
                            }
                        }
                    }

                    if (basicComplete)
                    {
                        completion += 20;
                    }


                    // ==========================================
                    // 2. PROFESSIONAL DETAILS - 15%
                    // ==========================================

                    const string professionalQuery = @"SELECT CandidateType,CurrentDesignation,CurrentCompany,TotalExperienceMonths,ExpectedSalary,PreferredEmploymentType,PreferredWorkMode FROM JobSeekerProfiles WHERE UserId = @UserId;";
                    bool professionalComplete = false;
                    using (SqlCommand cmd = new SqlCommand(professionalQuery,con))
                    {
                        cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string candidateType =GetString(reader["CandidateType"]);
                                bool candidateSelected =
                                    !string.IsNullOrWhiteSpace(
                                        candidateType
                                    );

                                bool employmentType =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader[
                                                "PreferredEmploymentType"
                                            ]
                                        )
                                    );

                                bool workMode =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader[
                                                "PreferredWorkMode"
                                            ]
                                        )
                                    );

                                bool expectedSalary = reader["ExpectedSalary"]!= DBNull.Value;
                                bool experienceValid;
                                if (candidateType.Equals("Fresher",StringComparison.OrdinalIgnoreCase))
                                {
                                    experienceValid = true;
                                }
                                else
                                {
                                    bool designation =
                                        !string.IsNullOrWhiteSpace(
                                            GetString(
                                                reader[
                                                    "CurrentDesignation"
                                                ]
                                            )
                                        );

                                    bool company =
                                        !string.IsNullOrWhiteSpace(
                                            GetString(
                                                reader[
                                                    "CurrentCompany"
                                                ]
                                            )
                                        );

                                    bool experience = reader["TotalExperienceMonths"] != DBNull.Value && Convert.ToInt32(reader["TotalExperienceMonths"]) > 0;
                                    experienceValid = designation && company && experience;
                                }

                                if (candidateType.Equals("Fresher",StringComparison.OrdinalIgnoreCase))
                                {
                                    professionalComplete = candidateSelected && employmentType && workMode;
                                }
                                else
                                {
                                    professionalComplete = candidateSelected && experienceValid && expectedSalary && employmentType && workMode;
                                }
                            }
                        }
                    }

                    if (professionalComplete)
                    {
                        completion += 15;
                    }


                    // ==========================================
                    // 3. WORK EXPERIENCE - 15%
                    // ==========================================

                    const string experienceQuery = @"SELECT COUNT(*) FROM JobSeekerExperiences WHERE JobSeekerId = @JobSeekerId;";
                    int experienceCount = 0;

                    using (SqlCommand cmd = new SqlCommand(experienceQuery,con))
                    {
                        cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value = jobSeekerId;
                        experienceCount = Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    if (experienceCount > 0)
                    {
                        completion += 15;
                    }


                    // ==========================================
                    // 4. EDUCATION - 15%
                    // ==========================================

                    const string educationQuery = @"SELECT COUNT(*) FROM JobSeekerEducation WHERE JobSeekerId = @JobSeekerId;";
                    int educationCount = 0;

                    using (SqlCommand cmd = new SqlCommand(educationQuery,con))
                    {
                        cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value = jobSeekerId;
                        educationCount = Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    if (educationCount > 0)
                    {
                        completion += 15;
                    }


                    // ==========================================
                    // 5. SKILLS - 10%
                    // ==========================================

                    const string skillQuery = @"SELECT COUNT(*) FROM JobSeekerSkills WHERE JobSeekerId = @JobSeekerId;";
                    int skillCount = 0;

                    using (SqlCommand cmd = new SqlCommand(skillQuery,con))
                    {
                        cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value = jobSeekerId;
                        skillCount =Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    if (skillCount > 0)
                    {
                        completion += 10;
                    }


                    // ==========================================
                    // 6. PROJECTS - 10%
                    // ==========================================

                    const string projectQuery = @"SELECT COUNT(*) FROM JobSeekerProjects WHERE JobSeekerId = @JobSeekerId;";
                    int projectCount = 0;

                    using (SqlCommand cmd = new SqlCommand(projectQuery,con))
                    {
                        cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value = jobSeekerId;
                        projectCount =Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    if (projectCount > 0)
                    {
                        completion += 10;
                    }


                    // ==========================================
                    // 7. RESUME - 10%
                    // ==========================================

                    const string resumeQuery = @"SELECT COUNT(*) FROM JobSeekerResumes WHERE JobSeekerId = @JobSeekerId AND IsPrimary = 1;";
                    int resumeCount = 0;
                    using (SqlCommand cmd = new SqlCommand(resumeQuery,con))
                    {
                        cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value = jobSeekerId;
                        resumeCount =Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    if (resumeCount > 0)
                    {
                        completion += 10;
                    }


                    // ==========================================
                    // 8. JOB PREFERENCES - 5%
                    // ==========================================

                    const string preferenceQuery = @"SELECT PreferredRole,PreferredLocation FROM JobSeekerProfiles WHERE UserId = @UserId;";
                    bool preferenceComplete = false;
                    using (SqlCommand cmd = new SqlCommand(preferenceQuery,con))
                    {
                        cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                        using (SqlDataReader reader =cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                bool role =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader[
                                                "PreferredRole"
                                            ]
                                        )
                                    );

                                bool location =
                                    !string.IsNullOrWhiteSpace(
                                        GetString(
                                            reader[
                                                "PreferredLocation"
                                            ]
                                        )
                                    );

                                preferenceComplete =
                                    role && location;
                            }
                        }
                    }

                    if (preferenceComplete)
                    {
                        completion += 5;
                    }


                    // ==========================================
                    // SAVE FINAL PERCENTAGE
                    // ==========================================

                    if (completion > 100)
                    {
                        completion = 100;
                    }

                    const string updateQuery = @"UPDATE JobSeekerProfiles SET ProfileCompletion = @ProfileCompletion,UpdatedAt = SYSDATETIME() WHERE JobSeekerId = @JobSeekerId;";
                    using (SqlCommand cmd = new SqlCommand(updateQuery,con))
                    {
                        cmd.Parameters.Add("@ProfileCompletion",SqlDbType.Int).Value = completion;
                        cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value = jobSeekerId;
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch
            {
                // Do not interrupt profile save operation.
            }
        }

        protected void btnSaveProfessional_Click(object sender,EventArgs e)
        {
            string candidateType =
                rbExperienced.Checked
                    ? "Experienced"
                    : "Fresher";


            string designation = txtCurrentDesignation.Text.Trim();
            string company = txtCurrentCompany.Text.Trim();
            int years =Convert.ToInt32(ddlExperienceYears.SelectedValue);
            int months = Convert.ToInt32(ddlExperienceMonths.SelectedValue);
            int totalExperienceMonths = (years * 12) + months;
            decimal? currentSalary = ParseSalary(txtCurrentSalary.Text);
            decimal? expectedSalary = ParseSalary(txtExpectedSalary.Text);
            // ==========================================
            // NOTICE PERIOD
            // ==========================================

            int noticePeriodDays = 0;

            int.TryParse(ddlNoticePeriod.SelectedValue,out noticePeriodDays);
            string employmentType = ddlEmploymentType.SelectedValue;
            string workMode = ddlWorkMode.SelectedValue;
            // ==========================================
            // FRESHER
            // ==========================================

            if (candidateType == "Fresher")
            {
                designation = "";
                company = "";
                totalExperienceMonths = 0;
                currentSalary = null;
                noticePeriodDays = 0;
            }


            // ==========================================
            // EXPERIENCED VALIDATION
            // ==========================================

            if (candidateType == "Experienced")
            {
                if (string.IsNullOrWhiteSpace(designation))
                {
                    ShowMessage("Please enter your current designation.",false);
                    return;
                }


                if (string.IsNullOrWhiteSpace(company))
                {
                    ShowMessage("Please enter your current company.",false);
                    return;
                }


                if (totalExperienceMonths <= 0)
                {
                    ShowMessage("Please select your total experience.",false);
                    return;
                }
            }


            const string query = @"UPDATE JobSeekerProfiles SET CandidateType =@CandidateType,CurrentDesignation =@CurrentDesignation,CurrentCompany =@CurrentCompany,TotalExperienceMonths =@TotalExperienceMonths,CurrentSalary =@CurrentSalary,ExpectedSalary =@ExpectedSalary,NoticePeriodDays =@NoticePeriodDays,PreferredEmploymentType =@PreferredEmploymentType,PreferredWorkMode =@PreferredWorkMode,UpdatedAt =SYSDATETIME() WHERE UserId =@UserId;";
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@CandidateType",SqlDbType.NVarChar,20).Value = candidateType;
                    cmd.Parameters.Add("@CurrentDesignation",SqlDbType.NVarChar,150).Value = DbValue(designation);
                    cmd.Parameters.Add("@CurrentCompany",SqlDbType.NVarChar,150).Value = DbValue(company);
                    cmd.Parameters.Add("@TotalExperienceMonths",SqlDbType.Int).Value = totalExperienceMonths;
                    SqlParameter currentSalaryParam =cmd.Parameters.Add("@CurrentSalary",SqlDbType.Decimal);
                    currentSalaryParam.Precision = 18;
                    currentSalaryParam.Scale = 2;
                    currentSalaryParam.Value = currentSalary.HasValue? (object)currentSalary.Value: DBNull.Value;
                    SqlParameter expectedSalaryParam = cmd.Parameters.Add("@ExpectedSalary",SqlDbType.Decimal);
                    expectedSalaryParam.Precision = 18;
                    expectedSalaryParam.Scale = 2;
                    expectedSalaryParam.Value = expectedSalary.HasValue? (object)expectedSalary.Value: DBNull.Value;
                    // =====================================
                    // NOTICE PERIOD
                    // =====================================
                    cmd.Parameters.Add("@NoticePeriodDays",SqlDbType.Int).Value = noticePeriodDays;
                    // =====================================
                    // EMPLOYMENT TYPE
                    // =====================================

                    cmd.Parameters.Add("@PreferredEmploymentType",SqlDbType.NVarChar,50).Value = DbValue(employmentType);
                    // =====================================
                    // WORK MODE
                    // =====================================

                    cmd.Parameters.Add("@PreferredWorkMode",SqlDbType.NVarChar,50).Value = DbValue(workMode);
                    cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = UserId;
                    con.Open();
                    int affected =cmd.ExecuteNonQuery();
                    if (affected == 0)
                    {
                        ShowMessage("Job seeker profile was not found.",false);
                        return;
                    }
                }


                ShowMessage("Professional details updated successfully.",true);
                RecalculateProfileCompletion();
                LoadProfessionalDetails();
            }
            catch (Exception ex)
            {
                ShowMessage("Unable to update professional details: " + ex.Message,false);
            }
        }

        private void LoadJobPreferences()
        {
            const string query = @"SELECT PreferredRole,PreferredLocation,PreferredIndustry,PreferredShift FROM JobSeekerProfiles WHERE UserId = @UserId;";
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


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            return;
                        }


                        txtPreferredRole.Text =
                            GetString(
                                reader["PreferredRole"]
                            );


                        txtPreferredLocation.Text =
                            GetString(
                                reader["PreferredLocation"]
                            );


                        SelectDropDownValue(
                            ddlPreferredIndustry,
                            GetString(
                                reader["PreferredIndustry"]
                            )
                        );


                        SelectDropDownValue(
                            ddlPreferredShift,
                            GetString(
                                reader["PreferredShift"]
                            )
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, false);
            }
        }
        protected void btnSavePreferences_Click(object sender, EventArgs e)
        {
            string preferredRole =
    txtPreferredRole.Text.Trim();


            string preferredLocation =
                txtPreferredLocation.Text.Trim();


            string preferredIndustry =
                ddlPreferredIndustry.SelectedValue;


            string preferredShift =
                ddlPreferredShift.SelectedValue;


            if (preferredRole.Length > 150 ||
                preferredLocation.Length > 200)
            {
                ShowMessage(
                    "One or more preference fields are too long.",
                    false
                );

                return;
            }


            const string query = @"UPDATE JobSeekerProfiles SET PreferredRole =@PreferredRole,PreferredLocation =@PreferredLocation,PreferredIndustry =@PreferredIndustry,PreferredShift =@PreferredShift,UpdatedAt =SYSDATETIME() WHERE UserId =@UserId;";

            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@PreferredRole",
                        SqlDbType.NVarChar,
                        150
                    ).Value =
                        DbValue(preferredRole);


                    cmd.Parameters.Add(
                        "@PreferredLocation",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        DbValue(preferredLocation);


                    cmd.Parameters.Add(
                        "@PreferredIndustry",
                        SqlDbType.NVarChar,
                        100
                    ).Value =
                        DbValue(preferredIndustry);


                    cmd.Parameters.Add(
                        "@PreferredShift",
                        SqlDbType.NVarChar,
                        50
                    ).Value =
                        DbValue(preferredShift);


                    cmd.Parameters.Add(
                        "@UserId",
                        SqlDbType.Int
                    ).Value =
                        UserId;


                    con.Open();


                    int affected =
                        cmd.ExecuteNonQuery();


                    if (affected == 0)
                    {
                        ShowMessage(
                            "Job seeker profile was not found.",
                            false
                        );

                        return;
                    }
                }


                ShowMessage(
                    "Job preferences updated successfully.",
                    true
                );

                RecalculateProfileCompletion();
                LoadJobPreferences();
            }
            catch
            {
                ShowMessage(
                    "Unable to update job preferences.",
                    false
                );
            }
        }
            private decimal? ParseSalary(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return null;
            }


            decimal salary;


            if (decimal.TryParse(
                    value.Trim(),
                    out salary))
            {
                if (salary >= 0)
                {
                    return salary;
                }
            }


            return null;
        }

        
        private void SelectDropDownValue(
            System.Web.UI.WebControls.DropDownList ddl,
            string value)
        {
            ddl.ClearSelection();


            if (string.IsNullOrWhiteSpace(value))
            {
                if (ddl.Items.Count > 0)
                {
                    ddl.SelectedIndex = 0;
                }

                return;
            }


            System.Web.UI.WebControls.ListItem item =
                ddl.Items.FindByValue(value);


            if (item != null)
            {
                item.Selected = true;
            }
        }

        private int GetJobSeekerId()
        {
            const string query = @"SELECT JobSeekerId FROM JobSeekerProfiles WHERE UserId = @UserId;";

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

        private void LoadSkills()
        {
            try
            {
                int jobSeekerId = GetJobSeekerId();

                if (jobSeekerId == 0)
                {
                    pnlSkills.Visible = false;
                    pnlNoEditSkills.Visible = true;
                    lblSkillCount.Text = "0";
                    return;
                }

                const string query = @"SELECT JS.JobSeekerSkillId,JS.SkillId,S.SkillName,JS.ExperienceMonths FROM JobSeekerSkills JS INNER JOIN Skills S ON JS.SkillId = S.SkillId WHERE JS.JobSeekerId = @JobSeekerId ORDER BY S.SkillName ASC;";
                DataTable dt = new DataTable();

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


                rptEditSkills.DataSource = dt;
                rptEditSkills.DataBind();

                lblSkillCount.Text =
                    dt.Rows.Count.ToString();

                pnlSkills.Visible =
                    dt.Rows.Count > 0;

                pnlNoEditSkills.Visible =
                    dt.Rows.Count == 0;
            }
            catch
            {
                pnlSkills.Visible = false;
                pnlNoEditSkills.Visible = true;
                lblSkillCount.Text = "0";

                ShowMessage(
                    "Unable to load skills.",
                    false
                );
            }
        }
        protected void btnAddSkill_Click(object sender, EventArgs e)
        {
            string skillName = txtSkill.Text.Trim();

            if (string.IsNullOrWhiteSpace(skillName))
            {
                ShowMessage(
                    "Please enter a skill.",
                    false
                );

                return;
            }

            if (skillName.Length > 100)
            {
                ShowMessage(
                    "Skill name cannot exceed 100 characters.",
                    false
                );

                return;
            }


            int jobSeekerId =
                GetJobSeekerId();

            if (jobSeekerId == 0)
            {
                ShowMessage(
                    "Please save your basic profile first.",
                    false
                );

                return;
            }


            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    int skillId = 0;


                    // =====================================
                    // FIND SKILL
                    // =====================================

                    const string findSkillQuery = @"SELECT TOP 1 SkillId FROM Skills WHERE LOWER(LTRIM(RTRIM(SkillName))) =LOWER(LTRIM(RTRIM(@SkillName)));";
                    using (SqlCommand cmd =
                           new SqlCommand(
                               findSkillQuery,
                               con,
                               transaction))
                    {
                        cmd.Parameters.Add(
                            "@SkillName",
                            SqlDbType.NVarChar,
                            100
                        ).Value = skillName;


                        object result =
                            cmd.ExecuteScalar();


                        if (result != null &&
                            result != DBNull.Value)
                        {
                            skillId =
                                Convert.ToInt32(result);
                        }
                    }


                    // =====================================
                    // CREATE MASTER SKILL IF NOT FOUND
                    // =====================================

                    if (skillId == 0)
                    {
                        const string insertSkillQuery = @"INSERT INTO Skills(SkillName)VALUES(@SkillName);
                            SELECT CAST(SCOPE_IDENTITY() AS INT);";


                        using (SqlCommand cmd =
                               new SqlCommand(
                                   insertSkillQuery,
                                   con,
                                   transaction))
                        {
                            cmd.Parameters.Add(
                                "@SkillName",
                                SqlDbType.NVarChar,
                                100
                            ).Value = skillName;


                            skillId =
                                Convert.ToInt32(
                                    cmd.ExecuteScalar()
                                );
                        }
                    }


                    // =====================================
                    // CHECK CANDIDATE ALREADY HAS SKILL
                    // =====================================

                    const string duplicateQuery = @"SELECT COUNT(*) FROM JobSeekerSkills WHERE JobSeekerId =@JobSeekerId AND SkillId =@SkillId;";
                    using (SqlCommand cmd =
                           new SqlCommand(
                               duplicateQuery,
                               con,
                               transaction))
                    {
                        cmd.Parameters.Add(
                            "@JobSeekerId",
                            SqlDbType.Int
                        ).Value = jobSeekerId;


                        cmd.Parameters.Add(
                            "@SkillId",
                            SqlDbType.Int
                        ).Value = skillId;


                        int exists =
                            Convert.ToInt32(
                                cmd.ExecuteScalar()
                            );


                        if (exists > 0)
                        {
                            transaction.Rollback();

                            ShowMessage(
                                "This skill is already added.",
                                false
                            );

                            return;
                        }
                    }


                    // =====================================
                    // INSERT JOB SEEKER SKILL
                    // =====================================

                    const string insertQuery = @"INSERT INTO JobSeekerSkills(JobSeekerId,SkillId,ExperienceMonths) VALUES (@JobSeekerId,@SkillId,NULL);";

                    using (SqlCommand cmd =
                           new SqlCommand(
                               insertQuery,
                               con,
                               transaction))
                    {
                        cmd.Parameters.Add(
                            "@JobSeekerId",
                            SqlDbType.Int
                        ).Value = jobSeekerId;


                        cmd.Parameters.Add(
                            "@SkillId",
                            SqlDbType.Int
                        ).Value = skillId;


                        cmd.ExecuteNonQuery();
                    }


                    transaction.Commit();


                    txtSkill.Text = "";
                    RecalculateProfileCompletion();


                    ShowMessage(
                        "Skill added successfully.",
                        true
                    );


                    LoadSkills();
                }
                catch
                {
                    try
                    {
                        transaction.Rollback();
                    }
                    catch
                    {
                    }


                    ShowMessage(
                        "Unable to add skill.",
                        false
                    );
                }
            }
        }

        protected void rptEditSkills_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "DeleteSkill")
            {
                return;
            }


            int jobSeekerSkillId;

            if (!int.TryParse(
                    Convert.ToString(
                        e.CommandArgument
                    ),
                    out jobSeekerSkillId))
            {
                return;
            }


            int jobSeekerId =
                GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                return;
            }


            const string query = @"DELETE FROM JobSeekerSkills WHERE JobSeekerSkillId =@JobSeekerSkillId AND JobSeekerId =@JobSeekerId;";
            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@JobSeekerSkillId",
                        SqlDbType.Int
                    ).Value =
                        jobSeekerSkillId;


                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value =
                        jobSeekerId;


                    con.Open();

                    int affected =
                        cmd.ExecuteNonQuery();


                    if (affected > 0)
                    {
                        ShowMessage(
                            "Skill removed successfully.",
                            true
                        );
                    }
                }

                RecalculateProfileCompletion();

                LoadSkills();
            }
            catch
            {
                ShowMessage(
                    "Unable to remove skill.",
                    false
                );
            }

        }
        private void DeleteExperience(
    int experienceId)
        {
            int jobSeekerId =
                GetJobSeekerId();


            const string query = @"DELETE FROM JobSeekerExperiences WHERE ExperienceId =@ExperienceId AND JobSeekerId =@JobSeekerId;";
            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@ExperienceId",
                        SqlDbType.Int
                    ).Value =
                        experienceId;


                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value =
                        jobSeekerId;


                    con.Open();


                    int affected =
                        cmd.ExecuteNonQuery();


                    if (affected > 0)
                    {
                        ShowMessage(
                            "Work experience deleted successfully.",
                            true
                        );
                    }
                }


                ResetExperienceForm();

                LoadExperiences();

                UpdateTotalExperience();
                RecalculateProfileCompletion();

            }
            catch
            {
                ShowMessage(
                    "Unable to delete work experience.",
                    false
                );
            }
        }

        protected void btnCancelExperience_Click(object sender, EventArgs e)
        {
            ResetExperienceForm();
        }

        private void ResetExperienceForm()
        {
            hfExperienceId.Value = "0";

            txtExperienceDesignation.Text = "";
            txtExperienceCompany.Text = "";

            ddlExperienceEmploymentType.SelectedIndex = 0;

            txtExperienceLocation.Text = "";

            txtExperienceStartDate.Text = "";
            txtExperienceEndDate.Text = "";

            chkCurrentJob.Checked = false;

            txtExperienceDescription.Text = "";

            lblExperienceFormTitle.Text =
                "Add Experience";

            btnSaveExperience.Text =
                "Add Experience";

            btnCancelExperience.Visible =
                false;
        }
        protected void btnSaveExperience_Click(object sender, EventArgs e)
        {
            int jobSeekerId =
       GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                ShowMessage(
                    "Please save your profile first.",
                    false
                );

                return;
            }


            string designation =
                txtExperienceDesignation.Text.Trim();


            string company =
                txtExperienceCompany.Text.Trim();


            string employmentType =
                ddlExperienceEmploymentType.SelectedValue;


            string location =
                txtExperienceLocation.Text.Trim();


            string description =
                txtExperienceDescription.Text.Trim();


            if (string.IsNullOrWhiteSpace(designation))
            {
                ShowMessage(
                    "Please enter your designation.",
                    false
                );

                return;
            }


            if (string.IsNullOrWhiteSpace(company))
            {
                ShowMessage(
                    "Please enter company name.",
                    false
                );

                return;
            }


            DateTime startDate;


            if (!DateTime.TryParse(
                    txtExperienceStartDate.Text,
                    out startDate))
            {
                ShowMessage(
                    "Please select a valid start date.",
                    false
                );

                return;
            }


            bool isCurrent =
                chkCurrentJob.Checked;


            DateTime? endDate =
                null;


            if (!isCurrent)
            {
                DateTime parsedEndDate;


                if (!DateTime.TryParse(
                        txtExperienceEndDate.Text,
                        out parsedEndDate))
                {
                    ShowMessage(
                        "Please select an end date.",
                        false
                    );

                    return;
                }


                if (parsedEndDate < startDate)
                {
                    ShowMessage(
                        "End date cannot be earlier than start date.",
                        false
                    );

                    return;
                }


                endDate =
                    parsedEndDate;
            }


            if (startDate.Date > DateTime.Today)
            {
                ShowMessage(
                    "Start date cannot be in the future.",
                    false
                );

                return;
            }


            if (endDate.HasValue &&
                endDate.Value.Date > DateTime.Today)
            {
                ShowMessage(
                    "End date cannot be in the future.",
                    false
                );

                return;
            }


            int experienceId = 0;

            int.TryParse(
                hfExperienceId.Value,
                out experienceId
            );


            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                {
                    con.Open();


                    // =====================================
                    // INSERT
                    // =====================================

                    if (experienceId == 0)
                    {
                        const string query = @"INSERT INTO JobSeekerExperiences(JobSeekerId,Designation,CompanyName,EmploymentType,Location,StartDate,EndDate,IsCurrentJob,JobDescription,CreatedAt)VALUES(@JobSeekerId,@Designation,@CompanyName,@EmploymentType,@Location,@StartDate,@EndDate,@IsCurrentJob,@JobDescription,SYSDATETIME());";
                        using (SqlCommand cmd =
                               new SqlCommand(query, con))
                        {
                            AddExperienceParameters(
                                cmd,
                                jobSeekerId,
                                designation,
                                company,
                                employmentType,
                                location,
                                startDate,
                                endDate,
                                isCurrent,
                                description
                            );


                            cmd.ExecuteNonQuery();
                        }


                        ShowMessage(
                            "Work experience added successfully.",
                            true
                        );
                    }

                    // =====================================
                    // UPDATE
                    // =====================================

                    else
                    {
                        const string query = @"UPDATE JobSeekerExperiences SET Designation = @Designation,CompanyName = @CompanyName,EmploymentType = @EmploymentType,Location = @Location,StartDate = @StartDate,EndDate = @EndDate,IsCurrentJob = @IsCurrentJob,JobDescription = @JobDescription,UpdatedAt = SYSDATETIME() WHERE ExperienceId = @ExperienceId AND JobSeekerId = @JobSeekerId;";
                        using (SqlCommand cmd =
                               new SqlCommand(query, con))
                        {
                            AddExperienceParameters(
                                cmd,
                                jobSeekerId,
                                designation,
                                company,
                                employmentType,
                                location,
                                startDate,
                                endDate,
                                isCurrent,
                                description
                            );


                            cmd.Parameters.Add(
                                "@ExperienceId",
                                SqlDbType.Int
                            ).Value =
                                experienceId;


                            int affected =
                                cmd.ExecuteNonQuery();


                            if (affected == 0)
                            {
                                ShowMessage(
                                    "Experience record was not found.",
                                    false
                                );

                                return;
                            }
                        }


                        ShowMessage(
                            "Work experience updated successfully.",
                            true
                        );
                    }
                }


                ResetExperienceForm();

                LoadExperiences();

                UpdateTotalExperience();
                RecalculateProfileCompletion();

            }
            catch
            {
                ShowMessage(
                    "Unable to save work experience.",
                    false
                );
            }
        }
        private void UpdateTotalExperience()
        {
            int jobSeekerId =
                GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                return;
            }


            const string query = @"SELECT MIN(StartDate) AS FirstStartDate,MAX(CASE WHEN IsCurrentJob = 1 THEN CAST(GETDATE() AS DATE) ELSE EndDate END) AS LastEndDate FROM JobSeekerExperiences WHERE JobSeekerId =@JobSeekerId;";
            try
            {
                DateTime? firstDate = null;
                DateTime? lastDate = null;


                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value =
                        jobSeekerId;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (reader["FirstStartDate"]
                                != DBNull.Value)
                            {
                                firstDate =
                                    Convert.ToDateTime(
                                        reader["FirstStartDate"]
                                    );
                            }


                            if (reader["LastEndDate"]
                                != DBNull.Value)
                            {
                                lastDate =
                                    Convert.ToDateTime(
                                        reader["LastEndDate"]
                                    );
                            }
                        }
                    }
                }


                int totalMonths = 0;


                if (firstDate.HasValue &&
                    lastDate.HasValue)
                {
                    totalMonths =
                        (
                            lastDate.Value.Year -
                            firstDate.Value.Year
                        ) * 12

                        +

                        (
                            lastDate.Value.Month -
                            firstDate.Value.Month
                        );


                    if (lastDate.Value.Day >=
                        firstDate.Value.Day)
                    {
                        totalMonths++;
                    }


                    if (totalMonths < 0)
                    {
                        totalMonths = 0;
                    }
                }


                const string updateQuery = @"UPDATE JobSeekerProfiles SET TotalExperienceMonths =@TotalExperienceMonths,UpdatedAt =SYSDATETIME() WHERE JobSeekerId =@JobSeekerId;";
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.Add(
                        "@TotalExperienceMonths",
                        SqlDbType.Int
                    ).Value =
                        totalMonths;


                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value =
                        jobSeekerId;


                    con.Open();

                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {
                // Don't stop experience save/delete
                // just because recalculation failed.
            }
        }
        private void AddExperienceParameters(SqlCommand cmd,int jobSeekerId,string designation,string company,string employmentType,string location,DateTime startDate,DateTime? endDate,bool isCurrent,string description)
        {
            cmd.Parameters.Add(
                "@JobSeekerId",
                SqlDbType.Int
            ).Value =
                jobSeekerId;


            cmd.Parameters.Add(
                "@Designation",
                SqlDbType.NVarChar,
                150
            ).Value =
                designation;


            cmd.Parameters.Add(
                "@CompanyName",
                SqlDbType.NVarChar,
                150
            ).Value =
                company;


            cmd.Parameters.Add(
                "@EmploymentType",
                SqlDbType.NVarChar,
                50
            ).Value =
                DbValue(employmentType);


            cmd.Parameters.Add(
                "@Location",
                SqlDbType.NVarChar,
                150
            ).Value =
                DbValue(location);


            cmd.Parameters.Add(
                "@StartDate",
                SqlDbType.Date
            ).Value =
                startDate.Date;


            cmd.Parameters.Add(
                "@EndDate",
                SqlDbType.Date
            ).Value =
                endDate.HasValue
                    ? (object)endDate.Value.Date
                    : DBNull.Value;


            cmd.Parameters.Add(
                "@IsCurrentJob",
                SqlDbType.Bit
            ).Value =
                isCurrent;


            cmd.Parameters.Add(
                "@JobDescription",
                SqlDbType.NVarChar,
                2000
            ).Value =
                DbValue(description);
        }

        private void LoadExperienceForEdit(
    int experienceId)
        {
            int jobSeekerId =
                GetJobSeekerId();


            const string query = @"SELECT ExperienceId,Designation,CompanyName,EmploymentType,Location,StartDate,EndDate,IsCurrentJob,JobDescription FROM JobSeekerExperiences WHERE ExperienceId =@ExperienceId AND JobSeekerId =@JobSeekerId;";
            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@ExperienceId",
                        SqlDbType.Int
                    ).Value =
                        experienceId;


                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value =
                        jobSeekerId;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            ShowMessage(
                                "Experience record was not found.",
                                false
                            );

                            return;
                        }


                        hfExperienceId.Value =
                            Convert.ToString(
                                reader["ExperienceId"]
                            );


                        txtExperienceDesignation.Text =
                            GetString(
                                reader["Designation"]
                            );


                        txtExperienceCompany.Text =
                            GetString(
                                reader["CompanyName"]
                            );


                        SelectDropDownValue(
                            ddlExperienceEmploymentType,
                            GetString(
                                reader["EmploymentType"]
                            )
                        );


                        txtExperienceLocation.Text =
                            GetString(
                                reader["Location"]
                            );


                        txtExperienceStartDate.Text =
                            Convert.ToDateTime(
                                reader["StartDate"]
                            )
                            .ToString("yyyy-MM-dd");


                        bool isCurrent =
                            Convert.ToBoolean(
                                reader["IsCurrentJob"]
                            );


                        chkCurrentJob.Checked =
                            isCurrent;


                        if (reader["EndDate"] != DBNull.Value)
                        {
                            txtExperienceEndDate.Text =
                                Convert.ToDateTime(
                                    reader["EndDate"]
                                )
                                .ToString("yyyy-MM-dd");
                        }
                        else
                        {
                            txtExperienceEndDate.Text =
                                "";
                        }


                        txtExperienceDescription.Text =
                            GetString(
                                reader["JobDescription"]
                            );
                    }
                }


                lblExperienceFormTitle.Text =
                    "Edit Experience";


                btnSaveExperience.Text =
                    "Update Experience";


                btnCancelExperience.Visible =
                    true;


                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ExperienceEdit",
                    "toggleCurrentJob();" +
                    "document.getElementById('experience').scrollIntoView({behavior:'smooth'});",
                    true
                );
            }
            catch
            {
                ShowMessage(
                    "Unable to load experience.",
                    false
                );
            }
        }
        protected string FormatExperienceDate(object startDateValue,object endDateValue,object currentValue)
        {
            if (startDateValue == null ||
                startDateValue == DBNull.Value)
            {
                return "";
            }


            DateTime startDate =
                Convert.ToDateTime(
                    startDateValue
                );


            bool isCurrent =
                currentValue != DBNull.Value &&
                Convert.ToBoolean(
                    currentValue
                );


            string start =
                startDate.ToString(
                    "MMM yyyy"
                );


            string end;


            if (isCurrent)
            {
                end = "Present";
            }
            else if (endDateValue != null &&
                     endDateValue != DBNull.Value)
            {
                end =
                    Convert.ToDateTime(
                        endDateValue
                    )
                    .ToString(
                        "MMM yyyy"
                    );
            }
            else
            {
                end = "";
            }


            return Server.HtmlEncode(
                string.IsNullOrWhiteSpace(end)
                    ? start
                    : start + " - " + end
            );
        }
        protected void rptExperiences_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int experienceId;


            if (!int.TryParse(
                    Convert.ToString(
                        e.CommandArgument
                    ),
                    out experienceId))
            {
                return;
            }


            if (e.CommandName == "EditExperience")
            {
                LoadExperienceForEdit(
                    experienceId
                );
            }


            if (e.CommandName == "DeleteExperience")
            {
                DeleteExperience(
                    experienceId
                );
            }

        }
        private void AddEducationParameters(SqlCommand cmd,int jobSeekerId,string qualification,string courseName,string specialization,string institute,string educationType,int? startYear,int? passingYear,string scoreType,decimal? score)
        {
            cmd.Parameters.Add(
                "@JobSeekerId",
                SqlDbType.Int
            ).Value =
                jobSeekerId;


            cmd.Parameters.Add(
                "@Qualification",
                SqlDbType.NVarChar,
                100
            ).Value =
                qualification;


            cmd.Parameters.Add(
                "@CourseName",
                SqlDbType.NVarChar,
                150
            ).Value =
                DbValue(courseName);


            cmd.Parameters.Add(
                "@Specialization",
                SqlDbType.NVarChar,
                150
            ).Value =
                DbValue(specialization);


            cmd.Parameters.Add(
                "@InstituteName",
                SqlDbType.NVarChar,
                200
            ).Value =
                institute;


            cmd.Parameters.Add(
                "@EducationType",
                SqlDbType.NVarChar,
                50
            ).Value =
                DbValue(educationType);


            cmd.Parameters.Add(
                "@StartYear",
                SqlDbType.Int
            ).Value =
                startYear.HasValue
                    ? (object)startYear.Value
                    : DBNull.Value;


            cmd.Parameters.Add(
                "@PassingYear",
                SqlDbType.Int
            ).Value =
                passingYear.HasValue
                    ? (object)passingYear.Value
                    : DBNull.Value;


            cmd.Parameters.Add(
                "@ScoreType",
                SqlDbType.NVarChar,
                20
            ).Value =
                DbValue(scoreType);


            SqlParameter scoreParameter =
                cmd.Parameters.Add(
                    "@Score",
                    SqlDbType.Decimal
                );


            scoreParameter.Precision = 5;
            scoreParameter.Scale = 2;


            scoreParameter.Value =
                score.HasValue
                    ? (object)score.Value
                    : DBNull.Value;
        }
        private void LoadEducationForEdit(int educationId)
        {
            int jobSeekerId =
                GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                return;
            }


            const string query = @"SELECT EducationId,Qualification,CourseName,Specialization,InstituteName,EducationType,StartYear,PassingYear,ScoreType,Score FROM JobSeekerEducation WHERE EducationId =@EducationId AND JobSeekerId =@JobSeekerId;";
            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@EducationId",
                        SqlDbType.Int
                    ).Value =
                        educationId;


                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value =
                        jobSeekerId;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            ShowMessage(
                                "Education record was not found.",
                                false
                            );

                            return;
                        }


                        hfEducationId.Value =
                            Convert.ToString(
                                reader["EducationId"]
                            );


                        SelectDropDownValue(
                            ddlQualification,
                            GetString(
                                reader["Qualification"]
                            )
                        );


                        txtCourseName.Text =
                            GetString(
                                reader["CourseName"]
                            );


                        txtSpecialization.Text =
                            GetString(
                                reader["Specialization"]
                            );


                        txtInstituteName.Text =
                            GetString(
                                reader["InstituteName"]
                            );


                        SelectDropDownValue(
                            ddlEducationType,
                            GetString(
                                reader["EducationType"]
                            )
                        );


                        if (reader["StartYear"] !=
                            DBNull.Value)
                        {
                            SelectDropDownValue(
                                ddlEducationStartYear,
                                Convert.ToString(
                                    reader["StartYear"]
                                )
                            );
                        }


                        if (reader["PassingYear"] !=
                            DBNull.Value)
                        {
                            SelectDropDownValue(
                                ddlEducationPassingYear,
                                Convert.ToString(
                                    reader["PassingYear"]
                                )
                            );
                        }


                        SelectDropDownValue(
                            ddlScoreType,
                            GetString(
                                reader["ScoreType"]
                            )
                        );


                        if (reader["Score"] !=
                            DBNull.Value)
                        {
                            txtEducationScore.Text =
                                Convert.ToDecimal(
                                    reader["Score"]
                                )
                                .ToString("0.##");
                        }
                        else
                        {
                            txtEducationScore.Text =
                                "";
                        }
                    }
                }


                lblEducationFormTitle.Text =
                    "Edit Education";


                btnSaveEducation.Text =
                    "Update Education";


                btnCancelEducation.Visible =
                    true;


                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "EducationEdit",
                    "document.getElementById('education').scrollIntoView({behavior:'smooth'});",
                    true
                );
            }
            catch
            {
                ShowMessage(
                    "Unable to load education record.",
                    false
                );
            }
        }
        private void DeleteEducation(
    int educationId)
        {
            int jobSeekerId =
                GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                return;
            }


            const string query = @"DELETE FROM JobSeekerEducation WHERE EducationId =@EducationId AND JobSeekerId =@JobSeekerId;";
            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@EducationId",
                        SqlDbType.Int
                    ).Value =
                        educationId;


                    cmd.Parameters.Add(
                        "@JobSeekerId",
                        SqlDbType.Int
                    ).Value =
                        jobSeekerId;


                    con.Open();


                    int affected =
                        cmd.ExecuteNonQuery();


                    if (affected > 0)
                    {
                        ShowMessage(
                            "Education record deleted successfully.",
                            true
                        );
                    }
                }


                ResetEducationForm();

                LoadEducation();
                RecalculateProfileCompletion();

            }
            catch
            {
                ShowMessage(
                    "Unable to delete education record.",
                    false
                );
            }
        }
        protected void rptEducation_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int educationId;


            if (!int.TryParse(
                    Convert.ToString(
                        e.CommandArgument
                    ),
                    out educationId))
            {
                return;
            }


            if (e.CommandName == "EditEducation")
            {
                LoadEducationForEdit(
                    educationId
                );
            }


            if (e.CommandName == "DeleteEducation")
            {
                DeleteEducation(
                    educationId
                );
            }

        }

        private void ResetEducationForm()
        {
            hfEducationId.Value =
                "0";


            ddlQualification.SelectedIndex =
                0;


            txtCourseName.Text =
                "";


            txtSpecialization.Text =
                "";


            txtInstituteName.Text =
                "";


            ddlEducationType.SelectedIndex =
                0;


            ddlEducationStartYear.SelectedIndex =
                0;


            ddlEducationPassingYear.SelectedIndex =
                0;


            ddlScoreType.SelectedIndex =
                0;


            txtEducationScore.Text =
                "";


            lblEducationFormTitle.Text =
                "Add Education";


            btnSaveEducation.Text =
                "Add Education";


            btnCancelEducation.Visible =
                false;
        }
        private int? ParseNullableInt(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return null;
            }


            int result;


            if (int.TryParse(
                    value,
                    out result))
            {
                return result;
            }


            return null;
        }


        private decimal? ParseNullableDecimal(
            string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return null;
            }


            decimal result;


            if (decimal.TryParse(
                    value,
                    out result))
            {
                return result;
            }


            return null;
        }
        protected string FormatEducationYears(object startYear,object passingYear)
        {
            string start =
                startYear == null ||
                startYear == DBNull.Value
                    ? ""
                    : Convert.ToString(startYear);


            string end =
                passingYear == null ||
                passingYear == DBNull.Value
                    ? ""
                    : Convert.ToString(passingYear);


            if (!string.IsNullOrWhiteSpace(start) &&
                !string.IsNullOrWhiteSpace(end))
            {
                return Server.HtmlEncode(
                    start + " - " + end
                );
            }


            if (!string.IsNullOrWhiteSpace(end))
            {
                return Server.HtmlEncode(end);
            }


            return Server.HtmlEncode(start);
        }
        protected string FormatEducationScore(object scoreType,object score)
        {
            if (score == null ||
                score == DBNull.Value)
            {
                return "";
            }


            decimal value =
                Convert.ToDecimal(score);


            string type =
                Convert.ToString(scoreType);


            if (type == "Percentage")
            {
                return Server.HtmlEncode(
                    value.ToString("0.##") + "%"
                );
            }


            if (type == "CGPA")
            {
                return Server.HtmlEncode(
                    value.ToString("0.##") +
                    " CGPA"
                );
            }


            return Server.HtmlEncode(
                value.ToString("0.##")
            );
        }
        protected void btnCancelEducation_Click(object sender, EventArgs e)
        {
            ResetEducationForm();
        }

        protected void btnSaveEducation_Click(object sender, EventArgs e)
        {
            int jobSeekerId =
        GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                ShowMessage(
                    "Please save your profile first.",
                    false
                );

                return;
            }


            string qualification =
                ddlQualification.SelectedValue;


            string courseName =
                txtCourseName.Text.Trim();


            string specialization =
                txtSpecialization.Text.Trim();


            string institute =
                txtInstituteName.Text.Trim();


            string educationType =
                ddlEducationType.SelectedValue;


            string scoreType =
                ddlScoreType.SelectedValue;


            // ==========================================
            // VALIDATION
            // ==========================================

            if (string.IsNullOrWhiteSpace(
                    qualification))
            {
                ShowMessage(
                    "Please select your qualification.",
                    false
                );

                return;
            }


            if (string.IsNullOrWhiteSpace(
                    institute))
            {
                ShowMessage(
                    "Please enter college, university or school name.",
                    false
                );

                return;
            }


            int? startYear =
                ParseNullableInt(
                    ddlEducationStartYear.SelectedValue
                );


            int? passingYear =
                ParseNullableInt(
                    ddlEducationPassingYear.SelectedValue
                );


            if (startYear.HasValue &&
                passingYear.HasValue &&
                passingYear.Value < startYear.Value)
            {
                ShowMessage(
                    "Passing year cannot be earlier than start year.",
                    false
                );

                return;
            }


            decimal? score =
                ParseNullableDecimal(
                    txtEducationScore.Text
                );


            if (!string.IsNullOrWhiteSpace(
                    txtEducationScore.Text) &&
                !score.HasValue)
            {
                ShowMessage(
                    "Please enter a valid score.",
                    false
                );

                return;
            }


            // Percentage validation

            if (score.HasValue &&
                scoreType == "Percentage" &&
                (score.Value < 0 ||
                 score.Value > 100))
            {
                ShowMessage(
                    "Percentage must be between 0 and 100.",
                    false
                );

                return;
            }


            // CGPA validation

            if (score.HasValue &&
                scoreType == "CGPA" &&
                (score.Value < 0 ||
                 score.Value > 10))
            {
                ShowMessage(
                    "CGPA must be between 0 and 10.",
                    false
                );

                return;
            }


            if (score.HasValue &&
                string.IsNullOrWhiteSpace(scoreType))
            {
                ShowMessage(
                    "Please select Percentage or CGPA.",
                    false
                );

                return;
            }


            int educationId = 0;


            int.TryParse(
                hfEducationId.Value,
                out educationId
            );


            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                {
                    con.Open();


                    // =====================================
                    // INSERT
                    // =====================================

                    if (educationId == 0)
                    {
                        const string query = @"INSERT INTO JobSeekerEducation (JobSeekerId,Qualification,CourseName,Specialization,InstituteName,EducationType,StartYear,PassingYear,ScoreType,Score,CreatedAt)VALUES(@JobSeekerId,@Qualification,@CourseName,@Specialization,@InstituteName,@EducationType,@StartYear,@PassingYear,@ScoreType,@Score,SYSDATETIME());";
                        using (SqlCommand cmd =
                               new SqlCommand(query, con))
                        {
                            AddEducationParameters(
                                cmd,
                                jobSeekerId,
                                qualification,
                                courseName,
                                specialization,
                                institute,
                                educationType,
                                startYear,
                                passingYear,
                                scoreType,
                                score
                            );


                            cmd.ExecuteNonQuery();
                        }


                        ShowMessage(
                            "Education added successfully.",
                            true
                        );
                    }

                    // =====================================
                    // UPDATE
                    // =====================================

                    else
                    {
                        const string query = @"UPDATE JobSeekerEducation SET Qualification =@Qualification,CourseName =@CourseName,Specialization =@Specialization,InstituteName =@InstituteName,EducationType =@EducationType,StartYear =@StartYear,PassingYear =@PassingYear,ScoreType =@ScoreType,Score =@Score,UpdatedAt =SYSDATETIME() WHERE EducationId =@EducationId AND JobSeekerId =@JobSeekerId;";
                        using (SqlCommand cmd =
                               new SqlCommand(query, con))
                        {
                            AddEducationParameters(
                                cmd,
                                jobSeekerId,
                                qualification,
                                courseName,
                                specialization,
                                institute,
                                educationType,
                                startYear,
                                passingYear,
                                scoreType,
                                score
                            );


                            cmd.Parameters.Add(
                                "@EducationId",
                                SqlDbType.Int
                            ).Value =
                                educationId;


                            int affected =
                                cmd.ExecuteNonQuery();


                            if (affected == 0)
                            {
                                ShowMessage(
                                    "Education record was not found.",
                                    false
                                );

                                return;
                            }
                        }


                        ShowMessage(
                            "Education updated successfully.",
                            true
                        );
                    }
                }


                ResetEducationForm();

                LoadEducation();
                RecalculateProfileCompletion();

            }
            catch
            {
                ShowMessage(
                    "Unable to save education details.",
                    false
                );
            }
        }

        protected void rptProjects_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int projectId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument),out projectId))
            {
                return;
            }

            if (e.CommandName == "EditProject")
            {
                LoadProjectForEdit(projectId);
            }
            else if (e.CommandName == "DeleteProject")
            {
                DeleteProject(projectId);
            }

        }
        private void LoadProjectForEdit(int projectId)
        {
            int jobSeekerId = GetJobSeekerId();
            if (jobSeekerId == 0)
            {
                return;
            }


            const string query = @"SELECT ProjectId,ProjectTitle,ProjectRole,ClientCompany,StartDate,EndDate,IsCurrentProject,ProjectUrl,Technologies,ProjectDescription FROM JobSeekerProjects WHERE ProjectId =@ProjectId AND JobSeekerId =@JobSeekerId;";
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@ProjectId",SqlDbType.Int).Value = projectId;
                    cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value = jobSeekerId;
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            ShowMessage("Project was not found.",false);
                            return;
                        }

                        hfProjectId.Value = Convert.ToString(reader["ProjectId"]);
                        txtProjectTitle.Text = GetString(reader["ProjectTitle"]);
                        txtProjectRole.Text = GetString(reader["ProjectRole"]);
                        txtProjectClient.Text = GetString(reader["ClientCompany"]);
                        txtProjectUrl.Text = GetString(reader["ProjectUrl"]);
                        txtProjectTechnologies.Text = GetString(reader["Technologies"]);
                        txtProjectDescription.Text = GetString(reader["ProjectDescription"]);
                        if (reader["StartDate"] != DBNull.Value)
                        {
                            txtProjectStartDate.Text = Convert.ToDateTime(reader["StartDate"]).ToString("yyyy-MM-dd");
                        }
                        else
                        {
                            txtProjectStartDate.Text = "";
                        }

                        bool current = reader["IsCurrentProject"] != DBNull.Value && Convert.ToBoolean(reader["IsCurrentProject"]);
                        chkCurrentProject.Checked = current;
                        if (reader["EndDate"] != DBNull.Value)
                        {
                            txtProjectEndDate.Text = Convert.ToDateTime(reader["EndDate"]).ToString("yyyy-MM-dd");
                        }
                        else
                        {
                            txtProjectEndDate.Text = "";
                        }
                    }
                }

                lblProjectFormTitle.Text = "Edit Project";
                btnSaveProject.Text ="Update Project";
                btnCancelProject.Visible = true;
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ProjectEdit",
                    "toggleCurrentProject();" +
                    "document.getElementById('projects').scrollIntoView({behavior:'smooth'});",
                    true
                );
            }
            catch
            {
                ShowMessage("Unable to load project.",false);
            }
        }
        private void DeleteProject(int projectId)
        {
            int jobSeekerId = GetJobSeekerId();
            if (jobSeekerId == 0)
            {
                return;
            }

            const string query = @"DELETE FROM JobSeekerProjects WHERE ProjectId =@ProjectId AND JobSeekerId =@JobSeekerId;";
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@ProjectId",SqlDbType.Int).Value = projectId;
                    cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value = jobSeekerId;
                    con.Open();
                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                    {
                        ShowMessage("Project deleted successfully.",true);
                    }
                }

                ResetProjectForm();
                LoadProjects();
                RecalculateProfileCompletion();

            }
            catch
            {
                ShowMessage("Unable to delete project.",false);
            }
        }
        protected void btnSaveProject_Click(object sender, EventArgs e)
        {
            int jobSeekerId = GetJobSeekerId();
            if (jobSeekerId == 0)
            {
                ShowMessage("Please save your profile first.",false);
                return;
            }
            string title = txtProjectTitle.Text.Trim();
            string role = txtProjectRole.Text.Trim();
            string client = txtProjectClient.Text.Trim();
            string projectUrl = txtProjectUrl.Text.Trim();
            string technologies = txtProjectTechnologies.Text.Trim();
            string description = txtProjectDescription.Text.Trim();

            if (string.IsNullOrWhiteSpace(title))
            {
                ShowMessage("Please enter project title.",false);
                return;
            }

            DateTime? startDate = ParseNullableDate(txtProjectStartDate.Text);
            DateTime? endDate = ParseNullableDate(txtProjectEndDate.Text);
            bool isCurrent = chkCurrentProject.Checked;
            if (!isCurrent && startDate.HasValue && !endDate.HasValue)
            {
                ShowMessage("Please select project end date.",false);
                return;
            }

            if (startDate.HasValue && endDate.HasValue && endDate.Value < startDate.Value)
            {
                ShowMessage("Project end date cannot be earlier than start date.",false);
                return;
            }


            if (isCurrent)
            {
                endDate = null;
            }

            // URL validation

            if (!string.IsNullOrWhiteSpace(projectUrl))
            {
                Uri uri;
                bool validUrl = Uri.TryCreate(projectUrl,UriKind.Absolute,out uri) && (uri.Scheme == Uri.UriSchemeHttp || uri.Scheme == Uri.UriSchemeHttps);
                if (!validUrl)
                {
                    ShowMessage("Please enter a valid http or https project URL.",false);
                    return;
                }
            }

            int projectId = 0;
            int.TryParse(hfProjectId.Value,out projectId);
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    if (projectId == 0)
                    {
                        const string query = @"INSERT INTO JobSeekerProjects(JobSeekerId,ProjectTitle,ProjectRole,ClientCompany,StartDate,EndDate,IsCurrentProject,ProjectUrl,Technologies,ProjectDescription,CreatedAt)VALUES(@JobSeekerId,@ProjectTitle,@ProjectRole,@ClientCompany,@StartDate,@EndDate,@IsCurrentProject,@ProjectUrl,@Technologies,@ProjectDescription,SYSDATETIME());";
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            AddProjectParameters(cmd,jobSeekerId,title,role,client,startDate,endDate,isCurrent,projectUrl,technologies,description);
                            cmd.ExecuteNonQuery();
                        }

                        ShowMessage("Project added successfully.",true);
                    }
                    else
                    {
                        const string query = @"UPDATE JobSeekerProjects SET ProjectTitle =@ProjectTitle,ProjectRole =@ProjectRole,ClientCompany =@ClientCompany,StartDate =@StartDate,EndDate =@EndDate,IsCurrentProject =@IsCurrentProject,ProjectUrl =@ProjectUrl,Technologies =@Technologies,ProjectDescription =@ProjectDescription,UpdatedAt =SYSDATETIME() WHERE ProjectId =@ProjectId AND JobSeekerId =@JobSeekerId;";
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            AddProjectParameters(cmd,jobSeekerId,title,role,client,startDate,endDate,isCurrent,projectUrl,technologies,description);
                            cmd.Parameters.Add("@ProjectId",SqlDbType.Int).Value = projectId;
                            int affected = cmd.ExecuteNonQuery();
                            if (affected == 0)
                            {
                                ShowMessage("Project was not found.",false);
                                return;
                            }
                        }

                        ShowMessage("Project updated successfully.",true);
                    }
                }

                ResetProjectForm();
                LoadProjects();
                RecalculateProfileCompletion();

            }
            catch
            {
                ShowMessage("Unable to save project.",false);
            }
        }

        private void AddProjectParameters(SqlCommand cmd,int jobSeekerId,string title,string role,string client,DateTime? startDate,DateTime? endDate,bool isCurrent,string projectUrl,string technologies,string description)
{
            cmd.Parameters.Add("@JobSeekerId",SqlDbType.Int).Value = jobSeekerId;
            cmd.Parameters.Add("@ProjectTitle",SqlDbType.NVarChar,200).Value = title;
            cmd.Parameters.Add("@ProjectRole",SqlDbType.NVarChar,150).Value = DbValue(role);
            cmd.Parameters.Add("@ClientCompany",SqlDbType.NVarChar,200).Value =DbValue(client);
            cmd.Parameters.Add("@StartDate",SqlDbType.Date).Value = startDate.HasValue? (object)startDate.Value.Date: DBNull.Value;
            cmd.Parameters.Add("@EndDate",SqlDbType.Date).Value =endDate.HasValue? (object)endDate.Value.Date: DBNull.Value;
            cmd.Parameters.Add("@IsCurrentProject",SqlDbType.Bit).Value = isCurrent;
            cmd.Parameters.Add("@ProjectUrl",SqlDbType.NVarChar,500).Value = DbValue(projectUrl);
            cmd.Parameters.Add("@Technologies",SqlDbType.NVarChar,1000).Value = DbValue(technologies);
            cmd.Parameters.Add("@ProjectDescription",SqlDbType.NVarChar,3000).Value = DbValue(description);
        }
        private DateTime? ParseNullableDate(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return null;
            }
            DateTime date;
            if (DateTime.TryParse(value,out date))
            {
                return date.Date;
            }
            return null;
        }
        protected string FormatProjectDate(object startDateValue,object endDateValue,object currentValue)
        {
            if (startDateValue == null || startDateValue == DBNull.Value)
            {
                return "";
            }

            DateTime start = Convert.ToDateTime(startDateValue);
            bool current = currentValue != null && currentValue != DBNull.Value && Convert.ToBoolean(currentValue);
            string startText = start.ToString("MMM yyyy");
            string endText;
            if (current)
            {
                endText = "Present";
            }
            else if (endDateValue != null && endDateValue != DBNull.Value)
            {
                endText = Convert.ToDateTime(endDateValue).ToString("MMM yyyy");
            }
            else
            {
                endText = "";

            }

            return Server.HtmlEncode(
                string.IsNullOrWhiteSpace(endText)
                    ? startText
                    : startText + " - " + endText
            );
        }
      
        protected void btnCancelProject_Click(object sender, EventArgs e)
        {
            ResetProjectForm();
        }

        protected string GetSafeProjectUrl(object urlValue)
        {
            string url = Convert.ToString(urlValue).Trim();

            if (string.IsNullOrWhiteSpace(url))
            {
                return "#";
            }

            Uri uri;
            if (!Uri.TryCreate(url,UriKind.Absolute,out uri))
            {
                return "#";
            }

            if (uri.Scheme != Uri.UriSchemeHttp && uri.Scheme != Uri.UriSchemeHttps)
            {
                return "#";
            }
            return Server.HtmlEncode(uri.AbsoluteUri);
        }
        private void ResetProjectForm()
        {
            hfProjectId.Value = "0";
            txtProjectTitle.Text = "";
            txtProjectRole.Text = "";
            txtProjectClient.Text = "";
            txtProjectStartDate.Text = "";
            txtProjectEndDate.Text = "";
            chkCurrentProject.Checked = false;
            txtProjectUrl.Text = "";
            txtProjectTechnologies.Text = "";
            txtProjectDescription.Text = "";
            lblProjectFormTitle.Text = "Add Project";
            btnSaveProject.Text = "Add Project";
            btnCancelProject.Visible = false;
        }
    }
    
}