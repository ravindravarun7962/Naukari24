<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JobSeekerRegister.aspx.cs" Inherits="Success24_Job_Portal.JobSeekerRegister" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>

        .auth-section {
            padding: 70px 0;
            min-height: 80vh;
            background: #f7f9fc;
        }

        .register-wrapper {
            max-width: 570px;
            margin: auto;
        }

        .register-card {
            background: #fff;
            border: 1px solid #e5e9f0;
            border-radius: 18px;
            padding: 38px;
            box-shadow: 0 15px 45px rgba(25, 45, 75, .07);
        }

        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .register-icon {
            width: 58px;
            height: 58px;
            margin: 0 auto 16px;
            border-radius: 15px;
            background: #edf4ff;
            color: #2557a7;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 25px;
        }

        .register-header h1 {
            color: #172033;
            font-size: 27px;
            font-weight: 800;
            margin-bottom: 8px;
        }

        .register-header p {
            color: #7a8494;
            font-size: 14px;
            margin: 0;
        }

        .form-group {
            margin-bottom: 19px;
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
            height: 48px;
            padding: 0 45px;
            border: 1px solid #dce2ea;
            border-radius: 9px;
            font-size: 14px;
            color: #303846;
            outline: none;
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
            font-size: 17px;
            padding: 0;
        }

        .validation-message {
            display: block;
            color: #dc3545;
            font-size: 11px;
            margin-top: 5px;
        }

        .terms-box {
            display: flex;
            align-items: flex-start;
            gap: 8px;
            color: #687385;
            font-size: 12px;
            line-height: 1.6;
            margin: 22px 0;
        }

        .terms-box input {
            margin-top: 3px;
        }

        .terms-box a {
            color: #2557a7;
            font-weight: 600;
        }

        .register-btn {
            width: 100%;
            height: 49px;
            border: 0;
            border-radius: 9px;
            background: #2557a7;
            color: #fff;
            font-size: 14px;
            font-weight: 700;
            transition: .2s;
        }

        .register-btn:hover {
            background: #17478f;
        }

        .server-message {
            display: block;
            border-radius: 8px;
            padding: 11px 13px;
            margin-bottom: 20px;
            font-size: 13px;
        }

        .server-message:empty {
            display: none;
        }

        .login-link {
            text-align: center;
            margin-top: 24px;
            color: #6b7280;
            font-size: 13px;
        }

        .login-link a {
            color: #2557a7;
            font-weight: 700;
        }

        .employer-link {
            text-align: center;
            margin-top: 14px;
            font-size: 12px;
        }

        .employer-link a {
            color: #6b7280;
        }

        @media(max-width:576px) {

            .auth-section {
                padding: 40px 12px;
            }

            .register-card {
                padding: 27px 20px;
            }

        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="auth-section">

        <div class="container">

            <div class="register-wrapper">

                <div class="register-card">

                    <div class="register-header">

                        <div class="register-icon">
                            <i class="bi bi-person-plus"></i>
                        </div>

                        <h1>Create your account</h1>

                        <p>
                            Create your NAUKARI24 profile and start
                            finding opportunities.
                        </p>

                    </div>


                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        CssClass="server-message">
                    </asp:Label>


                    <!-- FULL NAME -->

                    <div class="form-group">

                        <label class="form-label">
                            Full Name
                        </label>

                        <div class="input-wrapper">

                            <i class="bi bi-person"></i>

                            <asp:TextBox
                                ID="txtFullName"
                                runat="server"
                                CssClass="auth-input"
                                MaxLength="100"
                                placeholder="Enter your full name">
                            </asp:TextBox>

                        </div>

                        <asp:RequiredFieldValidator
                            ID="rfvFullName"
                            runat="server"
                            ControlToValidate="txtFullName"
                            ErrorMessage="Please enter your full name."
                            CssClass="validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>

                    </div>


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
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator
                            ID="revEmail"
                            runat="server"
                            ControlToValidate="txtEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Please enter a valid email address."
                            CssClass="validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RegularExpressionValidator>

                    </div>


                    <!-- MOBILE -->

                    <div class="form-group">

                        <label class="form-label">
                            Mobile Number
                        </label>

                        <div class="input-wrapper">

                            <i class="bi bi-phone"></i>

                            <asp:TextBox
                                ID="txtMobile"
                                runat="server"
                                CssClass="auth-input"
                                MaxLength="10"
                                placeholder="10-digit mobile number">
                            </asp:TextBox>

                        </div>

                        <asp:RequiredFieldValidator
                            ID="rfvMobile"
                            runat="server"
                            ControlToValidate="txtMobile"
                            ErrorMessage="Please enter your mobile number."
                            CssClass="validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator
                            ID="revMobile"
                            runat="server"
                            ControlToValidate="txtMobile"
                            ValidationExpression="^[6-9][0-9]{9}$"
                            ErrorMessage="Please enter a valid 10-digit mobile number."
                            CssClass="validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RegularExpressionValidator>

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
                                placeholder="Minimum 8 characters">
                            </asp:TextBox>

                            <button type="button"
                                    class="password-toggle"
                                    onclick="togglePassword('txtPassword', this)">

                                <i class="bi bi-eye"></i>

                            </button>

                        </div>

                        <asp:RequiredFieldValidator
                            ID="rfvPassword"
                            runat="server"
                            ControlToValidate="txtPassword"
                            ErrorMessage="Please enter a password."
                            CssClass="validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator
                            ID="revPassword"
                            runat="server"
                            ControlToValidate="txtPassword"
                            ValidationExpression="^.{8,100}$"
                            ErrorMessage="Password must contain at least 8 characters."
                            CssClass="validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RegularExpressionValidator>

                    </div>


                    <!-- CONFIRM PASSWORD -->

                    <div class="form-group">

                        <label class="form-label">
                            Confirm Password
                        </label>

                        <div class="input-wrapper">

                            <i class="bi bi-shield-lock"></i>

                            <asp:TextBox
                                ID="txtConfirmPassword"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="auth-input"
                                TextMode="Password"
                                MaxLength="100"
                                placeholder="Enter password again">
                            </asp:TextBox>

                            <button type="button"
                                    class="password-toggle"
                                    onclick="togglePassword('txtConfirmPassword', this)">

                                <i class="bi bi-eye"></i>

                            </button>

                        </div>

                        <asp:RequiredFieldValidator
                            ID="rfvConfirmPassword"
                            runat="server"
                            ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Please confirm your password."
                            CssClass="validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>

                        <asp:CompareValidator
                            ID="cvPassword"
                            runat="server"
                            ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtPassword"
                            ErrorMessage="Passwords do not match."
                            CssClass="validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:CompareValidator>

                    </div>


                    <!-- TERMS -->

                    <div class="terms-box">

                        <asp:CheckBox
                            ID="chkTerms"
                            runat="server" />

                        <span>

                            I agree to the

                            <a href="#">
                                Terms & Conditions
                            </a>

                            and

                            <a href="#">
                                Privacy Policy
                            </a>.

                        </span>

                    </div>


                    <!-- REGISTER -->

                    <asp:Button
                        ID="btnRegister"
                        runat="server"
                        Text="Create Account"
                        CssClass="register-btn"
                        ValidationGroup="Register"
                        OnClick="btnRegister_Click" />


                    <div class="login-link">

                        Already have an account?

                        <a href="<%= ResolveUrl("~/Login.aspx") %>">
                            Login
                        </a>

                    </div>


                    <div class="employer-link">

                        <a href="<%= ResolveUrl("~/Recruiter/RecruiterRegister.aspx") %>">

                            Hiring candidates?
                            Register as an employer

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script>
            function togglePassword(inputId, button) {

            var input = document.getElementById(inputId);
            var icon = button.querySelector("i");

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
