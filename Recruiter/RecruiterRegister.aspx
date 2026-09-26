<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="RecruiterRegister.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.RecruiterRegister" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Recruiter Registration - Naukari24
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
<style type="text/css">

/* =========================================================
   REGISTER PAGE
========================================================= */

.register-page {

    width: 100%;

    min-height: 0;

    display: flex;

    align-items: center;

    justify-content: center;

    padding: 22px 24px;
}


/* =========================================================
   MAIN REGISTER CARD
========================================================= */

.register-container {

    width: 100%;

    max-width: 1120px;

    min-height: 540px;

    display: grid;

    grid-template-columns: 40% 60%;

    background: #ffffff;

    border: 1px solid #e5e7eb;

    border-radius: 18px;

    overflow: hidden;

    box-shadow:
        0 12px 35px rgba(15, 23, 42, 0.08);
}


/* =========================================================
   LEFT INFORMATION PANEL
========================================================= */

.info-panel {

    position: relative;

    background:
        linear-gradient(
            145deg,
            #111827 0%,
            #1f2937 55%,
            #374151 100%
        );

    color: #ffffff;

    padding: 32px;

    display: flex;

    flex-direction: column;

    justify-content: space-between;

    overflow: hidden;
}


/* Decorative circle */

.info-panel::before {

    content: "";

    position: absolute;

    width: 280px;

    height: 280px;

    border-radius: 50%;

    background:
        rgba(255,255,255,0.035);

    top: -130px;

    right: -100px;
}


.info-panel::after {

    content: "";

    position: absolute;

    width: 230px;

    height: 230px;

    border-radius: 50%;

    background:
        rgba(255,255,255,0.025);

    bottom: -125px;

    left: -110px;
}


/* =========================================================
   LEFT CONTENT
========================================================= */

.info-content,
.info-bottom {

    position: relative;

    z-index: 2;
}


/* =========================================================
   BRAND
========================================================= */

.brand {

    display: flex;

    align-items: center;

    gap: 10px;

    margin-bottom: 35px;
}


.brand-icon {

    width: 40px;

    height: 40px;

    flex-shrink: 0;

    border-radius: 10px;

    display: flex;

    align-items: center;

    justify-content: center;

    background: #ffffff;

    color: #111827;

    font-size: 18px;
}


.brand-name {

    font-size: 17px;

    font-weight: 700;

    color: #ffffff;
}


.brand-subtitle {

    display: block;

    margin-top: 2px;

    font-size: 9px;

    color: #cbd5e1;
}


/* =========================================================
   LEFT HEADING
========================================================= */

.info-heading {

    margin: 0 0 13px;

    max-width: 360px;

    font-size: 30px;

    line-height: 1.15;

    font-weight: 800;

    letter-spacing: -0.7px;
}


.info-heading span {

    color: #cbd5e1;
}


/* =========================================================
   LEFT DESCRIPTION
========================================================= */

.info-description {

    margin: 0;

    max-width: 390px;

    color: #d1d5db;

    font-size: 12px;

    line-height: 1.6;
}


/* =========================================================
   BENEFITS
========================================================= */

.benefit-list {

    margin-top: 26px;

    display: flex;

    flex-direction: column;

    gap: 13px;
}


.benefit-item {

    display: flex;

    align-items: flex-start;

    gap: 10px;
}


.benefit-icon {

    width: 29px;

    height: 29px;

    flex-shrink: 0;

    display: flex;

    align-items: center;

    justify-content: center;

    border-radius: 7px;

    background:
        rgba(255,255,255,0.10);

    color: #ffffff;

    font-size: 12px;
}


.benefit-text strong {

    display: block;

    margin-bottom: 2px;

    font-size: 11px;

    color: #ffffff;
}


.benefit-text span {

    display: block;

    font-size: 9px;

    line-height: 1.4;

    color: #9ca3af;
}


/* =========================================================
   LEFT BOTTOM
========================================================= */

.info-bottom {

    padding-top: 14px;

    border-top:
        1px solid
        rgba(255,255,255,0.10);
}


.info-bottom-text {

    margin: 0;

    max-width: 380px;

    font-size: 9px;

    line-height: 1.5;

    color: #9ca3af;
}


/* =========================================================
   RIGHT FORM PANEL
========================================================= */

.form-panel {

    padding: 32px 38px;

    background: #ffffff;

    display: flex;

    flex-direction: column;

    justify-content: center;

    min-width: 0;
}


/* =========================================================
   FORM HEADER
========================================================= */

.form-header {

    margin-bottom: 17px;
}


.form-header h1 {

    margin: 0 0 5px;

    color: #111827;

    font-size: 23px;

    line-height: 1.2;

    font-weight: 800;
}


.form-header p {

    margin: 0;

    color: #6b7280;

    font-size: 10px;

    line-height: 1.5;
}


/* =========================================================
   SERVER MESSAGE
========================================================= */

.message {

    display: block;

    width: 100%;

    margin-bottom: 12px;

    padding: 8px 10px;

    border-radius: 6px;

    font-size: 10px;

    line-height: 1.4;
}


.message.error {

    background: #fef2f2;

    color: #b91c1c;

    border:
        1px solid
        #fecaca;
}


.message.success {

    background: #ecfdf5;

    color: #047857;

    border:
        1px solid
        #a7f3d0;
}


/* =========================================================
   FORM GRID
========================================================= */

.form-grid {

    display: grid;

    grid-template-columns:
        repeat(2, minmax(0, 1fr));

    column-gap: 15px;

    row-gap: 11px;
}


/* =========================================================
   FORM GROUP
========================================================= */

.form-group {

    display: flex;

    flex-direction: column;

    gap: 4px;

    min-width: 0;
}


/* =========================================================
   LABEL
========================================================= */

.form-label {

    font-size: 10px;

    font-weight: 600;

    color: #374151;

    line-height: 1.3;
}


.required {

    color: #dc2626;

    font-weight: 700;
}


/* =========================================================
   INPUT
========================================================= */

.form-control {

    width: 100%;

    height: 38px;

    padding:
        0 10px;

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
        border-color .15s ease,
        box-shadow .15s ease,
        background .15s ease;
}


.form-control:focus {

    border-color: #64748b;

    box-shadow:
        0 0 0 3px
        rgba(100,116,139,0.10);
}


.form-control::placeholder {

    color: #9ca3af;
}


.form-control:hover {

    border-color: #9ca3af;
}


/* =========================================================
   PASSWORD WRAPPER
========================================================= */

.password-wrapper {

    position: relative;

    width: 100%;
}


.password-wrapper .form-control {

    padding-right: 38px;
}


/* =========================================================
   PASSWORD TOGGLE
========================================================= */

.password-toggle {

    position: absolute;

    right: 7px;

    top: 50%;

    transform:
        translateY(-50%);

    width: 27px;

    height: 27px;

    padding: 0;

    border: 0;

    background: transparent;

    color: #6b7280;

    cursor: pointer;

    display: flex;

    align-items: center;

    justify-content: center;

    border-radius: 5px;
}


.password-toggle:hover {

    background: #f3f4f6;

    color: #111827;
}


.password-toggle i {

    font-size: 12px;
}


/* =========================================================
   VALIDATION
========================================================= */

.validation-message {

    display: block;

    color: #b91c1c;

    font-size: 8.5px;

    line-height: 1.25;

    margin: 0;
}


/* =========================================================
   PASSWORD HELP
========================================================= */

.password-help {

    display: block;

    color: #9ca3af;

    font-size: 8px;

    line-height: 1.3;
}


/* =========================================================
   REGISTER BUTTON
========================================================= */

.register-button-wrapper {

    grid-column: 1 / -1;

    margin-top: 2px;
}


.register-btn {

    width: 100%;

    height: 39px;

    padding: 0 15px;

    border: 0;

    border-radius: 7px;

    background: #111827;

    color: #ffffff;

    font-family: inherit;

    font-size: 11px;

    font-weight: 700;

    cursor: pointer;

    transition:
        background .2s ease,
        transform .1s ease;
}


.register-btn:hover {

    background: #1f2937;
}


.register-btn:active {

    transform: translateY(1px);
}


/* =========================================================
   LOGIN LINK
========================================================= */

.login-link {

    margin-top: 11px;

    text-align: center;

    color: #6b7280;

    font-size: 10px;

    line-height: 1.5;
}


.login-link a {

    color: #111827;

    font-weight: 700;

    text-decoration: none;
}


.login-link a:hover {

    text-decoration: underline;
}


/* =========================================================
   TABLET
========================================================= */

@media (max-width: 950px) {

    .register-page {

        padding: 20px;
    }


    .register-container {

        grid-template-columns: 1fr;

        max-width: 700px;
    }


    .info-panel {

        min-height: 300px;

        padding: 28px;
    }


    .info-bottom {

        display: none;
    }


    .form-panel {

        padding: 30px;
    }
}


/* =========================================================
   MOBILE
========================================================= */

@media (max-width: 600px) {

    .register-page {

        padding: 12px;
    }


    .register-container {

        border-radius: 12px;
    }


    .info-panel {

        padding: 24px;

        min-height: auto;
    }


    .brand {

        margin-bottom: 25px;
    }


    .info-heading {

        font-size: 26px;
    }


    .info-description {

        font-size: 11px;
    }


    .benefit-list {

        margin-top: 20px;

        gap: 11px;
    }


    .form-panel {

        padding: 24px;
    }


    .form-grid {

        grid-template-columns: 1fr;

        row-gap: 12px;
    }


    .register-button-wrapper {

        grid-column: auto;

        margin-top: 3px;
    }
}


/* =========================================================
   VERY SMALL MOBILE
========================================================= */

@media (max-width: 400px) {

    .info-panel {

        padding: 20px;
    }


    .form-panel {

        padding: 20px;
    }


    .info-heading {

        font-size: 23px;
    }


    .form-header h1 {

        font-size: 21px;
    }
}

</style>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
    Recruiter Registration
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

<div class="register-page">


    <div class="register-container">


        <!-- =====================================================
             LEFT INFORMATION PANEL
        ====================================================== -->

        <section class="info-panel">


            <div class="info-content">


                <!-- BRAND -->

                <div class="brand">


                    <div class="brand-icon">

                        <i class="bi bi-briefcase-fill"></i>

                    </div>


                    <div>

                        <div class="brand-name">
                            Naukari24
                        </div>

                        <span class="brand-subtitle">
                            Recruiter Portal
                        </span>

                    </div>


                </div>


                <!-- HEADING -->

                <h2 class="info-heading">

                    Build your team with
                    <span>the right talent.</span>

                </h2>


                <!-- DESCRIPTION -->

                <p class="info-description">

                    Create your recruiter account and connect
                    with candidates looking for their next
                    career opportunity.

                </p>


                <!-- BENEFITS -->

                <div class="benefit-list">


                    <!-- BENEFIT 1 -->

                    <div class="benefit-item">


                        <div class="benefit-icon">

                            <i class="bi bi-person-plus-fill"></i>

                        </div>


                        <div class="benefit-text">

                            <strong>
                                Connect with Candidates
                            </strong>

                            <span>
                                Discover candidates and build
                                your talent pipeline.
                            </span>

                        </div>


                    </div>


                    <!-- BENEFIT 2 -->

                    <div class="benefit-item">


                        <div class="benefit-icon">

                            <i class="bi bi-briefcase-fill"></i>

                        </div>


                        <div class="benefit-text">

                            <strong>
                                Manage Job Openings
                            </strong>

                            <span>
                                Create and manage your company's
                                job opportunities.
                            </span>

                        </div>


                    </div>


                    <!-- BENEFIT 3 -->

                    <div class="benefit-item">


                        <div class="benefit-icon">

                            <i class="bi bi-people-fill"></i>

                        </div>


                        <div class="benefit-text">

                            <strong>
                                Grow Your Team
                            </strong>

                            <span>
                                Find professionals who match
                                your hiring requirements.
                            </span>

                        </div>


                    </div>


                </div>


            </div>


            <!-- LEFT BOTTOM -->

            <div class="info-bottom">

                <p class="info-bottom-text">

                    Naukari24 helps recruiters and job seekers
                    connect through a simple and professional
                    recruitment platform.

                </p>

            </div>


        </section>


        <!-- =====================================================
             RIGHT REGISTRATION FORM
        ====================================================== -->

        <section class="form-panel">


            <!-- FORM HEADER -->

            <div class="form-header">


                <h1>
                    Create Recruiter Account
                </h1>


                <p>
                    Enter your details to create your recruiter account.
                </p>


            </div>


            <!-- SERVER MESSAGE -->

            <asp:Label
                ID="lblMessage"
                runat="server"
                Visible="false">
            </asp:Label>


            <!-- FORM GRID -->

            <div class="form-grid">


                <!-- =================================================
                     FULL NAME
                ================================================== -->

                <div class="form-group">


                    <label
                        for="<%= txtFullName.ClientID %>"
                        class="form-label">

                        Full Name
                        <span class="required">*</span>

                    </label>


                    <asp:TextBox
                        ID="txtFullName"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="100"
                        autocomplete="name"
                        placeholder="Enter your full name">
                    </asp:TextBox>


                    <asp:RequiredFieldValidator
                        ID="rfvFullName"
                        runat="server"
                        ControlToValidate="txtFullName"
                        ErrorMessage="Please enter your full name."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RequiredFieldValidator>


                    <asp:RegularExpressionValidator
                        ID="revFullName"
                        runat="server"
                        ControlToValidate="txtFullName"
                        ValidationExpression="^[A-Za-z]+(?:[ '\-][A-Za-z]+)*$"
                        ErrorMessage="Enter a valid name using letters, spaces or hyphen."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RegularExpressionValidator>


                </div>


                <!-- =================================================
                     EMAIL
                ================================================== -->

                <div class="form-group">


                    <label
                        for="<%= txtEmail.ClientID %>"
                        class="form-label">

                        Email Address
                        <span class="required">*</span>

                    </label>


                    <asp:TextBox
                        ID="txtEmail"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="150"
                        TextMode="Email"
                        autocomplete="email"
                        placeholder="name@company.com">
                    </asp:TextBox>


                    <asp:RequiredFieldValidator
                        ID="rfvEmail"
                        runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Please enter your email address."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RequiredFieldValidator>


                    <asp:RegularExpressionValidator
                        ID="revEmail"
                        runat="server"
                        ControlToValidate="txtEmail"
                        ValidationExpression="^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
                        ErrorMessage="Please enter a valid email address."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RegularExpressionValidator>


                </div>


                <!-- =================================================
                     MOBILE NUMBER
                ================================================== -->

                <div class="form-group">


                    <label
                        for="<%= txtPhone.ClientID %>"
                        class="form-label">

                        Mobile Number
                        <span class="required">*</span>

                    </label>


                    <asp:TextBox
                        ID="txtPhone"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="10"
                        TextMode="Phone"
                        autocomplete="tel"
                        inputmode="numeric"
                        placeholder="10-digit mobile number">
                    </asp:TextBox>


                    <asp:RequiredFieldValidator
                        ID="rfvPhone"
                        runat="server"
                        ControlToValidate="txtPhone"
                        ErrorMessage="Please enter your mobile number."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RequiredFieldValidator>


                    <asp:RegularExpressionValidator
                        ID="revPhone"
                        runat="server"
                        ControlToValidate="txtPhone"
                        ValidationExpression="^[6-9][0-9]{9}$"
                        ErrorMessage="Enter a valid 10-digit mobile number."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RegularExpressionValidator>


                </div>


                <!-- =================================================
                     DESIGNATION
                ================================================== -->

                <div class="form-group">


                    <label
                        for="<%= txtDesignation.ClientID %>"
                        class="form-label">

                        Designation
                        <span class="required">*</span>

                    </label>


                    <asp:TextBox
                        ID="txtDesignation"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="100"
                        autocomplete="organization-title"
                        placeholder="e.g. HR Manager">
                    </asp:TextBox>


                    <asp:RequiredFieldValidator
                        ID="rfvDesignation"
                        runat="server"
                        ControlToValidate="txtDesignation"
                        ErrorMessage="Please enter your designation."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RequiredFieldValidator>


                    <asp:RegularExpressionValidator
                        ID="revDesignation"
                        runat="server"
                        ControlToValidate="txtDesignation"
                        ValidationExpression="^[A-Za-z0-9]+(?:[A-Za-z0-9 .&amp;/'()\-]*)$"
                        ErrorMessage="Please enter a valid designation."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RegularExpressionValidator>


                </div>


                <!-- =================================================
                     PASSWORD
                ================================================== -->

                <div class="form-group">


                    <label
                        for="<%= txtPassword.ClientID %>"
                        class="form-label">

                        Password
                        <span class="required">*</span>

                    </label>


                    <div class="password-wrapper">


                        <asp:TextBox
                            ID="txtPassword"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            MaxLength="100"
                            autocomplete="new-password"
                            placeholder="Create password">
                        </asp:TextBox>


                        <button
                            type="button"
                            class="password-toggle"
                            aria-label="Show password"
                            onclick="togglePassword('<%= txtPassword.ClientID %>', this); return false;">

                            <i class="bi bi-eye"></i>

                        </button>


                    </div>


                    <asp:RequiredFieldValidator
                        ID="rfvPassword"
                        runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Please enter a password."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RequiredFieldValidator>


                    <asp:RegularExpressionValidator
                        ID="revPassword"
                        runat="server"
                        ControlToValidate="txtPassword"
                        ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,100}$"
                        ErrorMessage="Password must contain uppercase, lowercase, number and special character."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RegularExpressionValidator>


                    <span class="password-help">

                        Minimum 8 characters with uppercase,
                        lowercase, number and special character.

                    </span>


                </div>


                <!-- =================================================
                     CONFIRM PASSWORD
                ================================================== -->

                <div class="form-group">


                    <label
                        for="<%= txtConfirmPassword.ClientID %>"
                        class="form-label">

                        Confirm Password
                        <span class="required">*</span>

                    </label>


                    <div class="password-wrapper">


                        <asp:TextBox
                            ID="txtConfirmPassword"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            MaxLength="100"
                            autocomplete="new-password"
                            placeholder="Confirm password">
                        </asp:TextBox>


                        <button
                            type="button"
                            class="password-toggle"
                            aria-label="Show confirm password"
                            onclick="togglePassword('<%= txtConfirmPassword.ClientID %>', this); return false;">

                            <i class="bi bi-eye"></i>

                        </button>


                    </div>


                    <asp:RequiredFieldValidator
                        ID="rfvConfirmPassword"
                        runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ErrorMessage="Please confirm your password."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:RequiredFieldValidator>


                    <asp:CompareValidator
                        ID="cvPassword"
                        runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ControlToCompare="txtPassword"
                        Operator="Equal"
                        Type="String"
                        ErrorMessage="Passwords do not match."
                        CssClass="validation-message"
                        Display="Dynamic"
                        ValidationGroup="RecruiterRegister">
                    </asp:CompareValidator>


                </div>


                <!-- =================================================
                     REGISTER BUTTON
                ================================================== -->

                <div class="register-button-wrapper">


                    <asp:Button
                        ID="btnRegister"
                        runat="server"
                        Text="Create Recruiter Account"
                        CssClass="register-btn"
                        ValidationGroup="RecruiterRegister"
                        CausesValidation="true"
                        OnClick="btnRegister_Click" />


                </div>


            </div>


            <!-- =================================================
                 LOGIN
            ================================================== -->

            <div class="login-link">

                Already have an account?

                <a
                    href="<%= ResolveUrl("~/Recruiter/Login.aspx") %>">

                    Login here

                </a>

            </div>


        </section>


    </div>


</div>


</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">

    /* =========================================================
       STORAGE KEY
    ========================================================= */

    var recruiterRegistrationStorageKey =
        "naukari24_recruiter_registration";


    /* =========================================================
       PASSWORD TOGGLE
    ========================================================= */

    function togglePassword(controlId, button) {

        var input =
            document.getElementById(controlId);

        if (!input) {

            return false;
        }


        var icon =
            button
                ? button.querySelector("i")
                : null;


        if (input.type === "password") {

            input.type = "text";


            if (icon) {

                icon.className =
                    "bi bi-eye-slash";
            }


            if (button) {

                button.setAttribute(
                    "aria-label",
                    "Hide password"
                );
            }

        }
        else {

            input.type = "password";


            if (icon) {

                icon.className =
                    "bi bi-eye";
            }


            if (button) {

                button.setAttribute(
                    "aria-label",
                    "Show password"
                );
            }
        }


        return false;
    }


    /* =========================================================
       GET FORM ELEMENTS
    ========================================================= */

    function getRecruiterRegistrationFields() {

        return {

            fullName:
                document.getElementById(
                    "<%= txtFullName.ClientID %>"
                ),

            email:
                document.getElementById(
                    "<%= txtEmail.ClientID %>"
                ),

            phone:
                document.getElementById(
                    "<%= txtPhone.ClientID %>"
                ),

            designation:
                document.getElementById(
                    "<%= txtDesignation.ClientID %>"
                )
        };
    }


    /* =========================================================
       SAVE FORM DATA
       
       IMPORTANT:
       Passwords are deliberately NOT saved.
    ========================================================= */

    function saveRecruiterRegistrationData() {

        try {

            var fields =
                getRecruiterRegistrationFields();


            var registrationData = {

                fullName:
                    fields.fullName
                        ? fields.fullName.value
                        : "",

                email:
                    fields.email
                        ? fields.email.value
                        : "",

                phone:
                    fields.phone
                        ? fields.phone.value
                        : "",

                designation:
                    fields.designation
                        ? fields.designation.value
                        : ""

            };


            localStorage.setItem(

                recruiterRegistrationStorageKey,

                JSON.stringify(
                    registrationData
                )
            );

        }
        catch (error) {

            console.log(
                "Naukari24: Unable to save registration data."
            );
        }
    }


    /* =========================================================
       RESTORE FORM DATA
    ========================================================= */

    function restoreRecruiterRegistrationData() {

        try {

            var savedData =
                localStorage.getItem(
                    recruiterRegistrationStorageKey
                );


            if (!savedData) {

                return;
            }


            var data =
                JSON.parse(savedData);


            var fields =
                getRecruiterRegistrationFields();


            if (
                fields.fullName &&
                typeof data.fullName === "string"
            ) {

                fields.fullName.value =
                    data.fullName;
            }


            if (
                fields.email &&
                typeof data.email === "string"
            ) {

                fields.email.value =
                    data.email;
            }


            if (
                fields.phone &&
                typeof data.phone === "string"
            ) {

                fields.phone.value =
                    data.phone;
            }


            if (
                fields.designation &&
                typeof data.designation === "string"
            ) {

                fields.designation.value =
                    data.designation;
            }

        }
        catch (error) {

            console.log(
                "Naukari24: Unable to restore registration data."
            );
        }
    }


    /* =========================================================
       CLEAR SAVED DATA
    ========================================================= */

    function clearRecruiterRegistrationData() {

        try {

            localStorage.removeItem(
                recruiterRegistrationStorageKey
            );

        }
        catch (error) {

            console.log(
                "Naukari24: Unable to clear registration data."
            );
        }
    }


    /* =========================================================
       INPUT RESTRICTIONS
    ========================================================= */

    function setupInputRestrictions() {

        var fields =
            getRecruiterRegistrationFields();


        /* -----------------------------------------
           PHONE
        ----------------------------------------- */

        if (fields.phone) {

            fields.phone.addEventListener(
                "input",
                function () {

                    this.value =
                        this.value
                            .replace(/[^0-9]/g, "")
                            .substring(0, 10);

                    saveRecruiterRegistrationData();

                }
            );
        }


        /* -----------------------------------------
           FULL NAME
        ----------------------------------------- */

        if (fields.fullName) {

            fields.fullName.addEventListener(
                "input",
                function () {

                    this.value =
                        this.value
                            .replace(/[^A-Za-z\s'\-]/g, "")
                            .replace(/\s{2,}/g, " ");

                    saveRecruiterRegistrationData();

                }
            );
        }


        /* -----------------------------------------
           EMAIL
        ----------------------------------------- */

        if (fields.email) {

            fields.email.addEventListener(
                "input",
                function () {

                    saveRecruiterRegistrationData();

                }
            );
        }


        /* -----------------------------------------
           DESIGNATION
        ----------------------------------------- */

        if (fields.designation) {

            fields.designation.addEventListener(
                "input",
                function () {

                    this.value =
                        this.value
                            .replace(/[^A-Za-z0-9\s.&/'()\-]/g, "")
                            .replace(/\s{2,}/g, " ");

                    saveRecruiterRegistrationData();

                }
            );
        }
    }


    /* =========================================================
       INITIALIZE LOCAL STORAGE
    ========================================================= */

    document.addEventListener(
        "DOMContentLoaded",
        function () {

            /*
                If registration was successful,
                clear old saved information before
                doing anything else.
            */

            var registrationSuccessful =
                "<%= Request.QueryString["registered"] == "1" ? "1" : "" %>";


            if (
                registrationSuccessful === "1"
            ) {

                clearRecruiterRegistrationData();

            }
            else {

                restoreRecruiterRegistrationData();

            }


            setupInputRestrictions();


            /*
                Save current data when user
                leaves/reloads the page.
            */

            window.addEventListener(
                "beforeunload",
                function () {

                    saveRecruiterRegistrationData();

                }
            );

        }
    );

    </script>
</asp:Content>
