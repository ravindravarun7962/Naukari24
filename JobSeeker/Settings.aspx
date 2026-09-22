<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="Success24_Job_Portal.JobSeeker.Settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
        .settings-header {
            margin-bottom: 25px;
        }

        .settings-header h2 {
            font-weight: 700;
            margin-bottom: 5px;
        }

        .settings-header p {
            color: #6c757d;
            margin-bottom: 0;
        }

        .settings-card {
            background: #fff;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            margin-bottom: 20px;
            overflow: hidden;
        }

        .settings-card-header {
            padding: 18px 20px;
            border-bottom: 1px solid #e9ecef;
        }

        .settings-card-header h5 {
            font-weight: 700;
            margin: 0;
        }

        .settings-card-header p {
            color: #6c757d;
            font-size: 13px;
            margin: 5px 0 0;
        }


        .settings-card-body {
            padding: 20px;
        }

        .form-label {
            font-weight: 600;
            font-size: 14px;
        }

        .form-control {
            border-radius: 7px;
            padding: 10px 12px;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #86b7fe;
        }

        .readonly-field {
            background-color: #f8f9fa;
        }

        .settings-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .settings-row:last-child {
            border-bottom: none;
        }

        .settings-row-title {
            font-weight: 600;
            font-size: 14px;
        }

        .settings-row-description {
            color: #6c757d;
            font-size: 13px;
            margin-top: 3px;
        }

        .password-message {
            font-size: 13px;
        }

        .danger-card {
            border-color: #f1c7cb;
        }

        .danger-card .settings-card-header {
            background: #fff8f8;
        }

        .danger-title {
            color: #dc3545;
        }

        .alert-message {
            border-radius: 7px;
            font-size: 14px;
        }

        @media (max-width: 767px) {

            .settings-card-body {
                padding: 15px;
            }

            .settings-card-header {
                padding: 15px;
            }

            .settings-row {
                align-items: flex-start;
            }
        }

        .settings-switch {
    position: relative;
    display: inline-block;
    width: 48px;
    height: 26px;
    margin: 0;
    cursor: pointer;
}

.settings-switch input {
    opacity: 0;
    width: 0;
    height: 0;
    position: absolute;
}

.switch-slider {
    position: absolute;
    cursor: pointer;
    inset: 0;
    background-color: #ced4da;
    border-radius: 30px;
    transition: 0.25s;
}

.switch-slider:before {
    content: "";
    position: absolute;
    height: 20px;
    width: 20px;
    left: 3px;
    top: 3px;
    background-color: #fff;
    border-radius: 50%;
    transition: 0.25s;
    box-shadow: 0 1px 3px rgba(0,0,0,0.2);
}

.settings-switch input:checked + .switch-slider {
    background-color: #0d6efd;
}

.settings-switch input:checked + .switch-slider:before {
    transform: translateX(22px);
}

    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid py-4">

        <div class="settings-header">

            <h2>Settings</h2>

            <p>
                Manage your account and application preferences.
            </p>

        </div>

        <asp:Panel
            ID="pnlMessage"
            runat="server"
            Visible="false">

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="alert alert-message d-block">
            </asp:Label>

        </asp:Panel>

        <!-- Account Information -->

        <div class="settings-card">

            <div class="settings-card-header">

                <h5>
                    <i class="bi bi-person-circle me-2"></i>
                    Account Information
                </h5>

                <p>
                    Your basic account information.
                </p>

            </div>

            <div class="settings-card-body">

                <div class="row">

                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Full Name
                        </label>

                        <asp:TextBox
                            ID="txtFullName"
                            runat="server"
                            CssClass="form-control"
                            MaxLength="100">
                        </asp:TextBox>

                    </div>

                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Email Address
                        </label>

                        <asp:TextBox
                            ID="txtEmail"
                            runat="server"
                            CssClass="form-control readonly-field"
                            ReadOnly="true">
                        </asp:TextBox>

                    </div>

                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Mobile Number
                        </label>

                        <asp:TextBox
                            ID="txtMobile"
                            runat="server"
                            CssClass="form-control readonly-field"
                            ReadOnly="true">
                        </asp:TextBox>

                    </div>

                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Account Status
                        </label>

                        <asp:TextBox
                            ID="txtAccountStatus"
                            runat="server"
                            CssClass="form-control readonly-field"
                            ReadOnly="true">
                        </asp:TextBox>

                    </div>

                </div>

                <asp:Button
                    ID="btnSaveAccount"
                    runat="server"
                    Text="Save Changes"
                    CssClass="btn btn-primary"
                    OnClick="btnSaveAccount_Click" />

            </div>

        </div>

        <!-- Change Password -->

        <div class="settings-card">

            <div class="settings-card-header">

                <h5>
                    <i class="bi bi-shield-lock me-2"></i>
                    Change Password
                </h5>

                <p>
                    Update your password to keep your account secure.
                </p>

            </div>

            <div class="settings-card-body">

                <div class="row">

                    <div class="col-md-4 mb-3">

                        <label class="form-label">
                            Current Password
                        </label>

                        <asp:TextBox
                            ID="txtCurrentPassword"
                            runat="server"
                            TextMode="Password"
                            CssClass="form-control"
                            MaxLength="100">
                        </asp:TextBox>

                    </div>

                    <div class="col-md-4 mb-3">

                        <label class="form-label">
                            New Password
                        </label>

                        <asp:TextBox
                            ID="txtNewPassword"
                            runat="server"
                            TextMode="Password"
                            CssClass="form-control"
                            MaxLength="100">
                        </asp:TextBox>

                    </div>

                    <div class="col-md-4 mb-3">

                        <label class="form-label">
                            Confirm Password
                        </label>

                        <asp:TextBox
                            ID="txtConfirmPassword"
                            runat="server"
                            TextMode="Password"
                            CssClass="form-control"
                            MaxLength="100">
                        </asp:TextBox>

                    </div>

                </div>

                <asp:Button
                    ID="btnChangePassword"
                    runat="server"
                    Text="Change Password"
                    CssClass="btn btn-primary"
                    OnClick="btnChangePassword_Click" />

            </div>

        </div>

<!-- Notification Preferences -->

<div class="settings-card">

    <div class="settings-card-header">

        <h5>
            <i class="bi bi-bell me-2"></i>
            Notification Preferences
        </h5>

        <p>
            Choose which notifications you want to receive.
        </p>

    </div>

    <div class="settings-card-body">

        <div class="settings-row">

            <div>

                <div class="settings-row-title">
                    Job Alerts
                </div>

                <div class="settings-row-description">
                    Receive notifications about new jobs.
                </div>

            </div>

            <label class="settings-switch">

                <asp:CheckBox
                    ID="chkJobAlerts"
                    runat="server"
                    Checked="true" />

                <span class="switch-slider"></span>

            </label>

        </div>

        <div class="settings-row">

            <div>

                <div class="settings-row-title">
                    Application Updates
                </div>

                <div class="settings-row-description">
                    Get updates about your job applications.
                </div>

            </div>

            <label class="settings-switch">

                <asp:CheckBox
                    ID="chkApplicationUpdates"
                    runat="server"
                    Checked="true" />

                <span class="switch-slider"></span>

            </label>

        </div>

        <div class="settings-row">

            <div>

                <div class="settings-row-title">
                    Interview Notifications
                </div>

                <div class="settings-row-description">
                    Receive reminders and updates about interviews.
                </div>

            </div>

            <label class="settings-switch">

                <asp:CheckBox
                    ID="chkInterviewNotifications"
                    runat="server"
                    Checked="true" />

                <span class="switch-slider"></span>

            </label>

        </div>

        <div class="mt-3">

            <asp:Button
                ID="btnSaveNotifications"
                runat="server"
                Text="Save Preferences"
                CssClass="btn btn-primary"
                OnClick="btnSaveNotifications_Click" />

        </div>

    </div>

</div>


        <!-- Account -->

        <div class="settings-card danger-card">

            <div class="settings-card-header">

                <h5 class="danger-title">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    Account
                </h5>

                <p>
                    Manage your account status.
                </p>

            </div>

            <div class="settings-card-body">

                <div class="settings-row">

                    <div>

                        <div class="settings-row-title">
                            Deactivate Account
                        </div>

                        <div class="settings-row-description">
                            Temporarily deactivate your account.
                        </div>

                    </div>

                    <asp:Button
                        ID="btnDeactivate"
                        runat="server"
                        Text="Deactivate"
                        CssClass="btn btn-outline-danger"
                        OnClick="btnDeactivate_Click"
                        OnClientClick="return confirm('Are you sure you want to deactivate your account?');" />

                </div>

            </div>

        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
