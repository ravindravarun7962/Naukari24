<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="Applications.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.Applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>

        .applications-page {
            padding: 28px;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 25px;
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 22px;
        }

        .stat-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 18px;

            display: flex;
            align-items: center;
            gap: 13px;
        }

        .stat-icon {
            width: 43px;
            height: 43px;
            min-width: 43px;

            border-radius: 9px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #f3f4f6;
            color: #374151;

            font-size: 18px;
        }

        .stat-label {
            display: block;
            color: #6b7280;
            font-size: 11px;
            margin-bottom: 4px;
        }

        .stat-value {
            display: block;
            color: #111827;
            font-size: 22px;
            font-weight: 700;
        }

        .filter-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;

            padding: 18px;

            margin-bottom: 18px;
        }

        .filter-row {
            display: grid;
            grid-template-columns: 2fr 1fr auto;
            gap: 12px;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-label {
            font-size: 11px;
            font-weight: 600;
            color: #374151;
        }

        .form-control {
            width: 100%;
            height: 42px;

            border: 1px solid #d1d5db;
            border-radius: 8px;

            padding: 0 11px;

            font-size: 13px;
            outline: none;
        }

        .form-control:focus {
            border-color: #111827;
        }

        .btn {
            height: 42px;

            border: 0;
            border-radius: 8px;

            padding: 0 17px;

            font-size: 12px;
            font-weight: 600;

            cursor: pointer;
        }

        .btn-primary {
            background: #111827;
            color: #fff;
        }

        .btn-primary:hover {
            background: #1f2937;
        }

        .application-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            overflow: hidden;
        }

        .card-header {
            padding: 18px 20px;

            border-bottom: 1px solid #e5e7eb;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card-header h2 {
            margin: 0;
            font-size: 16px;
            color: #111827;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        .application-table {
            width: 100%;
            border-collapse: collapse;
        }

        .application-table th {
            padding: 12px 15px;

            background: #f9fafb;

            text-align: left;

            font-size: 11px;
            font-weight: 700;

            color: #6b7280;

            white-space: nowrap;
        }

        .application-table td {
            padding: 14px 15px;

            border-top: 1px solid #f0f1f3;

            font-size: 12px;

            color: #374151;

            vertical-align: middle;
        }

        .candidate-name {
            font-weight: 700;
            color: #111827;
            display: block;
        }

        .candidate-email {
            font-size: 11px;
            color: #9ca3af;
            display: block;
            margin-top: 3px;
        }

        .job-name {
            font-weight: 600;
            color: #111827;
        }

        .status {
            display: inline-block;

            padding: 5px 9px;

            border-radius: 20px;

            font-size: 10px;

            font-weight: 700;
        }

        .status-pending {
            background: #fff7ed;
            color: #c2410c;
        }

        .status-shortlisted {
            background: #eff6ff;
            color: #1d4ed8;
        }

        .status-interview {
            background: #f5f3ff;
            color: #6d28d9;
        }

        .status-selected {
            background: #ecfdf5;
            color: #047857;
        }

        .status-rejected {
            background: #fef2f2;
            color: #b91c1c;
        }

        .status-withdrawn {
            background: #f3f4f6;
            color: #6b7280;
        }

        .status-dropdown {
            min-width: 130px;
            height: 35px;

            border: 1px solid #d1d5db;
            border-radius: 7px;

            padding: 0 8px;

            font-size: 11px;
        }

        .update-btn {
            height: 35px;

            border: 0;
            border-radius: 7px;

            padding: 0 11px;

            background: #111827;
            color: #fff;

            font-size: 11px;
            font-weight: 600;

            cursor: pointer;
        }

        .message {
            display: block;

            padding: 11px 13px;

            margin-bottom: 18px;

            border-radius: 8px;

            font-size: 12px;
        }

        .success {
            background: #ecfdf5;
            color: #047857;
        }

        .error {
            background: #fef2f2;
            color: #b91c1c;
        }

        .empty-state {
            padding: 50px 20px;

            text-align: center;

            color: #9ca3af;
        }

        .empty-state i {
            font-size: 35px;
            display: block;
            margin-bottom: 10px;
        }

        .empty-state p {
            margin: 0;
            font-size: 13px;
        }

        .status-viewed {
            background: #e0f2fe;
            color: #0369a1;
        }

        .status-interview {
            background: #fef3c7;
            color: #92400e;
        }

        .status-hired {
            background: #dcfce7;
            color: #166534;
        }

        .status-withdrawn {
            background: #f3f4f6;
            color: #4b5563;
        }

        @media(max-width:1000px) {

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .filter-row {
                grid-template-columns: 1fr;
            }

        }

        @media(max-width:650px) {

            .applications-page {
                padding: 16px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

        }

    </style>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
    Applications
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
        <div class="applications-page">


        <%--HEADER--%>

        <div class="page-header">

            <div>

                <h1 class="page-title">
                <asp:Label
                    ID="lblPageTitle"
                    runat="server"
                    Text="Applications">
                </asp:Label>
            </h1>

                <p class="page-description">
                    Review and manage applications
                    submitted for your jobs.
                </p>

            </div>

        </div>


       <%--  MESSAGE --%>

        <asp:Label
            ID="lblMessage"
            runat="server"
            Visible="false">
        </asp:Label>


<%--   STATISTICS --%>

        <div class="stats-grid">


            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-people"></i>

                </div>

                <div>

                    <span class="stat-label">
                        Total Applications
                    </span>

                    <asp:Label
                        ID="lblTotalApplications"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-clock"></i>

                </div>

                <div>

                    <span class="stat-label">
                        Pending
                    </span>

                    <asp:Label
                        ID="lblPending"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-star"></i>

                </div>

                <div>

                    <span class="stat-label">
                        Shortlisted
                    </span>

                    <asp:Label
                        ID="lblShortlisted"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-check-circle"></i>

                </div>

                <div>

                    <span class="stat-label">
                        Selected
                    </span>

                    <asp:Label
                        ID="lblSelected"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


        </div>


        <%-- FILTER --%>

        <div class="filter-card">

            <div class="filter-row">


                <div class="form-group">

                    <label class="form-label">
                        Search Candidate / Job
                    </label>

                    <asp:TextBox
                        ID="txtSearch"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Search by candidate name, email or job title">
                    </asp:TextBox>

                </div>


                <div class="form-group">

                    <label class="form-label">
                        Application Status
                    </label>

                    <asp:DropDownList
                        ID="ddlStatus"
                        runat="server"
                        CssClass="form-control">

                        <asp:ListItem
                            Text="All Status"
                            Value="">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Pending"
                            Value="Pending">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Shortlisted"
                            Value="Shortlisted">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Interview"
                            Value="Interview">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Selected"
                            Value="Selected">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Rejected"
                            Value="Rejected">
                        </asp:ListItem>

                    </asp:DropDownList>

                </div>


                <asp:Button
                    ID="btnSearch"
                    runat="server"
                    Text="Search"
                    CssClass="btn btn-primary"
                    OnClick="btnSearch_Click" />


            </div>

        </div>


        <%-- APPLICATION LIST --%>

        <div class="application-card">


            <div class="card-header">

                <h2>
                    Candidate Applications
                </h2>

            </div>


            <div class="table-wrapper">


              <asp:GridView
            ID="gvApplications"
            runat="server"
            AutoGenerateColumns="False"
            CssClass="application-table"
            GridLines="None"
            OnRowCommand="gvApplications_RowCommand"
            OnRowDataBound="gvApplications_RowDataBound">


                    <Columns>


                        <%-- CANDIDATE --%>

                        <asp:TemplateField
                            HeaderText="Candidate">

                            <ItemTemplate>

                                <span class="candidate-name">

                                    <%# Eval("FullName") %>

                                </span>

                                <span class="candidate-email">

                                    <%# Eval("Email") %>

                                </span>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <%--JOB--%>

                        <asp:TemplateField
                            HeaderText="Job">

                            <ItemTemplate>

                                <span class="job-name">

                                    <%# Eval("JobTitle") %>

                                </span>

                            </ItemTemplate>

                        </asp:TemplateField>


                       <%--COMPANY--%> 

                        <asp:BoundField
                            DataField="CompanyName"
                            HeaderText="Company" />

    
                    <%-- APPLIED DATE--%>

                        <asp:TemplateField
                            HeaderText="Applied">

                            <ItemTemplate>

                                <%#
                                    Eval(
                                        "AppliedAt",
                                        "{0:dd MMM yyyy}"
                                    )
                                %>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <%-- STATUS --%>

                        <asp:TemplateField
                            HeaderText="Status">

                            <ItemTemplate>

                                <span
                                    class='<%# GetStatusClass(Convert.ToString(Eval("ApplicationStatus"))) %>'>
                                    <%# Eval("ApplicationStatus") %>

                                </span>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <%-- UPDATE STATUS --%>

                        <asp:TemplateField
                            HeaderText="Update">

                            <ItemTemplate>


                               <asp:DropDownList
                                ID="ddlStatus"
                                runat="server"
                                CssClass="status-dropdown">

                               <asp:ListItem
                                    Text="Applied"
                                    Value="Applied">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Pending"
                                    Value="Pending">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Viewed"
                                    Value="Viewed">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Shortlisted"
                                    Value="Shortlisted">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Interview"
                                    Value="Interview">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Selected"
                                    Value="Selected">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Hired"
                                    Value="Hired">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Rejected"
                                    Value="Rejected">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Withdrawn"
                                    Value="Withdrawn">
                                </asp:ListItem>

                            </asp:DropDownList>


                                <asp:LinkButton
                                    ID="btnUpdateStatus"
                                    runat="server"
                                    CssClass="update-btn"
                                    CommandName="UpdateStatus"
                                    CommandArgument='<%# Eval("ApplicationId") %>'
                                    CausesValidation="false">

                                    Update

                                </asp:LinkButton>


                            </ItemTemplate>

                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:HyperLink
                                    ID="lnkViewApplicant"
                                    runat="server"
                                    CssClass="update-btn"
                                    Text="View"
                                    NavigateUrl='<%# "~/Recruiter/ApplicantDetails.aspx?ApplicationId=" + Eval("ApplicationId") %>'>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>


                    <EmptyDataTemplate>

                        <div class="empty-state">

                            <i class="bi bi-inbox"></i>

                            <p>
                                No applications found.
                            </p>

                        </div>

                    </EmptyDataTemplate>


                </asp:GridView>


            </div>

        </div>


    </div>


</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
