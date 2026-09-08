<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JobDetails.aspx.cs" Inherits="Success24_Job_Portal.JobDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>

        .job-details-page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 32px;
        }

        .job-details-header {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 18px;
            padding: 28px;
            margin-bottom: 22px;
        }

        .job-details-top {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            align-items: flex-start;
        }

        .company-logo {
            width: 64px;
            height: 64px;
            border-radius: 14px;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 25px;
            font-weight: 700;
            color: #374151;
            flex-shrink: 0;
        }

        .job-title-area {
            display: flex;
            gap: 18px;
            flex: 1;
        }

        .job-title-area h1 {
            margin: 0 0 8px;
            font-size: 30px;
            color: #111827;
        }

        .company-name {
            font-size: 16px;
            font-weight: 600;
            color: #4b5563;
        }

        .job-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 18px;
            margin-top: 20px;
        }

        .job-meta span {
            color: #6b7280;
            font-size: 14px;
        }

        .job-meta i {
            margin-right: 5px;
        }

        .job-details-layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 340px;
            gap: 22px;
        }

        .job-content-card,
        .job-sidebar-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 25px;
        }

        .job-content-card {
            margin-bottom: 20px;
        }

        .job-content-card h2 {
            margin: 0 0 15px;
            font-size: 20px;
            color: #111827;
        }

        .job-description {
            color: #4b5563;
            line-height: 1.8;
            white-space: pre-line;
        }

        .job-sidebar-card {
            height: fit-content;
            position: sticky;
            top: 20px;
        }

        .apply-btn {
            width: 100%;
            border: 0;
            border-radius: 10px;
            padding: 13px 18px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            margin-bottom: 18px;
            text-decoration: none;
            color: #6b7280;
            font-size: 14px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            padding: 13px 0;
            border-bottom: 1px solid #f0f1f3;
        }

        .detail-row:last-child {
            border-bottom: 0;
        }

        .detail-label {
            color: #6b7280;
            font-size: 13px;
        }

        .detail-value {
            text-align: right;
            color: #111827;
            font-size: 13px;
            font-weight: 600;
        }

        .job-message {
            display: block;
            margin-top: 14px;
            padding: 11px 13px;
            border-radius: 8px;
            font-size: 13px;
        }

        .job-success {
            background: #ecfdf5;
            color: #047857;
        }

        .job-error {
            background: #fef2f2;
            color: #b91c1c;
        }

        .job-not-found {
            text-align: center;
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 70px 20px;
        }

        @media (max-width: 850px) {

            .job-details-page {
                padding: 20px 14px;
            }

            .job-details-layout {
                grid-template-columns: 1fr;
            }

            .job-sidebar-card {
                position: static;
            }

            .job-details-top {
                flex-direction: column;
            }

            .job-title-area h1 {
                font-size: 25px;
            }
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="job-details-page">

        <a
            href="<%= ResolveUrl("~/Jobs.aspx") %>"
            class="back-link">

            <i class="bi bi-arrow-left"></i>

            Back to Jobs

        </a>


        <asp:Panel
            ID="pnlJobDetails"
            runat="server"
            Visible="false">


            <!-- =========================================
                 HEADER
            ========================================== -->

            <div class="job-details-header">

                <div class="job-details-top">

                    <div class="job-title-area">

                        <div class="company-logo">

                            <asp:Label
                                ID="lblCompanyInitial"
                                runat="server">
                            </asp:Label>

                        </div>


                        <div>

                            <h1>
                                <asp:Label
                                    ID="lblJobTitle"
                                    runat="server">
                                </asp:Label>
                            </h1>


                            <div class="company-name">

                                <asp:Label
                                    ID="lblCompanyName"
                                    runat="server">
                                </asp:Label>

                            </div>

                        </div>

                    </div>

                </div>


                <div class="job-meta">

                    <span>
                        <i class="bi bi-geo-alt"></i>

                        <asp:Label
                            ID="lblLocation"
                            runat="server">
                        </asp:Label>
                    </span>


                    <span>
                        <i class="bi bi-briefcase"></i>

                        <asp:Label
                            ID="lblExperience"
                            runat="server">
                        </asp:Label>
                    </span>


                    <asp:Panel
                        ID="pnlSalary"
                        runat="server">

                        <span>
                            <i class="bi bi-currency-rupee"></i>

                            <asp:Label
                                ID="lblSalary"
                                runat="server">
                            </asp:Label>
                        </span>

                    </asp:Panel>


                    <span>
                        <i class="bi bi-calendar3"></i>

                        <asp:Label
                            ID="lblPostedDate"
                            runat="server">
                        </asp:Label>

                    </span>

                </div>

            </div>


            <!-- =========================================
                 CONTENT + SIDEBAR
            ========================================== -->

            <div class="job-details-layout">


                <div>


                    <!-- DESCRIPTION -->

                    <div class="job-content-card">

                        <h2>
                            Job Description
                        </h2>

                        <div class="job-description">

                            <asp:Literal
                                ID="litJobDescription"
                                runat="server">
                            </asp:Literal>

                        </div>

                    </div>


                    <!-- REQUIREMENTS -->

                    <asp:Panel
                        ID="pnlRequirements"
                        runat="server"
                        CssClass="job-content-card">

                        <h2>
                            Requirements
                        </h2>

                        <div class="job-description">

                            <asp:Literal
                                ID="litRequirements"
                                runat="server">
                            </asp:Literal>

                        </div>

                    </asp:Panel>


                    <!-- RESPONSIBILITIES -->

                    <asp:Panel
                        ID="pnlResponsibilities"
                        runat="server"
                        CssClass="job-content-card">

                        <h2>
                            Responsibilities
                        </h2>

                        <div class="job-description">

                            <asp:Literal
                                ID="litResponsibilities"
                                runat="server">
                            </asp:Literal>

                        </div>

                    </asp:Panel>


                </div>


                <!-- SIDEBAR -->

                <div>


                    <div class="job-sidebar-card">

                        <h2>
                            Apply for this job
                        </h2>


                        <asp:Button
                            ID="btnApply"
                            runat="server"
                            Text="Apply Now"
                            CssClass="apply-btn"
                            OnClick="btnApply_Click" />


                        <asp:Label
                            ID="lblMessage"
                            runat="server"
                            Visible="false"
                            CssClass="job-message">
                        </asp:Label>


                        <div style="margin-top:20px;">


                            <div class="detail-row">

                                <span class="detail-label">
                                    Job Type
                                </span>

                                <span class="detail-value">

                                    <asp:Label
                                        ID="lblEmploymentType"
                                        runat="server">
                                    </asp:Label>

                                </span>

                            </div>


                            <div class="detail-row">

                                <span class="detail-label">
                                    Location
                                </span>

                                <span class="detail-value">

                                    <asp:Label
                                        ID="lblSidebarLocation"
                                        runat="server">
                                    </asp:Label>

                                </span>

                            </div>


                            <div class="detail-row">

                                <span class="detail-label">
                                    Experience
                                </span>

                                <span class="detail-value">

                                    <asp:Label
                                        ID="lblSidebarExperience"
                                        runat="server">
                                    </asp:Label>

                                </span>

                            </div>


                            <div class="detail-row">

                                <span class="detail-label">
                                    Deadline
                                </span>

                                <span class="detail-value">

                                    <asp:Label
                                        ID="lblDeadline"
                                        runat="server">
                                    </asp:Label>

                                </span>

                            </div>


                        </div>

                    </div>

                </div>


            </div>


        </asp:Panel>


        <!-- NOT FOUND -->

        <asp:Panel
            ID="pnlJobNotFound"
            runat="server"
            Visible="false"
            CssClass="job-not-found">

            <h2>
                Job not found
            </h2>

            <p>
                This job may have been removed,
                expired, or is no longer available.
            </p>

            <a
                href="<%= ResolveUrl("~/Jobs.aspx") %>"
                class="back-link">

                Browse Jobs

            </a>

        </asp:Panel>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
