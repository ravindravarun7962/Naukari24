<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Success24_Job_Portal.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>

        .login-section {
            min-height: 78vh;
            display: flex;
            align-items: center;
            padding: 70px 15px;
            background:
                radial-gradient(circle at 15% 20%,
                    rgba(37,87,167,.07),
                    transparent 28%),
                #f7f9fc;
        }

        .login-wrapper {
            max-width: 470px;
            margin: auto;
        }

        .login-card {
            background: #fff;
            border: 1px solid #e5e9f0;
            border-radius: 18px;
            padding: 40px;
            box-shadow: 0 18px 50px rgba(25,45,75,.08);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 17px;
            border-radius: 16px;
            background: #edf4ff;
            color: #2557a7;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 25px;
        }

        .login-header h1 {
            color: #172033;
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 8px;
        }

        .login-header p {
            color: #7a8494;
            font-size: 14px;
            margin: 0;
        }


        /* FORM */

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            color: #374151;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 7px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper > i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #8b95a5;
            font-size: 16px;
            z-index: 2;
        }

        .auth-input {
            width: 100%;
            height: 49px;
            border: 1px solid #dce2ea;
            border-radius: 9px;
            padding: 0 45px;
            outline: none;
            color: #303846;
            font-size: 14px;
            transition: .2s;
        }

        .auth-input:focus {
            border-color: #2557a7;
            box-shadow: 0 0 0 3px rgba(37,87,167,.08);
        }

        .password-toggle {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            border: 0;
            background: transparent;
            color: #7a8494;
            padding: 0;
            font-size: 17px;
        }


        /* VALIDATION */

        .validation-message {
            display: block;
            color: #dc3545;
            font-size: 11px;
            margin-top: 5px;
        }

        .server-message {
            display: block;
            padding: 11px 13px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 20px;
        }

        .server-message:empty {
            display: none;
        }


        /* OPTIONS */

        .login-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 4px 0 23px;
            font-size: 12px;
            color: #687385;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 7px;
        }

        .forgot-link {
            color: #2557a7;
            font-weight: 600;
        }

        .forgot-link:hover {
            text-decoration: underline;
        }


        /* LOGIN BUTTON */

        .login-btn {
            width: 100%;
            height: 49px;
            border: 0;
            border-radius: 9px;
            background: #2557a7;
            color: white;
            font-size: 14px;
            font-weight: 700;
            transition: .2s;
        }

        .login-btn:hover {
            background: #17478f;
        }


        /* REGISTER */

        .register-link {
            text-align: center;
            color: #6b7280;
            font-size: 13px;
            margin-top: 24px;
        }

        .register-link a {
            color: #2557a7;
            font-weight: 700;
        }

        .register-link a:hover {
            text-decoration: underline;
        }


        /* DIVIDER */

        .login-divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 25px 0 20px;
            color: #a0a7b2;
            font-size: 11px;
        }

        .login-divider::before,
        .login-divider::after {
            content: "";
            height: 1px;
            background: #e5e9f0;
            flex: 1;
        }


        .employer-login {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 46px;
            border-radius: 9px;
            border: 1px solid #dce2ea;
            color: #374151;
            font-size: 13px;
            font-weight: 600;
            transition: .2s;
        }

        .employer-login i {
            color: #2557a7;
            margin-right: 7px;
        }

        .employer-login:hover {
            background: #f7f9fc;
            border-color: #cbd5e1;
            color: #2557a7;
        }


        @media(max-width:576px) {

            .login-section {
                padding: 40px 12px;
            }

            .login-card {
                padding: 28px 20px;
            }

            .login-options {
                align-items: flex-start;
            }

        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="login-section">

        <div class="container">

            <div class="login-wrapper">

                <div class="login-card">


                    <!-- HEADER -->

                    <div class="login-header">

                        <div class="login-icon">

                            <i class="bi bi-person-check"></i>

                        </div>

                        <h1>
                            Welcome back
                        </h1>

                        <p>
                            Login to continue to your NAUKARI24 account.
                        </p>

                    </div>


                    <!-- SERVER MESSAGE -->

                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        CssClass="server-message">
                    </asp:Label>


                    <!-- EMAIL -->

                    <div class="form-group">

                        <label class="form-label">
                            Email Address
                        </label>

                        <div class="input-wrapper">

                            <i class="bi bi-envelope"></i>

                            <asp:TextBox
                                ID="txtEmail"
                                runat="server"
                                CssClass="auth-input"
                                TextMode="Email"
                                MaxLength="150"
                                placeholder="name@example.com">
                            </asp:TextBox>

                        </div>


                        <asp:RequiredFieldValidator
                            ID="rfvEmail"
                            runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="Please enter your email address."
                            CssClass="validation-message"
                            ValidationGroup="Login"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>

                    </div>


                    <!-- PASSWORD -->

                    <div class="form-group">

                        <label class="form-label">
                            Password
                        </label>

                        <div class="input-wrapper">

                            <i class="bi bi-lock"></i>

                            <asp:TextBox
                                ID="txtPassword"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="auth-input"
                                TextMode="Password"
                                MaxLength="100"
                                placeholder="Enter your password">
                            </asp:TextBox>


                            <button type="button"
                                    class="password-toggle"
                                    onclick="togglePassword()">

                                <i id="passwordIcon"
                                   class="bi bi-eye">
                                </i>

                            </button>

                        </div>


                        <asp:RequiredFieldValidator
                            ID="rfvPassword"
                            runat="server"
                            ControlToValidate="txtPassword"
                            ErrorMessage="Please enter your password."
                            CssClass="validation-message"
                            ValidationGroup="Login"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>

                    </div>


                    <!-- OPTIONS -->

                    <div class="login-options">

                        <div class="remember-me">

                            <asp:CheckBox
                                ID="chkRemember"
                                runat="server" />

                            <span>
                                Remember me
                            </span>

                        </div>


                        <a href="<%= ResolveUrl("~/ForgotPassword.aspx") %>"
                           class="forgot-link">

                            Forgot password?

                        </a>

                    </div>


                    <!-- LOGIN BUTTON -->

                    <asp:Button
                        ID="btnLogin"
                        runat="server"
                        Text="Login"
                        CssClass="login-btn"
                        ValidationGroup="Login"
                        OnClick="btnLogin_Click" />


                    <!-- REGISTER -->

                    <div class="register-link">

                        Don't have an account?

                        <a href="<%= ResolveUrl("~/Register.aspx") %>">

                            Create account

                        </a>

                    </div>


                    <div class="login-divider">

                        EMPLOYER

                    </div>


                    <a href="<%= ResolveUrl("~/Recruiter/RecruiterRegister.aspx") %>"
                       class="employer-login">

                        <i class="bi bi-building"></i>

                        Create an Employer Account

                    </a>


                </div>

            </div>

        </div>

    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
        <script>

        function togglePassword() {

            var input =
                document.getElementById("txtPassword");

            var icon =
                document.getElementById("passwordIcon");


            if (input.type === "password") {

                input.type = "text";

                icon.classList.remove("bi-eye");
                icon.classList.add("bi-eye-slash");

            }
            else {

                input.type = "password";

                icon.classList.remove("bi-eye-slash");
                icon.classList.add("bi-eye");

            }
        }

    </script>


</asp:Content>
