<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
        <style>

        .dashboard-page {
            padding: 28px;
        }


        /* =========================================
           WELCOME
        ========================================== */

        .welcome-card {
            background: #111827;

            border-radius: 14px;

            padding: 25px 28px;

            color: #fff;

            margin-bottom: 24px;

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 20px;
        }


        .welcome-title {
            margin: 0 0 6px;

            font-size: 23px;

            font-weight: 700;
        }


        .welcome-text {
            margin: 0;

            color: #d1d5db;

            font-size: 13px;
        }


        .welcome-action {
            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding: 11px 16px;

            border-radius: 8px;

            background: #fff;

            color: #111827;

            text-decoration: none;

            font-size: 13px;

            font-weight: 700;

            white-space: nowrap;
        }


        .welcome-action:hover {
            color: #111827;

            background: #f3f4f6;
        }


        /* =========================================
           STAT CARDS
        ========================================== */

        .stats-grid {
            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 18px;

            margin-bottom: 24px;
        }


        .stat-card {
            background: #fff;

            border: 1px solid #e5e7eb;

            border-radius: 12px;

            padding: 20px;

            display: flex;

            align-items: center;

            gap: 14px;
        }


        .stat-icon {
            width: 45px;

            height: 45px;

            min-width: 45px;

            border-radius: 10px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #f3f4f6;

            color: #374151;

            font-size: 19px;
        }


        .stat-label {
            display: block;

            color: #6b7280;

            font-size: 12px;

            margin-bottom: 4px;
        }


        .stat-value {
            display: block;

            color: #111827;

            font-size: 23px;

            font-weight: 700;
        }


        /* =========================================
           CONTENT GRID
        ========================================== */

        .dashboard-grid {
            display: grid;

            grid-template-columns:
                minmax(0, 2fr)
                minmax(280px, 1fr);

            gap: 20px;
        }


        .dashboard-card {
            background: #fff;

            border: 1px solid #e5e7eb;

            border-radius: 12px;

            overflow: hidden;
        }


        .dashboard-card-header {
            padding: 18px 20px;

            border-bottom:
                1px solid #e5e7eb;

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 10px;
        }


        .dashboard-card-title {
            margin: 0;

            font-size: 15px;

            font-weight: 700;

            color: #111827;
        }


        .view-all {
            font-size: 12px;

            color: #374151;

            font-weight: 600;

            text-decoration: none;
        }


        .view-all:hover {
            text-decoration: underline;
        }


        /* =========================================
           JOB TABLE
        ========================================== */

        .job-table-wrapper {
            overflow-x: auto;
        }


        .job-table {
            width: 100%;

            border-collapse: collapse;
        }


        .job-table th {
            padding: 12px 20px;

            text-align: left;

            font-size: 11px;

            color: #6b7280;

            font-weight: 600;

            background: #f9fafb;

            white-space: nowrap;
        }


        .job-table td {
            padding: 14px 20px;

            border-top:
                1px solid #f0f1f3;

            font-size: 13px;

            color: #374151;

            vertical-align: middle;
        }


        .job-title {
            display: block;

            color: #111827;

            font-weight: 600;

            margin-bottom: 3px;
        }


        .job-company {
            display: block;

            color: #9ca3af;

            font-size: 11px;
        }


        .status {
            display: inline-block;

            padding: 5px 9px;

            border-radius: 20px;

            font-size: 10px;

            font-weight: 700;
        }


        .status-active {
            background: #ecfdf5;

            color: #047857;
        }


        .status-closed {
            background: #fef2f2;

            color: #b91c1c;
        }


        .status-draft {
            background: #f3f4f6;

            color: #4b5563;
        }


        .empty-state {
            padding: 45px 20px;

            text-align: center;

            color: #9ca3af;
        }


        .empty-state i {
            display: block;

            font-size: 35px;

            margin-bottom: 10px;
        }


        .empty-state p {
            margin: 0 0 15px;

            font-size: 13px;
        }


        .empty-btn {
            display: inline-flex;

            align-items: center;

            gap: 7px;

            padding: 9px 13px;

            border-radius: 7px;

            background: #111827;

            color: #fff;

            text-decoration: none;

            font-size: 12px;

            font-weight: 600;
        }

        .status-viewed {
    display: inline-block;
    padding: 5px 9px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 700;
    background: #e0f2fe;
    color: #0369a1;
}

.status-shortlisted {
    display: inline-block;
    padding: 5px 9px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 700;
    background: #fef3c7;
    color: #92400e;
}

.status-interview {
    display: inline-block;
    padding: 5px 9px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 700;
    background: #ede9fe;
    color: #6d28d9;
}

.status-selected {
    display: inline-block;
    padding: 5px 9px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 700;
    background: #dcfce7;
    color: #166534;
}

.status-hired {
    display: inline-block;
    padding: 5px 9px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 700;
    background: #d1fae5;
    color: #065f46;
}

.status-rejected {
    display: inline-block;
    padding: 5px 9px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 700;
    background: #fee2e2;
    color: #991b1b;
}

.status-pending {
    display: inline-block;
    padding: 5px 9px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 700;
    background: #f3f4f6;
    color: #4b5563;
}

        /* =========================================
           QUICK ACTIONS
        ========================================== */

        .quick-actions {
            padding: 18px;
        }


        .quick-action {
            display: flex;

            align-items: center;

            gap: 12px;

            padding: 13px;

            margin-bottom: 9px;

            border: 1px solid #e5e7eb;

            border-radius: 9px;

            color: #374151;

            text-decoration: none;
        }


        .quick-action:last-child {
            margin-bottom: 0;
        }


        .quick-action:hover {
            background: #f9fafb;

            color: #111827;
        }


        .quick-action-icon {
            width: 34px;

            height: 34px;

            border-radius: 8px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #f3f4f6;

            color: #374151;
        }


        .quick-action-content {
            flex: 1;
        }


        .quick-action-title {
            display: block;

            font-size: 13px;

            font-weight: 600;

            color: #111827;
        }


        .quick-action-text {
            display: block;

            font-size: 10px;

            color: #9ca3af;

            margin-top: 2px;
        }


        /* =========================================
           PROFILE
        ========================================== */

        .profile-card {
            padding: 20px;
        }


        .profile-header {
            display: flex;

            align-items: center;

            gap: 12px;

            margin-bottom: 18px;
        }


        .profile-avatar {
            width: 48px;

            height: 48px;

            border-radius: 50%;

            background: #f3f4f6;

            color: #374151;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 18px;

            font-weight: 700;
        }


        .profile-name {
            display: block;

            font-size: 14px;

            font-weight: 700;

            color: #111827;
        }


        .profile-designation {
            display: block;

            font-size: 11px;

            color: #9ca3af;

            margin-top: 3px;
        }


        .profile-detail {
            padding: 10px 0;

            border-top:
                1px solid #f0f1f3;

            display: flex;

            justify-content: space-between;

            gap: 15px;
        }


        .profile-detail-label {
            font-size: 11px;

            color: #9ca3af;
        }


        .profile-detail-value {
            font-size: 11px;

            color: #374151;

            font-weight: 600;

            text-align: right;
        }


        /* =========================================
           RESPONSIVE
        ========================================== */

        @media(max-width:1100px) {

            .stats-grid {
                grid-template-columns:
                    repeat(2, 1fr);
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }

        }


        @media(max-width:700px) {

            .dashboard-page {
                padding: 18px;
            }


            .welcome-card {
                flex-direction: column;

                align-items: flex-start;
            }


            .stats-grid {
                grid-template-columns: 1fr;
            }

        }


        @media(max-width:500px) {

            .dashboard-page {
                padding: 14px;
            }

            .welcome-title {
                font-size: 19px;
            }

            .stat-value {
                font-size: 20px;
            }

        }

    </style>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
     Recruiter Dashboard
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
     <div class="dashboard-page">


        <!-- =====================================
             WELCOME
        ====================================== -->

        <div class="welcome-card">

            <div>

                <h1 class="welcome-title">

                    Welcome,
                    <asp:Label
                        ID="lblWelcomeName"
                        runat="server"
                        Text="Recruiter">
                    </asp:Label>

                    👋

                </h1>

                <p class="welcome-text">

                    Manage your jobs, candidates
                    and recruitment activities
                    from one place.

                </p>

            </div>


            <a
                href="JobPost.aspx"
                class="welcome-action">

                <i class="bi bi-plus-lg"></i>

                Post a New Job

            </a>

        </div>


        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="stats-grid">


            <!-- TOTAL JOBS -->

            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-briefcase"></i>

                </div>

                <div>

                    <span class="stat-label">
                        Total Jobs
                    </span>

                    <asp:Label
                        ID="lblTotalJobs"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


            <!-- ACTIVE JOBS -->

            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-check-circle"></i>

                </div>

                <div>

                    <span class="stat-label">
                        Active Jobs
                    </span>

                    <asp:Label
                        ID="lblActiveJobs"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


            <!-- APPLICATIONS -->

            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-people"></i>

                </div>

                <div>

                    <span class="stat-label">
                        Applications
                    </span>

                    <asp:Label
                        ID="lblApplications"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


            <!-- FEATURED -->

            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-star"></i>

                </div>

                <div>

                    <span class="stat-label">
                        Featured Jobs
                    </span>

                    <asp:Label
                        ID="lblFeaturedJobs"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


        </div>


        <!-- =====================================
             MAIN CONTENT
        ====================================== -->

        <div class="dashboard-grid">


            <!-- =================================
                 RECENT JOBS
            ================================== -->

            <div class="dashboard-card">


                <div class="dashboard-card-header">

                    <h2 class="dashboard-card-title">

                        Recent Jobs

                    </h2>


                    <a
                        href="Jobs.aspx"
                        class="view-all">

                        View All

                    </a>

                </div>


                <div class="job-table-wrapper">


                    <asp:GridView
                        ID="gvRecentJobs"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="job-table"
                        GridLines="None"
                        ShowHeader="true"
                        EmptyDataText="">

                        <Columns>


                            <asp:TemplateField
                                HeaderText="Job">

                                <ItemTemplate>

                                    <span class="job-title">

                                        <%# Eval("JobTitle") %>

                                    </span>

                                    <span class="job-company">

                                        <%# Eval("CompanyName") %>

                                    </span>

                                </ItemTemplate>

                            </asp:TemplateField>


                            <asp:BoundField
                                DataField="EmploymentType"
                                HeaderText="Type" />


                            <asp:BoundField
                                DataField="City"
                                HeaderText="Location" />


                            <asp:TemplateField
                                HeaderText="Status">

                                <ItemTemplate>

                                    <span
                                        class='<%# GetStatusClass(Eval("JobStatus")) %>'>

                                        <%# Eval("JobStatus") %>

                                    </span>

                                </ItemTemplate>

                            </asp:TemplateField>


                            <asp:TemplateField
                                HeaderText="Posted">

                                <ItemTemplate>

                                    <%#
                                        Eval(
                                            "CreatedAt",
                                            "{0:dd MMM yyyy}"
                                        )
                                    %>

                                </ItemTemplate>

                            </asp:TemplateField>


                        </Columns>


                        <EmptyDataTemplate>

                            <div class="empty-state">

                                <i class="bi bi-briefcase"></i>

                                <p>
                                    You haven't posted any jobs yet.
                                </p>

                                <a
                                    href="JobPost.aspx"
                                    class="empty-btn">

                                    <i class="bi bi-plus-lg"></i>

                                    Post Your First Job

                                </a>

                            </div>

                        </EmptyDataTemplate>


                    </asp:GridView>


                </div>

            </div>

            <!-- =================================
     RECENT APPLICATIONS
================================== -->

<div class="dashboard-card" style="margin-top:20px;">

    <div class="dashboard-card-header">

        <h2 class="dashboard-card-title">
            Recent Applications
        </h2>

        <a href="Applications.aspx"
           class="view-all">
            View All
        </a>

    </div>

    <div class="job-table-wrapper">

        <asp:GridView
            ID="gvRecentApplications"
            runat="server"
            AutoGenerateColumns="False"
            CssClass="job-table"
            GridLines="None"
            ShowHeader="true"
            EmptyDataText="">

            <Columns>

<%--Candidate --%>
                <asp:TemplateField HeaderText="Candidate">

                    <ItemTemplate>

                        <span class="job-title">
                            <%# Eval("FullName") %>
                        </span>

                        <span class="job-company">
                            <%# Eval("Email") %>
                        </span>

                    </ItemTemplate>

                </asp:TemplateField>


               <%--  Job --%>
                <asp:BoundField
                    DataField="JobTitle"
                    HeaderText="Job" />


                <%-- Applied --%>
                <asp:TemplateField HeaderText="Applied">

                    <ItemTemplate>

                        <%#
                            Eval(
                                "AppliedAt",
                                "{0:dd MMM yyyy}"
                            )
                        %>

                    </ItemTemplate>

                </asp:TemplateField>


                <%-- Status --%>
                <asp:TemplateField HeaderText="Status">

                    <ItemTemplate>

                        <span class='<%# GetApplicationStatusClass(Eval("ApplicationStatus")) %>'>
                            <%# Eval("ApplicationStatus") %>
                        </span>

                    </ItemTemplate>

                </asp:TemplateField>


               <%--  Action --%>
                <asp:TemplateField HeaderText="Action">

                    <ItemTemplate>

                        <a
                            href='<%# "ApplicantDetails.aspx?ApplicationId=" + Eval("ApplicationId") %>'
                            class="view-all">

                            View

                        </a>

                    </ItemTemplate>

                </asp:TemplateField>

            </Columns>


            <EmptyDataTemplate>

                <div class="empty-state">

                    <i class="bi bi-people"></i>

                    <p>
                        No applications received yet.
                    </p>

                    <a
                        href="Jobs.aspx"
                        class="empty-btn">

                        <i class="bi bi-briefcase"></i>

                        View My Jobs

                    </a>

                </div>

            </EmptyDataTemplate>

        </asp:GridView>

    </div>

</div>


            <!-- =================================
                 RIGHT SIDE
            ================================== -->

            <div>


                <!-- QUICK ACTIONS -->

                <div
                    class="dashboard-card"
                    style="margin-bottom:20px;">


                    <div class="dashboard-card-header">

                        <h2 class="dashboard-card-title">

                            Quick Actions

                        </h2>

                    </div>


                    <div class="quick-actions">


                        <a
                            href="JobPost.aspx"
                            class="quick-action">

                            <div class="quick-action-icon">

                                <i class="bi bi-plus-lg"></i>

                            </div>

                            <div class="quick-action-content">

                                <span class="quick-action-title">
                                    Post a Job
                                </span>

                                <span class="quick-action-text">
                                    Create a new job opening
                                </span>

                            </div>

                            <i class="bi bi-chevron-right"></i>

                        </a>


                        <a
                            href="Jobs.aspx"
                            class="quick-action">

                            <div class="quick-action-icon">

                                <i class="bi bi-briefcase"></i>

                            </div>

                            <div class="quick-action-content">

                                <span class="quick-action-title">
                                    Manage Jobs
                                </span>

                                <span class="quick-action-text">
                                    View and manage your jobs
                                </span>

                            </div>

                            <i class="bi bi-chevron-right"></i>

                        </a>


                        <a
                            href="Applications.aspx"
                            class="quick-action">

                            <div class="quick-action-icon">

                                <i class="bi bi-people"></i>

                            </div>

                            <div class="quick-action-content">

                                <span class="quick-action-title">
                                    Applications
                                </span>

                                <span class="quick-action-text">
                                    Review candidate applications
                                </span>

                            </div>

                            <i class="bi bi-chevron-right"></i>

                        </a>

                      <a href='<%= ResolveUrl("~/Recruiter/SearchCandidates.aspx") %>'
                           class="quick-action">

                            <div class="quick-action-icon">

                                <i class="bi bi-search"></i>

                            </div>

                            <div class="quick-action-content">

                                <span class="quick-action-title">
                                    Search Candidates
                                </span>

                                <span class="quick-action-text">
                                    Find candidates by skills, experience and location
                                </span>

                            </div>

                            <i class="bi bi-chevron-right"></i>

                        </a>


                        <a
                            href="RecruiterProfile.aspx"
                            class="quick-action">

                            <div class="quick-action-icon">

                                <i class="bi bi-person"></i>

                            </div>

                            <div class="quick-action-content">

                                <span class="quick-action-title">
                                    My Profile
                                </span>

                                <span class="quick-action-text">
                                    Update recruiter information
                                </span>

                            </div>

                            <i class="bi bi-chevron-right"></i>

                        </a>


                    </div>

                </div>


                <!-- PROFILE -->

                <div class="dashboard-card">


                    <div class="dashboard-card-header">

                        <h2 class="dashboard-card-title">

                            Recruiter Profile

                        </h2>

                    </div>


                    <div class="profile-card">


                        <div class="profile-header">


                            <div class="profile-avatar">

                                <asp:Label
                                    ID="lblProfileInitial"
                                    runat="server"
                                    Text="R">
                                </asp:Label>

                            </div>


                            <div>

                                <span
                                    class="profile-name">

                                    <asp:Label
                                        ID="lblProfileName"
                                        runat="server"
                                        Text="Recruiter">
                                    </asp:Label>

                                </span>


                                <span
                                    class="profile-designation">

                                    <asp:Label
                                        ID="lblDesignation"
                                        runat="server"
                                        Text="Recruiter">
                                    </asp:Label>

                                </span>

                            </div>

                        </div>


                        <div class="profile-detail">

                            <span
                                class="profile-detail-label">

                                Email

                            </span>

                            <asp:Label
                                ID="lblEmail"
                                runat="server"
                                CssClass="profile-detail-value">
                            </asp:Label>

                        </div>


                        <div class="profile-detail">

                            <span
                                class="profile-detail-label">

                                Mobile

                            </span>

                            <asp:Label
                                ID="lblMobile"
                                runat="server"
                                CssClass="profile-detail-value">
                            </asp:Label>

                        </div>


                        <div class="profile-detail">

                            <span
                                class="profile-detail-label">

                                Status

                            </span>

                            <asp:Label
                                ID="lblVerification"
                                runat="server"
                                CssClass="profile-detail-value"
                                Text="Verified">
                            </asp:Label>

                        </div>


                    </div>

                </div>


            </div>


        </div>


    </div>


</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
