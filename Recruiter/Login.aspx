<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
        <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;

            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            background: #f5f7fb;

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 20px;
        }

        .login-container {
            width: 100%;
            max-width: 430px;
        }

        .login-card {
            background: #fff;

            border: 1px solid #e5e7eb;

            border-radius: 18px;

            padding: 35px;

            box-shadow:
                0 15px 40px
                rgba(0, 0, 0, .06);
        }

        .brand {
            text-align: center;

            margin-bottom: 28px;
        }

        .brand-icon {
            width: 56px;
            height: 56px;

            margin: 0 auto 14px;

            border-radius: 14px;

            background: #111827;
            color: #fff;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 24px;
        }

        .brand h1 {
            margin: 0 0 7px;

            font-size: 26px;

            color: #111827;
        }

        .brand p {
            margin: 0;

            color: #6b7280;

            font-size: 14px;
        }

        .message {
            display: block;

            padding: 11px 13px;

            margin-bottom: 18px;

            border-radius: 8px;

            font-size: 13px;
        }

        .error {
            background: #fef2f2;

            color: #b91c1c;
        }

        .success {
            background: #ecfdf5;

            color: #047857;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-label {
            display: block;

            margin-bottom: 7px;

            font-size: 13px;

            font-weight: 600;

            color: #374151;
        }

        .form-control {
            width: 100%;

            height: 46px;

            border:
                1px solid #d1d5db;

            border-radius: 9px;

            padding:
                0 13px;

            font-size: 14px;

            outline: none;
        }

        .form-control:focus {
            border-color: #111827;
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper .form-control {
            padding-right: 45px;
        }

        .password-toggle {
            position: absolute;

            right: 12px;
            top: 50%;

            transform:
                translateY(-50%);

            border: 0;

            background: transparent;

            color: #6b7280;

            cursor: pointer;

            font-size: 16px;
        }

        .login-btn {
            width: 100%;

            height: 47px;

            margin-top: 5px;

            border: 0;

            border-radius: 9px;

            background: #111827;

            color: #fff;

            font-size: 14px;

            font-weight: 700;

            cursor: pointer;
        }

        .login-btn:hover {
            background: #1f2937;
        }

        .register-link {
            margin-top: 22px;

            text-align: center;

            color: #6b7280;

            font-size: 13px;
        }

        .register-link a {
            color: #111827;

            font-weight: 600;

            text-decoration: none;
        }

        .back-home {
            display: block;

            margin-top: 15px;

            text-align: center;

            color: #9ca3af;

            font-size: 12px;

            text-decoration: none;
        }

        @media(max-width:500px) {

            .login-card {
                padding: 27px 20px;
            }

        }

    </style>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-container">


        <div class="login-card">


            <!-- BRAND -->

            <div class="brand">

                <div class="brand-icon">

                    <i class="bi bi-briefcase-fill"></i>

                </div>


                <h1>
                    Recruiter Login
                </h1>


                <p>
                    Login to manage your jobs
                    and applications.
                </p>

            </div>


            <!-- MESSAGE -->

            <asp:Label
                ID="lblMessage"
                runat="server"
                Visible="false">
            </asp:Label>


            <!-- EMAIL -->

            <div class="form-group">

                <label class="form-label">
                    Email Address
                </label>

                <asp:TextBox
                    ID="txtEmail"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Email"
                    MaxLength="250"
                    placeholder="name@company.com">
                </asp:TextBox>

            </div>


            <!-- PASSWORD -->

            <div class="form-group">

                <label class="form-label">
                    Password
                </label>


                <div class="password-wrapper">

                    <asp:TextBox
                        ID="txtPassword"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Password"
                        MaxLength="100"
                        placeholder="Enter your password">
                    </asp:TextBox>


                    <button
                        type="button"
                        class="password-toggle"
                        onclick="togglePassword()">

                        <i
                            id="passwordIcon"
                            class="bi bi-eye">
                        </i>

                    </button>

                </div>

            </div>


            <!-- LOGIN -->

            <asp:Button
                ID="btnLogin"
                runat="server"
                Text="Login"
                CssClass="login-btn"
                OnClick="btnLogin_Click" />


            <!-- REGISTER -->

            <div class="register-link">

                Don't have a recruiter account?

                <a href="RecruiterRegister.aspx">
                    Register
                </a>

            </div>


            <a
                href="../Default.aspx"
                class="back-home">

                ← Back to website

            </a>


        </div>

    </div>


</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
        <script>

function togglePassword() {

    var password =
                document.getElementById(
                    '<%= txtPassword.ClientID %>'
                );

            var icon =
                document.getElementById(
                    'passwordIcon'
                );


            if (
                password.type === "password"
            ) {

                password.type = "text";

                icon.className =
                    "bi bi-eye-slash";

            }
            else {

                password.type = "password";

                icon.className =
                    "bi bi-eye";

            }

        }

        </script>


</asp:Content>
