<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="RecruiterProfile.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.RecruiterProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
      My Profile
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>

    * {
        box-sizing: border-box;
    }

    .recruiter-profile-page {
        max-width: 1200px;
        margin: 0 auto;
        padding: 32px;
    }

    /* ==============================
       HEADER
    ============================== */

    .profile-page-heading {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        gap: 20px;
        margin-bottom: 24px;
    }

    .profile-page-heading span {
        font-size: 11px;
        font-weight: 700;
        letter-spacing: 1.5px;
        color: #6b7280;
        text-transform: uppercase;
    }

    .profile-page-heading h1 {
        margin: 5px 0 6px;
        font-size: 30px;
        color: #111827;
        font-weight: 750;
    }

    .profile-page-heading p {
        margin: 0;
        color: #6b7280;
        font-size: 14px;
    }

    .edit-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 11px 18px;
        border-radius: 9px;
        background: #111827;
        color: #fff;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: .2s;
    }

    .edit-btn:hover {
        background: #1f2937;
        color: #fff;
    }

    /* ==============================
       PROFILE HERO
    ============================== */

    .profile-hero {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 16px;
        overflow: hidden;
        margin-bottom: 22px;
    }

    .cover-area {
        height: 145px;
        background:
            linear-gradient(
                135deg,
                #111827 0%,
                #1f2937 50%,
                #374151 100%
            );
        position: relative;
    }

    .cover-pattern {
        position: absolute;
        inset: 0;
        opacity: .12;
        background-image:
            radial-gradient(
                circle at 20% 20%,
                #fff 1px,
                transparent 1px
            );
        background-size: 20px 20px;
    }

    .hero-content {
        padding: 0 30px 28px;
        position: relative;
    }

    .profile-avatar-wrapper {
        margin-top: -55px;
        position: relative;
        width: 110px;
        height: 110px;
    }

    .profile-avatar {
        width: 110px;
        height: 110px;
        border-radius: 50%;
        border: 5px solid #fff;
        background: #111827;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        box-shadow: 0 5px 20px rgba(0,0,0,.12);
    }

    .profile-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .profile-initial {
        color: #fff;
        font-size: 40px;
        font-weight: 700;
    }

    .verified-badge {
        position: absolute;
        right: -2px;
        bottom: 5px;
        width: 29px;
        height: 29px;
        border-radius: 50%;
        background: #2563eb;
        color: #fff;
        border: 3px solid #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
    }

    .hero-main {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        gap: 25px;
        margin-top: 16px;
    }

    .hero-name {
        margin: 0;
        font-size: 25px;
        color: #111827;
        font-weight: 750;
    }

    .hero-designation {
        margin: 6px 0 12px;
        font-size: 15px;
        color: #4b5563;
    }

    .hero-contact {
        display: flex;
        flex-wrap: wrap;
        gap: 18px;
        color: #6b7280;
        font-size: 13px;
    }

    .hero-contact span {
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .hero-contact i {
        color: #374151;
    }

    .verification-text {
        display: flex;
        align-items: center;
        gap: 7px;
        color: #2563eb;
        font-size: 13px;
        font-weight: 600;
        white-space: nowrap;
    }

    /* ==============================
       GRID
    ============================== */

    .profile-grid {
        display: grid;
        grid-template-columns: minmax(0, 2fr) minmax(300px, 1fr);
        gap: 22px;
        align-items: start;
    }

    .profile-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        margin-bottom: 22px;
        overflow: hidden;
    }

    .card-header {
        padding: 20px 22px 16px;
        border-bottom: 1px solid #f0f1f3;
    }

    .card-header h2 {
        margin: 0;
        font-size: 18px;
        color: #111827;
    }

    .card-header p {
        margin: 5px 0 0;
        font-size: 12px;
        color: #9ca3af;
    }

    .card-body {
        padding: 22px;
    }

    /* ==============================
       ABOUT
    ============================== */

    .about-text {
        margin: 0;
        color: #4b5563;
        font-size: 14px;
        line-height: 1.8;
    }

    .empty-state {
        text-align: center;
        padding: 25px 10px;
        color: #9ca3af;
        font-size: 13px;
    }

    .empty-state i {
        display: block;
        font-size: 28px;
        margin-bottom: 8px;
    }

    /* ==============================
       INFORMATION LIST
    ============================== */

    .info-list {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 18px;
    }

    .info-item {
        padding: 15px;
        border: 1px solid #eef0f3;
        border-radius: 10px;
        background: #fafafa;
    }

    .info-item span {
        display: block;
        color: #9ca3af;
        font-size: 11px;
        margin-bottom: 6px;
    }

    .info-item strong {
        color: #111827;
        font-size: 14px;
        font-weight: 600;
        word-break: break-word;
    }

    /* ==============================
       ACCOUNT CARD
    ============================== */

    .account-row {
        display: flex;
        align-items: center;
        gap: 13px;
        padding: 14px 0;
        border-bottom: 1px solid #f0f1f3;
    }

    .account-row:last-child {
        border-bottom: 0;
        padding-bottom: 0;
    }

    .account-icon {
        width: 38px;
        height: 38px;
        border-radius: 9px;
        background: #f3f4f6;
        color: #374151;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .account-info {
        min-width: 0;
    }

    .account-info span {
        display: block;
        color: #9ca3af;
        font-size: 11px;
        margin-bottom: 3px;
    }

    .account-info strong {
        color: #111827;
        font-size: 13px;
        word-break: break-word;
    }

    /* ==============================
       PROFILE STRENGTH
    ============================== */

    .strength-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }

    .strength-header span {
        font-size: 13px;
        color: #4b5563;
    }

    .strength-header strong {
        font-size: 14px;
        color: #111827;
    }

    .progress-track {
        width: 100%;
        height: 8px;
        background: #eef0f3;
        border-radius: 20px;
        overflow: hidden;
    }

    .progress-bar {
        height: 100%;
        width: 100%;
        background: #111827;
        border-radius: 20px;
    }

    .strength-message {
        margin: 12px 0 0;
        color: #6b7280;
        font-size: 12px;
        line-height: 1.6;
    }

    /* ==============================
       ACTIONS
    ============================== */

    .profile-actions {
        display: flex;
        gap: 10px;
        margin-top: 18px;
    }

    .profile-action {
        flex: 1;
        text-align: center;
        padding: 10px;
        border-radius: 8px;
        text-decoration: none;
        font-size: 12px;
        font-weight: 600;
        border: 1px solid #e5e7eb;
        color: #374151;
        background: #fff;
    }

    .profile-action:hover {
        background: #f9fafb;
        color: #111827;
    }

    /* ==============================
       RESPONSIVE
    ============================== */

    @media (max-width: 900px) {

        .profile-grid {
            grid-template-columns: 1fr;
        }

    }

    @media (max-width: 650px) {

        .recruiter-profile-page {
            padding: 20px 14px;
        }

        .profile-page-heading {
            align-items: flex-start;
            flex-direction: column;
        }

        .hero-content {
            padding: 0 20px 22px;
        }

        .hero-main {
            flex-direction: column;
        }

        .info-list {
            grid-template-columns: 1fr;
        }

        .hero-contact {
            flex-direction: column;
            gap: 8px;
        }

    }

</style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
        My Profile
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="recruiter-profile-page">

    <!-- PAGE HEADER -->

    <div class="profile-page-heading">

        <div>

            <span>ACCOUNT</span>

            <h1>My Profile</h1>

            <p>
                Manage your recruiter profile and professional information.
            </p>

        </div>

        <a
            href="#"
            class="edit-btn">

            <i class="bi bi-pencil-square"></i>

            Edit Profile

        </a>

    </div>


    <!-- PROFILE HERO -->

    <div class="profile-hero">

        <div class="cover-area">
            <div class="cover-pattern"></div>
        </div>

        <div class="hero-content">

            <div class="profile-avatar-wrapper">

                <div class="profile-avatar">

                    <asp:Image
                        ID="imgProfile"
                        runat="server"
                        Visible="false" />

                    <asp:Label
                        ID="lblInitial"
                        runat="server"
                        CssClass="profile-initial">
                    </asp:Label>

                </div>

                <asp:Panel
                    ID="pnlVerified"
                    runat="server"
                    CssClass="verified-badge"
                    Visible="false">

                    <i class="bi bi-check-lg"></i>

                </asp:Panel>

            </div>


            <div class="hero-main">

                <div>

                    <h2 class="hero-name">

                        <asp:Label
                            ID="lblFullName"
                            runat="server">
                        </asp:Label>

                    </h2>

                    <div class="hero-designation">

                        <asp:Label
                            ID="lblDesignation"
                            runat="server">
                        </asp:Label>

                    </div>


                    <div class="hero-contact">

                        <span>

                            <i class="bi bi-envelope"></i>

                            <asp:Label
                                ID="lblEmail"
                                runat="server">
                            </asp:Label>

                        </span>


                        <span>

                            <i class="bi bi-phone"></i>

                            <asp:Label
                                ID="lblMobile"
                                runat="server">
                            </asp:Label>

                        </span>

                    </div>

                </div>


                <div class="verification-text">

                    <i class="bi bi-patch-check-fill"></i>

                    Verified Recruiter

                </div>

            </div>

        </div>

    </div>


    <!-- MAIN GRID -->

    <div class="profile-grid">


        <!-- LEFT -->

        <div>


            <!-- ABOUT -->

            <div class="profile-card">

                <div class="card-header">

                    <h2>About</h2>

                    <p>
                        Professional recruiter information
                    </p>

                </div>

                <div class="card-body">

                    <p class="about-text">

                        Welcome to your recruiter profile.
                        Keep your account information updated
                        to build trust with job seekers and
                        manage your recruitment activities.

                    </p>

                </div>

            </div>


            <!-- CONTACT INFORMATION -->

            <div class="profile-card">

                <div class="card-header">

                    <h2>Contact Information</h2>

                    <p>
                        Your registered account details
                    </p>

                </div>

                <div class="card-body">

                    <div class="info-list">


                        <div class="info-item">

                            <span>
                                Full Name
                            </span>

                            <strong>
                                <asp:Label
                                    ID="lblInfoName"
                                    runat="server">
                                </asp:Label>
                            </strong>

                        </div>


                        <div class="info-item">

                            <span>
                                Email Address
                            </span>

                            <strong>
                                <asp:Label
                                    ID="lblInfoEmail"
                                    runat="server">
                                </asp:Label>
                            </strong>

                        </div>


                        <div class="info-item">

                            <span>
                                Phone Number
                            </span>

                            <strong>
                                <asp:Label
                                    ID="lblInfoMobile"
                                    runat="server">
                                </asp:Label>
                            </strong>

                        </div>


                        <div class="info-item">

                            <span>
                                Designation
                            </span>

                            <strong>
                                <asp:Label
                                    ID="lblInfoDesignation"
                                    runat="server">
                                </asp:Label>
                            </strong>

                        </div>


                    </div>

                </div>

            </div>


        </div>


        <!-- RIGHT -->

        <div>


            <!-- PROFILE STRENGTH -->

            <div class="profile-card">

                <div class="card-header">

                    <h2>Profile Strength</h2>

                    <p>
                        Complete your profile
                    </p>

                </div>

                <div class="card-body">

                    <div class="strength-header">

                        <span>
                            Profile completed
                        </span>

                        <strong>
                            100%
                        </strong>

                    </div>

                    <div class="progress-track">

                        <div class="progress-bar"></div>

                    </div>

                    <p class="strength-message">

                        Your basic recruiter information is
                        available. Keep your profile updated
                        for a professional presence.

                    </p>

                </div>

            </div>


            <!-- ACCOUNT -->

            <div class="profile-card">

                <div class="card-header">

                    <h2>Account</h2>

                    <p>
                        Account information
                    </p>

                </div>

                <div class="card-body">


                    <div class="account-row">

                        <div class="account-icon">
                            <i class="bi bi-person"></i>
                        </div>

                        <div class="account-info">

                            <span>
                                Account Type
                            </span>

                            <strong>
                                Recruiter
                            </strong>

                        </div>

                    </div>


                    <div class="account-row">

                        <div class="account-icon">
                            <i class="bi bi-shield-check"></i>
                        </div>

                        <div class="account-info">

                            <span>
                                Account Status
                            </span>

                            <strong>
                                <asp:Label
                                    ID="lblAccountStatus"
                                    runat="server">
                                </asp:Label>
                            </strong>

                        </div>

                    </div>


                    <div class="account-row">

                        <div class="account-icon">
                            <i class="bi bi-person-badge"></i>
                        </div>

                        <div class="account-info">

                            <span>
                                Recruiter ID
                            </span>

                            <strong>
                                #<asp:Label
                                    ID="lblRecruiterId"
                                    runat="server">
                                </asp:Label>
                            </strong>

                        </div>

                    </div>


                </div>

            </div>


            <!-- QUICK ACTIONS -->

            <div class="profile-card">

                <div class="card-header">

                    <h2>Quick Actions</h2>

                    <p>
                        Manage your recruiter account
                    </p>

                </div>

                <div class="card-body">

                    <div class="profile-actions">

                        <a
                            href="JobPost.aspx"
                            class="profile-action">

                            <i class="bi bi-plus-circle"></i>
                            Post Job

                        </a>

                        <a
                            href="Jobs.aspx"
                            class="profile-action">

                            <i class="bi bi-briefcase"></i>
                            My Jobs

                        </a>

                    </div>

                </div>

            </div>


        </div>

    </div>

</div>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
