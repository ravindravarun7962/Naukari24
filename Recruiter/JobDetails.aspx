<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="JobDetails.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.JobDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
      Job Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>

    .job-details-page {
        max-width: 1200px;
        margin: 0 auto;
        padding: 32px;
    }

    /* ==============================
       TOP ACTION
    ============================== */

    .job-top-action {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 18px;
    }

    .back-link {
        display: inline-flex;
        align-items: center;
        gap: 7px;
        color: #6b7280;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
    }

    .back-link:hover {
        color: #111827;
    }

    /* ==============================
       HERO
    ============================== */

    .job-hero {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 18px;
        overflow: hidden;
        margin-bottom: 22px;
    }

    .job-hero-cover {
        height: 125px;
        background:
            linear-gradient(
                135deg,
                #111827,
                #374151
            );
        position: relative;
    }

    .job-hero-cover::after {
        content: "";
        position: absolute;
        inset: 0;
        opacity: .10;

        background-image:
            radial-gradient(
                circle at 20% 30%,
                #fff 1px,
                transparent 1px
            );

        background-size: 22px 22px;
    }

    .job-hero-content {
        padding: 0 30px 28px;
    }

    .company-logo {
        width: 82px;
        height: 82px;

        margin-top: -42px;

        border-radius: 14px;

        background: #fff;

        border: 1px solid #e5e7eb;

        display: flex;
        align-items: center;
        justify-content: center;

        font-size: 30px;
        font-weight: 750;

        color: #111827;

        position: relative;
        z-index: 2;

        box-shadow:
            0 8px 25px
            rgba(0,0,0,.08);
    }

    .job-hero-main {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;

        gap: 25px;

        margin-top: 18px;
    }

    .job-title {
        margin: 0;

        font-size: 29px;
        line-height: 1.25;

        color: #111827;

        font-weight: 750;
    }

    .company-name {
        margin-top: 8px;

        font-size: 15px;

        color: #4b5563;

        font-weight: 600;
    }

    .job-category {
        display: inline-flex;

        margin-top: 10px;

        padding: 5px 10px;

        border-radius: 20px;

        background: #f3f4f6;

        color: #374151;

        font-size: 11px;

        font-weight: 600;
    }

    .featured-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;

        padding: 7px 11px;

        background: #f3f4f6;

        color: #111827;

        border-radius: 20px;

        font-size: 11px;

        font-weight: 700;

        white-space: nowrap;
    }

    /* ==============================
       META
    ============================== */

    .job-meta {
        display: flex;
        flex-wrap: wrap;

        gap: 10px;

        margin-top: 20px;
    }

    .meta-item {
        display: inline-flex;
        align-items: center;

        gap: 7px;

        padding: 9px 12px;

        background: #f9fafb;

        border: 1px solid #eef0f3;

        border-radius: 9px;

        color: #4b5563;

        font-size: 12px;
    }

    .meta-item i {
        color: #374151;
        font-size: 14px;
    }

    /* ==============================
       GRID
    ============================== */

    .job-content-grid {
        display: grid;

        grid-template-columns:
            minmax(0, 2fr)
            minmax(300px, 1fr);

        gap: 22px;

        align-items: start;
    }

    /* ==============================
       CARD
    ============================== */

    .job-card {
        background: #fff;

        border: 1px solid #e5e7eb;

        border-radius: 14px;

        overflow: hidden;

        margin-bottom: 20px;
    }

    .job-card-header {
        padding: 20px 22px 16px;

        border-bottom:
            1px solid #f0f1f3;
    }

    .job-card-header h2 {
        margin: 0;

        font-size: 18px;

        color: #111827;
    }

    .job-card-header p {
        margin: 5px 0 0;

        color: #9ca3af;

        font-size: 12px;
    }

    .job-card-body {
        padding: 22px;
    }

    /* ==============================
       DESCRIPTION
    ============================== */

    .job-description {
        color: #4b5563;

        font-size: 14px;

        line-height: 1.85;

        white-space: pre-line;
    }

    /* ==============================
       RESPONSIBILITIES
    ============================== */

    .job-text-content {
        color: #4b5563;

        font-size: 14px;

        line-height: 1.85;

        white-space: pre-line;
    }

    /* ==============================
       REQUIREMENTS
    ============================== */

    .requirements-box {
        color: #4b5563;

        font-size: 14px;

        line-height: 1.85;

        white-space: pre-line;
    }

    /* ==============================
       DETAILS
    ============================== */

    .details-list {
        display: grid;

        grid-template-columns:
            repeat(2, 1fr);

        gap: 12px;
    }

    .detail-item {
        padding: 14px;

        background: #fafafa;

        border: 1px solid #eef0f3;

        border-radius: 10px;
    }

    .detail-item span {
        display: block;

        font-size: 11px;

        color: #9ca3af;

        margin-bottom: 5px;
    }

    .detail-item strong {
        display: block;

        color: #111827;

        font-size: 13px;

        font-weight: 600;
    }

    /* ==============================
       APPLY CARD
    ============================== */

    .apply-card {
        position: sticky;

        top: 95px;
    }

    .apply-box {
        padding: 22px;
    }

    .apply-button {
        width: 100%;

        display: flex;

        align-items: center;

        justify-content: center;

        gap: 8px;

        padding: 13px;

        border: 0;

        border-radius: 9px;

        background: #111827;

        color: #fff;

        text-decoration: none;

        font-size: 14px;

        font-weight: 700;

        cursor: pointer;

        transition: .2s;
    }

    .apply-button:hover {
        background: #1f2937;

        color: #fff;
    }

    .edit-job-button {
        width: 100%;

        display: flex;

        align-items: center;

        justify-content: center;

        gap: 8px;

        margin-top: 10px;

        padding: 11px;

        border: 1px solid #e5e7eb;

        border-radius: 9px;

        background: #fff;

        color: #374151;

        text-decoration: none;

        font-size: 13px;

        font-weight: 600;
    }

    .edit-job-button:hover {
        background: #f9fafb;

        color: #111827;
    }

    /* ==============================
       DEADLINE
    ============================== */

    .deadline-box {
        display: flex;

        align-items: center;

        gap: 12px;

        margin-top: 18px;

        padding: 14px;

        border-radius: 10px;

        background: #f9fafb;

        border: 1px solid #eef0f3;
    }

    .deadline-icon {
        width: 38px;
        height: 38px;

        border-radius: 9px;

        background: #fff;

        border: 1px solid #e5e7eb;

        display: flex;

        align-items: center;

        justify-content: center;

        color: #374151;
    }

    .deadline-text span {
        display: block;

        font-size: 10px;

        color: #9ca3af;
    }

    .deadline-text strong {
        display: block;

        margin-top: 3px;

        color: #111827;

        font-size: 13px;
    }

    /* ==============================
       MESSAGE
    ============================== */

    .message {
        display: block;

        padding: 13px 15px;

        margin-bottom: 18px;

        border-radius: 9px;

        font-size: 13px;
    }

    .error {
        background: #fef2f2;

        color: #b91c1c;
    }

    /* ==============================
       RESPONSIVE
    ============================== */

    @media (max-width: 900px) {

        .job-content-grid {
            grid-template-columns: 1fr;
        }

        .apply-card {
            position: static;
        }

    }

    @media (max-width: 650px) {

        .job-details-page {
            padding: 20px 14px;
        }

        .job-hero-content {
            padding: 0 20px 22px;
        }

        .job-hero-main {
            flex-direction: column;
        }

        .job-title {
            font-size: 23px;
        }

        .details-list {
            grid-template-columns: 1fr;
        }

        .job-meta {
            flex-direction: column;
        }

        .meta-item {
            width: 100%;
        }

    }

</style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
      Job Details
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="job-details-page">


    <!-- TOP ACTION -->

    <div class="job-top-action">

        <a
            href="Jobs.aspx"
            class="back-link">

            <i class="bi bi-arrow-left"></i>

            Back to Jobs

        </a>

    </div>


    <asp:Label
        ID="lblMessage"
        runat="server"
        Visible="false"
        CssClass="message error">
    </asp:Label>


    <!-- =========================================
         JOB HERO
    ========================================== -->

    <div class="job-hero">

        <div class="job-hero-cover"></div>

        <div class="job-hero-content">


            <div class="company-logo">

                <asp:Label
                    ID="lblCompanyInitial"
                    runat="server">
                </asp:Label>

            </div>


            <div class="job-hero-main">


                <div>

                    <h1 class="job-title">

                        <asp:Label
                            ID="lblJobTitle"
                            runat="server">
                        </asp:Label>

                    </h1>


                    <div class="company-name">

                        <i class="bi bi-building"></i>

                        <asp:Label
                            ID="lblCompanyName"
                            runat="server">
                        </asp:Label>

                    </div>


                    <asp:Label
                        ID="lblCategory"
                        runat="server"
                        CssClass="job-category">
                    </asp:Label>


                </div>


                <asp:Panel
                    ID="pnlFeatured"
                    runat="server"
                    Visible="false"
                    CssClass="featured-badge">

                    <i class="bi bi-star-fill"></i>

                    Featured Job

                </asp:Panel>


            </div>


            <!-- JOB META -->

            <div class="job-meta">


                <div class="meta-item">

                    <i class="bi bi-geo-alt"></i>

                    <asp:Label
                        ID="lblLocation"
                        runat="server">
                    </asp:Label>

                </div>


                <div class="meta-item">

                    <i class="bi bi-briefcase"></i>

                    <asp:Label
                        ID="lblEmploymentType"
                        runat="server">
                    </asp:Label>

                </div>


                <div class="meta-item">

                    <i class="bi bi-laptop"></i>

                    <asp:Label
                        ID="lblWorkMode"
                        runat="server">
                    </asp:Label>

                </div>


                <div class="meta-item">

                    <i class="bi bi-clock"></i>

                    <asp:Label
                        ID="lblExperience"
                        runat="server">
                    </asp:Label>

                </div>


                <div class="meta-item">

                    <i class="bi bi-cash-stack"></i>

                    <asp:Label
                        ID="lblSalary"
                        runat="server">
                    </asp:Label>

                </div>


            </div>

        </div>

    </div>


    <!-- =========================================
         CONTENT GRID
    ========================================== -->

    <div class="job-content-grid">


        <!-- =====================================
             LEFT
        ====================================== -->

        <div>


            <!-- DESCRIPTION -->

            <div class="job-card">

                <div class="job-card-header">

                    <h2>
                        Job Description
                    </h2>

                    <p>
                        About this opportunity
                    </p>

                </div>

                <div class="job-card-body">

                    <div class="job-description">

                        <asp:Label
                            ID="lblJobDescription"
                            runat="server">
                        </asp:Label>

                    </div>

                </div>

            </div>


            <!-- RESPONSIBILITIES -->

            <div class="job-card">

                <div class="job-card-header">

                    <h2>
                        Responsibilities
                    </h2>

                    <p>
                        What you'll be doing
                    </p>

                </div>

                <div class="job-card-body">

                    <div class="job-text-content">

                        <asp:Label
                            ID="lblResponsibilities"
                            runat="server">
                        </asp:Label>

                    </div>

                </div>

            </div>


            <!-- REQUIREMENTS -->

            <div class="job-card">

                <div class="job-card-header">

                    <h2>
                        Requirements
                    </h2>

                    <p>
                        Skills and qualifications
                    </p>

                </div>

                <div class="job-card-body">

                    <div class="requirements-box">

                        <asp:Label
                            ID="lblRequirements"
                            runat="server">
                        </asp:Label>

                    </div>

                </div>

            </div>


            <!-- JOB DETAILS -->

            <div class="job-card">

                <div class="job-card-header">

                    <h2>
                        Job Details
                    </h2>

                    <p>
                        Additional information
                    </p>

                </div>

                <div class="job-card-body">

                    <div class="details-list">


                        <div class="detail-item">

                            <span>
                                Education
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblEducation"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                        <div class="detail-item">

                            <span>
                                Number of Openings
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblOpenings"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                        <div class="detail-item">

                            <span>
                                Minimum Experience
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblMinExperience"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                        <div class="detail-item">

                            <span>
                                Maximum Experience
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblMaxExperience"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                        <div class="detail-item">

                            <span>
                                City
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblCity"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                        <div class="detail-item">

                            <span>
                                State
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblState"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                    </div>

                </div>

            </div>


        </div>


        <!-- =====================================
             RIGHT
        ====================================== -->

        <div>


            <div class="job-card apply-card">

                <div class="job-card-header">

                    <h2>
                        Application
                    </h2>

                    <p>
                        Manage this job posting
                    </p>

                </div>


                <div class="apply-box">


                    <asp:HyperLink
                        ID="lnkApply"
                        runat="server"
                        CssClass="apply-button">

                        <i class="bi bi-pencil-square"></i>

                        Edit Job

                    </asp:HyperLink>


                    <a
                        href="Jobs.aspx"
                        class="edit-job-button">

                        <i class="bi bi-briefcase"></i>

                        View My Jobs

                    </a>


                    <!-- DEADLINE -->

                    <div class="deadline-box">

                        <div class="deadline-icon">

                            <i class="bi bi-calendar-event"></i>

                        </div>


                        <div class="deadline-text">

                            <span>
                                Application Deadline
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblDeadline"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>

                    </div>


                </div>

            </div>


            <!-- STATUS -->

            <div class="job-card">

                <div class="job-card-header">

                    <h2>
                        Job Status
                    </h2>

                    <p>
                        Current posting status
                    </p>

                </div>

                <div class="job-card-body">

                    <div class="detail-item">

                        <span>
                            Status
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblJobStatus"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>

                </div>

            </div>


        </div>

    </div>

</div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
