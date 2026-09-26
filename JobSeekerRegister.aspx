<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JobSeekerRegister.aspx.cs" Inherits="Success24_Job_Portal.JobSeekerRegister" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">

        /* =========================================================
           PAGE
        ========================================================= */

        .jobseeker-register-page {
            width: 100%;

            /*
                Site.Master already contains header/navigation/footer.
                Therefore this page uses the remaining viewport area.
            */
            height: calc(100vh - 140px);

            min-height: 600px;

            padding: 14px 20px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #f6f7fb;

            overflow: hidden;
        }


        /* =========================================================
           MAIN CARD
        ========================================================= */

        .jobseeker-register-container {

            width: 100%;
            max-width: 1180px;

            height: 590px;

            display: grid;

            grid-template-columns: 42% 58%;

            background: #ffffff;

            border: 1px solid #e5e7eb;

            border-radius: 20px;

            overflow: hidden;

            box-shadow:
                0 18px 50px rgba(15, 23, 42, 0.09);
        }


        /* =========================================================
           LEFT INFORMATION PANEL
        ========================================================= */

        .jobseeker-info-panel {

            position: relative;

            background:
                linear-gradient(
                    145deg,
                    #111827 0%,
                    #1f2937 55%,
                    #374151 100%
                );

            color: #ffffff;

            padding: 38px 38px 30px;

            display: flex;

            flex-direction: column;

            justify-content: space-between;

            overflow: hidden;
        }


        /* Decorative circle */

        .jobseeker-info-panel::before {

            content: "";

            position: absolute;

            width: 300px;
            height: 300px;

            border-radius: 50%;

            background:
                rgba(255,255,255,0.035);

            top: -145px;
            right: -100px;
        }


        .jobseeker-info-panel::after {

            content: "";

            position: absolute;

            width: 230px;
            height: 230px;

            border-radius: 50%;

            background:
                rgba(255,255,255,0.025);

            bottom: -125px;
            left: -105px;
        }


        .jobseeker-info-content,
        .jobseeker-info-bottom {

            position: relative;

            z-index: 2;
        }


        /* =========================================================
           BRAND
        ========================================================= */

        .jobseeker-brand {

            display: flex;

            align-items: center;

            gap: 11px;

            margin-bottom: 38px;
        }


        .jobseeker-brand-icon {

            width: 40px;
            height: 40px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 10px;

            background: #ffffff;

            color: #111827;

            font-size: 18px;
        }


        .jobseeker-brand-name {

            font-size: 17px;

            font-weight: 700;

            color: #ffffff;
        }


        .jobseeker-brand-subtitle {

            display: block;

            margin-top: 2px;

            font-size: 9px;

            color: #cbd5e1;
        }


        /* =========================================================
           LEFT HEADING
        ========================================================= */

        .jobseeker-info-heading {

            margin: 0 0 14px;

            max-width: 400px;

            font-size: 31px;

            line-height: 1.15;

            font-weight: 800;

            letter-spacing: -0.7px;
        }


        .jobseeker-info-heading span {

            color: #cbd5e1;
        }


        .jobseeker-info-description {

            margin: 0;

            max-width: 405px;

            color: #d1d5db;

            font-size: 13px;

            line-height: 1.65;
        }


        /* =========================================================
           BENEFITS
        ========================================================= */

        .jobseeker-benefit-list {

            margin-top: 27px;

            display: flex;

            flex-direction: column;

            gap: 14px;
        }


        .jobseeker-benefit-item {

            display: flex;

            align-items: flex-start;

            gap: 11px;
        }


        .jobseeker-benefit-icon {

            width: 29px;
            height: 29px;

            flex-shrink: 0;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 7px;

            background:
                rgba(255,255,255,0.10);

            font-size: 12px;
        }


        .jobseeker-benefit-text strong {

            display: block;

            margin-bottom: 2px;

            font-size: 11px;

            color: #ffffff;
        }


        .jobseeker-benefit-text span {

            display: block;

            font-size: 9px;

            line-height: 1.4;

            color: #9ca3af;
        }


        /* =========================================================
           LEFT BOTTOM TEXT
        ========================================================= */

        .jobseeker-info-bottom {

            padding-top: 14px;

            border-top:
                1px solid
                rgba(255,255,255,0.10);
        }


        .jobseeker-info-bottom-text {

            margin: 0;

            font-size: 9px;

            line-height: 1.5;

            color: #9ca3af;
        }


        /* =========================================================
           RIGHT FORM PANEL
        ========================================================= */

        .jobseeker-form-panel {

            padding: 30px 40px;

            background: #ffffff;

            display: flex;

            flex-direction: column;

            justify-content: center;

            min-width: 0;
        }


        /* =========================================================
           FORM HEADER
        ========================================================= */

        .jobseeker-form-header {

            margin-bottom: 17px;
        }


        .jobseeker-form-header h1 {

            margin: 0 0 5px;

            color: #111827;

            font-size: 23px;

            line-height: 1.2;

            font-weight: 800;
        }


        .jobseeker-form-header p {

            margin: 0;

            color: #6b7280;

            font-size: 10px;
        }


        /* =========================================================
           SERVER MESSAGE
        ========================================================= */

        .jobseeker-server-message {

            display: block;

            margin-bottom: 10px;

            padding: 7px 9px;

            border-radius: 6px;

            font-size: 10px;
        }


        .jobseeker-server-message:empty {

            display: none;
        }


        /* =========================================================
           FORM GRID
        ========================================================= */

        .jobseeker-form-grid {

            display: grid;

            grid-template-columns:
                repeat(2, minmax(0, 1fr));

            gap: 11px 15px;
        }


        .jobseeker-form-group {

            display: flex;

            flex-direction: column;

            gap: 4px;

            min-width: 0;
        }


        .jobseeker-form-label {

            font-size: 10px;

            font-weight: 600;

            color: #374151;
        }


        .jobseeker-required {

            color: #dc2626;
        }


        /* =========================================================
           INPUT
        ========================================================= */

        .jobseeker-input-wrapper {

            position: relative;

            width: 100%;
        }


        .jobseeker-input-icon {

            position: absolute;

            left: 10px;

            top: 50%;

            transform:
                translateY(-50%);

            color: #9ca3af;

            font-size: 13px;

            z-index: 2;

            pointer-events: none;
        }


        .jobseeker-form-control {

            width: 100%;

            height: 37px;

            padding:
                0 10px 0 32px;

            border:
                1px solid
                #d1d5db;

            border-radius: 7px;

            background: #ffffff;

            color: #111827;

            font-family: inherit;

            font-size: 11px;

            outline: none;

            transition:
                border-color .2s ease,
                box-shadow .2s ease;
        }


        .jobseeker-form-control:focus {

            border-color: #6b7280;

            box-shadow:
                0 0 0 3px
                rgba(107,114,128,0.08);
        }


        .jobseeker-form-control::placeholder {

            color: #9ca3af;
        }


        /* =========================================================
           PASSWORD
        ========================================================= */

        .jobseeker-password-wrapper {

            position: relative;
        }


        .jobseeker-password-wrapper
        .jobseeker-form-control {

            padding-right: 38px;
        }


        .jobseeker-password-toggle {

            position: absolute;

            right: 7px;

            top: 50%;

            transform:
                translateY(-50%);

            width: 26px;
            height: 26px;

            border: 0;

            background: transparent;

            color: #6b7280;

            cursor: pointer;

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 0;

            z-index: 3;
        }


        .jobseeker-password-toggle:hover {

            color: #111827;
        }


        /* =========================================================
           VALIDATION
        ========================================================= */

        .jobseeker-validation-message {

            display: block;

            color: #b91c1c;

            font-size: 8.5px;

            line-height: 1.2;
        }


        /* =========================================================
           TERMS
        ========================================================= */

        .jobseeker-terms {

            grid-column: 1 / -1;

            display: flex;

            align-items: flex-start;

            gap: 7px;

            margin-top: 1px;

            color: #6b7280;

            font-size: 9px;

            line-height: 1.45;
        }


        .jobseeker-terms input {

            margin-top: 2px;

            flex-shrink: 0;
        }


        .jobseeker-terms a {

            color: #374151;

            font-weight: 600;

            text-decoration: none;
        }


        .jobseeker-terms a:hover {

            text-decoration: underline;
        }


        /* =========================================================
           REGISTER BUTTON
        ========================================================= */

        .jobseeker-register-button-wrapper {

            grid-column: 1 / -1;

            margin-top: 2px;
        }


        .jobseeker-register-btn {

            width: 100%;

            height: 40px;

            border: 0;

            border-radius: 7px;

            background: #111827;

            color: #ffffff;

            font-family: inherit;

            font-size: 11px;

            font-weight: 700;

            cursor: pointer;

            transition:
                background .2s ease;
        }


        .jobseeker-register-btn:hover {

            background: #1f2937;
        }


        /* =========================================================
           LOGIN LINK
        ========================================================= */

        .jobseeker-login-link {

            margin-top: 10px;

            text-align: center;

            font-size: 9.5px;

            color: #6b7280;
        }


        .jobseeker-login-link a {

            color: #111827;

            font-weight: 700;

            text-decoration: none;
        }


        .jobseeker-login-link a:hover {

            text-decoration: underline;
        }


        /* =========================================================
           EMPLOYER LINK
        ========================================================= */

        .jobseeker-employer-link {

            margin-top: 6px;

            text-align: center;

            font-size: 9px;
        }


        .jobseeker-employer-link a {

            color: #6b7280;

            text-decoration: none;
        }


        .jobseeker-employer-link a:hover {

            color: #111827;

            text-decoration: underline;
        }


        /* =========================================================
           TABLET
        ========================================================= */

        @media (max-width: 950px) {

            .jobseeker-register-page {

                height: auto;

                min-height:
                    calc(100vh - 140px);

                padding: 20px;
            }


            .jobseeker-register-container {

                height: auto;

                grid-template-columns: 1fr;
            }


            .jobseeker-info-panel {

                min-height: 350px;
            }


            .jobseeker-form-panel {

                padding: 30px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 600px) {

            .jobseeker-register-page {

                height: auto;

                min-height: auto;

                padding: 10px;

                overflow: visible;
            }


            .jobseeker-register-container {

                border-radius: 12px;
            }


            .jobseeker-info-panel {

                padding: 27px;

                min-height: auto;
            }


            .jobseeker-brand {

                margin-bottom: 28px;
            }


            .jobseeker-info-heading {

                font-size: 26px;
            }


            .jobseeker-form-panel {

                padding: 25px 20px;
            }


            .jobseeker-form-grid {

                grid-template-columns: 1fr;
            }


            .jobseeker-terms {

                grid-column: auto;
            }


            .jobseeker-register-button-wrapper {

                grid-column: auto;
            }
        }


    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="jobseeker-register-page">


        <div class="jobseeker-register-container">


            <!-- =====================================================
                 LEFT INFORMATION PANEL
            ====================================================== -->

            <section class="jobseeker-info-panel">


                <div class="jobseeker-info-content">


                    <!-- BRAND -->

                    <div class="jobseeker-brand">

                        <div class="jobseeker-brand-icon">

                            <i class="bi bi-briefcase-fill"></i>

                        </div>


                        <div>

                            <div class="jobseeker-brand-name">

                                Naukari24

                            </div>


                            <span class="jobseeker-brand-subtitle">

                                Job Seeker Portal

                            </span>

                        </div>

                    </div>


                    <!-- HEADING -->

                    <h2 class="jobseeker-info-heading">

                        Find your next
                        <span>career opportunity.</span>

                    </h2>


                    <p class="jobseeker-info-description">

                        Create your Naukari24 account and discover
                        jobs that match your skills, experience and
                        career goals.

                    </p>


                    <!-- BENEFITS -->

                    <div class="jobseeker-benefit-list">


                        <!-- BENEFIT 1 -->

                        <div class="jobseeker-benefit-item">


                            <div class="jobseeker-benefit-icon">

                                <i class="bi bi-search"></i>

                            </div>


                            <div class="jobseeker-benefit-text">

                                <strong>
                                    Discover Opportunities
                                </strong>

                                <span>
                                    Search and explore jobs that
                                    match your career profile.
                                </span>

                            </div>

                        </div>


                        <!-- BENEFIT 2 -->

                        <div class="jobseeker-benefit-item">


                            <div class="jobseeker-benefit-icon">

                                <i class="bi bi-file-earmark-person-fill"></i>

                            </div>


                            <div class="jobseeker-benefit-text">

                                <strong>
                                    Build Your Profile
                                </strong>

                                <span>
                                    Create your professional profile
                                    and showcase your skills.
                                </span>

                            </div>

                        </div>


                        <!-- BENEFIT 3 -->

                        <div class="jobseeker-benefit-item">


                            <div class="jobseeker-benefit-icon">

                                <i class="bi bi-send-fill"></i>

                            </div>


                            <div class="jobseeker-benefit-text">

                                <strong>
                                    Apply With Confidence
                                </strong>

                                <span>
                                    Apply to relevant opportunities
                                    and connect with employers.
                                </span>

                            </div>

                        </div>


                    </div>


                </div>


                <!-- LEFT BOTTOM -->

                <div class="jobseeker-info-bottom">

                    <p class="jobseeker-info-bottom-text">

                        Naukari24 helps job seekers and recruiters
                        connect through a simple and professional
                        recruitment platform.

                    </p>

                </div>


            </section>


            <!-- =====================================================
                 RIGHT REGISTRATION PANEL
            ====================================================== -->

            <section class="jobseeker-form-panel">


                <!-- FORM HEADER -->

                <div class="jobseeker-form-header">

                    <h1>
                        Create your account
                    </h1>

                    <p>
                        Create your Naukari24 profile and start
                        finding opportunities.
                    </p>

                </div>


                <!-- SERVER MESSAGE -->

                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="jobseeker-server-message">
                </asp:Label>


                <!-- =================================================
                     FORM
                ================================================== -->

                <div class="jobseeker-form-grid">


                    <!-- =================================================
                         FULL NAME
                    ================================================== -->

                    <div class="jobseeker-form-group">


                        <label class="jobseeker-form-label">

                            Full Name

                            <span class="jobseeker-required">
                                *
                            </span>

                        </label>


                        <div class="jobseeker-input-wrapper">


                            <i class="bi bi-person jobseeker-input-icon"></i>


                            <asp:TextBox
                                ID="txtFullName"
                                runat="server"
                                CssClass="jobseeker-form-control"
                                MaxLength="100"
                                placeholder="Enter your full name">
                            </asp:TextBox>


                        </div>


                        <asp:RequiredFieldValidator
                            ID="rfvFullName"
                            runat="server"
                            ControlToValidate="txtFullName"
                            ErrorMessage="Please enter your full name."
                            CssClass="jobseeker-validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>


                        <asp:RegularExpressionValidator
                            ID="revFullName"
                            runat="server"
                            ControlToValidate="txtFullName"
                            ValidationExpression="^[A-Za-z]+(?:\s+[A-Za-z]+)*$"
                            ErrorMessage="Full name must contain alphabets and spaces only."
                            CssClass="jobseeker-validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RegularExpressionValidator>


                    </div>


                    <!-- =================================================
                         EMAIL
                    ================================================== -->

                    <div class="jobseeker-form-group">


                        <label class="jobseeker-form-label">

                            Email Address

                            <span class="jobseeker-required">
                                *
                            </span>

                        </label>


                        <div class="jobseeker-input-wrapper">


                            <i class="bi bi-envelope jobseeker-input-icon"></i>


                            <asp:TextBox
                                ID="txtEmail"
                                runat="server"
                                CssClass="jobseeker-form-control"
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
                            CssClass="jobseeker-validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>


                        <asp:RegularExpressionValidator
                            ID="revEmail"
                            runat="server"
                            ControlToValidate="txtEmail"
                            ValidationExpression="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
                            ErrorMessage="Please enter a valid email address."
                            CssClass="jobseeker-validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RegularExpressionValidator>


                    </div>


                    <!-- =================================================
                         MOBILE
                    ================================================== -->

                    <div class="jobseeker-form-group">


                        <label class="jobseeker-form-label">

                            Mobile Number

                            <span class="jobseeker-required">
                                *
                            </span>

                        </label>


                        <div class="jobseeker-input-wrapper">


                            <i class="bi bi-phone jobseeker-input-icon"></i>


                            <asp:TextBox
                                ID="txtMobile"
                                runat="server"
                                CssClass="jobseeker-form-control"
                                MaxLength="10"
                                TextMode="Phone"
                                placeholder="10-digit mobile number">
                            </asp:TextBox>


                        </div>


                        <asp:RequiredFieldValidator
                            ID="rfvMobile"
                            runat="server"
                            ControlToValidate="txtMobile"
                            ErrorMessage="Please enter your mobile number."
                            CssClass="jobseeker-validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>


                        <asp:RegularExpressionValidator
                            ID="revMobile"
                            runat="server"
                            ControlToValidate="txtMobile"
                            ValidationExpression="^[6-9][0-9]{9}$"
                            ErrorMessage="Please enter a valid 10-digit mobile number."
                            CssClass="jobseeker-validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RegularExpressionValidator>


                    </div>


                    <!-- =================================================
                         PASSWORD
                    ================================================== -->

                    <div class="jobseeker-form-group">


                        <label class="jobseeker-form-label">

                            Password

                            <span class="jobseeker-required">
                                *
                            </span>

                        </label>


                        <div class="jobseeker-input-wrapper jobseeker-password-wrapper">


                            <i class="bi bi-lock jobseeker-input-icon"></i>


                            <asp:TextBox
                                ID="txtPassword"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="jobseeker-form-control"
                                TextMode="Password"
                                MaxLength="100"
                                placeholder="Minimum 8 characters">
                            </asp:TextBox>


                            <button
                                type="button"
                                class="jobseeker-password-toggle"
                                onclick="toggleJobSeekerPassword('txtPassword', this); return false;"
                                aria-label="Show password">

                                <i class="bi bi-eye"></i>

                            </button>


                        </div>


                        <asp:RequiredFieldValidator
                            ID="rfvPassword"
                            runat="server"
                            ControlToValidate="txtPassword"
                            ErrorMessage="Please enter a password."
                            CssClass="jobseeker-validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>


                        <asp:RegularExpressionValidator
                            ID="revPassword"
                            runat="server"
                            ControlToValidate="txtPassword"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,100}$"
                            ErrorMessage="Password must contain uppercase, lowercase, number and special character."
                            CssClass="jobseeker-validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RegularExpressionValidator>


                    </div>


                    <!-- =================================================
                         CONFIRM PASSWORD
                    ================================================== -->

                    <div class="jobseeker-form-group">


                        <label class="jobseeker-form-label">

                            Confirm Password

                            <span class="jobseeker-required">
                                *
                            </span>

                        </label>


                        <div class="jobseeker-input-wrapper jobseeker-password-wrapper">


                            <i class="bi bi-shield-lock jobseeker-input-icon"></i>


                            <asp:TextBox
                                ID="txtConfirmPassword"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="jobseeker-form-control"
                                TextMode="Password"
                                MaxLength="100"
                                placeholder="Enter password again">
                            </asp:TextBox>


                            <button
                                type="button"
                                class="jobseeker-password-toggle"
                                onclick="toggleJobSeekerPassword('txtConfirmPassword', this); return false;"
                                aria-label="Show password">

                                <i class="bi bi-eye"></i>

                            </button>


                        </div>


                        <asp:RequiredFieldValidator
                            ID="rfvConfirmPassword"
                            runat="server"
                            ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Please confirm your password."
                            CssClass="jobseeker-validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>


                        <asp:CompareValidator
                            ID="cvPassword"
                            runat="server"
                            ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtPassword"
                            Operator="Equal"
                            Type="String"
                            ErrorMessage="Passwords do not match."
                            CssClass="jobseeker-validation-message"
                            ValidationGroup="Register"
                            Display="Dynamic">
                        </asp:CompareValidator>


                    </div>


                    <!-- =================================================
                         TERMS
                    ================================================== -->

                    <div class="jobseeker-terms">


                        <asp:CheckBox
                            ID="chkTerms"
                            runat="server" />


                        <span>

                            I agree to the

                            <a href="<%= ResolveUrl("~/PrivacyPolicy.aspx") %>">
                                Terms &amp; Conditions
                            </a>

                            and

                            <a href="<%= ResolveUrl("~/PrivacyPolicy.aspx") %>">
                                Privacy Policy
                            </a>.

                        </span>


                    </div>


                    <!-- =================================================
                         REGISTER BUTTON
                    ================================================== -->

                    <div class="jobseeker-register-button-wrapper">


                        <asp:Button
                            ID="btnRegister"
                            runat="server"
                            Text="Create Account"
                            CssClass="jobseeker-register-btn"
                            ValidationGroup="Register"
                            OnClick="btnRegister_Click" />


                    </div>


                </div>


                <!-- =================================================
                     LOGIN
                ================================================== -->

                <div class="jobseeker-login-link">

                    Already have an account?

                    <a href="<%= ResolveUrl("~/Login.aspx") %>">
                        Login
                    </a>

                </div>

            </section>


        </div>


    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
               
        function toggleJobSeekerPassword(inputId, button) {

            var input = document.getElementById(inputId);

            if (!input) {
                return false;
            }

            var icon = button.querySelector("i");

            if (input.type === "password") {

                input.type = "text";

                if (icon) {
                    icon.classList.remove("bi-eye");
                    icon.classList.add("bi-eye-slash");
                }

                button.setAttribute(
                    "aria-label",
                    "Hide password"
                );

            }
            else {

                input.type = "password";

                if (icon) {
                    icon.classList.remove("bi-eye-slash");
                    icon.classList.add("bi-eye");
                }

                button.setAttribute(
                    "aria-label",
                    "Show password"
                );
            }

            return false;
        }

    </script>

</asp:Content>
