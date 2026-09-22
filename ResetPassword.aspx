<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="Success24_Job_Portal.ResetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f5f7fb;
        }

        .page-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 25px;
        }

        .reset-card {
            width: 100%;
            max-width: 460px;
            background: #ffffff;
            border-radius: 16px;
            padding: 35px;
            box-shadow: 0 10px 35px rgba(0,0,0,0.08);
        }

        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo h1 {
            margin: 0;
            color: #2563eb;
            font-size: 30px;
        }

        .title {
            text-align: center;
            margin-bottom: 8px;
            color: #111827;
            font-size: 24px;
            font-weight: 700;
        }

        .subtitle {
            text-align: center;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .message {
            display: block;
            padding: 12px 14px;
            border-radius: 8px;
            margin-bottom: 18px;
            font-size: 14px;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-label {
            display: block;
            margin-bottom: 7px;
            color: #374151;
            font-size: 14px;
            font-weight: 600;
        }

        .form-control {
            width: 100%;
            height: 48px;
            padding: 0 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
        }

        .form-control:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.10);
        }

        .password-hint {
            margin-top: 6px;
            color: #6b7280;
            font-size: 12px;
            line-height: 1.5;
        }

        .field-error {
            display: block;
            color: #dc2626;
            font-size: 12px;
            margin-top: 5px;
        }

        .btn-primary {
            width: 100%;
            height: 48px;
            border: none;
            border-radius: 8px;
            background: #2563eb;
            color: #ffffff;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-primary:hover {
            background: #1d4ed8;
        }

        .back-login {
            text-align: center;
            margin-top: 22px;
        }

        .back-login a {
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }

        .back-login a:hover {
            text-decoration: underline;
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="page-wrapper">

        <div class="reset-card">

            <div class="logo">
                <h1>Naukari24</h1>
            </div>

            <div class="title">
                Reset Password
            </div>

            <div class="subtitle">
                Create a new password for your Naukari24 account.
            </div>


            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message"
                Visible="false">
            </asp:Label>


            <!-- NEW PASSWORD -->

            <div class="form-group">

                <asp:Label
                    ID="lblNewPassword"
                    runat="server"
                    Text="New Password"
                    CssClass="form-label">
                </asp:Label>

                <asp:TextBox
                    ID="txtNewPassword"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                    MaxLength="100"
                    placeholder="Enter new password">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    ID="rfvNewPassword"
                    runat="server"
                    ControlToValidate="txtNewPassword"
                    ErrorMessage="Please enter a new password."
                    CssClass="field-error"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>

                <asp:RegularExpressionValidator
                    ID="revNewPassword"
                    runat="server"
                    ControlToValidate="txtNewPassword"
                    ValidationExpression="^(?=.*[A-Za-z])(?=.*\d).{8,100}$"
                    ErrorMessage="Password must be at least 8 characters and contain a letter and a number."
                    CssClass="field-error"
                    Display="Dynamic">
                </asp:RegularExpressionValidator>

                <div class="password-hint">
                    Minimum 8 characters with at least one letter and one number.
                </div>

            </div>


            <!-- CONFIRM PASSWORD -->

            <div class="form-group">

                <asp:Label
                    ID="lblConfirmPassword"
                    runat="server"
                    Text="Confirm Password"
                    CssClass="form-label">
                </asp:Label>

                <asp:TextBox
                    ID="txtConfirmPassword"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                    MaxLength="100"
                    placeholder="Confirm new password">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    ID="rfvConfirmPassword"
                    runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ErrorMessage="Please confirm your password."
                    CssClass="field-error"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>

                <asp:CompareValidator
                    ID="cvPassword"
                    runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtNewPassword"
                    Operator="Equal"
                    Type="String"
                    ErrorMessage="Passwords do not match."
                    CssClass="field-error"
                    Display="Dynamic">
                </asp:CompareValidator>

            </div>


            <!-- RESET -->

            <asp:Button
                ID="btnResetPassword"
                runat="server"
                Text="Reset Password"
                CssClass="btn-primary"
                OnClick="btnResetPassword_Click" />


            <div class="back-login">

                <a href="Login.aspx">
                    ← Back to Login
                </a>

            </div>

        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
