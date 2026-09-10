<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="ApplicantDetails.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.ApplicantDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Applicant Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
        <style>

        .applicant-page {
            padding: 28px;
            max-width: 1100px;
            margin: auto;
        }

        .page-header {
            margin-bottom: 22px;
        }

        .page-title {
            margin: 0 0 5px;
            font-size: 26px;
            font-weight: 700;
            color: #111827;
        }

        .page-description {
            margin: 0;
            color: #6b7280;
            font-size: 13px;
        }

        .message {
            display: block;
            padding: 12px 15px;
            margin-bottom: 18px;
            border-radius: 8px;
            font-size: 13px;
        }

        .error {
            background: #fef2f2;
            color: #b91c1c;
        }

        .success {
            background: #ecfdf5;
            color: #047857;
        }

        .card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            margin-bottom: 18px;
            overflow: hidden;
        }

        .card-header {
            padding: 18px 20px;
            border-bottom: 1px solid #e5e7eb;
        }

        .card-header h2 {
            margin: 0;
            font-size: 16px;
            font-weight: 700;
            color: #111827;
        }

        .card-body {
            padding: 20px;
        }

        .candidate-header {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .candidate-avatar {
            width: 65px;
            height: 65px;
            min-width: 65px;
            border-radius: 50%;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 25px;
            font-weight: 700;
            color: #374151;
        }

        .candidate-name {
            margin: 0 0 5px;
            font-size: 22px;
            font-weight: 700;
            color: #111827;
        }

        .candidate-email {
            color: #6b7280;
            font-size: 13px;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .detail-item {
            padding: 13px;
            background: #f9fafb;
            border-radius: 8px;
        }

        .detail-label {
            display: block;
            font-size: 10px;
            color: #6b7280;
            margin-bottom: 5px;
            text-transform: uppercase;
            font-weight: 600;
        }

        .detail-value {
            display: block;
            font-size: 13px;
            color: #111827;
            font-weight: 600;
        }

        .cover-letter {
            background: #f9fafb;
            border-radius: 8px;
            padding: 16px;
            color: #374151;
            font-size: 13px;
            line-height: 1.7;
            white-space: pre-wrap;
        }

        .resume-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            padding: 15px;
            background: #f9fafb;
            border-radius: 8px;
        }

        .resume-name {
            font-size: 13px;
            font-weight: 600;
            color: #111827;
        }
        .timeline {
    position: relative;
    padding-left: 10px;
}

.timeline-item {
    position: relative;
    display: flex;
    gap: 14px;
    padding-bottom: 22px;
}

.timeline-item:last-child {
    padding-bottom: 0;
}

.timeline-item:not(:last-child)::before {
    content: "";
    position: absolute;
    left: 5px;
    top: 16px;
    width: 1px;
    height: calc(100% - 5px);
    background: #d1d5db;
}

.timeline-dot {
    width: 11px;
    height: 11px;
    min-width: 11px;
    margin-top: 3px;
    border-radius: 50%;
    background: #111827;
    position: relative;
    z-index: 1;
}

.timeline-content {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.timeline-content strong {
    font-size: 13px;
    color: #111827;
}

.timeline-date {
    font-size: 11px;
    color: #6b7280;
}

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 38px;
            padding: 0 15px;
            border-radius: 7px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            border: 0;
            cursor: pointer;
        }

        .btn-primary {
            background: #111827;
            color: #fff;
        }

        .btn-secondary {
            background: #f3f4f6;
            color: #374151;
        }

        .status {
            display: inline-block;
            padding: 6px 11px;
            border-radius: 20px;
            background: #eff6ff;
            color: #1d4ed8;
            font-size: 11px;
            font-weight: 700;
        }

        .action-row {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        @media(max-width:700px) {

            .applicant-page {
                padding: 16px;
            }

            .details-grid {
                grid-template-columns: 1fr;
            }

            .candidate-header {
                align-items: flex-start;
            }

            .resume-box {
                flex-direction: column;
                align-items: flex-start;
            }
        }

    </style>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
     Applicant Details
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
        <div class="applicant-page">

        <!-- HEADER -->

        <div class="page-header">

            <h1 class="page-title">
                Applicant Details
            </h1>

            <p class="page-description">
                View candidate information and application details.
            </p>

        </div>


        <!-- MESSAGE -->

        <asp:Label
            ID="lblMessage"
            runat="server"
            Visible="false">
        </asp:Label>


        <!-- CANDIDATE -->

        <div class="card">

            <div class="card-body">

                <div class="candidate-header">

                    <div class="candidate-avatar">

                        <asp:Label
                            ID="lblInitial"
                            runat="server">
                        </asp:Label>

                    </div>

                    <div>

                        <h2 class="candidate-name">

                            <asp:Label
                                ID="lblCandidateName"
                                runat="server">
                            </asp:Label>

                        </h2>

                        <div class="candidate-email">

                            <asp:Label
                                ID="lblEmail"
                                runat="server">
                            </asp:Label>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- CONTACT DETAILS -->

        <div class="card">

            <div class="card-header">

                <h2>Candidate Information</h2>

            </div>

            <div class="card-body">

                <div class="details-grid">

                    <div class="detail-item">

                        <span class="detail-label">
                            Full Name
                        </span>

                        <asp:Label
                            ID="lblFullName"
                            runat="server"
                            CssClass="detail-value">
                        </asp:Label>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Email
                        </span>

                        <asp:Label
                            ID="lblCandidateEmail"
                            runat="server"
                            CssClass="detail-value">
                        </asp:Label>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Mobile
                        </span>

                        <asp:Label
                            ID="lblMobile"
                            runat="server"
                            CssClass="detail-value">
                        </asp:Label>

                    </div>

                </div>

            </div>

        </div>


        <!-- JOB INFORMATION -->

        <div class="card">

            <div class="card-header">

                <h2>Application Details</h2>

            </div>

            <div class="card-body">

                <div class="details-grid">

                    <div class="detail-item">

                        <span class="detail-label">
                            Job
                        </span>

                        <asp:Label
                            ID="lblJobTitle"
                            runat="server"
                            CssClass="detail-value">
                        </asp:Label>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Company
                        </span>

                        <asp:Label
                            ID="lblCompany"
                            runat="server"
                            CssClass="detail-value">
                        </asp:Label>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Application Status
                        </span>

                        <asp:Label
                            ID="lblStatus"
                            runat="server"
                            CssClass="status">
                        </asp:Label>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Applied Date
                        </span>

                        <asp:Label
                            ID="lblAppliedDate"
                            runat="server"
                            CssClass="detail-value">
                        </asp:Label>

                    </div>

                </div>

            </div>

        </div>


        <!-- COVER LETTER -->

        <div class="card">

            <div class="card-header">

                <h2>Cover Letter</h2>

            </div>

            <div class="card-body">

                <asp:Panel
                    ID="pnlCoverLetter"
                    runat="server">

                    <div class="cover-letter">

                        <asp:Label
                            ID="lblCoverLetter"
                            runat="server">
                        </asp:Label>

                    </div>

                </asp:Panel>

                <asp:Label
                    ID="lblNoCoverLetter"
                    runat="server"
                    Text="No cover letter submitted."
                    Visible="false">
                </asp:Label>

            </div>

        </div>


        <!-- RESUME -->

        <div class="card">

            <div class="card-header">

                <h2>Resume</h2>

            </div>

            <div class="card-body">

                <div class="resume-box">

                    <asp:Label
                        ID="lblResumeName"
                        runat="server"
                        CssClass="resume-name"
                        Text="No resume attached.">
                    </asp:Label>

                    <asp:HyperLink
                        ID="lnkResume"
                        runat="server"
                        CssClass="btn btn-primary"
                        Text="View Resume"
                        Target="_blank"
                        Visible="false">
                    </asp:HyperLink>

                </div>

            </div>

        </div>
            <!-- APPLICATION TIMELINE -->

<div class="card">

    <div class="card-header">

        <h2>Application Timeline</h2>

    </div>

    <div class="card-body">

        <div class="timeline">

            <div class="timeline-item">

                <div class="timeline-dot"></div>

                <div class="timeline-content">

                    <strong>Application Submitted</strong>

                    <asp:Label
                        ID="lblAppliedTimeline"
                        runat="server"
                        CssClass="timeline-date">
                    </asp:Label>

                </div>

            </div>


            <asp:Panel
                ID="pnlViewed"
                runat="server"
                CssClass="timeline-item"
                Visible="false">

                <div class="timeline-dot"></div>

                <div class="timeline-content">

                    <strong>Application Viewed</strong>

                    <asp:Label
                        ID="lblViewedTimeline"
                        runat="server"
                        CssClass="timeline-date">
                    </asp:Label>

                </div>

            </asp:Panel>


            <asp:Panel
                ID="pnlShortlisted"
                runat="server"
                CssClass="timeline-item"
                Visible="false">

                <div class="timeline-dot"></div>

                <div class="timeline-content">

                    <strong>Candidate Shortlisted</strong>

                    <asp:Label
                        ID="lblShortlistedTimeline"
                        runat="server"
                        CssClass="timeline-date">
                    </asp:Label>

                </div>

            </asp:Panel>


            <asp:Panel
                ID="pnlRejected"
                runat="server"
                CssClass="timeline-item"
                Visible="false">

                <div class="timeline-dot"></div>

                <div class="timeline-content">

                    <strong>Application Rejected</strong>

                    <asp:Label
                        ID="lblRejectedTimeline"
                        runat="server"
                        CssClass="timeline-date">
                    </asp:Label>

                </div>

            </asp:Panel>


            <div class="timeline-item">

                <div class="timeline-dot"></div>

                <div class="timeline-content">

                    <strong>Current Status</strong>

                    <asp:Label
                        ID="lblCurrentStatusTimeline"
                        runat="server"
                        CssClass="timeline-date">
                    </asp:Label>

                </div>

            </div>

        </div>

    </div>

</div>


        <!-- ACTIONS -->

        <div class="action-row">

            <asp:HyperLink
                ID="lnkBack"
                runat="server"
                CssClass="btn btn-secondary"
                Text="← Back to Applications">
            </asp:HyperLink>

        </div>

    </div>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
