<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Interviews.aspx.cs" Inherits="Success24_Job_Portal.JobSeeker.Interviews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
        .interview-header {
            margin-bottom: 25px;
        }

        .interview-header h2 {
            font-weight: 700;
            margin-bottom: 5px;
        }

        .interview-header p {
            color: #6c757d;
            margin-bottom: 0;
        }

        .interview-card {
            background: #fff;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            padding: 22px;
            margin-bottom: 16px;
            transition: all 0.2s ease;
        }

        .interview-card:hover {
            border-color: #dee2e6;
            box-shadow: 0 5px 18px rgba(0,0,0,0.06);
        }

        .interview-date {
            width: 70px;
            min-width: 70px;
            height: 78px;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            text-align: center;
            overflow: hidden;
            background: #fff;
        }

        .interview-date .month {
            background: #0d6efd;
            color: #fff;
            font-size: 12px;
            font-weight: 700;
            padding: 5px;
            text-transform: uppercase;
        }

        .interview-date .day {
            font-size: 26px;
            font-weight: 700;
            line-height: 35px;
            color: #212529;
        }

        .interview-date .year {
            font-size: 11px;
            color: #6c757d;
        }

        .job-title {
            font-size: 18px;
            font-weight: 700;
            color: #212529;
            text-decoration: none;
        }

        .job-title:hover {
            color: #0d6efd;
        }

        .company-name {
            color: #6c757d;
            font-size: 14px;
            margin-top: 4px;
        }

        .interview-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            margin-top: 14px;
            color: #6c757d;
            font-size: 13px;
        }

        .interview-meta i {
            margin-right: 5px;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-scheduled {
            background: #e7f1ff;
            color: #0d6efd;
        }

        .status-completed {
            background: #e8f7ee;
            color: #198754;
        }

        .status-cancelled {
            background: #fdecec;
            color: #dc3545;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-selected {
            background: #e8f7ee;
            color: #198754;
        }

        .status-rejected {
            background: #fdecec;
            color: #dc3545;
        }

        .interview-notes {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 10px 12px;
            margin-top: 14px;
            font-size: 13px;
            color: #495057;
        }

        .join-btn {
            border-radius: 7px;
            padding: 8px 15px;
            font-size: 13px;
        }

        .empty-state {
            background: #fff;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            padding: 60px 20px;
            text-align: center;
        }

        .empty-state i {
            font-size: 55px;
            color: #adb5bd;
            margin-bottom: 15px;
        }

        .empty-state h4 {
            font-weight: 700;
            margin-bottom: 8px;
        }

        .empty-state p {
            color: #6c757d;
            margin-bottom: 20px;
        }

        @media (max-width: 767px) {

            .interview-card {
                padding: 15px;
            }

            .interview-meta {
                gap: 8px;
            }

            .interview-date {
                width: 60px;
                min-width: 60px;
            }

            .action-buttons {
                margin-top: 15px;
            }
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container-fluid py-4">

        <div class="interview-header">
            <h2>My Interviews</h2>
            <p>Manage your upcoming and past interviews</p>
        </div>

        <asp:Panel ID="pnlInterviews" runat="server">

            <asp:Repeater ID="rptInterviews" runat="server">

                <ItemTemplate>

                    <div class="interview-card">

                        <div class="row align-items-center">

                            <div class="col-md-9">

                                <div class="d-flex align-items-start">

                                    <div class="me-3">

                                        <div class="interview-date">

                                            <div class="month">
                                                <%# GetMonth(Eval("InterviewDate")) %>
                                            </div>

                                            <div class="day">
                                                <%# GetDay(Eval("InterviewDate")) %>
                                            </div>

                                            <div class="year">
                                                <%# GetYear(Eval("InterviewDate")) %>
                                            </div>

                                        </div>

                                    </div>

                                    <div>

                                        <a
                                            href='<%# GetJobUrl(Eval("JobId"), Eval("JobTitle"), Eval("CompanyName"), Eval("City")) %>'
                                            class="job-title">

                                            <%# Eval("JobTitle") %>

                                        </a>

                                        <div class="company-name">
                                            <%# Eval("CompanyName") %>
                                        </div>

                                        <div class="interview-meta">

                                            <span>
                                                <i class="bi bi-clock"></i>
                                                <%# FormatTime(Eval("InterviewDate")) %>
                                            </span>

                                            <span>
                                                <i class="bi bi-calendar-event"></i>
                                                <%# FormatDate(Eval("InterviewDate")) %>
                                            </span>

                                            <span>
                                                <i class="bi bi-camera-video"></i>
                                                <%# Eval("InterviewMode") %>
                                            </span>

                                            <span>
                                                <i class="bi bi-geo-alt"></i>
                                                <%# GetInterviewLocation(Eval("Location")) %>
                                            </span>

                                        </div>

                                        <div class="mt-3">

                                            <span class='status-badge <%# GetStatusClass(Eval("InterviewStatus")) %>'>
                                                <%# Eval("InterviewStatus") %>
                                            </span>

                                        </div>

                                        <asp:Panel
                                            ID="pnlNotes"
                                            runat="server"
                                            CssClass="interview-notes"
                                            Visible='<%# !string.IsNullOrWhiteSpace(Convert.ToString(Eval("Instructions"))) %>'>

                                            <strong>
                                                <i class="bi bi-info-circle me-1"></i>
                                                Notes:
                                            </strong>

                                            <%# Eval("Instructions") %>

                                        </asp:Panel>

                                    </div>

                                </div>

                            </div>

                            <div class="col-md-3">

                                <div class="d-flex justify-content-md-end action-buttons">

                                    <asp:HyperLink
                                        ID="lnkJoinInterview"
                                        runat="server"
                                        CssClass="btn btn-primary join-btn"
                                        NavigateUrl='<%# GetInterviewLink(Eval("MeetingLink")) %>'
                                        Target="_blank"
                                        Visible='<%# HasInterviewLink(Eval("MeetingLink")) %>'>

                                        <i class="bi bi-camera-video me-1"></i>
                                        Join Interview

                                    </asp:HyperLink>

                                </div>

                            </div>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

        </asp:Panel>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">

            <div class="empty-state">

                <i class="bi bi-calendar-x"></i>

                <h4>No Interviews</h4>

                <p>
                    You don't have any interviews scheduled yet.
                    Keep applying for jobs to get interview opportunities.
                </p>

                <a href="~/Jobs.aspx" runat="server" class="btn btn-primary">

                    <i class="bi bi-search me-1"></i>
                    Search Jobs

                </a>

            </div>

        </asp:Panel>

    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
