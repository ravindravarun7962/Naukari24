<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Success24_Job_Portal.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="<%= ResolveUrl("~/Assets/css/jobseeker-dashboard.css") %>"
          rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="dashboard-page">


        <!-- =========================================
             WELCOME
        ========================================== -->

        <div class="welcome-section">

            <div>

                <span class="welcome-small">
                    JOB SEEKER DASHBOARD
                </span>

                <h1>
                    <asp:Label
                        ID="lblGreeting"
                        runat="server">
                    </asp:Label>,

                    <asp:Label
                        ID="lblName"
                        runat="server">
                    </asp:Label>

                    <span class="welcome-wave">👋</span>
                </h1>

                <p>
                    Here's what's happening with your job search.
                </p>

            </div>


            <a href="<%= ResolveUrl("~/Jobs.aspx") %>"
               class="dashboard-find-job">

                <i class="bi bi-search"></i>

                Find Jobs

            </a>

        </div>



        <!-- =========================================
             PROFILE COMPLETION
        ========================================== -->

        <asp:Panel
            ID="pnlProfileCompletion"
            runat="server"
            CssClass="profile-banner">

            <div class="profile-banner-icon">

                <i class="bi bi-person-check"></i>

            </div>


            <div class="profile-banner-content">

                <div class="profile-banner-heading">

                    <div>

                        <h3>
                            Complete your profile
                        </h3>

                        <p>
                            A complete profile helps recruiters
                            discover you faster.
                        </p>

                    </div>


                    <strong>

                        <asp:Label
                            ID="lblDashboardProfileCompletion"
                            runat="server"
                            Text="0%">
                        </asp:Label>

                    </strong>

                </div>


                <div class="progress dashboard-profile-progress">

                    <div
                        id="dashboardProfileProgressBar"
                        runat="server"
                        class="progress-bar">
                    </div>

                </div>

            </div>


            <a href="<%= ResolveUrl("~/JobSeeker/EditProfile.aspx") %>"
               class="complete-profile-btn">

                Complete Profile

                <i class="bi bi-arrow-right"></i>

            </a>

        </asp:Panel>



        <!-- =========================================
             STAT CARDS
        ========================================== -->

        <div class="row g-3 dashboard-stats">


            <!-- APPLIED -->

            <div class="col-xl-3 col-md-6">

                <a href="<%= ResolveUrl("~/JobSeeker/Applications.aspx") %>"
                   class="stat-card">

                    <div class="stat-card-icon blue">

                        <i class="bi bi-send-check"></i>

                    </div>


                    <div class="stat-card-info">

                        <span>
                            Applications
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblApplications"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </strong>

                    </div>


                    <i class="bi bi-arrow-right stat-arrow"></i>

                </a>

            </div>



            <!-- SHORTLISTED -->

            <div class="col-xl-3 col-md-6">

                <a href="<%= ResolveUrl("~/JobSeeker/Applications.aspx?status=Shortlisted") %>"
                   class="stat-card">

                    <div class="stat-card-icon green">

                        <i class="bi bi-person-check"></i>

                    </div>


                    <div class="stat-card-info">

                        <span>
                            Shortlisted
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblShortlisted"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </strong>

                    </div>


                    <i class="bi bi-arrow-right stat-arrow"></i>

                </a>

            </div>



            <!-- INTERVIEWS -->

            <div class="col-xl-3 col-md-6">

                <a href="<%= ResolveUrl("~/JobSeeker/Interviews.aspx") %>"
                   class="stat-card">

                    <div class="stat-card-icon orange">

                        <i class="bi bi-calendar-event"></i>

                    </div>


                    <div class="stat-card-info">

                        <span>
                            Interviews
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblInterviews"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </strong>

                    </div>


                    <i class="bi bi-arrow-right stat-arrow"></i>

                </a>

            </div>



            <!-- SAVED -->

            <div class="col-xl-3 col-md-6">

                <a href="<%= ResolveUrl("~/JobSeeker/SavedJobs.aspx") %>"
                   class="stat-card">

                    <div class="stat-card-icon purple">

                        <i class="bi bi-bookmark"></i>

                    </div>


                    <div class="stat-card-info">

                        <span>
                            Saved Jobs
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblSavedJobs"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </strong>

                    </div>


                    <i class="bi bi-arrow-right stat-arrow"></i>

                </a>

            </div>

        </div>



        <!-- =========================================
             MAIN GRID
        ========================================== -->

        <div class="row g-4 dashboard-main-grid">


            <!-- =====================================
                 RECENT APPLICATIONS
            ====================================== -->

            <div class="col-xl-8">

                <div class="dashboard-card">

                    <div class="dashboard-card-header">

                        <div>

                            <h2>
                                Recent Applications
                            </h2>

                            <p>
                                Track your latest job applications.
                            </p>

                        </div>


                        <a href="<%= ResolveUrl("~/JobSeeker/Applications.aspx") %>">

                            View All

                            <i class="bi bi-arrow-right"></i>

                        </a>

                    </div>


                    <div class="application-list">


                        <asp:Repeater
                            ID="rptRecentApplications"
                            runat="server">

                            <ItemTemplate>

                                <div class="application-item">

                                    <div class="application-company-logo">

                                        <%# GetCompanyInitial(Eval("CompanyName")) %>

                                    </div>


                                    <div class="application-info">

                                        <a href='<%#
                                            ResolveUrl(
                                                "~/JobDetails.aspx?id=" +
                                                Eval("JobId")
                                            )
                                        %>'
                                           class="application-title">

                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("JobTitle")
                                                )
                                            ) %>

                                        </a>


                                        <span class="application-company">

                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("CompanyName")
                                                )
                                            ) %>

                                        </span>


                                        <div class="application-meta">

                                            <span>

                                                <i class="bi bi-geo-alt"></i>

                                                <%# Server.HtmlEncode(
                                                    GetLocation(
                                                        Eval("City"),
                                                        Eval("State")
                                                    )
                                                ) %>

                                            </span>


                                            <span>

                                                <i class="bi bi-clock"></i>

                                                Applied
                                                <%# GetTimeAgo(
                                                    Eval("AppliedAt")
                                                ) %>

                                            </span>

                                        </div>

                                    </div>


                                    <div class="application-status-wrapper">

                                        <span class='<%#
                                            "application-status " +
                                            GetStatusClass(
                                                Convert.ToString(
                                                    Eval("ApplicationStatus")
                                                )
                                            )
                                        %>'>

                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("ApplicationStatus")
                                                )
                                            ) %>

                                        </span>

                                    </div>

                                </div>

                            </ItemTemplate>

                        </asp:Repeater>



                        <!-- EMPTY -->

                        <asp:Panel
                            ID="pnlNoApplications"
                            runat="server"
                            CssClass="empty-state"
                            Visible="false">

                            <div class="empty-icon">

                                <i class="bi bi-send"></i>

                            </div>

                            <h3>
                                No applications yet
                            </h3>

                            <p>
                                Start applying to jobs and your
                                applications will appear here.
                            </p>

                            <a href="<%= ResolveUrl("~/Jobs.aspx") %>">

                                Browse Jobs

                            </a>

                        </asp:Panel>

                    </div>

                </div>

            </div>



            <!-- =====================================
                 UPCOMING INTERVIEW
            ====================================== -->

            <div class="col-xl-4">

                <div class="dashboard-card interview-card">

                    <div class="dashboard-card-header">

                        <div>

                            <h2>
                                Upcoming Interview
                            </h2>

                            <p>
                                Your next scheduled interview.
                            </p>

                        </div>

                    </div>


                    <asp:Panel
                        ID="pnlUpcomingInterview"
                        runat="server"
                        Visible="false">


                        <div class="interview-date-box">

                            <span>

                                <asp:Label
                                    ID="lblInterviewMonth"
                                    runat="server">
                                </asp:Label>

                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblInterviewDay"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                        <h3 class="interview-job-title">

                            <asp:Label
                                ID="lblInterviewJobTitle"
                                runat="server">
                            </asp:Label>

                        </h3>


                        <p class="interview-company">

                            <asp:Label
                                ID="lblInterviewCompany"
                                runat="server">
                            </asp:Label>

                        </p>


                        <div class="interview-details">

                            <div>

                                <i class="bi bi-calendar3"></i>

                                <span>

                                    <asp:Label
                                        ID="lblInterviewDate"
                                        runat="server">
                                    </asp:Label>

                                </span>

                            </div>


                            <div>

                                <i class="bi bi-clock"></i>

                                <span>

                                    <asp:Label
                                        ID="lblInterviewTime"
                                        runat="server">
                                    </asp:Label>

                                </span>

                            </div>


                            <div>

                                <i class="bi bi-camera-video"></i>

                                <span>

                                    <asp:Label
                                        ID="lblInterviewMode"
                                        runat="server">
                                    </asp:Label>

                                </span>

                            </div>

                        </div>


                        <a href="<%= ResolveUrl("~/JobSeeker/Interviews.aspx") %>"
                           class="view-interview-btn">

                            View Interview Details

                        </a>

                    </asp:Panel>



                    <!-- NO INTERVIEW -->

                    <asp:Panel
                        ID="pnlNoInterview"
                        runat="server"
                        CssClass="empty-state small-empty"
                        Visible="false">

                        <div class="empty-icon">

                            <i class="bi bi-calendar2-check"></i>

                        </div>

                        <h3>
                            No upcoming interviews
                        </h3>

                        <p>
                            Scheduled interviews will appear here.
                        </p>

                    </asp:Panel>

                </div>

            </div>

        </div>



        <!-- =========================================
             LATEST JOBS
        ========================================== -->

        <div class="dashboard-card latest-jobs-card">

            <div class="dashboard-card-header">

                <div>

                    <h2>
                        Latest Jobs
                    </h2>

                    <p>
                        Recently posted opportunities you may like.
                    </p>

                </div>


                <a href="<%= ResolveUrl("~/Jobs.aspx") %>">

                    Browse All

                    <i class="bi bi-arrow-right"></i>

                </a>

            </div>


            <div class="row g-3">


                <asp:Repeater
                    ID="rptLatestJobs"
                    runat="server">

                    <ItemTemplate>

                        <div class="col-xl-4 col-md-6">

                            <div class="latest-job-item">

                                <div class="latest-job-header">

                                    <div class="latest-company-logo">

                                        <%# GetCompanyInitial(
                                            Eval("CompanyName")
                                        ) %>

                                    </div>


                                    <span class="latest-job-time">

                                        <%# GetTimeAgo(
                                            Eval("CreatedAt")
                                        ) %>

                                    </span>

                                </div>


                                <a href='<%#
                                    ResolveUrl(
                                        "~/JobDetails.aspx?id=" +
                                        Eval("JobId")
                                    )
                                %>'
                                   class="latest-job-title">

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("JobTitle")
                                        )
                                    ) %>

                                </a>


                                <p>

                                    <%# Server.HtmlEncode(
                                        Convert.ToString(
                                            Eval("CompanyName")
                                        )
                                    ) %>

                                </p>


                                <div class="latest-job-meta">

                                    <span>

                                        <i class="bi bi-geo-alt"></i>

                                        <%# Server.HtmlEncode(
                                            GetLocation(
                                                Eval("City"),
                                                Eval("State")
                                            )
                                        ) %>

                                    </span>


                                    <span>

                                        <i class="bi bi-briefcase"></i>

                                        <%# GetExperienceText(
                                            Eval("MinExperienceMonths"),
                                            Eval("MaxExperienceMonths")
                                        ) %>

                                    </span>

                                </div>


                                <div class="latest-job-bottom">

                                    <span>

                                        <%# GetSalaryText(
                                            Eval("MinSalary"),
                                            Eval("MaxSalary"),
                                            Eval("SalaryVisible")
                                        ) %>

                                    </span>


                                    <a href='<%#
                                        ResolveUrl(
                                            "~/JobDetails.aspx?id=" +
                                            Eval("JobId")
                                        )
                                    %>'>

                                        View Job

                                        <i class="bi bi-arrow-right"></i>

                                    </a>

                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>


            <asp:Panel
                ID="pnlNoJobs"
                runat="server"
                CssClass="empty-state"
                Visible="false">

                <div class="empty-icon">

                    <i class="bi bi-briefcase"></i>

                </div>

                <h3>
                    No jobs available
                </h3>

                <p>
                    New opportunities will appear here.
                </p>

            </asp:Panel>

        </div>


    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
