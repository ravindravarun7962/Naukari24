<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="SavedJobs.aspx.cs" Inherits="Success24_Job_Portal.JobSeeker.SavedJobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        .saved-header {
            margin-bottom: 25px;
        }

        .saved-header h2 {
            font-weight: 700;
            margin-bottom: 5px;
        }

        .saved-header p {
            color: #6c757d;
            margin-bottom: 0;
        }

        .saved-card {
            background: #fff;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.2s ease;
        }

        .saved-card:hover {
            border-color: #dee2e6;
            box-shadow: 0 5px 18px rgba(0,0,0,0.06);
        }

        .company-logo {
            width: 58px;
            height: 58px;
            border-radius: 10px;
            object-fit: cover;
            border: 1px solid #eee;
        }

        .company-initial {
            width: 58px;
            height: 58px;
            border-radius: 10px;
            background: #f1f3f5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            font-weight: 700;
            color: #495057;
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

        .job-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 12px;
            color: #6c757d;
            font-size: 13px;
        }

        .job-meta i {
            margin-right: 5px;
        }

        .saved-date {
            color: #8b949e;
            font-size: 12px;
        }

        .remove-btn {
            border: 1px solid #dc3545;
            color: #dc3545;
            background: #fff;
            border-radius: 7px;
            padding: 7px 12px;
            font-size: 13px;
        }

        .remove-btn:hover {
            background: #dc3545;
            color: #fff;
        }

        .view-btn {
            border-radius: 7px;
            padding: 7px 14px;
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
            .saved-card {
                padding: 15px;
            }

            .job-meta {
                gap: 8px;
            }

            .action-buttons {
                margin-top: 15px;
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid py-4">

        <div class="saved-header">
            <h2>Saved Jobs</h2>
            <p>Jobs you saved for later</p>
        </div>

        <asp:Panel ID="pnlSavedJobs" runat="server">

            <asp:Repeater ID="rptSavedJobs" runat="server">

                <ItemTemplate>

                    <div class="saved-card">

                        <div class="row align-items-center">

                            <div class="col-md-8">

                                <div class="d-flex align-items-start">

                                    <div class="me-3">

                                        <asp:Image
                                            ID="imgCompanyLogo"
                                            runat="server"
                                            CssClass="company-logo"
                                            ImageUrl='<%# GetCompanyLogo(Eval("CompanyLogo")) %>'
                                            Visible='<%# !string.IsNullOrEmpty(Convert.ToString(Eval("CompanyLogo"))) %>' />

                                        <asp:Panel
                                            ID="pnlCompanyInitial"
                                            runat="server"
                                            CssClass="company-initial"
                                            Visible='<%# string.IsNullOrEmpty(Convert.ToString(Eval("CompanyLogo"))) %>'>

                                            <%# GetCompanyInitial(Eval("CompanyName")) %>

                                        </asp:Panel>

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

                                        <div class="job-meta">

                                            <span>
                                                <i class="bi bi-geo-alt"></i>
                                                <%# Eval("City") %>
                                            </span>

                                            <span>
                                                <i class="bi bi-briefcase"></i>
                                                <%# Eval("EmploymentType") %>
                                            </span>

                                            <span>
                                                <i class="bi bi-laptop"></i>
                                                <%# Eval("WorkMode") %>
                                            </span>

                                            <asp:Panel
                                                ID="pnlSalary"
                                                runat="server"
                                                Visible='<%# GetSalaryVisibility(Eval("SalaryVisible")) %>'>

                                                <span>
                                                    <i class="bi bi-currency-rupee"></i>
                                                    <%# GetSalary(Eval("MinSalary"), Eval("MaxSalary")) %>
                                                </span>

                                            </asp:Panel>

                                        </div>

                                        <div class="saved-date mt-2">

                                            <i class="bi bi-bookmark-fill"></i>
                                            Saved on <%# FormatDate(Eval("SavedAt")) %>

                                        </div>

                                    </div>

                                </div>

                            </div>

                            <div class="col-md-4">

                                <div class="d-flex justify-content-md-end gap-2 action-buttons">

                                    <a
                                        href='<%# GetJobUrl(Eval("JobId"), Eval("JobTitle"), Eval("CompanyName"), Eval("City")) %>'
                                        class="btn btn-primary view-btn">

                                        <i class="bi bi-eye me-1"></i>
                                        View Job

                                    </a>

                                    <asp:LinkButton
                                        ID="btnRemove"
                                        runat="server"
                                        CssClass="remove-btn"
                                        CommandArgument='<%# Eval("SavedJobId") %>'
                                        OnCommand="btnRemove_Command"
                                        OnClientClick="return confirm('Are you sure you want to remove this job from saved jobs?');">

                                        <i class="bi bi-trash me-1"></i>
                                        Remove

                                    </asp:LinkButton>

                                </div>

                            </div>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

        </asp:Panel>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">

            <div class="empty-state">

                <i class="bi bi-bookmark"></i>

                <h4>No Saved Jobs</h4>

                <p>
                    You haven't saved any jobs yet.
                    Browse jobs and save the ones you're interested in.
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
