<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="Success24_Job_Portal.AboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>

        /* =========================================
           ABOUT PAGE
        ========================================== */

        .about-page {
            background: #f8fafc;
            padding: 50px 20px;
        }

        .about-container {
            max-width: 1100px;
            margin: 0 auto;
        }


        /* =========================================
           HERO
        ========================================== */

        .about-hero {
            background: #111827;
            border-radius: 16px;
            padding: 55px 50px;
            color: #ffffff;
            margin-bottom: 25px;
        }

        .about-eyebrow {
            display: inline-block;
            margin-bottom: 12px;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
            color: #d1d5db;
            text-transform: uppercase;
        }

        .about-hero h1 {
            margin: 0 0 15px;
            font-size: 38px;
            line-height: 1.2;
            font-weight: 700;
        }

        .about-hero p {
            max-width: 700px;
            margin: 0;
            color: #d1d5db;
            font-size: 15px;
            line-height: 1.8;
        }


        /* =========================================
           CONTENT CARD
        ========================================== */

        .about-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 35px;
            margin-bottom: 20px;
        }

        .about-card h2 {
            margin: 0 0 14px;
            color: #111827;
            font-size: 22px;
            font-weight: 700;
        }

        .about-card p {
            margin: 0 0 14px;
            color: #4b5563;
            font-size: 14px;
            line-height: 1.8;
        }

        .about-card p:last-child {
            margin-bottom: 0;
        }


        /* =========================================
           FEATURE GRID
        ========================================== */

        .about-features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-bottom: 20px;
        }

        .about-feature {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 25px;
        }

        .about-feature-icon {
            width: 45px;
            height: 45px;
            border-radius: 10px;
            background: #f3f4f6;
            color: #374151;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
        }

        .about-feature-icon i {
            font-size: 20px;
        }

        .about-feature h3 {
            margin: 0 0 8px;
            font-size: 16px;
            font-weight: 700;
            color: #111827;
        }

        .about-feature p {
            margin: 0;
            color: #6b7280;
            font-size: 13px;
            line-height: 1.7;
        }


        /* =========================================
           HOW IT WORKS
        ========================================== */

        .about-steps {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-top: 20px;
        }

        .about-step {
            position: relative;
            padding: 25px;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
        }

        .step-number {
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: #111827;
            color: #ffffff;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .about-step h3 {
            margin: 0 0 8px;
            color: #111827;
            font-size: 16px;
            font-weight: 700;
        }

        .about-step p {
            margin: 0;
            color: #6b7280;
            font-size: 13px;
            line-height: 1.7;
        }


        /* =========================================
           CTA
        ========================================== */

        .about-cta {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 35px;
            text-align: center;
            margin-top: 20px;
        }

        .about-cta h2 {
            margin: 0 0 10px;
            color: #111827;
            font-size: 24px;
            font-weight: 700;
        }

        .about-cta p {
            margin: 0 auto 20px;
            max-width: 650px;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.7;
        }

        .about-cta-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .about-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 11px 17px;
            border-radius: 8px;
            background: #111827;
            color: #ffffff;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
        }

        .about-btn:hover {
            background: #1f2937;
            color: #ffffff;
            text-decoration: none;
        }

        .about-btn-outline {
            background: #ffffff;
            color: #111827;
            border: 1px solid #d1d5db;
        }

        .about-btn-outline:hover {
            background: #f9fafb;
            color: #111827;
        }


        /* =========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 900px) {

            .about-features,
            .about-steps {
                grid-template-columns: 1fr;
            }

        }


        @media (max-width: 700px) {

            .about-page {
                padding: 25px 15px;
            }

            .about-hero {
                padding: 35px 25px;
            }

            .about-hero h1 {
                font-size: 29px;
            }

            .about-hero p {
                font-size: 14px;
            }

            .about-card {
                padding: 25px 20px;
            }

        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="about-page">

        <div class="about-container">


            <!-- =====================================
                 HERO
            ====================================== -->

            <div class="about-hero">

                <span class="about-eyebrow">
                    ABOUT NAUKARI24
                </span>

                <h1>
                    Connecting Talent With Opportunity
                </h1>

                <p>
                    Naukari24 Job Portal is an online platform designed
                    to connect job seekers with recruiters and employers.
                    Our goal is to make job searching and recruitment
                    simpler, more accessible and more efficient.
                </p>

            </div>


            <!-- =====================================
                 WHO WE ARE
            ====================================== -->

            <div class="about-card">

                <h2>
                    Who We Are
                </h2>

                <p>
                    Naukari24 Job Portal provides a platform where job
                    seekers can discover career opportunities and
                    recruiters can find suitable candidates for their
                    organizations.
                </p>

                <p>
                    We bring job discovery, candidate profiles, resumes,
                    applications and recruitment activities together in
                    one convenient platform.
                </p>

            </div>


            <!-- =====================================
                 WHAT WE DO
            ====================================== -->

            <div class="about-card">

                <h2>
                    What We Do
                </h2>

                <p>
                    Our platform supports both sides of the recruitment
                    process.
                </p>

                <p>
                    Job seekers can create professional profiles, upload
                    resumes, search for relevant jobs and submit
                    applications to suitable opportunities.
                </p>

                <p>
                    Recruiters can create company profiles, publish job
                    openings, manage their job postings and review
                    candidate applications.
                </p>

            </div>


            <!-- =====================================
                 FEATURES
            ====================================== -->

            <div class="about-features">

                <div class="about-feature">

                    <div class="about-feature-icon">
                        <i class="bi bi-search"></i>
                    </div>

                    <h3>
                        Find Opportunities
                    </h3>

                    <p>
                        Search and discover job opportunities based on
                        your skills, experience, location and career
                        preferences.
                    </p>

                </div>


                <div class="about-feature">

                    <div class="about-feature-icon">
                        <i class="bi bi-person-check"></i>
                    </div>

                    <h3>
                        Build Your Profile
                    </h3>

                    <p>
                        Create a professional profile and maintain your
                        education, experience, skills and resume information.
                    </p>

                </div>


                <div class="about-feature">

                    <div class="about-feature-icon">
                        <i class="bi bi-people"></i>
                    </div>

                    <h3>
                        Connect Recruiters
                    </h3>

                    <p>
                        Recruiters can discover candidates, manage job
                        postings and review applications efficiently.
                    </p>

                </div>

            </div>


            <!-- =====================================
                 FOR JOB SEEKERS
            ====================================== -->

            <div class="about-card">

                <h2>
                    For Job Seekers
                </h2>

                <p>
                    Naukari24 helps job seekers take control of their
                    career search by providing tools to create and manage
                    their professional presence.
                </p>

                <p>
                    From searching for suitable positions to submitting
                    applications, the platform is designed to simplify
                    the journey from discovering an opportunity to
                    connecting with a recruiter.
                </p>

            </div>


            <!-- =====================================
                 FOR RECRUITERS
            ====================================== -->

            <div class="about-card">

                <h2>
                    For Recruiters
                </h2>

                <p>
                    Recruiters can use Naukari24 to publish job openings,
                    manage their recruitment activities and review
                    applications from potential candidates.
                </p>

                <p>
                    The recruiter dashboard provides tools to manage
                    jobs, applications, candidates and recruiter profile
                    information from one place.
                </p>

            </div>


            <!-- =====================================
                 HOW IT WORKS
            ====================================== -->

            <div class="about-card">

                <h2>
                    How Naukari24 Works
                </h2>

                <div class="about-steps">

                    <div class="about-step">

                        <div class="step-number">
                            1
                        </div>

                        <h3>
                            Create Your Profile
                        </h3>

                        <p>
                            Build your professional profile with relevant
                            personal, educational, experience and skill
                            information.
                        </p>

                    </div>


                    <div class="about-step">

                        <div class="step-number">
                            2
                        </div>

                        <h3>
                            Discover Opportunities
                        </h3>

                        <p>
                            Search for jobs that match your skills,
                            experience, preferred location and career goals.
                        </p>

                    </div>


                    <div class="about-step">

                        <div class="step-number">
                            3
                        </div>

                        <h3>
                            Apply & Connect
                        </h3>

                        <p>
                            Apply for suitable opportunities and connect
                            with recruiters during the hiring process.
                        </p>

                    </div>

                </div>

            </div>


            <!-- =====================================
                 MISSION
            ====================================== -->

            <div class="about-card">

                <h2>
                    Our Mission
                </h2>

                <p>
                    Our mission is to simplify the connection between
                    talented professionals and organizations looking for
                    the right people.
                </p>

                <p>
                    We aim to provide a straightforward and user-friendly
                    recruitment platform that helps people discover
                    meaningful career opportunities while helping
                    recruiters manage their hiring requirements.
                </p>

            </div>


            <!-- =====================================
                 CTA
            ====================================== -->

            <div class="about-cta">

                <h2>
                    Ready to Take the Next Step?
                </h2>

                <p>
                    Explore job opportunities or create your recruiter
                    account and start connecting with talent.
                </p>

                <div class="about-cta-buttons">

                    <a
                        href="<%= ResolveUrl("~/Jobs.aspx") %>"
                        class="about-btn">

                        <i class="bi bi-search"></i>

                        Find Jobs

                    </a>


                    <a
                        href="<%= ResolveUrl("~/Recruiter/Login.aspx") %>"
                        class="about-btn about-btn-outline">

                        <i class="bi bi-building"></i>

                        Recruiter Login

                    </a>

                </div>

            </div>


        </div>

    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
