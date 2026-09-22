<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VerifyPasswordOTP.aspx.cs" Inherits="Success24_Job_Portal.VerifyPasswordOTP" %>
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

        .otp-card {
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

        .email-display {
            text-align: center;
            color: #374151;
            font-size: 14px;
            margin-bottom: 22px;
        }

        .email-display strong {
            color: #2563eb;
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

        .otp-input {
            width: 100%;
            height: 56px;
            padding: 0 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 24px;
            text-align: center;
            letter-spacing: 10px;
            font-weight: 700;
            outline: none;
        }

        .otp-input:focus {
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

        .resend-section {
            text-align: center;
            margin-top: 20px;
            color: #6b7280;
            font-size: 14px;
        }

        .resend-button {
            border: none;
            background: transparent;
            color: #2563eb;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            padding: 0;
        }

        .resend-button:hover {
            text-decoration: underline;
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

        <div class="otp-card">

            <div class="logo">
                <h1>Naukari24</h1>
            </div>

            <div class="title">
                Verify Your Email
            </div>

            <div class="subtitle">
                Enter the 6-digit verification code sent
                to your registered email address.
            </div>


            <asp:Label
                ID="lblEmail"
                runat="server"
                CssClass="email-display">
            </asp:Label>


            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message"
                Visible="false">
            </asp:Label>


            <!-- OTP -->

            <div class="form-group">

                <asp:Label
                    ID="lblOTP"
                    runat="server"
                    Text="Verification Code"
                    CssClass="form-label">
                </asp:Label>

                <asp:TextBox
                    ID="txtOTP"
                    runat="server"
                    CssClass="otp-input"
                    MaxLength="6"
                    TextMode="SingleLine"
                    autocomplete="one-time-code"
                    placeholder="000000">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    ID="rfvOTP"
                    runat="server"
                    ControlToValidate="txtOTP"
                    ErrorMessage="Please enter the verification code."
                    CssClass="field-error"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>

                <asp:RegularExpressionValidator
                    ID="revOTP"
                    runat="server"
                    ControlToValidate="txtOTP"
                    ValidationExpression="^[0-9]{6}$"
                    ErrorMessage="Please enter a valid 6-digit code."
                    CssClass="field-error"
                    Display="Dynamic">
                </asp:RegularExpressionValidator>

            </div>


            <!-- VERIFY -->

            <asp:Button
                ID="btnVerifyOTP"
                runat="server"
                Text="Verify Code"
                CssClass="btn-primary"
                OnClick="btnVerifyOTP_Click" />


            <!-- RESEND -->

            <div class="resend-section">

                Didn't receive the code?

                <asp:Button
                    ID="btnResendOTP"
                    runat="server"
                    Text="Resend OTP"
                    CssClass="resend-button"
                    CausesValidation="false"
                    OnClick="btnResendOTP_Click" />

            </div>


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
