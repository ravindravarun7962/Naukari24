<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="RecruiterRegister.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.RecruiterRegister" %>
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

            padding: 30px 15px;
        }

        .register-wrapper {
            width: 100%;
            max-width: 850px;
        }

        .register-card {
            background: #fff;

            border: 1px solid #e5e7eb;

            border-radius: 18px;

            overflow: hidden;

            box-shadow:
                0 15px 40px
                rgba(0, 0, 0, .06);
        }

        .register-header {
            padding: 28px 32px;

            border-bottom:
                1px solid #f0f1f3;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 11px;

            margin-bottom: 22px;
        }

        .brand-icon {
            width: 40px;
            height: 40px;

            border-radius: 10px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #111827;
            color: #fff;

            font-size: 19px;
        }

        .brand-name {
            font-size: 17px;
            font-weight: 700;
            color: #111827;
        }

        .brand-subtitle {
            display: block;

            font-size: 10px;
            color: #9ca3af;
        }

        .register-header h1 {
            margin: 0 0 7px;

            font-size: 27px;
            color: #111827;
        }

        .register-header p {
            margin: 0;

            color: #6b7280;

            font-size: 14px;
        }

        .register-body {
            padding: 30px 32px;
        }

        .section-title {
            margin: 0 0 18px;

            font-size: 18px;
            color: #111827;
        }

        .form-grid {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 18px;
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
            font-size: 13px;
            font-weight: 600;
            color: #374151;
        }

        .form-control {
            width: 100%;

            height: 45px;

            border: 1px solid #d1d5db;

            border-radius: 9px;

            padding: 0 12px;

            font-size: 14px;

            outline: none;
        }

        .form-control:focus {
            border-color: #6b7280;
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper .form-control {
            padding-right: 45px;
        }

        .password-toggle {
            position: absolute;

            right: 13px;
            top: 50%;

            transform:
                translateY(-50%);

            border: 0;
            background: transparent;

            color: #6b7280;

            cursor: pointer;
        }

        .form-help {
            font-size: 11px;
            color: #9ca3af;
        }

        .register-footer {
            padding: 0 32px 30px;
        }

        .register-btn {
            width: 100%;

            height: 48px;

            border: 0;

            border-radius: 9px;

            background: #111827;
            color: #fff;

            font-size: 14px;
            font-weight: 700;

            cursor: pointer;
        }

        .register-btn:hover {
            background: #1f2937;
        }

        .login-link {
            margin-top: 18px;

            text-align: center;

            font-size: 13px;

            color: #6b7280;
        }

        .login-link a {
            color: #111827;

            font-weight: 600;

            text-decoration: none;
        }

        .message {
            display: block;

            margin-bottom: 20px;

            padding: 12px 14px;

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

        @media (max-width: 650px) {

            .register-header,
            .register-body {
                padding: 22px;
            }

            .register-footer {
                padding:
                    0 22px 22px;
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
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
        <div class="register-wrapper">


        <div class="register-card">


            <!-- HEADER -->

            <div class="register-header">

                <div class="brand">

                    <div class="brand-icon">

                        <i class="bi bi-briefcase-fill"></i>

                    </div>

                    <div>

                        <div class="brand-name">
                            Naukari
                        </div>

                        <span class="brand-subtitle">
                            Recruiter Portal
                        </span>

                    </div>

                </div>


                <h1>
                    Create Recruiter Account
                </h1>

                <p>
                    Register your recruiter account
                    to post and manage jobs.
                </p>

            </div>


            <!-- BODY -->

            <div class="register-body">


                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    Visible="false">
                </asp:Label>


                <h2 class="section-title">
                    Account Information
                </h2>


                <div class="form-grid">


                    <!-- FULL NAME -->

                    <div class="form-group">

                        <label class="form-label">
                            Full Name *
                        </label>

                        <asp:TextBox
                            ID="txtFullName"
                            runat="server"
                            CssClass="form-control"
                            MaxLength="200"
                            placeholder="Enter your full name">
                        </asp:TextBox>

                    </div>


                    <!-- EMAIL -->

                    <div class="form-group">

                        <label class="form-label">
                            Email Address *
                        </label>

                        <asp:TextBox
                            ID="txtEmail"
                            runat="server"
                            CssClass="form-control"
                            MaxLength="250"
                            TextMode="Email"
                            placeholder="name@company.com">
                        </asp:TextBox>

                    </div>


                    <!-- PHONE -->

                    <div class="form-group">

                        <label class="form-label">
                            Phone Number
                        </label>

                        <asp:TextBox
                            ID="txtPhone"
                            runat="server"
                            CssClass="form-control"
                            MaxLength="30"
                            placeholder="Enter phone number">
                        </asp:TextBox>

                    </div>


                    <!-- DESIGNATION -->

                    <div class="form-group">

                        <label class="form-label">
                            Designation
                        </label>

                        <asp:TextBox
                            ID="txtDesignation"
                            runat="server"
                            CssClass="form-control"
                            MaxLength="200"
                            placeholder="e.g. HR Manager">
                        </asp:TextBox>

                    </div>


                    <!-- PASSWORD -->

                    <div class="form-group">

                        <label class="form-label">
                            Password *
                        </label>

                        <div class="password-wrapper">

                            <asp:TextBox
                                ID="txtPassword"
                                runat="server"
                                CssClass="form-control"
                                TextMode="Password"
                                MaxLength="100"
                                placeholder="Create password">
                            </asp:TextBox>

                            <button
                                type="button"
                                class="password-toggle"
                                onclick="togglePassword('txtPassword', this)">

                                <i class="bi bi-eye"></i>

                            </button>

                        </div>

                    </div>


                    <!-- CONFIRM PASSWORD -->

                    <div class="form-group">

                        <label class="form-label">
                            Confirm Password *
                        </label>

                        <div class="password-wrapper">

                            <asp:TextBox
                                ID="txtConfirmPassword"
                                runat="server"
                                CssClass="form-control"
                                TextMode="Password"
                                MaxLength="100"
                                placeholder="Confirm password">
                            </asp:TextBox>

                            <button
                                type="button"
                                class="password-toggle"
                                onclick="togglePassword('txtConfirmPassword', this)">

                                <i class="bi bi-eye"></i>

                            </button>

                        </div>

                    </div>

                </div>

            </div>


            <!-- FOOTER -->

            <div class="register-footer">

                <asp:Button
                    ID="btnRegister"
                    runat="server"
                    Text="Create Recruiter Account"
                    CssClass="register-btn"
                    OnClick="btnRegister_Click" />


                <div class="login-link">

                    Already have an account?

                    <a href="Login.aspx">
                        Login here
                    </a>

                </div>

            </div>


        </div>

    </div>


</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
        <script>

        function togglePassword(
            controlId,
            button
        ) {

            var input =
                document.getElementById(
                    controlId
                );

            var icon =
                button.querySelector(
                    "i"
                );


            if (
                input.type === "password"
            ) {

                input.type = "text";

                icon.className =
                    "bi bi-eye-slash";

            }
            else {

                input.type = "password";

                icon.className =
                    "bi bi-eye";

            }

        }

        </script>


</asp:Content>
