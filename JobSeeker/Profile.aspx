<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Success24_Job_Portal.JobSeeker.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <link href="<%= ResolveUrl("~/Assets/css/jobseeker-profile.css") %>"
          rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="profile-page">

        <!-- TOP BAR -->

        <div class="profile-page-heading">

            <div>
                <span>MY PROFILE</span>

                <h1>Professional Profile</h1>

                <p>
                    Manage how your professional information
                    appears to recruiters.
                </p>
            </div>

            <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx") %>"
               class="edit-profile-btn">

                <i class="bi bi-pencil-square"></i>
                Edit Profile

            </a>

        </div>


        <!-- PROFILE HEADER -->

        <div class="profile-header-card">

            <div class="profile-cover"></div>

            <div class="profile-header-content">

                <div class="profile-photo-wrapper">

                    <asp:Image
                        ID="imgProfile"
                        runat="server"
                        CssClass="profile-photo"
                        Visible="false" />

                    <asp:Panel
                        ID="pnlProfileInitial"
                        runat="server"
                        CssClass="profile-initial">

                        <asp:Label
                            ID="lblProfileInitial"
                            runat="server">
                        </asp:Label>

                    </asp:Panel>

                </div>


                <div class="profile-main-info">

                    <div class="profile-name-row">

                        <div>

                            <h2>
                                <asp:Label
                                    ID="lblFullName"
                                    runat="server">
                                </asp:Label>
                            </h2>

                            <p class="profile-headline">

                                <asp:Label
                                    ID="lblHeadline"
                                    runat="server">
                                </asp:Label>

                            </p>

                        </div>


                        <div class="profile-completion">

                            <span>Profile Completion</span>

                            <strong>
                                <asp:Label
                                    ID="lblCompletion"
                                    runat="server">
                                </asp:Label>
                            </strong>

                        </div>

                    </div>


                    <div class="profile-contact-info">

                        <span>

                            <i class="bi bi-geo-alt"></i>

                            <asp:Label
                                ID="lblLocation"
                                runat="server">
                            </asp:Label>

                        </span>


                        <span>

                            <i class="bi bi-envelope"></i>

                            <asp:Label
                                ID="lblEmail"
                                runat="server">
                            </asp:Label>

                        </span>


                        <span>

                            <i class="bi bi-phone"></i>

                            <asp:Label
                                ID="lblMobile"
                                runat="server">
                            </asp:Label>

                        </span>

                    </div>

                </div>

            </div>

        </div>


        <div class="row g-4 profile-grid">

            <!-- LEFT -->

            <div class="col-xl-8">


                <!-- ABOUT -->

                <div class="profile-card">

                    <div class="profile-card-header">

                        <div>
                            <h2>About Me</h2>
                            <p>Your professional summary</p>
                        </div>

                        <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx#about") %>">
                            <i class="bi bi-pencil"></i>
                        </a>

                    </div>


                    <div class="profile-card-body">

                        <asp:Panel
                            ID="pnlAbout"
                            runat="server">

                            <p class="about-text">

                                <asp:Label
                                    ID="lblAbout"
                                    runat="server">
                                </asp:Label>

                            </p>

                        </asp:Panel>


                        <asp:Panel
                            ID="pnlNoAbout"
                            runat="server"
                            Visible="false"
                            CssClass="section-empty">

                            <i class="bi bi-person-lines-fill"></i>

                            <div>
                                <strong>Add your professional summary</strong>
                                <span>
                                    Tell recruiters about your experience,
                                    skills and career goals.
                                </span>
                            </div>

                            <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx#about") %>">
                                Add
                            </a>

                        </asp:Panel>

                    </div>

                </div>



                <!-- EXPERIENCE -->

                <div class="profile-card">

                    <div class="profile-card-header">

                        <div>
                            <h2>Work Experience</h2>
                            <p>Your employment history</p>
                        </div>

                        <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx#experience") %>">
                            <i class="bi bi-plus-lg"></i>
                        </a>

                    </div>


                    <div class="profile-card-body">

                        <asp:Repeater
                            ID="rptExperience"
                            runat="server">

                            <ItemTemplate>

                                <div class="timeline-item">

                                    <div class="timeline-icon">
                                        <i class="bi bi-building"></i>
                                    </div>


                                    <div class="timeline-content">

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

                                        <div class="timeline-meta">

                                         <%# GetExperiencePeriod(
                                            Eval("StartDate"),
                                            Eval("EndDate"),
                                            Eval("IsCurrentJob")
                                        ) %>

                                        </div>

                                        <p>
                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("JobDescription")
                                                )
                                            ) %>
                                        </p>

                                    </div>

                                </div>

                            </ItemTemplate>

                        </asp:Repeater>


                        <asp:Panel
                            ID="pnlNoExperience"
                            runat="server"
                            Visible="false"
                            CssClass="section-empty">

                            <i class="bi bi-briefcase"></i>

                            <div>
                                <strong>No work experience added</strong>
                                <span>
                                    Fresher? You can leave this section empty.
                                </span>
                            </div>

                            <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx#experience") %>">
                                Add
                            </a>

                        </asp:Panel>

                    </div>

                </div>



                <!-- EDUCATION -->

                <div class="profile-card">

                    <div class="profile-card-header">

                        <div>
                            <h2>Education</h2>
                            <p>Your academic qualifications</p>
                        </div>

                        <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx#education") %>">
                            <i class="bi bi-plus-lg"></i>
                        </a>

                    </div>


                    <div class="profile-card-body">

                        <asp:Repeater
                            ID="rptEducation"
                            runat="server">

                            <ItemTemplate>

                                <div class="timeline-item">

                                    <div class="timeline-icon education-icon">
                                        <i class="bi bi-mortarboard"></i>
                                    </div>


                                    <div class="timeline-content">

                                        <h3>
                                          <%# GetEducationTitle(
                                            Eval("Qualification"),
                                            Eval("CourseName")
                                        ) %>
                                        </h3>

                                        <strong>
                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("InstituteName")
                                                )
                                            ) %>
                                        </strong>

                                        <div class="timeline-meta">

                                         <%# GetEducationPeriod(
                                            Eval("StartYear"),
                                            Eval("PassingYear")
                                        ) %>

                                        </div>

                                    </div>

                                </div>

                            </ItemTemplate>

                        </asp:Repeater>


                        <asp:Panel
                            ID="pnlNoEducation"
                            runat="server"
                            Visible="false"
                            CssClass="section-empty">

                            <i class="bi bi-mortarboard"></i>

                            <div>
                                <strong>No education added</strong>
                                <span>
                                    Add your degree and educational background.
                                </span>
                            </div>

                            <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx#education") %>">
                                Add
                            </a>

                        </asp:Panel>

                    </div>

                </div>



                <!-- PROJECTS -->

                <div class="profile-card">

                    <div class="profile-card-header">

                        <div>
                            <h2>Projects</h2>
                            <p>Projects that showcase your skills</p>
                        </div>

                        <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx#projects") %>">
                            <i class="bi bi-plus-lg"></i>
                        </a>

                    </div>


                    <div class="profile-card-body">

                        <asp:Repeater
                            ID="rptProjects"
                            runat="server">

                            <ItemTemplate>

                                <div class="project-item">

                                    <div class="project-icon">
                                        <i class="bi bi-code-square"></i>
                                    </div>


                                    <div class="project-content">

                                        <h3>
                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("ProjectTitle")
                                                )
                                            ) %>
                                        </h3>

                                        <p>
                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("ProjectDescription")
                                                )
                                            ) %>
                                        </p>

                                        <asp:HyperLink
                                            runat="server"
                                            CssClass="project-link"
                                            Visible='<%#
                                                !string.IsNullOrWhiteSpace(
                                                    Convert.ToString(
                                                        Eval("ProjectUrl")
                                                    )
                                                )
                                            %>'
                                            NavigateUrl='<%#
                                                GetSafeExternalUrl(
                                                    Eval("ProjectUrl")
                                                )
                                            %>'
                                            Target="_blank">

                                            <i class="bi bi-box-arrow-up-right"></i>
                                            View Project

                                        </asp:HyperLink>

                                    </div>

                                </div>

                            </ItemTemplate>

                        </asp:Repeater>


                        <asp:Panel
                            ID="pnlNoProjects"
                            runat="server"
                            Visible="false"
                            CssClass="section-empty">

                            <i class="bi bi-code-square"></i>

                            <div>
                                <strong>No projects added</strong>
                                <span>
                                    Showcase projects that demonstrate your skills.
                                </span>
                            </div>

                            <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx#projects") %>">
                                Add
                            </a>

                        </asp:Panel>

                    </div>

                </div>

            </div>



            <!-- RIGHT -->

            <div class="col-xl-4">


                <!-- PROFESSIONAL INFORMATION -->

                <div class="profile-card">

                    <div class="profile-card-header">

                        <div>
                            <h2>Professional Details</h2>
                            <p>Your career information</p>
                        </div>

                    </div>


                    <div class="profile-card-body">

                        <div class="detail-list">


                            <div class="detail-item">

                                <span>Current Designation</span>

                                <strong>
                                    <asp:Label
                                        ID="lblDesignation"
                                        runat="server">
                                    </asp:Label>
                                </strong>

                            </div>


                            <div class="detail-item">

                                <span>Current Company</span>

                                <strong>
                                    <asp:Label
                                        ID="lblCompany"
                                        runat="server">
                                    </asp:Label>
                                </strong>

                            </div>


                            <div class="detail-item">

                                <span>Total Experience</span>

                                <strong>
                                    <asp:Label
                                        ID="lblExperience"
                                        runat="server">
                                    </asp:Label>
                                </strong>

                            </div>


                            <div class="detail-item">

                                <span>Current Salary</span>

                                <strong>
                                    <asp:Label
                                        ID="lblCurrentSalary"
                                        runat="server">
                                    </asp:Label>
                                </strong>

                            </div>


                            <div class="detail-item">

                                <span>Expected Salary</span>

                                <strong>
                                    <asp:Label
                                        ID="lblExpectedSalary"
                                        runat="server">
                                    </asp:Label>
                                </strong>

                            </div>


                            <div class="detail-item">

                                <span>Notice Period</span>

                                <strong>
                                    <asp:Label
                                        ID="lblNoticePeriod"
                                        runat="server">
                                    </asp:Label>
                                </strong>

                            </div>


                            <div class="detail-item">

                                <span>Employment Type</span>

                                <strong>
                                    <asp:Label
                                        ID="lblEmploymentType"
                                        runat="server">
                                    </asp:Label>
                                </strong>

                            </div>

                        </div>

                    </div>

                </div>



                <!-- SKILLS -->

                <div class="profile-card">

                    <div class="profile-card-header">

                        <div>
                            <h2>Skills</h2>
                            <p>Your professional skills</p>
                        </div>

                        <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx#skills") %>">
                            <i class="bi bi-pencil"></i>
                        </a>

                    </div>


                    <div class="profile-card-body">

                        <div class="skill-list">

                            <asp:Repeater
                                ID="rptSkills"
                                runat="server">

                                <ItemTemplate>

                                    <span class="skill-tag">

                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("SkillName")
                                            )
                                        ) %>

                                    </span>

                                </ItemTemplate>

                            </asp:Repeater>

                        </div>


                        <asp:Panel
                            ID="pnlNoSkills"
                            runat="server"
                            Visible="false"
                            CssClass="small-empty-text">

                            Add skills to improve your job recommendations.

                        </asp:Panel>

                    </div>

                </div>



                <!-- RESUME -->

                <div class="profile-card">

                    <div class="profile-card-header">

                        <div>
                            <h2>Resume</h2>
                            <p>Your latest resume</p>
                        </div>

                    </div>


                    <div class="profile-card-body">

                        <asp:Panel
                            ID="pnlResume"
                            runat="server"
                            Visible="false">

                            <div class="resume-box">

                                <div class="resume-icon">
                                    <i class="bi bi-file-earmark-pdf"></i>
                                </div>


                                <div class="resume-info">

                                    <strong>
                                        <asp:Label
                                            ID="lblResumeName"
                                            runat="server">
                                        </asp:Label>
                                    </strong>

                                    <span>
                                        <asp:Label
                                            ID="lblResumeDate"
                                            runat="server">
                                        </asp:Label>
                                    </span>

                                </div>


                                <asp:HyperLink
                                    ID="lnkResume"
                                    runat="server"
                                    CssClass="resume-view-btn"
                                    Target="_blank">

                                    <i class="bi bi-eye"></i>

                                </asp:HyperLink>

                            </div>

                        </asp:Panel>


                        <asp:Panel
                            ID="pnlNoResume"
                            runat="server"
                            Visible="false">

                            <div class="resume-empty">

                                <i class="bi bi-file-earmark-arrow-up"></i>

                                <strong>Upload your resume</strong>

                                <span>
                                    Recruiters use your resume to
                                    evaluate your profile.
                                </span>

                                <a href="<%= ResolveUrl("~/JobSeeker/Resume.aspx") %>">
                                    Upload Resume
                                </a>

                            </div>

                        </asp:Panel>

                    </div>

                </div>



                <!-- JOB PREFERENCES -->

                <div class="profile-card">

                    <div class="profile-card-header">

                        <div>
                            <h2>Job Preferences</h2>
                            <p>What you're looking for</p>
                        </div>

                    </div>


                    <div class="profile-card-body">

                        <div class="detail-list">

                            <div class="detail-item">

                                <span>Preferred Location</span>

                                <strong>
                                    <asp:Label
                                        ID="lblPreferredLocation"
                                        runat="server">
                                    </asp:Label>
                                </strong>

                            </div>


                            <div class="detail-item">

                                <span>Preferred Role</span>

                                <strong>
                                    <asp:Label
                                        ID="lblPreferredRole"
                                        runat="server">
                                    </asp:Label>
                                </strong>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
