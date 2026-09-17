<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Applications.aspx.cs" Inherits="Success24_Job_Portal.JobSeeker.Applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>

        .applications-page {
            padding: 35px 20px 60px;
            background: #f8fafc;
            min-height: calc(100vh - 100px);
        }

        .page-header {
            margin-bottom: 28px;
        }

        .page-header h1 {
            font-size: 30px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #6b7280;
            margin: 0;
        }

        /* ==========================================
           STAT CARDS
        =========================================== */

        .stats-row {
            margin-bottom: 30px;
        }

        .stat-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 22px;
            height: 100%;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: #fff7ed;
            color: #f97316;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            flex-shrink: 0;
        }

        .stat-content h3 {
            margin: 0 0 4px;
            font-size: 25px;
            font-weight: 800;
            color: #111827;
        }

        .stat-content span {
            color: #6b7280;
            font-size: 14px;
        }

        /* ==========================================
           FILTER
        =========================================== */

        .application-toolbar {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 18px 20px;
            margin-bottom: 20px;
        }

        .filter-label {
            font-size: 14px;
            font-weight: 600;
            color: #374151;
            margin-right: 10px;
        }

        .status-filter {
            min-width: 180px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            padding: 9px 12px;
            color: #374151;
            background: #ffffff;
        }

        /* ==========================================
           APPLICATION CARD
        =========================================== */

        .application-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 16px;
            transition: all 0.25s ease;
        }

        .application-card:hover {
            border-color: #fed7aa;
            box-shadow: 0 10px 25px rgba(0,0,0,0.06);
        }

        .application-top {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .job-info {
            display: flex;
            gap: 16px;
            min-width: 0;
        }

        .company-logo {
            width: 58px;
            height: 58px;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            object-fit: contain;
            background: #ffffff;
            padding: 7px;
            flex-shrink: 0;
        }

        .company-initial {
            width: 58px;
            height: 58px;
            border-radius: 12px;
            background: #fff7ed;
            color: #f97316;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            font-weight: 800;
            flex-shrink: 0;
        }

        .job-info h2 {
            margin: 0 0 7px;
            font-size: 20px;
            font-weight: 750;
            color: #111827;
        }

        .company-name {
            color: #4b5563;
            font-size: 14px;
            margin-bottom: 7px;
        }

        .job-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            color: #6b7280;
            font-size: 13px;
        }

        .job-meta span i {
            margin-right: 5px;
            color: #f97316;
        }

        /* ==========================================
           STATUS
        =========================================== */

        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 7px 13px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
        }

        .status-applied {
            background: #eff6ff;
            color: #2563eb;
        }

        .status-viewed {
            background: #f5f3ff;
            color: #7c3aed;
        }

        .status-shortlisted {
            background: #fff7ed;
            color: #ea580c;
        }

        .status-interview {
            background: #ecfeff;
            color: #0891b2;
        }

        .status-selected,
        .status-hired {
            background: #ecfdf5;
            color: #059669;
        }

        .status-rejected {
            background: #fef2f2;
            color: #dc2626;
        }

        .status-withdrawn {
            background: #f3f4f6;
            color: #6b7280;
        }

        .status-pending {
            background: #fefce8;
            color: #ca8a04;
        }

        .application-bottom {
            border-top: 1px solid #f0f0f0;
            margin-top: 20px;
            padding-top: 17px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .applied-date {
            color: #6b7280;
            font-size: 13px;
        }

        .applied-date strong {
            color: #374151;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-view-job {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 15px;
            border-radius: 8px;
            background: #f97316;
            color: #ffffff !important;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
        }

        .btn-view-job:hover {
            background: #ea580c;
        }

        /* ==========================================
           EMPTY STATE
        =========================================== */

        .empty-state {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 18px;
            padding: 65px 25px;
            text-align: center;
        }

        .empty-icon {
            width: 75px;
            height: 75px;
            border-radius: 50%;
            background: #fff7ed;
            color: #f97316;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 30px;
        }

        .empty-state h2 {
            font-size: 22px;
            font-weight: 750;
            color: #111827;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #6b7280;
            max-width: 500px;
            margin: 0 auto 22px;
            line-height: 1.6;
        }

        .btn-search-jobs {
            display: inline-block;
            padding: 11px 22px;
            border-radius: 9px;
            background: #f97316;
            color: #ffffff !important;
            text-decoration: none;
            font-weight: 700;
        }

        .btn-search-jobs:hover {
            background: #ea580c;
        }

        /* ==========================================
           RESPONSIVE
        =========================================== */

        @media (max-width: 768px) {

            .applications-page {
                padding: 25px 15px 45px;
            }

            .page-header h1 {
                font-size: 25px;
            }

            .application-top {
                flex-direction: column;
            }

            .application-bottom {
                flex-direction: column;
                align-items: flex-start;
            }

            .action-buttons {
                width: 100%;
            }

            .btn-view-job {
                justify-content: center;
            }

        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="applications-page">

        <div class="container">

            <!-- ==========================================
                 PAGE HEADER
            =========================================== -->

            <div class="page-header">

                <h1>My Applications</h1>

                <p>
                    Track the jobs you have applied for and check
                    the latest status of your applications.
                </p>

            </div>


            <!-- ==========================================
                 STATISTICS
            =========================================== -->

            <div class="row g-3 stats-row">

                <div class="col-lg-3 col-md-6">

                    <div class="stat-card">

                        <div class="stat-icon">
                            <i class="bi bi-send"></i>
                        </div>

                        <div class="stat-content">

                            <h3>
                                <asp:Label
                                    ID="lblTotalApplications"
                                    runat="server"
                                    Text="0" />
                            </h3>

                            <span>Total Applications</span>

                        </div>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="stat-card">

                        <div class="stat-icon">
                            <i class="bi bi-eye"></i>
                        </div>

                        <div class="stat-content">

                            <h3>
                                <asp:Label
                                    ID="lblViewedApplications"
                                    runat="server"
                                    Text="0" />
                            </h3>

                            <span>Viewed</span>

                        </div>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="stat-card">

                        <div class="stat-icon">
                            <i class="bi bi-star"></i>
                        </div>

                        <div class="stat-content">

                            <h3>
                                <asp:Label
                                    ID="lblShortlistedApplications"
                                    runat="server"
                                    Text="0" />
                            </h3>

                            <span>Shortlisted</span>

                        </div>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="stat-card">

                        <div class="stat-icon">
                            <i class="bi bi-calendar-event"></i>
                        </div>

                        <div class="stat-content">

                            <h3>
                                <asp:Label
                                    ID="lblInterviewApplications"
                                    runat="server"
                                    Text="0" />
                            </h3>

                            <span>Interview</span>

                        </div>

                    </div>

                </div>

            </div>


            <!-- ==========================================
                 FILTER
            =========================================== -->

            <div class="application-toolbar">

                <label class="filter-label">
                    Filter by status
                </label>

                <asp:DropDownList
                    ID="ddlStatus"
                    runat="server"
                    CssClass="status-filter"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">

                    <asp:ListItem Text="All Applications"
                        Value="All"
                        Selected="True" />

                    <asp:ListItem Text="Applied"
                        Value="Applied" />

                    <asp:ListItem Text="Viewed"
                        Value="Viewed" />

                    <asp:ListItem Text="Shortlisted"
                        Value="Shortlisted" />

                    <asp:ListItem Text="Interview"
                        Value="Interview" />

                    <asp:ListItem Text="Selected"
                        Value="Selected" />

                    <asp:ListItem Text="Hired"
                        Value="Hired" />

                    <asp:ListItem Text="Rejected"
                        Value="Rejected" />

                    <asp:ListItem Text="Withdrawn"
                        Value="Withdrawn" />

                </asp:DropDownList>

            </div>


            <!-- ==========================================
                 APPLICATION LIST
            =========================================== -->

            <asp:Panel
                ID="pnlApplications"
                runat="server">

                <asp:Repeater
                    ID="rptApplications"
                    runat="server">

                    <ItemTemplate>

                        <div class="application-card">

                            <div class="application-top">

                                <div class="job-info">

                                    <asp:Image
                                        ID="imgCompanyLogo"
                                        runat="server"
                                        CssClass="company-logo"
                                        ImageUrl='<%# GetCompanyLogo(Eval("CompanyLogo")) %>'
                                        Visible='<%# !string.IsNullOrWhiteSpace(Convert.ToString(Eval("CompanyLogo"))) %>' />

                                    <asp:Panel
                                        ID="pnlCompanyInitial"
                                        runat="server"
                                        CssClass="company-initial"
                                        Visible='<%# string.IsNullOrWhiteSpace(Convert.ToString(Eval("CompanyLogo"))) %>'>

                                        <%# GetCompanyInitial(Eval("CompanyName")) %>

                                    </asp:Panel>


                                    <div>

                                        <h2>
                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("JobTitle")
                                                )
                                            ) %>
                                        </h2>


                                        <div class="company-name">

                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("CompanyName")
                                                )
                                            ) %>

                                        </div>


                                        <div class="job-meta">

                                            <span>
                                                <i class="bi bi-geo-alt"></i>

                                                <%# Server.HtmlEncode(
                                                    Convert.ToString(
                                                        Eval("City")
                                                    )
                                                ) %>
                                            </span>


                                            <span>
                                                <i class="bi bi-briefcase"></i>

                                                <%# Server.HtmlEncode(
                                                    Convert.ToString(
                                                        Eval("EmploymentType")
                                                    )
                                                ) %>
                                            </span>


                                            <span>
                                                <i class="bi bi-house"></i>

                                                <%# Server.HtmlEncode(
                                                    Convert.ToString(
                                                        Eval("WorkMode")
                                                    )
                                                ) %>
                                            </span>

                                        </div>

                                    </div>

                                </div>


                                <div>

                                    <span class='<%# GetStatusClass(
                                        Convert.ToString(
                                            Eval("ApplicationStatus")
                                        )
                                    ) %>'>

                                        <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("ApplicationStatus")
                                            )
                                        ) %>

                                    </span>

                                </div>

                            </div>


                            <div class="application-bottom">

                                <div class="applied-date">

                                    Applied on:

                                    <strong>
                                        <%# FormatDate(
                                            Eval("AppliedAt")
                                        ) %>
                                    </strong>

                                </div>


                                <div class="action-buttons">

                                    <a
                                        href='<%# GetJobUrl(
                                            Eval("JobId"),
                                            Eval("City"),
                                            Eval("CompanyName"),
                                            Eval("JobTitle")
                                        ) %>'
                                        class="btn-view-job">

                                        <i class="bi bi-arrow-right-circle"></i>

                                        View Job

                                    </a>

                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>


                <!-- ==========================================
                     EMPTY STATE
                =========================================== -->

                <asp:Panel
                    ID="pnlNoApplications"
                    runat="server"
                    CssClass="empty-state"
                    Visible="false">

                    <div class="empty-icon">

                        <i class="bi bi-file-earmark-text"></i>

                    </div>


                    <h2>No Applications Found</h2>

                    <p>
                        You haven't applied to any jobs yet, or no
                        applications match the selected status.
                    </p>


                    <a
                        href="<%= ResolveUrl("~/Jobs.aspx") %>"
                        class="btn-search-jobs">

                        <i class="bi bi-search me-1"></i>

                        Search Jobs

                    </a>

                </asp:Panel>

            </asp:Panel>

        </div>

    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
