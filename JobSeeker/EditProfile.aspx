<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="Success24_Job_Portal.JobSeeker.EditProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <link href="<%= ResolveUrl("~/Assets/css/edit-profile.css") %>"
          rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="edit-profile-page">

        <!-- =========================================
             PAGE HEADING
        ========================================== -->

        <div class="edit-page-heading">

            <div>

                <span class="page-small-title">
                    MY PROFILE
                </span>

                <h1>Edit Profile</h1>

                <p>
                    Keep your professional information updated
                    to get better job opportunities.
                </p>

            </div>


            <a href="<%= ResolveUrl("~/JobSeeker/Profile.aspx") %>"
               class="view-profile-btn">

                <i class="bi bi-eye"></i>

                View Profile

            </a>

        </div>


        <!-- =========================================
             MESSAGE
        ========================================== -->

        <asp:Panel
            ID="pnlMessage"
            runat="server"
            Visible="false">

            <div id="messageBox"
                 runat="server"
                 class="profile-message">

                <i id="messageIcon"
                   runat="server"
                   class="bi bi-check-circle"></i>

                <asp:Label
                    ID="lblMessage"
                    runat="server">
                </asp:Label>

            </div>

        </asp:Panel>


        <div class="row g-4">


            <!-- =====================================
                 LEFT NAVIGATION
            ====================================== -->

            <div class="col-xl-3">

                <div class="edit-profile-nav">

                    <div class="edit-nav-title">

                        <span>
                            PROFILE SECTIONS
                        </span>

                    </div>


                    <a href="#basic-information"
                       class="edit-nav-link active">

                        <i class="bi bi-person"></i>

                        <span>
                            Basic Information
                        </span>

                    </a>


                    <a href="#professional"
                       class="edit-nav-link">

                        <i class="bi bi-briefcase"></i>

                        <span>
                            Professional Details
                        </span>

                    </a>


                    <a href="#skills"
                       class="edit-nav-link">

                        <i class="bi bi-lightning"></i>

                        <span>
                            Skills
                        </span>

                    </a>


                    <a href="#experience"
                       class="edit-nav-link">

                        <i class="bi bi-building"></i>

                        <span>
                            Work Experience
                        </span>

                    </a>


                    <a href="#education"
                       class="edit-nav-link">

                        <i class="bi bi-mortarboard"></i>

                        <span>
                            Education
                        </span>

                    </a>


                    <a href="#projects"
                       class="edit-nav-link">

                        <i class="bi bi-code-square"></i>

                        <span>
                            Projects
                        </span>

                    </a>


                    <a href="#preferences"
                       class="edit-nav-link">

                        <i class="bi bi-sliders"></i>

                        <span>
                            Job Preferences
                        </span>

                    </a>


                    <a href="<%= ResolveUrl("~/JobSeeker/Resume.aspx") %>"
                       class="edit-nav-link">

                        <i class="bi bi-file-earmark-person"></i>

                        <span>
                            Resume
                        </span>

                    </a>

                </div>

            </div>



            <!-- =====================================
                 RIGHT CONTENT
            ====================================== -->

            <div class="col-xl-9">


                <!-- =================================
                     BASIC INFORMATION
                ================================== -->

                <section id="basic-information"
                         class="edit-section">

                    <div class="edit-section-header">

                        <div class="section-heading-icon">

                            <i class="bi bi-person"></i>

                        </div>


                        <div>

                            <h2>
                                Basic Information
                            </h2>

                            <p>
                                Your personal and professional
                                introduction.
                            </p>

                        </div>

                    </div>


                    <div class="edit-section-body">


                        <!-- PROFILE PHOTO -->

                        <div class="profile-photo-edit">

                            <div class="edit-photo-wrapper">

                                <asp:Image
                                    ID="imgProfilePreview"
                                    runat="server"
                                    CssClass="edit-profile-photo"
                                    Visible="false" />


                                <asp:Panel
                                    ID="pnlProfileInitial"
                                    runat="server"
                                    CssClass="edit-profile-initial">

                                    <asp:Label
                                        ID="lblProfileInitial"
                                        runat="server">
                                    </asp:Label>

                                </asp:Panel>

                            </div>


                            <div class="profile-photo-info">

                                <strong>
                                    Profile Photo
                                </strong>

                                <span>
                                    JPG, JPEG or PNG. Maximum 2 MB.
                                </span>


                                <div class="photo-actions">

                                    <asp:FileUpload
                                        ID="fuProfilePhoto"
                                        runat="server"
                                        CssClass="profile-file-input"
                                        accept=".jpg,.jpeg,.png" />


                                    <asp:Button
                                        ID="btnUploadPhoto"
                                        runat="server"
                                        Text="Upload Photo"
                                        CssClass="photo-upload-btn"
                                        OnClick="btnUploadPhoto_Click" />

                                </div>

                            </div>

                        </div>


                        <div class="form-divider"></div>


                        <!-- FULL NAME + EMAIL -->

                        <div class="row g-3">


                            <div class="col-md-6">

                                <div class="profile-form-group">

                                    <label>
                                        Full Name
                                        <span>*</span>
                                    </label>


                                    <asp:TextBox
                                        ID="txtFullName"
                                        runat="server"
                                        CssClass="profile-input"
                                        MaxLength="100"
                                        placeholder="Enter your full name">
                                    </asp:TextBox>


                                    <asp:RequiredFieldValidator
                                        ID="rfvFullName"
                                        runat="server"
                                        ControlToValidate="txtFullName"
                                        ValidationGroup="BasicProfile"
                                        ErrorMessage="Full name is required."
                                        CssClass="field-error"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>

                                </div>

                            </div>



                            <div class="col-md-6">

                                <div class="profile-form-group">

                                    <label>
                                        Email Address
                                    </label>


                                    <asp:TextBox
                                        ID="txtEmail"
                                        runat="server"
                                        CssClass="profile-input readonly-input"
                                        ReadOnly="true">
                                    </asp:TextBox>


                                    <small>
                                        Email cannot be changed here.
                                    </small>

                                </div>

                            </div>



                            <!-- MOBILE -->

                            <div class="col-md-6">

                                <div class="profile-form-group">

                                    <label>
                                        Mobile Number
                                        <span>*</span>
                                    </label>


                                    <asp:TextBox
                                        ID="txtMobile"
                                        runat="server"
                                        CssClass="profile-input"
                                        MaxLength="15"
                                        placeholder="Enter mobile number">
                                    </asp:TextBox>


                                    <asp:RequiredFieldValidator
                                        ID="rfvMobile"
                                        runat="server"
                                        ControlToValidate="txtMobile"
                                        ValidationGroup="BasicProfile"
                                        ErrorMessage="Mobile number is required."
                                        CssClass="field-error"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>

                                </div>

                            </div>



                            <!-- HEADLINE -->

                            <div class="col-md-6">

                                <div class="profile-form-group">

                                    <label>
                                        Professional Headline
                                    </label>


                                    <asp:TextBox
                                        ID="txtHeadline"
                                        runat="server"
                                        CssClass="profile-input"
                                        MaxLength="150"
                                        placeholder="e.g. Full Stack .NET Developer">
                                    </asp:TextBox>


                                    <small>
                                        A short title describing your profession.
                                    </small>

                                </div>

                            </div>



                            <!-- CITY -->

                            <div class="col-md-6">

                                <div class="profile-form-group">

                                    <label>
                                        City
                                    </label>


                                    <asp:TextBox
                                        ID="txtCity"
                                        runat="server"
                                        CssClass="profile-input"
                                        MaxLength="100"
                                        placeholder="e.g. Noida">
                                    </asp:TextBox>

                                </div>

                            </div>



                            <!-- STATE -->

                            <div class="col-md-6">

                                <div class="profile-form-group">

                                    <label>
                                        State
                                    </label>


                                    <asp:DropDownList
                                        ID="ddlState"
                                        runat="server"
                                        CssClass="profile-input">

                                        <asp:ListItem
                                            Text="Select State"
                                            Value="">
                                        </asp:ListItem>

                                        <asp:ListItem Text="Andhra Pradesh" />
                                        <asp:ListItem Text="Arunachal Pradesh" />
                                        <asp:ListItem Text="Assam" />
                                        <asp:ListItem Text="Bihar" />
                                        <asp:ListItem Text="Chhattisgarh" />
                                        <asp:ListItem Text="Delhi" />
                                        <asp:ListItem Text="Goa" />
                                        <asp:ListItem Text="Gujarat" />
                                        <asp:ListItem Text="Haryana" />
                                        <asp:ListItem Text="Himachal Pradesh" />
                                        <asp:ListItem Text="Jharkhand" />
                                        <asp:ListItem Text="Karnataka" />
                                        <asp:ListItem Text="Kerala" />
                                        <asp:ListItem Text="Madhya Pradesh" />
                                        <asp:ListItem Text="Maharashtra" />
                                        <asp:ListItem Text="Manipur" />
                                        <asp:ListItem Text="Meghalaya" />
                                        <asp:ListItem Text="Mizoram" />
                                        <asp:ListItem Text="Nagaland" />
                                        <asp:ListItem Text="Odisha" />
                                        <asp:ListItem Text="Punjab" />
                                        <asp:ListItem Text="Rajasthan" />
                                        <asp:ListItem Text="Sikkim" />
                                        <asp:ListItem Text="Tamil Nadu" />
                                        <asp:ListItem Text="Telangana" />
                                        <asp:ListItem Text="Tripura" />
                                        <asp:ListItem Text="Uttar Pradesh" />
                                        <asp:ListItem Text="Uttarakhand" />
                                        <asp:ListItem Text="West Bengal" />

                                    </asp:DropDownList>

                                </div>

                            </div>



                            <!-- ABOUT -->

                            <div class="col-12">

                                <div class="profile-form-group">

                                    <label>
                                        About Me
                                    </label>


                                    <asp:TextBox
                                        ID="txtAbout"
                                        runat="server"
                                        TextMode="MultiLine"
                                        Rows="6"
                                        MaxLength="1500"
                                        CssClass="profile-input profile-textarea"
                                        placeholder="Write a short professional summary about yourself...">
                                    </asp:TextBox>


                                    <div class="textarea-help">

                                        <small>
                                            Mention your experience, strengths,
                                            skills and career goals.
                                        </small>

                                        <span id="aboutCounter">
                                            0 / 1500
                                        </span>

                                    </div>

                                </div>

                            </div>

                        </div>


                        <!-- BUTTON -->

                        <div class="section-actions">

                            <asp:Button
                                ID="btnSaveBasic"
                                runat="server"
                                Text="Save Basic Information"
                                CssClass="save-profile-btn"
                                ValidationGroup="BasicProfile"
                                OnClick="btnSaveBasic_Click" />

                        </div>

                    </div>

                </section>



                <!-- =================================
                     PLACEHOLDERS FOR NEXT PARTS
                ================================== -->

               <!-- =========================================
     PROFESSIONAL DETAILS
========================================== -->

<section id="professional"
         class="edit-section">

    <div class="edit-section-header">

        <div class="section-heading-icon">

            <i class="bi bi-briefcase"></i>

        </div>

        <div>

            <h2>Professional Details</h2>

            <p>
                Tell recruiters about your current
                professional status.
            </p>

        </div>

    </div>


    <div class="edit-section-body">

        <!-- =====================================
             CANDIDATE TYPE
        ====================================== -->

        <div class="profile-form-group">

            <label>
                Are you a Fresher or Experienced?
                <span>*</span>
            </label>


            <div class="candidate-type-options">

                <label class="candidate-type-card">

                    <asp:RadioButton
                        ID="rbFresher"
                        runat="server"
                        GroupName="CandidateType"
                        CssClass="candidate-radio"
                        onclick="toggleExperienceFields();" />

                    <span class="candidate-option-icon">

                        <i class="bi bi-mortarboard"></i>

                    </span>

                    <span class="candidate-option-content">

                        <strong>Fresher</strong>

                        <small>
                            I am looking for my first
                            professional opportunity.
                        </small>

                    </span>

                </label>


                <label class="candidate-type-card">

                    <asp:RadioButton
                        ID="rbExperienced"
                        runat="server"
                        GroupName="CandidateType"
                        CssClass="candidate-radio"
                        onclick="toggleExperienceFields();" />

                    <span class="candidate-option-icon">

                        <i class="bi bi-briefcase"></i>

                    </span>

                    <span class="candidate-option-content">

                        <strong>Experienced</strong>

                        <small>
                            I have professional work
                            experience.
                        </small>

                    </span>

                </label>

            </div>

        </div>


        <div class="form-divider"></div>


        <!-- =====================================
             EXPERIENCED CANDIDATE FIELDS
        ====================================== -->

        <div id="experiencedFields">

            <div class="row g-3">


                <!-- DESIGNATION -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Current Designation
                        </label>

                        <asp:TextBox
                            ID="txtCurrentDesignation"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="150"
                            placeholder="e.g. Software Developer">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- COMPANY -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Current Company
                        </label>

                        <asp:TextBox
                            ID="txtCurrentCompany"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="150"
                            placeholder="e.g. ABC Technologies">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- EXPERIENCE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Total Experience
                        </label>


                        <div class="experience-select-row">

                            <asp:DropDownList
                                ID="ddlExperienceYears"
                                runat="server"
                                CssClass="profile-input">

                                <asp:ListItem Text="Years" Value="0" />
                                <asp:ListItem Text="1 Year" Value="1" />
                                <asp:ListItem Text="2 Years" Value="2" />
                                <asp:ListItem Text="3 Years" Value="3" />
                                <asp:ListItem Text="4 Years" Value="4" />
                                <asp:ListItem Text="5 Years" Value="5" />
                                <asp:ListItem Text="6 Years" Value="6" />
                                <asp:ListItem Text="7 Years" Value="7" />
                                <asp:ListItem Text="8 Years" Value="8" />
                                <asp:ListItem Text="9 Years" Value="9" />
                                <asp:ListItem Text="10 Years" Value="10" />
                                <asp:ListItem Text="11 Years" Value="11" />
                                <asp:ListItem Text="12 Years" Value="12" />
                                <asp:ListItem Text="13 Years" Value="13" />
                                <asp:ListItem Text="14 Years" Value="14" />
                                <asp:ListItem Text="15 Years" Value="15" />
                                <asp:ListItem Text="16 Years" Value="16" />
                                <asp:ListItem Text="17 Years" Value="17" />
                                <asp:ListItem Text="18 Years" Value="18" />
                                <asp:ListItem Text="19 Years" Value="19" />
                                <asp:ListItem Text="20+ Years" Value="20" />

                            </asp:DropDownList>


                            <asp:DropDownList
                                ID="ddlExperienceMonths"
                                runat="server"
                                CssClass="profile-input">

                                <asp:ListItem Text="Months" Value="0" />
                                <asp:ListItem Text="1 Month" Value="1" />
                                <asp:ListItem Text="2 Months" Value="2" />
                                <asp:ListItem Text="3 Months" Value="3" />
                                <asp:ListItem Text="4 Months" Value="4" />
                                <asp:ListItem Text="5 Months" Value="5" />
                                <asp:ListItem Text="6 Months" Value="6" />
                                <asp:ListItem Text="7 Months" Value="7" />
                                <asp:ListItem Text="8 Months" Value="8" />
                                <asp:ListItem Text="9 Months" Value="9" />
                                <asp:ListItem Text="10 Months" Value="10" />
                                <asp:ListItem Text="11 Months" Value="11" />

                            </asp:DropDownList>

                        </div>

                    </div>

                </div>


                <!-- NOTICE PERIOD -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Notice Period
                        </label>

                      <asp:DropDownList
                        ID="ddlNoticePeriod"
                        runat="server"
                        CssClass="profile-input">

                        <asp:ListItem
                            Text="Select Notice Period"
                            Value="" />

                        <asp:ListItem
                            Text="Immediate"
                            Value="0" />

                        <asp:ListItem
                            Text="15 Days"
                            Value="15" />

                        <asp:ListItem
                            Text="30 Days"
                            Value="30" />

                        <asp:ListItem
                            Text="45 Days"
                            Value="45" />

                        <asp:ListItem
                            Text="60 Days"
                            Value="60" />

                        <asp:ListItem
                            Text="90 Days"
                            Value="90" />

                        <asp:ListItem
                            Text="More than 90 Days"
                            Value="91" />

                    </asp:DropDownList>

                    </div>

                </div>


                <!-- CURRENT SALARY -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Current Annual Salary
                        </label>

                        <div class="salary-input">

                            <span>₹</span>

                            <asp:TextBox
                                ID="txtCurrentSalary"
                                runat="server"
                                CssClass="profile-input salary-field"
                                MaxLength="12"
                                placeholder="e.g. 600000">
                            </asp:TextBox>

                        </div>

                        <small>
                            Enter annual salary in INR.
                        </small>

                    </div>

                </div>


                <!-- EXPECTED SALARY -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Expected Annual Salary
                        </label>

                        <div class="salary-input">

                            <span>₹</span>

                            <asp:TextBox
                                ID="txtExpectedSalary"
                                runat="server"
                                CssClass="profile-input salary-field"
                                MaxLength="12"
                                placeholder="e.g. 900000">
                            </asp:TextBox>

                        </div>

                        <small>
                            Enter expected annual salary in INR.
                        </small>

                    </div>

                </div>

            </div>

        </div>


        <!-- =====================================
             EMPLOYMENT TYPE
        ====================================== -->

        <div class="form-divider"></div>


        <div class="row g-3">

            <div class="col-md-6">

                <div class="profile-form-group">

                    <label>
                        Preferred Employment Type
                    </label>

                    <asp:DropDownList
                        ID="ddlEmploymentType"
                        runat="server"
                        CssClass="profile-input">

                        <asp:ListItem Text="Select Employment Type" Value="" />
                        <asp:ListItem Text="Full Time" Value="Full Time" />
                        <asp:ListItem Text="Part Time" Value="Part Time" />
                        <asp:ListItem Text="Internship" Value="Internship" />
                        <asp:ListItem Text="Contract" Value="Contract" />
                        <asp:ListItem Text="Freelance" Value="Freelance" />

                    </asp:DropDownList>

                </div>

            </div>


            <!-- WORK MODE -->

            <div class="col-md-6">

                <div class="profile-form-group">

                    <label>
                        Preferred Work Mode
                    </label>

                    <asp:DropDownList
                        ID="ddlWorkMode"
                        runat="server"
                        CssClass="profile-input">

                        <asp:ListItem Text="Select Work Mode" Value="" />
                        <asp:ListItem Text="Work From Office" Value="Work From Office" />
                        <asp:ListItem Text="Remote" Value="Remote" />
                        <asp:ListItem Text="Hybrid" Value="Hybrid" />

                    </asp:DropDownList>

                </div>

            </div>

        </div>


        <!-- BUTTON -->

        <div class="section-actions">

            <asp:Button
                ID="btnSaveProfessional"
                runat="server"
                Text="Save Professional Details"
                CssClass="save-profile-btn"
                OnClick="btnSaveProfessional_Click" />

        </div>

    </div>

</section>


               <!-- =========================================
     SKILLS
========================================== -->

<section id="skills"
         class="edit-section">

    <div class="edit-section-header">

        <div class="section-heading-icon">
            <i class="bi bi-lightning"></i>
        </div>

        <div>
            <h2>Skills</h2>

            <p>
                Add your technical and professional skills.
            </p>
        </div>

    </div>


    <div class="edit-section-body">

        <!-- ADD SKILL -->

        <div class="skill-add-area">

            <div class="profile-form-group">

                <label>
                    Add Skill
                </label>

                <div class="skill-input-row">

                    <asp:TextBox
                        ID="txtSkill"
                        runat="server"
                        CssClass="profile-input"
                        MaxLength="100"
                        placeholder="e.g. ASP.NET Core">
                    </asp:TextBox>


                    <asp:Button
                        ID="btnAddSkill"
                        runat="server"
                        Text="Add Skill"
                        CssClass="add-skill-btn"
                        CausesValidation="false"
                        OnClick="btnAddSkill_Click" />

                </div>


                <small>
                    Add technologies, tools, frameworks,
                    languages or professional skills.
                </small>

            </div>

        </div>


        <div class="form-divider"></div>


        <!-- CURRENT SKILLS -->

        <div class="current-skills-heading">

            <div>
                <strong>Your Skills</strong>

                <span>
                    Recruiters can use these skills
                    to discover your profile.
                </span>
            </div>


            <span class="skill-count">

                <asp:Label
                    ID="lblSkillCount"
                    runat="server"
                    Text="0">
                </asp:Label>

                Skills

            </span>

        </div>


        <asp:Panel
            ID="pnlSkills"
            runat="server">

            <div class="edit-skill-list">

                <asp:Repeater
                    ID="rptEditSkills"
                    runat="server"
                    OnItemCommand="rptEditSkills_ItemCommand">

                    <ItemTemplate>

                        <div class="edit-skill-tag">

                            <span>

                                <%# Server.HtmlEncode(
                                    Convert.ToString(
                                        Eval("SkillName")
                                    )
                                ) %>

                            </span>


                            <asp:LinkButton
                                ID="btnDeleteSkill"
                                runat="server"
                                CommandName="DeleteSkill"
                                CommandArgument='<%# Eval("JobSeekerSkillId") %>'
                                CssClass="delete-skill-btn"
                                CausesValidation="false"
                                ToolTip="Remove skill"
                                OnClientClick="return confirm('Remove this skill?');">

                                <i class="bi bi-x-lg"></i>

                            </asp:LinkButton>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </asp:Panel>


        <!-- EMPTY -->

        <asp:Panel
            ID="pnlNoEditSkills"
            runat="server"
            Visible="false"
            CssClass="skills-empty-state">

            <div class="skills-empty-icon">
                <i class="bi bi-lightning"></i>
            </div>

            <strong>No skills added yet</strong>

            <span>
                Add skills like C#, ASP.NET, SQL Server,
                JavaScript, Python, React, Communication,
                Machine Learning, etc.
            </span>

        </asp:Panel>


        <!-- SUGGESTIONS -->

        <div class="skill-suggestions">

            <span class="suggestion-title">
                Popular Skills
            </span>


            <div class="suggestion-list">

                <button type="button"
                        class="skill-suggestion"
                        onclick="setSkill('C#');">
                    + C#
                </button>

                <button type="button"
                        class="skill-suggestion"
                        onclick="setSkill('ASP.NET Core');">
                    + ASP.NET Core
                </button>

                <button type="button"
                        class="skill-suggestion"
                        onclick="setSkill('SQL Server');">
                    + SQL Server
                </button>

                <button type="button"
                        class="skill-suggestion"
                        onclick="setSkill('JavaScript');">
                    + JavaScript
                </button>

                <button type="button"
                        class="skill-suggestion"
                        onclick="setSkill('React');">
                    + React
                </button>

                <button type="button"
                        class="skill-suggestion"
                        onclick="setSkill('Python');">
                    + Python
                </button>

                <button type="button"
                        class="skill-suggestion"
                        onclick="setSkill('Machine Learning');">
                    + Machine Learning
                </button>

                <button type="button"
                        class="skill-suggestion"
                        onclick="setSkill('Communication');">
                    + Communication
                </button>

            </div>

        </div>

    </div>

</section>

               <!-- =========================================
     WORK EXPERIENCE
========================================== -->

<section id="experience"
         class="edit-section">

    <div class="edit-section-header">

        <div class="section-heading-icon">
            <i class="bi bi-building"></i>
        </div>

        <div>
            <h2>Work Experience</h2>

            <p>
                Add your professional employment history.
            </p>
        </div>

    </div>


    <div class="edit-section-body">

        <!-- =====================================
             ADD / EDIT EXPERIENCE FORM
        ====================================== -->

        <asp:HiddenField
            ID="hfExperienceId"
            runat="server"
            Value="0" />


        <div class="experience-form-box">

            <div class="experience-form-heading">

                <div>
                    <strong>
                        <asp:Label
                            ID="lblExperienceFormTitle"
                            runat="server"
                            Text="Add Experience">
                        </asp:Label>
                    </strong>

                    <span>
                        Enter your employment details.
                    </span>
                </div>

            </div>


            <div class="row g-3">


                <!-- DESIGNATION -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Designation
                            <span>*</span>
                        </label>

                        <asp:TextBox
                            ID="txtExperienceDesignation"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="150"
                            placeholder="e.g. Full Stack .NET Developer">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- COMPANY -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Company Name
                            <span>*</span>
                        </label>

                        <asp:TextBox
                            ID="txtExperienceCompany"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="150"
                            placeholder="e.g. ABC Technologies Pvt. Ltd.">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- EMPLOYMENT TYPE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Employment Type
                        </label>

                        <asp:DropDownList
                            ID="ddlExperienceEmploymentType"
                            runat="server"
                            CssClass="profile-input">

                            <asp:ListItem
                                Text="Select Employment Type"
                                Value="" />

                            <asp:ListItem
                                Text="Full Time"
                                Value="Full Time" />

                            <asp:ListItem
                                Text="Part Time"
                                Value="Part Time" />

                            <asp:ListItem
                                Text="Internship"
                                Value="Internship" />

                            <asp:ListItem
                                Text="Contract"
                                Value="Contract" />

                            <asp:ListItem
                                Text="Freelance"
                                Value="Freelance" />

                            <asp:ListItem
                                Text="Apprenticeship"
                                Value="Apprenticeship" />

                        </asp:DropDownList>

                    </div>

                </div>


                <!-- LOCATION -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Location
                        </label>

                        <asp:TextBox
                            ID="txtExperienceLocation"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="150"
                            placeholder="e.g. Noida, Uttar Pradesh">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- START DATE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Start Date
                            <span>*</span>
                        </label>

                        <asp:TextBox
                            ID="txtExperienceStartDate"
                            runat="server"
                            TextMode="Date"
                            CssClass="profile-input">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- END DATE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            End Date
                        </label>

                        <asp:TextBox
                            ID="txtExperienceEndDate"
                            runat="server"
                            TextMode="Date"
                            CssClass="profile-input">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- CURRENT JOB -->

                <div class="col-12">

                    <div class="current-job-checkbox">

                        <asp:CheckBox
                            ID="chkCurrentJob"
                            runat="server"
                            onclick="toggleCurrentJob();" />

                        <label for="<%= chkCurrentJob.ClientID %>">
                            I currently work here
                        </label>

                    </div>

                </div>


                <!-- DESCRIPTION -->

                <div class="col-12">

                    <div class="profile-form-group">

                        <label>
                            Job Description
                        </label>

                        <asp:TextBox
                            ID="txtExperienceDescription"
                            runat="server"
                            TextMode="MultiLine"
                            Rows="5"
                            MaxLength="2000"
                            CssClass="profile-input profile-textarea"
                            placeholder="Describe your responsibilities, technologies and achievements...">
                        </asp:TextBox>

                        <small>
                            Mention your responsibilities,
                            projects, technologies and achievements.
                        </small>

                    </div>

                </div>

            </div>


            <!-- FORM BUTTONS -->

            <div class="experience-form-actions">

                <asp:Button
                    ID="btnCancelExperience"
                    runat="server"
                    Text="Cancel"
                    CssClass="cancel-experience-btn"
                    CausesValidation="false"
                    Visible="false"
                    OnClick="btnCancelExperience_Click" />


                <asp:Button
                    ID="btnSaveExperience"
                    runat="server"
                    Text="Add Experience"
                    CssClass="save-profile-btn"
                    CausesValidation="false"
                    OnClick="btnSaveExperience_Click" />

            </div>

        </div>


        <div class="form-divider"></div>


        <!-- =====================================
             EXPERIENCE LIST
        ====================================== -->

        <div class="experience-list-heading">

            <div>
                <strong>Employment History</strong>

                <span>
                    Your previously added work experience.
                </span>
            </div>


            <span class="experience-count">

                <asp:Label
                    ID="lblExperienceCount"
                    runat="server"
                    Text="0">
                </asp:Label>

                Experience

            </span>

        </div>


        <asp:Panel
            ID="pnlExperienceList"
            runat="server">

            <asp:Repeater
                ID="rptExperiences"
                runat="server"
                OnItemCommand="rptExperiences_ItemCommand">

                <ItemTemplate>

                    <div class="experience-card">

                        <div class="experience-company-icon">
                            <i class="bi bi-building"></i>
                        </div>


                        <div class="experience-card-content">

                            <div class="experience-card-top">

                                <div>

                                    <h3>
                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("Designation")
                                            )
                                        ) %>
                                    </h3>

                                    <strong>
                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("CompanyName")
                                            )
                                        ) %>
                                    </strong>

                                </div>


                                <div class="experience-actions">

                                    <asp:LinkButton
                                        ID="btnEditExperience"
                                        runat="server"
                                        CommandName="EditExperience"
                                        CommandArgument='<%# Eval("ExperienceId") %>'
                                        CssClass="experience-action-btn"
                                        CausesValidation="false"
                                        ToolTip="Edit">

                                        <i class="bi bi-pencil"></i>

                                    </asp:LinkButton>


                                    <asp:LinkButton
                                        ID="btnDeleteExperience"
                                        runat="server"
                                        CommandName="DeleteExperience"
                                        CommandArgument='<%# Eval("ExperienceId") %>'
                                        CssClass="experience-action-btn delete"
                                        CausesValidation="false"
                                        ToolTip="Delete"
                                        OnClientClick="return confirm('Are you sure you want to delete this experience?');">

                                        <i class="bi bi-trash"></i>

                                    </asp:LinkButton>

                                </div>

                            </div>


                            <div class="experience-meta">

                                <span>
                                    <i class="bi bi-calendar3"></i>

                                    <%# FormatExperienceDate(
                                        Eval("StartDate"),
                                        Eval("EndDate"),
                                        Eval("IsCurrentJob")
                                    ) %>
                                </span>


                                <asp:PlaceHolder
                                    ID="phEmploymentType"
                                    runat="server"
                                    Visible='<%#
                                        !string.IsNullOrWhiteSpace(
                                            Convert.ToString(
                                                Eval("EmploymentType")
                                            )
                                        )
                                    %>'>

                                    <span>
                                        <i class="bi bi-briefcase"></i>

                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("EmploymentType")
                                            )
                                        ) %>
                                    </span>

                                </asp:PlaceHolder>


                                <asp:PlaceHolder
                                    ID="phLocation"
                                    runat="server"
                                    Visible='<%#
                                        !string.IsNullOrWhiteSpace(
                                            Convert.ToString(
                                                Eval("Location")
                                            )
                                        )
                                    %>'>

                                    <span>
                                        <i class="bi bi-geo-alt"></i>

                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("Location")
                                            )
                                        ) %>
                                    </span>

                                </asp:PlaceHolder>

                            </div>


                            <asp:PlaceHolder
                                ID="phDescription"
                                runat="server"
                                Visible='<%#
                                    !string.IsNullOrWhiteSpace(
                                        Convert.ToString(
                                            Eval("JobDescription")
                                        )
                                    )
                                %>'>

                                <p class="experience-description">
                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("JobDescription")
                                        )
                                    ) %>
                                </p>

                            </asp:PlaceHolder>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

        </asp:Panel>


        <!-- EMPTY -->

        <asp:Panel
            ID="pnlNoExperience"
            runat="server"
            Visible="false"
            CssClass="experience-empty-state">

            <div class="experience-empty-icon">
                <i class="bi bi-building"></i>
            </div>

            <strong>
                No work experience added
            </strong>

            <span>
                If you are an experienced candidate,
                add your employment history here.
            </span>

        </asp:Panel>

    </div>

</section>


               <!-- =========================================
     EDUCATION
========================================== -->

<section id="education"
         class="edit-section">

    <div class="edit-section-header">

        <div class="section-heading-icon">
            <i class="bi bi-mortarboard"></i>
        </div>

        <div>
            <h2>Education</h2>

            <p>
                Add your academic qualifications
                and education history.
            </p>
        </div>

    </div>


    <div class="edit-section-body">


        <!-- EDIT ID -->

        <asp:HiddenField
            ID="hfEducationId"
            runat="server"
            Value="0" />


        <!-- =====================================
             ADD / EDIT FORM
        ====================================== -->

        <div class="education-form-box">

            <div class="education-form-heading">

                <strong>
                    <asp:Label
                        ID="lblEducationFormTitle"
                        runat="server"
                        Text="Add Education">
                    </asp:Label>
                </strong>

                <span>
                    Enter your qualification details.
                </span>

            </div>


            <div class="row g-3">


                <!-- QUALIFICATION -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Qualification
                            <span>*</span>
                        </label>


                        <asp:DropDownList
                            ID="ddlQualification"
                            runat="server"
                            CssClass="profile-input">

                            <asp:ListItem
                                Text="Select Qualification"
                                Value="" />

                            <asp:ListItem
                                Text="10th"
                                Value="10th" />

                            <asp:ListItem
                                Text="12th"
                                Value="12th" />

                            <asp:ListItem
                                Text="Diploma"
                                Value="Diploma" />

                            <asp:ListItem
                                Text="ITI"
                                Value="ITI" />

                            <asp:ListItem
                                Text="Bachelor's Degree"
                                Value="Bachelor's Degree" />

                            <asp:ListItem
                                Text="Master's Degree"
                                Value="Master's Degree" />

                            <asp:ListItem
                                Text="Doctorate / PhD"
                                Value="Doctorate / PhD" />

                            <asp:ListItem
                                Text="Other"
                                Value="Other" />

                        </asp:DropDownList>

                    </div>

                </div>


                <!-- COURSE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Course / Degree
                        </label>

                        <asp:TextBox
                            ID="txtCourseName"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="150"
                            placeholder="e.g. B.Tech">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- SPECIALIZATION -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Specialization
                        </label>

                        <asp:TextBox
                            ID="txtSpecialization"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="150"
                            placeholder="e.g. Computer Science Engineering">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- INSTITUTE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            College / University / School
                            <span>*</span>
                        </label>

                        <asp:TextBox
                            ID="txtInstituteName"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="200"
                            placeholder="Enter institute name">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- EDUCATION TYPE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Education Type
                        </label>

                        <asp:DropDownList
                            ID="ddlEducationType"
                            runat="server"
                            CssClass="profile-input">

                            <asp:ListItem
                                Text="Select Education Type"
                                Value="" />

                            <asp:ListItem
                                Text="Full Time"
                                Value="Full Time" />

                            <asp:ListItem
                                Text="Part Time"
                                Value="Part Time" />

                            <asp:ListItem
                                Text="Distance"
                                Value="Distance" />

                            <asp:ListItem
                                Text="Online"
                                Value="Online" />

                        </asp:DropDownList>

                    </div>

                </div>


                <!-- START YEAR -->

                <div class="col-md-3">

                    <div class="profile-form-group">

                        <label>
                            Start Year
                        </label>

                        <asp:DropDownList
                            ID="ddlEducationStartYear"
                            runat="server"
                            CssClass="profile-input">
                        </asp:DropDownList>

                    </div>

                </div>


                <!-- PASSING YEAR -->

                <div class="col-md-3">

                    <div class="profile-form-group">

                        <label>
                            Passing Year
                        </label>

                        <asp:DropDownList
                            ID="ddlEducationPassingYear"
                            runat="server"
                            CssClass="profile-input">
                        </asp:DropDownList>

                    </div>

                </div>


                <!-- SCORE TYPE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Score Type
                        </label>

                        <asp:DropDownList
                            ID="ddlScoreType"
                            runat="server"
                            CssClass="profile-input">

                            <asp:ListItem
                                Text="Select Score Type"
                                Value="" />

                            <asp:ListItem
                                Text="Percentage"
                                Value="Percentage" />

                            <asp:ListItem
                                Text="CGPA"
                                Value="CGPA" />

                        </asp:DropDownList>

                    </div>

                </div>


                <!-- SCORE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Score
                        </label>

                        <asp:TextBox
                            ID="txtEducationScore"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="6"
                            placeholder="e.g. 78.50 or 8.20">
                        </asp:TextBox>

                    </div>

                </div>

            </div>


            <!-- BUTTONS -->

            <div class="education-form-actions">

                <asp:Button
                    ID="btnCancelEducation"
                    runat="server"
                    Text="Cancel"
                    CssClass="cancel-experience-btn"
                    CausesValidation="false"
                    Visible="false"
                    OnClick="btnCancelEducation_Click" />


                <asp:Button
                    ID="btnSaveEducation"
                    runat="server"
                    Text="Add Education"
                    CssClass="save-profile-btn"
                    CausesValidation="false"
                    OnClick="btnSaveEducation_Click"/>

            </div>

        </div>


        <div class="form-divider"></div>


        <!-- =====================================
             EDUCATION HISTORY
        ====================================== -->

        <div class="education-list-heading">

            <div>

                <strong>
                    Education History
                </strong>

                <span>
                    Your academic qualifications.
                </span>

            </div>


            <span class="education-count">

                <asp:Label
                    ID="lblEducationCount"
                    runat="server"
                    Text="0">
                </asp:Label>

                Records

            </span>

        </div>


        <asp:Panel
            ID="pnlEducationList"
            runat="server">

            <asp:Repeater
                ID="rptEducation"
                runat="server"
                OnItemCommand="rptEducation_ItemCommand">

                <ItemTemplate>

                    <div class="education-card">

                        <div class="education-icon">

                            <i class="bi bi-mortarboard"></i>

                        </div>


                        <div class="education-card-content">


                            <div class="education-card-top">

                                <div>

                                    <h3>
                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("CourseName")
                                            )
                                        ) %>
                                    </h3>


                                    <strong>
                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("InstituteName")
                                            )
                                        ) %>
                                    </strong>

                                </div>


                                <div class="experience-actions">


                                    <!-- EDIT -->

                                    <asp:LinkButton
                                        ID="btnEditEducation"
                                        runat="server"
                                        CommandName="EditEducation"
                                        CommandArgument='<%# Eval("EducationId") %>'
                                        CssClass="experience-action-btn"
                                        CausesValidation="false"
                                        ToolTip="Edit">

                                        <i class="bi bi-pencil"></i>

                                    </asp:LinkButton>


                                    <!-- DELETE -->

                                    <asp:LinkButton
                                        ID="btnDeleteEducation"
                                        runat="server"
                                        CommandName="DeleteEducation"
                                        CommandArgument='<%# Eval("EducationId") %>'
                                        CssClass="experience-action-btn delete"
                                        CausesValidation="false"
                                        ToolTip="Delete"
                                        OnClientClick="return confirm('Delete this education record?');">

                                        <i class="bi bi-trash"></i>

                                    </asp:LinkButton>

                                </div>

                            </div>


                            <!-- SPECIALIZATION -->

                            <asp:PlaceHolder
                                ID="phSpecialization"
                                runat="server"
                                Visible='<%#
                                    !string.IsNullOrWhiteSpace(
                                        Convert.ToString(
                                            Eval("Specialization")
                                        )
                                    )
                                %>'>

                                <div class="education-specialization">

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("Specialization")
                                        )
                                    ) %>

                                </div>

                            </asp:PlaceHolder>


                            <!-- META -->

                            <div class="education-meta">


                                <span>

                                    <i class="bi bi-award"></i>

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("Qualification")
                                        )
                                    ) %>

                                </span>


                                <asp:PlaceHolder
                                    ID="phEducationYears"
                                    runat="server"
                                    Visible='<%#
                                        Eval("StartYear") != DBNull.Value ||
                                        Eval("PassingYear") != DBNull.Value
                                    %>'>

                                    <span>

                                        <i class="bi bi-calendar3"></i>

                                        <%# FormatEducationYears(
                                            Eval("StartYear"),
                                            Eval("PassingYear")
                                        ) %>

                                    </span>

                                </asp:PlaceHolder>


                                <asp:PlaceHolder
                                    ID="phEducationType"
                                    runat="server"
                                    Visible='<%#
                                        !string.IsNullOrWhiteSpace(
                                            Convert.ToString(
                                                Eval("EducationType")
                                            )
                                        )
                                    %>'>

                                    <span>

                                        <i class="bi bi-clock"></i>

                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("EducationType")
                                            )
                                        ) %>

                                    </span>

                                </asp:PlaceHolder>


                                <asp:PlaceHolder
                                    ID="phScore"
                                    runat="server"
                                    Visible='<%#
                                        Eval("Score") != DBNull.Value
                                    %>'>

                                    <span>

                                        <i class="bi bi-bar-chart"></i>

                                        <%# FormatEducationScore(
                                            Eval("ScoreType"),
                                            Eval("Score")
                                        ) %>

                                    </span>

                                </asp:PlaceHolder>


                            </div>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

        </asp:Panel>


        <!-- EMPTY -->

        <asp:Panel
            ID="pnlNoEducation"
            runat="server"
            Visible="false"
            CssClass="education-empty-state">

            <div class="education-empty-icon">

                <i class="bi bi-mortarboard"></i>

            </div>

            <strong>
                No education added
            </strong>

            <span>
                Add your academic qualifications
                to strengthen your profile.
            </span>

        </asp:Panel>

    </div>

</section>


               <!-- =========================================
     PROJECTS
========================================== -->

<section id="projects"
         class="edit-section">

    <div class="edit-section-header">

        <div class="section-heading-icon">
            <i class="bi bi-kanban"></i>
        </div>

        <div>
            <h2>Projects</h2>

            <p>
                Showcase projects that demonstrate
                your practical experience.
            </p>
        </div>

    </div>


    <div class="edit-section-body">

        <asp:HiddenField
            ID="hfProjectId"
            runat="server"
            Value="0" />


        <!-- =====================================
             ADD / EDIT PROJECT
        ====================================== -->

        <div class="project-form-box">

            <div class="project-form-heading">

                <strong>
                    <asp:Label
                        ID="lblProjectFormTitle"
                        runat="server"
                        Text="Add Project">
                    </asp:Label>
                </strong>

                <span>
                    Add your project details,
                    technologies and responsibilities.
                </span>

            </div>


            <div class="row g-3">


                <!-- PROJECT TITLE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Project Title
                            <span>*</span>
                        </label>

                        <asp:TextBox
                            ID="txtProjectTitle"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="200"
                            placeholder="e.g. Job Portal">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- ROLE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Your Role
                        </label>

                        <asp:TextBox
                            ID="txtProjectRole"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="150"
                            placeholder="e.g. Full Stack Developer">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- CLIENT / COMPANY -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Client / Company
                        </label>

                        <asp:TextBox
                            ID="txtProjectClient"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="200"
                            placeholder="e.g. ABC Technologies">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- PROJECT URL -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Project URL
                        </label>

                        <asp:TextBox
                            ID="txtProjectUrl"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="500"
                            placeholder="https://example.com">
                        </asp:TextBox>

                        <small>
                            GitHub, live website or portfolio URL.
                        </small>

                    </div>

                </div>


                <!-- START DATE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            Start Date
                        </label>

                        <asp:TextBox
                            ID="txtProjectStartDate"
                            runat="server"
                            TextMode="Date"
                            CssClass="profile-input">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- END DATE -->

                <div class="col-md-6">

                    <div class="profile-form-group">

                        <label>
                            End Date
                        </label>

                        <asp:TextBox
                            ID="txtProjectEndDate"
                            runat="server"
                            TextMode="Date"
                            CssClass="profile-input">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- CURRENT PROJECT -->

                <div class="col-12">

                    <div class="current-job-checkbox">

                        <asp:CheckBox
                            ID="chkCurrentProject"
                            runat="server"
                            onclick="toggleCurrentProject();" />

                        <label for="<%= chkCurrentProject.ClientID %>">
                            I am currently working on this project
                        </label>

                    </div>

                </div>


                <!-- TECHNOLOGIES -->

                <div class="col-12">

                    <div class="profile-form-group">

                        <label>
                            Technologies Used
                        </label>

                        <asp:TextBox
                            ID="txtProjectTechnologies"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="1000"
                            placeholder="e.g. ASP.NET Web Forms, C#, SQL Server, JavaScript, Bootstrap">
                        </asp:TextBox>

                        <small>
                            Separate technologies with commas.
                        </small>

                    </div>

                </div>


                <!-- DESCRIPTION -->

                <div class="col-12">

                    <div class="profile-form-group">

                        <label>
                            Project Description
                        </label>

                        <asp:TextBox
                            ID="txtProjectDescription"
                            runat="server"
                            TextMode="MultiLine"
                            Rows="6"
                            MaxLength="3000"
                            CssClass="profile-input profile-textarea"
                            placeholder="Explain the project, your responsibilities, important features and achievements...">
                        </asp:TextBox>

                    </div>

                </div>

            </div>


            <!-- BUTTONS -->

            <div class="project-form-actions">

                <asp:Button
                    ID="btnCancelProject"
                    runat="server"
                    Text="Cancel"
                    CssClass="cancel-experience-btn"
                    CausesValidation="false"
                    Visible="false"
                    OnClick="btnCancelProject_Click" />


                <asp:Button
                    ID="btnSaveProject"
                    runat="server"
                    Text="Add Project"
                    CssClass="save-profile-btn"
                    CausesValidation="false"
                    OnClick="btnSaveProject_Click" />

            </div>

        </div>


        <div class="form-divider"></div>


        <!-- =====================================
             PROJECT LIST
        ====================================== -->

        <div class="project-list-heading">

            <div>

                <strong>
                    Your Projects
                </strong>

                <span>
                    Projects visible on your candidate profile.
                </span>

            </div>


            <span class="project-count">

                <asp:Label
                    ID="lblProjectCount"
                    runat="server"
                    Text="0">
                </asp:Label>

                Projects

            </span>

        </div>


        <asp:Panel
            ID="pnlProjectList"
            runat="server">


            <asp:Repeater
                ID="rptProjects"
                runat="server"
                OnItemCommand="rptProjects_ItemCommand">

                <ItemTemplate>


                    <div class="project-card">


                        <div class="project-icon">

                            <i class="bi bi-kanban"></i>

                        </div>


                        <div class="project-card-content">


                            <!-- TOP -->

                            <div class="project-card-top">


                                <div>

                                    <h3>

                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("ProjectTitle")
                                            )
                                        ) %>

                                    </h3>


                                    <asp:PlaceHolder
                                        ID="phProjectRole"
                                        runat="server"
                                        Visible='<%#
                                            !string.IsNullOrWhiteSpace(
                                                Convert.ToString(
                                                    Eval("ProjectRole")
                                                )
                                            )
                                        %>'>

                                        <strong>

                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("ProjectRole")
                                                )
                                            ) %>

                                        </strong>

                                    </asp:PlaceHolder>

                                </div>


                                <!-- ACTIONS -->

                                <div class="experience-actions">


                                    <asp:LinkButton
                                        ID="btnEditProject"
                                        runat="server"
                                        CommandName="EditProject"
                                        CommandArgument='<%# Eval("ProjectId") %>'
                                        CssClass="experience-action-btn"
                                        CausesValidation="false"
                                        ToolTip="Edit">

                                        <i class="bi bi-pencil"></i>

                                    </asp:LinkButton>


                                    <asp:LinkButton
                                        ID="btnDeleteProject"
                                        runat="server"
                                        CommandName="DeleteProject"
                                        CommandArgument='<%# Eval("ProjectId") %>'
                                        CssClass="experience-action-btn delete"
                                        CausesValidation="false"
                                        ToolTip="Delete"
                                        OnClientClick="return confirm('Delete this project?');">

                                        <i class="bi bi-trash"></i>

                                    </asp:LinkButton>

                                </div>

                            </div>


                            <!-- META -->

                            <div class="project-meta">


                                <asp:PlaceHolder
                                    ID="phProjectClient"
                                    runat="server"
                                    Visible='<%#
                                        !string.IsNullOrWhiteSpace(
                                            Convert.ToString(
                                                Eval("ClientCompany")
                                            )
                                        )
                                    %>'>

                                    <span>

                                        <i class="bi bi-building"></i>

                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("ClientCompany")
                                            )
                                        ) %>

                                    </span>

                                </asp:PlaceHolder>


                                <asp:PlaceHolder
                                    ID="phProjectDates"
                                    runat="server"
                                    Visible='<%#
                                        Eval("StartDate") != DBNull.Value
                                    %>'>

                                    <span>

                                        <i class="bi bi-calendar3"></i>

                                        <%# FormatProjectDate(
                                            Eval("StartDate"),
                                            Eval("EndDate"),
                                            Eval("IsCurrentProject")
                                        ) %>

                                    </span>

                                </asp:PlaceHolder>

                            </div>


                            <!-- TECHNOLOGIES -->

                            <asp:PlaceHolder
                                ID="phTechnologies"
                                runat="server"
                                Visible='<%#
                                    !string.IsNullOrWhiteSpace(
                                        Convert.ToString(
                                            Eval("Technologies")
                                        )
                                    )
                                %>'>

                                <div class="project-technologies">

                                    <i class="bi bi-code-slash"></i>

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("Technologies")
                                        )
                                    ) %>

                                </div>

                            </asp:PlaceHolder>


                            <!-- DESCRIPTION -->

                            <asp:PlaceHolder
                                ID="phProjectDescription"
                                runat="server"
                                Visible='<%#
                                    !string.IsNullOrWhiteSpace(
                                        Convert.ToString(
                                            Eval("ProjectDescription")
                                        )
                                    )
                                %>'>

                                <p class="project-description">

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("ProjectDescription")
                                        )
                                    ) %>

                                </p>

                            </asp:PlaceHolder>


                            <!-- URL -->

                            <asp:PlaceHolder
                                ID="phProjectUrl"
                                runat="server"
                                Visible='<%#
                                    !string.IsNullOrWhiteSpace(
                                        Convert.ToString(
                                            Eval("ProjectUrl")
                                        )
                                    )
                                %>'>

                                <div class="project-link">

                                    <i class="bi bi-link-45deg"></i>

                                    <asp:HyperLink
                                        ID="lnkProjectUrl"
                                        runat="server"
                                        NavigateUrl='<%# GetSafeProjectUrl(Eval("ProjectUrl")) %>'
                                        Target="_blank"
                                        rel="noopener noreferrer"
                                        Text="View Project">
                                    </asp:HyperLink>

                                </div>

                            </asp:PlaceHolder>


                        </div>

                    </div>


                </ItemTemplate>

            </asp:Repeater>


        </asp:Panel>


        <!-- EMPTY -->

        <asp:Panel
            ID="pnlNoProjects"
            runat="server"
            Visible="false"
            CssClass="project-empty-state">

            <div class="project-empty-icon">

                <i class="bi bi-kanban"></i>

            </div>

            <strong>
                No projects added
            </strong>

            <span>
                Add your best projects to demonstrate
                your practical skills and experience.
            </span>

        </asp:Panel>


    </div>

</section>


               <!-- =========================================
     JOB PREFERENCES
========================================== -->

<section id="preferences"
         class="edit-section">

    <div class="edit-section-header">

        <div class="section-heading-icon">

            <i class="bi bi-sliders"></i>

        </div>

        <div>

            <h2>
                Job Preferences
            </h2>

            <p>
                Tell us what type of opportunities
                you're interested in.
            </p>

        </div>

    </div>


    <div class="edit-section-body">

        <div class="row g-3">


            <!-- PREFERRED ROLE -->

            <div class="col-md-6">

                <div class="profile-form-group">

                    <label>
                        Preferred Job Role
                    </label>

                    <asp:TextBox
                        ID="txtPreferredRole"
                        runat="server"
                        CssClass="profile-input"
                        MaxLength="150"
                        placeholder="e.g. Full Stack .NET Developer">
                    </asp:TextBox>

                </div>

            </div>


            <!-- PREFERRED LOCATION -->

            <div class="col-md-6">

                <div class="profile-form-group">

                    <label>
                        Preferred Location
                    </label>

                    <asp:TextBox
                        ID="txtPreferredLocation"
                        runat="server"
                        CssClass="profile-input"
                        MaxLength="200"
                        placeholder="e.g. Noida, Delhi NCR, Remote">
                    </asp:TextBox>

                    <small>
                        You can enter multiple locations separated
                        by commas.
                    </small>

                </div>

            </div>


            <!-- INDUSTRY -->

            <div class="col-md-6">

                <div class="profile-form-group">

                    <label>
                        Preferred Industry
                    </label>

                    <asp:DropDownList
                        ID="ddlPreferredIndustry"
                        runat="server"
                        CssClass="profile-input">

                        <asp:ListItem Text="Select Industry" Value="" />

                        <asp:ListItem Text="IT / Software" Value="IT / Software" />

                        <asp:ListItem Text="Banking / Finance" Value="Banking / Finance" />

                        <asp:ListItem Text="Healthcare" Value="Healthcare" />

                        <asp:ListItem Text="Education" Value="Education" />

                        <asp:ListItem Text="E-Commerce" Value="E-Commerce" />

                        <asp:ListItem Text="Manufacturing" Value="Manufacturing" />

                        <asp:ListItem Text="Telecom" Value="Telecom" />

                        <asp:ListItem Text="Retail" Value="Retail" />

                        <asp:ListItem Text="Consulting" Value="Consulting" />

                        <asp:ListItem Text="Real Estate" Value="Real Estate" />

                        <asp:ListItem Text="Other" Value="Other" />

                    </asp:DropDownList>

                </div>

            </div>


            <!-- SHIFT -->

            <div class="col-md-6">

                <div class="profile-form-group">

                    <label>
                        Preferred Shift
                    </label>

                    <asp:DropDownList
                        ID="ddlPreferredShift"
                        runat="server"
                        CssClass="profile-input">

                        <asp:ListItem Text="Select Shift" Value="" />

                        <asp:ListItem Text="Day Shift" Value="Day Shift" />

                        <asp:ListItem Text="Night Shift" Value="Night Shift" />

                        <asp:ListItem Text="Flexible" Value="Flexible" />

                    </asp:DropDownList>

                </div>

            </div>

        </div>


        <div class="section-actions">

            <asp:Button
                ID="btnSavePreferences"
                runat="server"
                Text="Save Job Preferences"
                CssClass="save-profile-btn"
                OnClick="btnSavePreferences_Click" />

        </div>

    </div>

</section>

            </div>

        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
        <script>

        document.addEventListener("DOMContentLoaded", function () {

            var about =
                document.getElementById(
                    "<%= txtAbout.ClientID %>"
                );

            var counter =
                document.getElementById(
                    "aboutCounter"
                );


            function updateCounter() {

                if (!about || !counter)
                    return;

                counter.innerText =
                    about.value.length +
                    " / 1500";
            }


            if (about) {

                updateCounter();

                about.addEventListener(
                    "input",
                    updateCounter
                );
            }

        });

    </script>
    <script>

        function toggleExperienceFields() {

            var fresher =
                document.getElementById(
                "<%= rbFresher.ClientID %>"
            );

            var experiencedFields =
                document.getElementById(
                    "experiencedFields"
                );


            if (!fresher ||
                !experiencedFields) {
                return;
            }


            if (fresher.checked) {

                experiencedFields.style.display =
                    "none";

            }
            else {

                experiencedFields.style.display =
                    "block";

            }
        }


        document.addEventListener(
            "DOMContentLoaded",
            function () {

                toggleExperienceFields();

            }
        );

        </script>
    <script>

        function setSkill(skillName) {

            var skillBox =
                document.getElementById(
                "<%= txtSkill.ClientID %>"
            );


            if (!skillBox) {
                return;
            }


            skillBox.value =
                skillName;


            skillBox.focus();
        }

        </script>
    <script>

        function toggleCurrentJob() {

            var currentJob =
                document.getElementById(
                "<%= chkCurrentJob.ClientID %>"
            );

        var endDate =
            document.getElementById(
                "<%= txtExperienceEndDate.ClientID %>"
            );


            if (!currentJob || !endDate) {
                return;
            }


            if (currentJob.checked) {

                endDate.value = "";

                endDate.disabled = true;

            }
            else {

                endDate.disabled = false;

            }
        }


        document.addEventListener(
            "DOMContentLoaded",
            function () {

                toggleCurrentJob();

            }
        );

        </script>
    <script>

        function toggleCurrentProject() {

            var checkbox =
                document.getElementById(
                "<%= chkCurrentProject.ClientID %>"
            );


        var endDate =
            document.getElementById(
                "<%= txtProjectEndDate.ClientID %>"
            );


            if (!checkbox || !endDate) {
                return;
            }


            if (checkbox.checked) {

                endDate.value = "";

                endDate.disabled = true;

            }
            else {

                endDate.disabled = false;

            }
        }


        document.addEventListener(
            "DOMContentLoaded",
            function () {

                toggleCurrentProject();

            }
        );

        </script>

</asp:Content>
