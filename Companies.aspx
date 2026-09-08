<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Companies.aspx.cs" Inherits="Success24_Job_Portal.Companies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>

        .companies-page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 25px;
        }

        .page-header h1 {
            margin: 0 0 6px;
            font-size: 28px;
            color: #111827;
        }

        .page-header p {
            margin: 0;
            color: #6b7280;
            font-size: 13px;
        }

        .btn {
            border: 0;
            border-radius: 8px;
            padding: 10px 16px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-primary {
            background: #111827;
            color: #fff;
        }

        .btn-primary:hover {
            background: #1f2937;
            color: #fff;
        }

        .message {
            display: block;
            padding: 12px 14px;
            border-radius: 9px;
            margin-bottom: 20px;
            font-size: 13px;
        }

        .success {
            background: #ecfdf5;
            color: #047857;
        }

        .error {
            background: #fef2f2;
            color: #b91c1c;
        }

        .company-form-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 22px;
        }

        .section-title {
            margin: 0 0 20px;
            font-size: 18px;
            color: #111827;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 17px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 7px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-label {
            font-size: 12px;
            font-weight: 600;
            color: #374151;
        }

        .form-control {
            width: 100%;
            min-height: 43px;
            box-sizing: border-box;

            border: 1px solid #d1d5db;
            border-radius: 8px;

            padding: 9px 11px;

            font-size: 13px;
            outline: none;
        }

        textarea.form-control {
            min-height: 110px;
            resize: vertical;
        }

        .form-control:focus {
            border-color: #6b7280;
        }

        .checkbox-row {
            display: flex;
            align-items: center;
            gap: 8px;
            min-height: 43px;
        }

        .checkbox-row label {
            font-size: 13px;
            color: #374151;
        }

        .action-row {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-secondary {
            background: #f3f4f6;
            color: #374151;
        }

        /* ===================================
           COMPANY LIST
        =================================== */

        .list-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            overflow: hidden;
        }

        .list-header {
            padding: 18px 20px;
            border-bottom: 1px solid #e5e7eb;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .list-header h2 {
            margin: 0;
            font-size: 16px;
            color: #111827;
        }

        .company-table-wrapper {
            overflow-x: auto;
        }

        .company-table {
            width: 100%;
            border-collapse: collapse;
        }

        .company-table th {
            background: #f9fafb;
            padding: 12px 15px;

            text-align: left;

            font-size: 11px;
            font-weight: 700;

            color: #6b7280;

            white-space: nowrap;
        }

        .company-table td {
            padding: 14px 15px;

            border-top: 1px solid #f0f1f3;

            font-size: 12px;

            color: #374151;

            vertical-align: middle;
        }

        .company-name {
            font-weight: 700;
            color: #111827;
        }

        .company-industry {
            color: #6b7280;
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

        .status-inactive {
            background: #fef2f2;
            color: #b91c1c;
        }

        .verified {
            color: #047857;
            font-weight: 700;
        }

        .not-verified {
            color: #9ca3af;
            font-weight: 600;
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
            margin: 0;
            font-size: 13px;
        }

        .company-logo {
            width: 38px;
            height: 38px;
            border-radius: 8px;
            object-fit: contain;

            border: 1px solid #e5e7eb;

            background: #fff;
        }

        .company-logo-placeholder {
            width: 38px;
            height: 38px;
            border-radius: 8px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #f3f4f6;
            color: #6b7280;

            font-size: 16px;
        }

        .company-info {
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .edit-link {
            color: #374151;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
        }

        .edit-link:hover {
            text-decoration: underline;
        }

        @media(max-width:800px) {

            .companies-page {
                padding: 20px 14px;
            }

            .page-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full {
                grid-column: auto;
            }

        }

    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="companies-page">


        <!-- ===================================
             HEADER
        ==================================== -->

        <div class="page-header">

            <div>

                <h1>
                    Companies
                </h1>

                <p>
                    Manage companies available
                    for your job postings.
                </p>

            </div>


            <a
                href="JobPost.aspx"
                class="btn btn-primary">

                + Post a Job

            </a>

        </div>


        <!-- ===================================
             MESSAGE
        ==================================== -->

        <asp:Label
            ID="lblMessage"
            runat="server"
            Visible="false">
        </asp:Label>


        <!-- ===================================
             ADD COMPANY
        ==================================== -->

        <div class="company-form-card">


            <h2 class="section-title">

                Add New Company

            </h2>


            <div class="form-grid">


                <!-- COMPANY NAME -->

                <div class="form-group">

                    <label class="form-label">
                        Company Name *
                    </label>

                    <asp:TextBox
                        ID="txtCompanyName"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="300"
                        placeholder="Enter company name">
                    </asp:TextBox>

                </div>


                <!-- WEBSITE -->

                <div class="form-group">

                    <label class="form-label">
                        Website
                    </label>

                    <asp:TextBox
                        ID="txtWebsite"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="500"
                        placeholder="https://example.com">
                    </asp:TextBox>

                </div>


                <!-- INDUSTRY -->

                <div class="form-group">

                    <label class="form-label">
                        Industry
                    </label>

                    <asp:TextBox
                        ID="txtIndustry"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="200"
                        placeholder="e.g. Information Technology">
                    </asp:TextBox>

                </div>


                <!-- COMPANY SIZE -->

                <div class="form-group">

                    <label class="form-label">
                        Company Size
                    </label>

                    <asp:DropDownList
                        ID="ddlCompanySize"
                        runat="server"
                        CssClass="form-control">

                        <asp:ListItem
                            Text="Select Company Size"
                            Value="">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="1-10 Employees"
                            Value="1-10">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="11-50 Employees"
                            Value="11-50">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="51-200 Employees"
                            Value="51-200">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="201-500 Employees"
                            Value="201-500">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="501-1000 Employees"
                            Value="501-1000">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="1000+ Employees"
                            Value="1000+">
                        </asp:ListItem>

                    </asp:DropDownList>

                </div>


                <!-- FOUNDED YEAR -->

                <div class="form-group">

                    <label class="form-label">
                        Founded Year
                    </label>

                    <asp:TextBox
                        ID="txtFoundedYear"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Number"
                        placeholder="e.g. 2010">
                    </asp:TextBox>

                </div>


                <!-- LOGO -->

                <div class="form-group">

                    <label class="form-label">
                        Company Logo URL
                    </label>

                    <asp:TextBox
                        ID="txtCompanyLogo"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="500"
                        placeholder="/uploads/company/logo.png">
                    </asp:TextBox>

                </div>


                <!-- DESCRIPTION -->

                <div class="form-group full">

                    <label class="form-label">
                        Company Description
                    </label>

                    <asp:TextBox
                        ID="txtDescription"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        placeholder="Describe the company...">
                    </asp:TextBox>

                </div>


                <!-- ADDRESS -->

                <div class="form-group full">

                    <label class="form-label">
                        Address
                    </label>

                    <asp:TextBox
                        ID="txtAddress"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="500"
                        placeholder="Company address">
                    </asp:TextBox>

                </div>


                <!-- CITY -->

                <div class="form-group">

                    <label class="form-label">
                        City
                    </label>

                    <asp:TextBox
                        ID="txtCity"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="200"
                        placeholder="e.g. Noida">
                    </asp:TextBox>

                </div>


                <!-- STATE -->

                <div class="form-group">

                    <label class="form-label">
                        State
                    </label>

                    <asp:TextBox
                        ID="txtState"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="200"
                        placeholder="e.g. Uttar Pradesh">
                    </asp:TextBox>

                </div>


                <!-- PINCODE -->

                <div class="form-group">

                    <label class="form-label">
                        Pincode
                    </label>

                    <asp:TextBox
                        ID="txtPincode"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="20"
                        placeholder="e.g. 201301">
                    </asp:TextBox>

                </div>


                <!-- ACTIVE -->

                <div class="form-group">

                    <div class="checkbox-row">

                        <asp:CheckBox
                            ID="chkIsActive"
                            runat="server"
                            Checked="true" />

                        <label
                            for="<%= chkIsActive.ClientID %>">

                            Make company active

                        </label>

                    </div>

                </div>


            </div>


            <div class="action-row">

                <asp:Button
                    ID="btnClear"
                    runat="server"
                    Text="Clear"
                    CssClass="btn btn-secondary"
                    CausesValidation="false"
                    OnClick="btnClear_Click" />


                <asp:Button
                    ID="btnSave"
                    runat="server"
                    Text="Save Company"
                    CssClass="btn btn-primary"
                    OnClick="btnSave_Click" />

            </div>


        </div>


        <!-- ===================================
             COMPANY LIST
        ==================================== -->

        <div class="list-card">


            <div class="list-header">

                <h2>
                    Company List
                </h2>

            </div>


            <div class="company-table-wrapper">


                <asp:GridView
                    ID="gvCompanies"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="company-table"
                    GridLines="None"
                    OnRowCommand="gvCompanies_RowCommand">


                    <Columns>


                        <asp:TemplateField
                            HeaderText="Company">

                            <ItemTemplate>

                                <div class="company-info">


                                    <asp:Image
                                        ID="imgLogo"
                                        runat="server"
                                        CssClass="company-logo"
                                        ImageUrl='<%# Eval("CompanyLogo") %>'
                                        Visible='<%# !string.IsNullOrWhiteSpace(Convert.ToString(Eval("CompanyLogo"))) %>' />


                                    <div
                                        class="company-logo-placeholder"
                                        visible='<%# string.IsNullOrWhiteSpace(Convert.ToString(Eval("CompanyLogo"))) %>'
                                        runat="server">

                                        <i class="bi bi-building"></i>

                                    </div>


                                    <div>

                                        <span class="company-name">

                                            <%# Eval("CompanyName") %>

                                        </span>

                                    </div>


                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <asp:BoundField
                            DataField="Industry"
                            HeaderText="Industry" />


                        <asp:BoundField
                            DataField="CompanySize"
                            HeaderText="Company Size" />


                        <asp:TemplateField
                            HeaderText="Location">

                            <ItemTemplate>

                                <%# GetLocation(
                                    Eval("City"),
                                    Eval("State")
                                ) %>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <asp:TemplateField
                            HeaderText="Verified">

                            <ItemTemplate>

                                <asp:Label
                                    runat="server"
                                    CssClass='<%# Convert.ToBoolean(Eval("IsVerified")) ? "verified" : "not-verified" %>'
                                    Text='<%# Convert.ToBoolean(Eval("IsVerified")) ? "Verified" : "Pending" %>'>
                                </asp:Label>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <asp:TemplateField
                            HeaderText="Status">

                            <ItemTemplate>

                                <asp:Label
                                    runat="server"
                                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "status status-active" : "status status-inactive" %>'
                                    Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>'>
                                </asp:Label>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <asp:TemplateField
                            HeaderText="Action">

                            <ItemTemplate>

                                <asp:LinkButton
                                    ID="btnToggle"
                                    runat="server"
                                    CssClass="edit-link"
                                    CommandName="ToggleStatus"
                                    CommandArgument='<%# Eval("CompanyId") %>'
                                    CausesValidation="false">

                                    <%# Convert.ToBoolean(Eval("IsActive"))
                                        ? "Deactivate"
                                        : "Activate" %>

                                </asp:LinkButton>

                            </ItemTemplate>

                        </asp:TemplateField>


                    </Columns>


                    <EmptyDataTemplate>

                        <div class="empty-state">

                            <i class="bi bi-building"></i>

                            <p>
                                No companies found.
                                Add your first company above.
                            </p>

                        </div>

                    </EmptyDataTemplate>


                </asp:GridView>


            </div>

        </div>


    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
