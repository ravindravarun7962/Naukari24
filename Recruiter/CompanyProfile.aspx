<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="CompanyProfile.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.CompanyProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>

        .company-profile-page {
            padding: 28px;
            max-width: 1100px;
            margin: auto;
        }

        .page-header {
            margin-bottom: 24px;
        }

        .page-title {
            margin: 0 0 6px;
            font-size: 27px;
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
            padding: 12px 14px;
            margin-bottom: 20px;
            border-radius: 9px;
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

        .profile-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 20px;
        }

        .section-title {
            margin: 0 0 20px;
            font-size: 17px;
            font-weight: 700;
            color: #111827;
        }

        .company-selector {
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 12px;
            align-items: end;
            margin-bottom: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 7px;
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

        .form-control:focus {
            border-color: #111827;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .btn {
            min-height: 43px;
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

        .btn-secondary {
            background: #f3f4f6;
            color: #374151;
        }

        .profile-top {
            display: flex;
            align-items: center;
            gap: 18px;

            padding-bottom: 22px;
            margin-bottom: 23px;

            border-bottom: 1px solid #e5e7eb;
        }

        .company-logo {
            width: 75px;
            height: 75px;

            border-radius: 14px;

            border: 1px solid #e5e7eb;

            object-fit: contain;

            background: #fff;
        }

        .logo-placeholder {
            width: 75px;
            height: 75px;

            border-radius: 14px;

            background: #f3f4f6;
            color: #6b7280;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 28px;
        }

        .company-heading h2 {
            margin: 0 0 5px;

            font-size: 22px;

            color: #111827;
        }

        .company-heading p {
            margin: 0;

            font-size: 12px;

            color: #9ca3af;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 17px;
        }

        .full {
            grid-column: 1 / -1;
        }

        .action-row {
            display: flex;
            justify-content: flex-end;
            gap: 10px;

            margin-top: 23px;
            padding-top: 20px;

            border-top: 1px solid #e5e7eb;
        }

        .status-row {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
        }

        .status-box {
            padding: 10px 14px;
            border-radius: 8px;
            background: #f9fafb;
            border: 1px solid #e5e7eb;
        }

        .status-label {
            display: block;
            font-size: 10px;
            color: #9ca3af;
            margin-bottom: 3px;
        }

        .status-value {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: #374151;
        }

        @media(max-width:700px) {

            .company-profile-page {
                padding: 18px 14px;
            }

            .company-selector {
                grid-template-columns: 1fr;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .full {
                grid-column: auto;
            }

            .profile-top {
                align-items: flex-start;
            }

        }

    </style>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
     Company Profile
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="company-profile-page">


        <!-- HEADER -->

        <div class="page-header">

            <h1 class="page-title">
                Company Profile
            </h1>

            <p class="page-description">
                Manage your company information
                and profile details.
            </p>

        </div>


        <!-- MESSAGE -->

        <asp:Label
            ID="lblMessage"
            runat="server"
            Visible="false">
        </asp:Label>


        <!-- COMPANY SELECTOR -->

        <div class="profile-card">

            <h2 class="section-title">
                Select Company
            </h2>


            <div class="company-selector">


                <div class="form-group">

                    <label class="form-label">
                        Company
                    </label>

                    <asp:DropDownList
                        ID="ddlCompany"
                        runat="server"
                        CssClass="form-control"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged">
                    </asp:DropDownList>

                </div>


                <asp:Button
                    ID="btnLoadCompany"
                    runat="server"
                    Text="Load Profile"
                    CssClass="btn btn-primary"
                    CausesValidation="false"
                    OnClick="btnLoadCompany_Click" />

            </div>

        </div>


        <!-- COMPANY PROFILE -->

        <div
            class="profile-card"
            id="profileSection"
            runat="server">


            <div class="profile-top">


                <asp:Image
                    ID="imgCompanyLogo"
                    runat="server"
                    CssClass="company-logo"
                    Visible="false" />


                <div
                    id="divLogoPlaceholder"
                    runat="server"
                    class="logo-placeholder">

                    <i class="bi bi-building"></i>

                </div>


                <div class="company-heading">

                    <h2>

                        <asp:Label
                            ID="lblCompanyHeading"
                            runat="server"
                            Text="Company Profile">
                        </asp:Label>

                    </h2>

                    <p>
                        Update company information below.
                    </p>

                </div>

            </div>


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
                        MaxLength="300">
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
                        MaxLength="500">
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
                        MaxLength="200">
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
                        TextMode="Number">
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
                        MaxLength="500">
                    </asp:TextBox>

                </div>


                <!-- DESCRIPTION -->

                <div class="form-group full">

                    <label class="form-label">
                        Description
                    </label>

                    <asp:TextBox
                        ID="txtDescription"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine">
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
                        MaxLength="500">
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
                        MaxLength="200">
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
                        MaxLength="200">
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
                        MaxLength="20">
                    </asp:TextBox>

                </div>


            </div>


            <!-- STATUS -->

            <div class="status-row"
                 style="margin-top:20px;">


                <div class="status-box">

                    <span class="status-label">
                        Verification
                    </span>

                    <asp:Label
                        ID="lblVerification"
                        runat="server"
                        CssClass="status-value">
                    </asp:Label>

                </div>


                <div class="status-box">

                    <span class="status-label">
                        Status
                    </span>

                    <asp:Label
                        ID="lblActiveStatus"
                        runat="server"
                        CssClass="status-value">
                    </asp:Label>

                </div>


            </div>


            <!-- ACTIONS -->

            <div class="action-row">


                <asp:Button
                    ID="btnCancel"
                    runat="server"
                    Text="Reset"
                    CssClass="btn btn-secondary"
                    CausesValidation="false"
                    OnClick="btnCancel_Click" />


                <asp:Button
                    ID="btnSave"
                    runat="server"
                    Text="Save Changes"
                    CssClass="btn btn-primary"
                    OnClick="btnSave_Click" />

            </div>


        </div>


    </div>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
