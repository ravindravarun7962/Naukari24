<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Success24_Job_Portal.ForgotPassword" %>
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

        .forgot-card {
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

        .field-error {
            display: block;
            color: #dc2626;
            font-size: 12px;
            margin-top: 5px;
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="page-wrapper">

        <div class="forgot-card">

            <div class="logo">
                <h1>Naukari24</h1>
            </div>

            <div class="title">
                Forgot Password?
            </div>

            <div class="subtitle">
                Enter your registered email address and
                we'll send you a verification code to reset
                your password.
            </div>

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message"
                Visible="false">
            </asp:Label>


            <!-- EMAIL -->

            <div class="form-group">

                <asp:Label
                    ID="lblEmail"
                    runat="server"
                    Text="Email Address"
                    CssClass="form-label">
                </asp:Label>

                <asp:TextBox
                    ID="txtEmail"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Email"
                    MaxLength="150"
                    placeholder="Enter your registered email">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    ID="rfvEmail"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Please enter your email address."
                    CssClass="field-error"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>

                <asp:RegularExpressionValidator
                    ID="revEmail"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Please enter a valid email address."
                    CssClass="field-error"
                    Display="Dynamic">
                </asp:RegularExpressionValidator>

            </div>


            <!-- SEND OTP -->

            <asp:Button
                ID="btnSendOTP"
                runat="server"
                Text="Send Verification Code"
                CssClass="btn-primary"
                OnClick="btnSendOTP_Click" />


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
