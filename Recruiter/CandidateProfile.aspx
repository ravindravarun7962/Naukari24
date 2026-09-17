<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="CandidateProfile.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.CandidateProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Candidate Profile
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
        <style>

        /* =========================================
           CANDIDATE PROFILE
        ========================================== */

        .candidate-profile-page {
            padding: 28px;
            background: #f8fafc;
            min-height: 100vh;
        }

        .candidate-container {
            max-width: 1100px;
            margin: 0 auto;
        }


        /* =========================================
           BACK LINK
        ========================================== */

        .candidate-back {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            margin-bottom: 18px;
            color: #6b7280;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
        }

        .candidate-back:hover {
            color: #111827;
            text-decoration: none;
        }


        /* =========================================
           PROFILE HEADER
        ========================================== */

        .candidate-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 25px;
            padding: 28px;
            background: #111827;
            border-radius: 14px;
            color: #ffffff;
            margin-bottom: 20px;
        }

        .candidate-header-left {
            display: flex;
            align-items: center;
            gap: 18px;
            min-width: 0;
        }

        .candidate-avatar {
            width: 72px;
            height: 72px;
            min-width: 72px;
            border-radius: 50%;
            background: #374151;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 25px;
            font-weight: 700;
        }

        .candidate-header-info {
            min-width: 0;
        }

        .candidate-name {
            margin: 0 0 5px;
            font-size: 24px;
            font-weight: 700;
            color: #ffffff;
        }

        .candidate-headline {
            margin: 0 0 7px;
            color: #d1d5db;
            font-size: 13px;
        }

        .candidate-location {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #9ca3af;
            font-size: 12px;
        }


        /* =========================================
           RESUME BUTTON
        ========================================== */

        .resume-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 15px;
            background: #ffffff;
            color: #111827;
            border-radius: 8px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
        }

        .resume-btn:hover {
            background: #f3f4f6;
            color: #111827;
            text-decoration: none;
        }


        /* =========================================
           CONTENT GRID
        ========================================== */

        .candidate-grid {
            display: grid;
            grid-template-columns: minmax(0, 2fr) minmax(280px, 1fr);
            gap: 20px;
            align-items: start;
        }


        /* =========================================
           CARD
        ========================================== */

        .candidate-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .candidate-card:last-child {
            margin-bottom: 0;
        }

        .candidate-card-header {
            padding: 17px 20px;
            border-bottom: 1px solid #e5e7eb;
        }

        .candidate-card-title {
            margin: 0;
            color: #111827;
            font-size: 15px;
            font-weight: 700;
        }

        .candidate-card-body {
            padding: 20px;
        }


        /* =========================================
           SUMMARY
        ========================================== */

        .candidate-summary {
            margin: 0;
            color: #4b5563;
            font-size: 13px;
            line-height: 1.8;
        }


        /* =========================================
           SKILLS
        ========================================== */

        .skills-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .skill-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 10px;
            border-radius: 20px;
            background: #f3f4f6;
            color: #374151;
            font-size: 11px;
            font-weight: 600;
        }


        /* =========================================
           DETAILS
        ========================================== */

        .detail-row {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            padding: 11px 0;
            border-top: 1px solid #f0f1f3;
        }

        .detail-row:first-child {
            border-top: 0;
            padding-top: 0;
        }

        .detail-label {
            color: #9ca3af;
            font-size: 11px;
        }

        .detail-value {
            color: #374151;
            font-size: 12px;
            font-weight: 600;
            text-align: right;
        }


        /* =========================================
           CONTACT
        ========================================== */

        .contact-item {
            display: flex;
            align-items: flex-start;
            gap: 11px;
            padding: 12px 0;
            border-top: 1px solid #f0f1f3;
        }

        .contact-item:first-child {
            border-top: 0;
            padding-top: 0;
        }

        .contact-icon {
            width: 34px;
            height: 34px;
            min-width: 34px;
            border-radius: 8px;
            background: #f3f4f6;
            color: #374151;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .contact-icon i {
            font-size: 14px;
        }

        .contact-label {
            display: block;
            margin-bottom: 2px;
            color: #9ca3af;
            font-size: 10px;
        }

        .contact-value {
            display: block;
            color: #374151;
            font-size: 12px;
            font-weight: 600;
            word-break: break-word;
        }


        /* =========================================
           PREFERENCES
        ========================================== */

        .preference-item {
            padding: 12px 0;
            border-top: 1px solid #f0f1f3;
        }

        .preference-item:first-child {
            border-top: 0;
            padding-top: 0;
        }

        .preference-label {
            display: block;
            margin-bottom: 4px;
            color: #9ca3af;
            font-size: 10px;
        }

        .preference-value {
            color: #374151;
            font-size: 12px;
            font-weight: 600;
        }


        /* =========================================
           RESUME CARD
        ========================================== */

        .resume-box {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px;
            border: 1px solid #e5e7eb;
            border-radius: 9px;
        }

        .resume-icon {
            width: 40px;
            height: 40px;
            min-width: 40px;
            border-radius: 8px;
            background: #f3f4f6;
            color: #374151;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .resume-icon i {
            font-size: 18px;
        }

        .resume-info {
            flex: 1;
            min-width: 0;
        }

        .resume-name {
            display: block;
            color: #111827;
            font-size: 12px;
            font-weight: 600;
            word-break: break-word;
        }

        .resume-date {
            display: block;
            margin-top: 3px;
            color: #9ca3af;
            font-size: 10px;
        }

        .resume-download {
            color: #374151;
            font-size: 16px;
        }

        .resume-download:hover {
            color: #111827;
        }


        /* =========================================
           EMPTY
        ========================================== */

        .profile-empty {
            padding: 20px;
            text-align: center;
            color: #9ca3af;
            font-size: 12px;
        }


        /* =========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 900px) {

            .candidate-grid {
                grid-template-columns: 1fr;
            }

        }


        @media (max-width: 650px) {

            .candidate-profile-page {
                padding: 18px;
            }

            .candidate-header {
                flex-direction: column;
                align-items: flex-start;
                padding: 22px;
            }

            .candidate-header-left {
                align-items: flex-start;
            }

            .candidate-name {
                font-size: 20px;
            }

            .candidate-avatar {
                width: 58px;
                height: 58px;
                min-width: 58px;
                font-size: 21px;
            }

            .candidate-card-body {
                padding: 17px;
            }

        }

    </style>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
        <div class="candidate-profile-page">

        <div class="candidate-container">


            <!-- BACK -->

            <a href="SearchCandidates.aspx"
               class="candidate-back">

                <i class="bi bi-arrow-left"></i>

                Back to Search Candidates

            </a>


            <!-- =====================================
                 HEADER
            ====================================== -->

            <div class="candidate-header">

                <div class="candidate-header-left">

                    <div class="candidate-avatar">

                        <asp:Label
                            ID="lblInitial"
                            runat="server"
                            Text="C">
                        </asp:Label>

                    </div>


                    <div class="candidate-header-info">

                        <h1 class="candidate-name">

                            <asp:Label
                                ID="lblCandidateName"
                                runat="server"
                                Text="Candidate">
                            </asp:Label>

                        </h1>


                        <p class="candidate-headline">

                            <asp:Label
                                ID="lblHeadline"
                                runat="server"
                                Text="Professional">
                            </asp:Label>

                        </p>


                        <div class="candidate-location">

                            <i class="bi bi-geo-alt"></i>

                            <asp:Label
                                ID="lblLocation"
                                runat="server"
                                Text="Location not available">
                            </asp:Label>

                        </div>

                    </div>

                </div>


                <asp:HyperLink
                    ID="lnkResumeTop"
                    runat="server"
                    CssClass="resume-btn"
                    Target="_blank"
                    Visible="false">

                    <i class="bi bi-file-earmark-pdf"></i>

                    View Resume

                </asp:HyperLink>

            </div>


            <!-- =====================================
                 MAIN GRID
            ====================================== -->

            <div class="candidate-grid">


                <!-- =================================
                     LEFT
                ================================== -->

                <div>


                    <!-- PROFESSIONAL SUMMARY -->

                    <div class="candidate-card">

                        <div class="candidate-card-header">

                            <h2 class="candidate-card-title">
                                Professional Summary
                            </h2>

                        </div>

                        <div class="candidate-card-body">

                            <asp:Label
                                ID="lblProfessionalSummary"
                                runat="server"
                                CssClass="candidate-summary"
                                Text="No professional summary available.">
                            </asp:Label>

                        </div>

                    </div>


                    <!-- SKILLS -->

                    <div class="candidate-card">

                        <div class="candidate-card-header">

                            <h2 class="candidate-card-title">
                                Skills
                            </h2>

                        </div>

                        <div class="candidate-card-body">

                            <div class="skills-list">

                                <asp:Repeater
                                    ID="rptSkills"
                                    runat="server">

                                    <ItemTemplate>

                                        <span class="skill-badge">

                                            <%# Eval("SkillName") %>

                                        </span>

                                    </ItemTemplate>

                                </asp:Repeater>

                            </div>


                            <asp:Panel
                                ID="pnlNoSkills"
                                runat="server"
                                CssClass="profile-empty"
                                Visible="false">

                                No skills have been added.

                            </asp:Panel>

                        </div>

                    </div>


                    <!-- RESUME -->

                    <div class="candidate-card">

                        <div class="candidate-card-header">

                            <h2 class="candidate-card-title">
                                Resume
                            </h2>

                        </div>

                        <div class="candidate-card-body">

                            <asp:Panel
                                ID="pnlResume"
                                runat="server"
                                Visible="false">

                                <div class="resume-box">

                                    <div class="resume-icon">

                                        <i class="bi bi-file-earmark-text"></i>

                                    </div>


                                    <div class="resume-info">

                                        <asp:Label
                                            ID="lblResumeName"
                                            runat="server"
                                            CssClass="resume-name">
                                        </asp:Label>

                                        <asp:Label
                                            ID="lblResumeDate"
                                            runat="server"
                                            CssClass="resume-date">
                                        </asp:Label>

                                    </div>


                                    <asp:HyperLink
                                        ID="lnkResume"
                                        runat="server"
                                        CssClass="resume-download"
                                        Target="_blank">

                                        <i class="bi bi-box-arrow-up-right"></i>

                                    </asp:HyperLink>

                                </div>

                            </asp:Panel>


                            <asp:Panel
                                ID="pnlNoResume"
                                runat="server"
                                CssClass="profile-empty"
                                Visible="false">

                                No resume uploaded.

                            </asp:Panel>

                        </div>

                    </div>

                </div>


                <!-- =================================
                     RIGHT
                ================================== -->

                <div>


                    <!-- CONTACT INFORMATION -->

                    <div class="candidate-card">

                        <div class="candidate-card-header">

                            <h2 class="candidate-card-title">
                                Contact Information
                            </h2>

                        </div>

                        <div class="candidate-card-body">


                            <div class="contact-item">

                                <div class="contact-icon">

                                    <i class="bi bi-envelope"></i>

                                </div>

                                <div>

                                    <span class="contact-label">
                                        Email
                                    </span>

                                    <asp:Label
                                        ID="lblEmail"
                                        runat="server"
                                        CssClass="contact-value">
                                    </asp:Label>

                                </div>

                            </div>


                            <div class="contact-item">

                                <div class="contact-icon">

                                    <i class="bi bi-phone"></i>

                                </div>

                                <div>

                                    <span class="contact-label">
                                        Mobile
                                    </span>

                                    <asp:Label
                                        ID="lblMobile"
                                        runat="server"
                                        CssClass="contact-value">
                                    </asp:Label>

                                </div>

                            </div>


                            <div class="contact-item">

                                <div class="contact-icon">

                                    <i class="bi bi-geo-alt"></i>

                                </div>

                                <div>

                                    <span class="contact-label">
                                        Location
                                    </span>

                                    <asp:Label
                                        ID="lblCurrentLocation"
                                        runat="server"
                                        CssClass="contact-value">
                                    </asp:Label>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- JOB PREFERENCES -->

                    <div class="candidate-card">

                        <div class="candidate-card-header">

                            <h2 class="candidate-card-title">
                                Job Preferences
                            </h2>

                        </div>

                        <div class="candidate-card-body">


                            <div class="preference-item">

                                <span class="preference-label">
                                    Preferred Role
                                </span>

                                <asp:Label
                                    ID="lblPreferredRole"
                                    runat="server"
                                    CssClass="preference-value">
                                </asp:Label>

                            </div>


                            <div class="preference-item">

                                <span class="preference-label">
                                    Preferred Location
                                </span>

                                <asp:Label
                                    ID="lblPreferredLocation"
                                    runat="server"
                                    CssClass="preference-value">
                                </asp:Label>

                            </div>


                            <div class="preference-item">

                                <span class="preference-label">
                                    Preferred Industry
                                </span>

                                <asp:Label
                                    ID="lblPreferredIndustry"
                                    runat="server"
                                    CssClass="preference-value">
                                </asp:Label>

                            </div>


                            <div class="preference-item">

                                <span class="preference-label">
                                    Preferred Shift
                                </span>

                                <asp:Label
                                    ID="lblPreferredShift"
                                    runat="server"
                                    CssClass="preference-value">
                                </asp:Label>

                            </div>

                        </div>

                    </div>


                    <!-- PROFILE DETAILS -->

                    <div class="candidate-card">

                        <div class="candidate-card-header">

                            <h2 class="candidate-card-title">
                                Profile Details
                            </h2>

                        </div>

                        <div class="candidate-card-body">


                            <div class="detail-row">

                                <span class="detail-label">
                                    Full Name
                                </span>

                                <asp:Label
                                    ID="lblFullName"
                                    runat="server"
                                    CssClass="detail-value">
                                </asp:Label>

                            </div>


                            <div class="detail-row">

                                <span class="detail-label">
                                    Candidate ID
                                </span>

                                <asp:Label
                                    ID="lblCandidateId"
                                    runat="server"
                                    CssClass="detail-value">
                                </asp:Label>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
