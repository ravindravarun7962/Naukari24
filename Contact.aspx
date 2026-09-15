<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Success24_Job_Portal.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        /* =========================================
           CONTACT PAGE
        ========================================== */

        .contact-page {
            background: #f8fafc;
            padding: 50px 20px;
        }

        .contact-container {
            max-width: 1100px;
            margin: 0 auto;
        }


        /* =========================================
           HERO
        ========================================== */

        .contact-hero {
            background: #111827;
            border-radius: 16px;
            padding: 45px 50px;
            color: #ffffff;
            margin-bottom: 25px;
        }

        .contact-eyebrow {
            display: inline-block;
            margin-bottom: 10px;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
            color: #d1d5db;
            text-transform: uppercase;
        }

        .contact-hero h1 {
            margin: 0 0 12px;
            font-size: 36px;
            font-weight: 700;
        }

        .contact-hero p {
            max-width: 700px;
            margin: 0;
            color: #d1d5db;
            font-size: 14px;
            line-height: 1.8;
        }


        /* =========================================
           CONTACT GRID
        ========================================== */

        .contact-grid {
            display: grid;
            grid-template-columns: 0.85fr 1.5fr;
            gap: 20px;
            align-items: start;
        }


        /* =========================================
           CONTACT INFORMATION
        ========================================== */

        .contact-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 30px;
        }

        .contact-card h2 {
            margin: 0 0 8px;
            font-size: 21px;
            font-weight: 700;
            color: #111827;
        }

        .contact-card-intro {
            margin: 0 0 25px;
            color: #6b7280;
            font-size: 13px;
            line-height: 1.7;
        }

        .contact-info {
            display: flex;
            align-items: flex-start;
            gap: 13px;
            padding: 16px 0;
            border-top: 1px solid #f0f1f3;
        }

        .contact-info:first-of-type {
            border-top: 0;
        }

        .contact-info-icon {
            width: 40px;
            height: 40px;
            min-width: 40px;
            border-radius: 9px;
            background: #f3f4f6;
            color: #374151;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .contact-info-icon i {
            font-size: 17px;
        }

        .contact-info-content {
            flex: 1;
        }

        .contact-info-label {
            display: block;
            margin-bottom: 3px;
            color: #9ca3af;
            font-size: 11px;
        }

        .contact-info-value {
            display: block;
            color: #374151;
            font-size: 13px;
            font-weight: 600;
            line-height: 1.5;
        }

        .contact-info-value a {
            color: #374151;
            text-decoration: none;
        }

        .contact-info-value a:hover {
            color: #111827;
            text-decoration: underline;
        }


        /* =========================================
           FORM
        ========================================== */

        .contact-form-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 30px;
        }

        .contact-form-card h2 {
            margin: 0 0 8px;
            font-size: 21px;
            font-weight: 700;
            color: #111827;
        }

        .contact-form-intro {
            margin: 0 0 25px;
            color: #6b7280;
            font-size: 13px;
            line-height: 1.7;
        }

        .contact-form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .contact-form-group {
            margin-bottom: 17px;
        }

        .contact-form-group label {
            display: block;
            margin-bottom: 7px;
            color: #374151;
            font-size: 12px;
            font-weight: 600;
        }

        .contact-input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #ffffff;
            color: #111827;
            font-size: 13px;
            outline: none;
            box-sizing: border-box;
            transition: border-color 0.2s ease,
                        box-shadow 0.2s ease;
        }

        .contact-input:focus {
            border-color: #6b7280;
            box-shadow: 0 0 0 3px rgba(17, 24, 39, 0.06);
        }

        textarea.contact-input {
            min-height: 130px;
            resize: vertical;
        }

        .contact-submit {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 11px 18px;
            border: 0;
            border-radius: 8px;
            background: #111827;
            color: #ffffff;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .contact-submit:hover {
            background: #1f2937;
        }


        /* =========================================
           VALIDATION
        ========================================== */

        .contact-validation {
            display: block;
            margin-top: 5px;
            color: #b91c1c;
            font-size: 11px;
        }

        .contact-message {
            display: block;
            margin-bottom: 18px;
            padding: 11px 13px;
            border-radius: 7px;
            font-size: 12px;
        }


        /* =========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 850px) {

            .contact-grid {
                grid-template-columns: 1fr;
            }

        }


        @media (max-width: 650px) {

            .contact-page {
                padding: 25px 15px;
            }

            .contact-hero {
                padding: 35px 25px;
            }

            .contact-hero h1 {
                font-size: 29px;
            }

            .contact-card,
            .contact-form-card {
                padding: 25px 20px;
            }

            .contact-form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }

        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="contact-page">

        <div class="contact-container">


            <!-- =====================================
                 HERO
            ====================================== -->

            <div class="contact-hero">

                <span class="contact-eyebrow">
                    GET IN TOUCH
                </span>

                <h1>
                    Contact Us
                </h1>

                <p>
                    Have a question, suggestion or need assistance?
                    Get in touch with the Naukari24 Job Portal team.
                    We are here to help you with your job search and
                    recruitment experience.
                </p>

            </div>


            <!-- =====================================
                 CONTACT GRID
            ====================================== -->

            <div class="contact-grid">


                <!-- =================================
                     CONTACT INFORMATION
                ================================== -->

                <div class="contact-card">

                    <h2>
                        Let's Talk
                    </h2>

                    <p class="contact-card-intro">
                        Whether you are a job seeker or recruiter,
                        feel free to contact us regarding our platform
                        and services.
                    </p>


                    <!-- EMAIL -->

                    <div class="contact-info">

                        <div class="contact-info-icon">

                            <i class="bi bi-envelope"></i>

                        </div>

                        <div class="contact-info-content">

                            <span class="contact-info-label">
                                Email
                            </span>

                            <span class="contact-info-value">

                                <a href="mailto:info@naukari24.in">
                                    info@naukari24.in
                                </a>

                            </span>

                        </div>

                    </div>


                    <!-- PHONE -->

                    <div class="contact-info">

                        <div class="contact-info-icon">

                            <i class="bi bi-telephone"></i>

                        </div>

                        <div class="contact-info-content">

                            <span class="contact-info-label">
                                Phone
                            </span>

                            <span class="contact-info-value">

                                <a href="tel:+919555580458">
                                    +91 95555 80458
                                </a>

                            </span>

                        </div>

                    </div>


                    <!-- ADDRESS -->

                    <div class="contact-info">

                        <div class="contact-info-icon">

                            <i class="bi bi-geo-alt"></i>

                        </div>

                        <div class="contact-info-content">

                            <span class="contact-info-label">
                                Address
                            </span>

                            <span class="contact-info-value">
                                India
                            </span>

                        </div>

                    </div>


                    <!-- SUPPORT -->

                    <div class="contact-info">

                        <div class="contact-info-icon">

                            <i class="bi bi-headset"></i>

                        </div>

                        <div class="contact-info-content">

                            <span class="contact-info-label">
                                Support
                            </span>

                            <span class="contact-info-value">
                                Job Seekers & Recruiters
                            </span>

                        </div>

                    </div>

                </div>


                <!-- =================================
                     CONTACT FORM
                ================================== -->

                <div class="contact-form-card">

                    <h2>
                        Send Us a Message
                    </h2>

                    <p class="contact-form-intro">
                        Fill out the form below and our team will
                        get back to you as soon as possible.
                    </p>


                    <asp:ValidationSummary
                        ID="vsContact"
                        runat="server"
                        CssClass="contact-message"
                        ForeColor="#b91c1c"
                        HeaderText="Please correct the following:"
                        DisplayMode="BulletList" />


                    <!-- NAME + EMAIL -->

                    <div class="contact-form-row">

                        <div class="contact-form-group">

                            <label>
                                Full Name
                            </label>

                            <asp:TextBox
                                ID="txtName"
                                runat="server"
                                CssClass="contact-input"
                                MaxLength="100"
                                placeholder="Enter your name">
                            </asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="rfvName"
                                runat="server"
                                ControlToValidate="txtName"
                                ErrorMessage="Please enter your name."
                                CssClass="contact-validation"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>

                        </div>


                        <div class="contact-form-group">

                            <label>
                                Email Address
                            </label>

                            <asp:TextBox
                                ID="txtEmail"
                                runat="server"
                                CssClass="contact-input"
                                MaxLength="150"
                                TextMode="Email"
                                placeholder="Enter your email">
                            </asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="rfvEmail"
                                runat="server"
                                ControlToValidate="txtEmail"
                                ErrorMessage="Please enter your email."
                                CssClass="contact-validation"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>

                            <asp:RegularExpressionValidator
                                ID="revEmail"
                                runat="server"
                                ControlToValidate="txtEmail"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                ErrorMessage="Please enter a valid email address."
                                CssClass="contact-validation"
                                Display="Dynamic">
                            </asp:RegularExpressionValidator>

                        </div>

                    </div>


                    <!-- MOBILE + SUBJECT -->

                    <div class="contact-form-row">

                        <div class="contact-form-group">

                            <label>
                                Mobile Number
                            </label>

                            <asp:TextBox
                                ID="txtMobile"
                                runat="server"
                                CssClass="contact-input"
                                MaxLength="10"
                                placeholder="Enter 10 digit mobile number">
                            </asp:TextBox>

                            <asp:RegularExpressionValidator
                                ID="revMobile"
                                runat="server"
                                ControlToValidate="txtMobile"
                                ValidationExpression="^[6-9][0-9]{9}$"
                                ErrorMessage="Please enter a valid 10 digit mobile number."
                                CssClass="contact-validation"
                                Display="Dynamic">
                            </asp:RegularExpressionValidator>

                        </div>


                        <div class="contact-form-group">

                            <label>
                                Subject
                            </label>

                            <asp:TextBox
                                ID="txtSubject"
                                runat="server"
                                CssClass="contact-input"
                                MaxLength="150"
                                placeholder="Enter subject">
                            </asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="rfvSubject"
                                runat="server"
                                ControlToValidate="txtSubject"
                                ErrorMessage="Please enter a subject."
                                CssClass="contact-validation"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>

                        </div>

                    </div>


                    <!-- MESSAGE -->

                    <div class="contact-form-group">

                        <label>
                            Message
                        </label>

                        <asp:TextBox
                            ID="txtMessage"
                            runat="server"
                            CssClass="contact-input"
                            TextMode="MultiLine"
                            MaxLength="2000"
                            placeholder="Write your message here...">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvMessage"
                            runat="server"
                            ControlToValidate="txtMessage"
                            ErrorMessage="Please enter your message."
                            CssClass="contact-validation"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>

                    </div>


                    <!-- MESSAGE -->

                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        Visible="false">
                    </asp:Label>


                    <!-- BUTTON -->

                    <asp:Button
                        ID="btnSendMessage"
                        runat="server"
                        Text="Send Message"
                        CssClass="contact-submit"
                        OnClick="btnSendMessage_Click" />

                </div>

            </div>

        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
