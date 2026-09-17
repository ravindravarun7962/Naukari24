<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CareerAdvice.aspx.cs" Inherits="Success24_Job_Portal.Career.CareerAdvice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>

        .career-hero {
            background: linear-gradient(135deg, #f97316, #ea580c);
            padding: 75px 20px;
            color: #ffffff;
            text-align: center;
        }

        .career-hero h1 {
            font-size: 46px;
            font-weight: 800;
            margin-bottom: 18px;
        }

        .career-hero p {
            max-width: 760px;
            margin: auto;
            font-size: 18px;
            line-height: 1.7;
            opacity: 0.95;
        }

        .career-section {
            padding: 65px 20px;
        }

        .section-title {
            text-align: center;
            margin-bottom: 45px;
        }

        .section-title h2 {
            font-size: 34px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 12px;
        }

        .section-title p {
            color: #6b7280;
            max-width: 700px;
            margin: auto;
            line-height: 1.7;
        }

        .advice-card {
            height: 100%;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 18px;
            padding: 30px;
            transition: all 0.3s ease;
        }

        .advice-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.08);
        }

        .advice-icon {
            width: 58px;
            height: 58px;
            border-radius: 14px;
            background: #fff7ed;
            color: #f97316;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 25px;
            margin-bottom: 20px;
        }

        .advice-card h3 {
            font-size: 21px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 12px;
        }

        .advice-card p {
            color: #6b7280;
            line-height: 1.7;
            margin-bottom: 15px;
        }

        .advice-card ul {
            padding-left: 20px;
            margin-bottom: 0;
        }

        .advice-card li {
            color: #4b5563;
            margin-bottom: 9px;
            line-height: 1.5;
        }

        .career-tips {
            background: #f9fafb;
        }

        .tip-box {
            background: #ffffff;
            border-radius: 16px;
            padding: 25px;
            border: 1px solid #e5e7eb;
            height: 100%;
        }

        .tip-number {
            font-size: 28px;
            font-weight: 800;
            color: #f97316;
            margin-bottom: 10px;
        }

        .tip-box h4 {
            font-weight: 700;
            color: #111827;
            margin-bottom: 10px;
        }

        .tip-box p {
            color: #6b7280;
            line-height: 1.7;
            margin: 0;
        }

        .roadmap-section {
            background: #111827;
            color: #ffffff;
            padding: 70px 20px;
        }

        .roadmap-section .section-title h2 {
            color: #ffffff;
        }

        .roadmap-section .section-title p {
            color: #d1d5db;
        }

        .roadmap-card {
            position: relative;
            background: #1f2937;
            border: 1px solid #374151;
            border-radius: 18px;
            padding: 30px;
            height: 100%;
        }

        .roadmap-card span {
            display: inline-flex;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: #f97316;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            margin-bottom: 18px;
        }

        .roadmap-card h3 {
            font-size: 21px;
            font-weight: 700;
            margin-bottom: 12px;
        }

        .roadmap-card p {
            color: #d1d5db;
            line-height: 1.7;
            margin: 0;
        }

        .cta-section {
            padding: 70px 20px;
            text-align: center;
            background: #fff7ed;
        }

        .cta-section h2 {
            font-size: 35px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 15px;
        }

        .cta-section p {
            color: #6b7280;
            max-width: 650px;
            margin: 0 auto 28px;
            line-height: 1.7;
        }

        .cta-btn {
            display: inline-block;
            background: #f97316;
            color: #ffffff !important;
            padding: 13px 28px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 700;
            transition: all 0.3s ease;
        }

        .cta-btn:hover {
            background: #ea580c;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {

            .career-hero h1 {
                font-size: 34px;
            }

            .career-hero p {
                font-size: 16px;
            }

            .section-title h2 {
                font-size: 28px;
            }

            .cta-section h2 {
                font-size: 28px;
            }
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <!-- ==========================================
         HERO SECTION
    =========================================== -->

    <section class="career-hero">

        <div class="container">

            <h1>Career Advice</h1>

            <p>
                Build a stronger career with practical guidance on
                job searching, resumes, interviews, skills, networking
                and professional growth.
            </p>

        </div>

    </section>


    <!-- ==========================================
         CAREER ADVICE CARDS
    =========================================== -->

    <section class="career-section">

        <div class="container">

            <div class="section-title">

                <h2>Build Your Career With Confidence</h2>

                <p>
                    Whether you are starting your career or looking for
                    your next opportunity, the right preparation can make
                    your job search more effective.
                </p>

            </div>


            <div class="row g-4">

                <!-- Resume -->

                <div class="col-lg-4 col-md-6">

                    <div class="advice-card">

                        <div class="advice-icon">
                        <i class="bi bi-file-earmark-text"></i>

                        </div>

                        <h3>Build a Strong Resume</h3>

                        <p>
                            Your resume should clearly communicate your
                            skills, experience and achievements.
                        </p>

                        <ul>
                            <li>Keep your resume clear and easy to read.</li>
                            <li>Highlight relevant technical skills.</li>
                            <li>Use measurable achievements where possible.</li>
                            <li>Customize your resume for the job.</li>
                        </ul>

                    </div>

                </div>


                <!-- Job Search -->

                <div class="col-lg-4 col-md-6">

                    <div class="advice-card">

                        <div class="advice-icon">
                        <i class="bi bi-search"></i>

                        </div>

                        <h3>Search for the Right Job</h3>

                        <p>
                            A focused job search can help you find
                            opportunities that match your skills and goals.
                        </p>

                        <ul>
                            <li>Search using relevant job titles.</li>
                            <li>Use location and work-mode filters.</li>
                            <li>Read the complete job description.</li>
                            <li>Apply to roles matching your profile.</li>
                        </ul>

                    </div>

                </div>


                <!-- Interview -->

                <div class="col-lg-4 col-md-6">

                    <div class="advice-card">

                        <div class="advice-icon">
                            <i class="bi bi-chat-dots"></i>
                        </div>

                        <h3>Prepare for Interviews</h3>

                        <p>
                            Good preparation helps you communicate your
                            knowledge and experience more effectively.
                        </p>

                        <ul>
                            <li>Research the company before the interview.</li>
                            <li>Review the job requirements.</li>
                            <li>Practice common interview questions.</li>
                            <li>Prepare questions for the interviewer.</li>
                        </ul>

                    </div>

                </div>


                <!-- Skills -->

                <div class="col-lg-4 col-md-6">

                    <div class="advice-card">

                        <div class="advice-icon">
                            <i class="bi bi-code-slash"></i>
                        </div>

                        <h3>Develop Your Skills</h3>

                        <p>
                            Continuous learning can help you stay prepared
                            for changing job requirements.
                        </p>

                        <ul>
                            <li>Strengthen your core technical skills.</li>
                            <li>Work on practical projects.</li>
                            <li>Learn tools used in your target industry.</li>
                            <li>Keep your skills section updated.</li>
                        </ul>

                    </div>

                </div>


                <!-- Networking -->

                <div class="col-lg-4 col-md-6">

                    <div class="advice-card">

                        <div class="advice-icon">
                            <i class="bi bi-diagram-3"></i>
                        </div>

                        <h3>Build Your Network</h3>

                        <p>
                            Professional connections can help you discover
                            opportunities and learn from other professionals.
                        </p>

                        <ul>
                            <li>Maintain a professional online profile.</li>
                            <li>Connect with people in your industry.</li>
                            <li>Participate in professional communities.</li>
                            <li>Share useful work and learning.</li>
                        </ul>

                    </div>

                </div>


                <!-- Career Growth -->

                <div class="col-lg-4 col-md-6">

                    <div class="advice-card">

                        <div class="advice-icon">
                           <i class="bi bi-graph-up-arrow"></i>
                        </div>

                        <h3>Plan Your Career Growth</h3>

                        <p>
                            Having clear goals can help you decide which
                            skills and opportunities to pursue.
                        </p>

                        <ul>
                            <li>Define short-term career goals.</li>
                            <li>Identify skills you need to improve.</li>
                            <li>Track your professional progress.</li>
                            <li>Review your goals regularly.</li>
                        </ul>

                    </div>

                </div>

            </div>

        </div>

    </section>


    <!-- ==========================================
         QUICK TIPS
    =========================================== -->

    <section class="career-section career-tips">

        <div class="container">

            <div class="section-title">

                <h2>Smart Job Search Tips</h2>

                <p>
                    Small improvements in your job-search process can
                    make your applications more organized and effective.
                </p>

            </div>


            <div class="row g-4">

                <div class="col-lg-3 col-md-6">

                    <div class="tip-box">

                        <div class="tip-number">01</div>

                        <h4>Complete Your Profile</h4>

                        <p>
                            Keep your professional profile complete with
                            your skills, experience, education and resume.
                        </p>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="tip-box">

                        <div class="tip-number">02</div>

                        <h4>Apply Carefully</h4>

                        <p>
                            Read job requirements carefully before applying
                            and highlight relevant experience.
                        </p>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="tip-box">

                        <div class="tip-number">03</div>

                        <h4>Track Applications</h4>

                        <p>
                            Keep track of jobs you have applied for,
                            interview dates and application status.
                        </p>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="tip-box">

                        <div class="tip-number">04</div>

                        <h4>Keep Learning</h4>

                        <p>
                            Continue improving your skills while searching
                            for opportunities.
                        </p>

                    </div>

                </div>

            </div>

        </div>

    </section>


    <!-- ==========================================
         CAREER ROADMAP
    =========================================== -->

    <section class="roadmap-section">

        <div class="container">

            <div class="section-title">

                <h2>A Simple Career Roadmap</h2>

                <p>
                    Follow a practical process to prepare yourself
                    for your next career opportunity.
                </p>

            </div>


            <div class="row g-4">

                <div class="col-lg-3 col-md-6">

                    <div class="roadmap-card">

                        <span>1</span>

                        <h3>Know Yourself</h3>

                        <p>
                            Understand your interests, strengths,
                            experience and career goals.
                        </p>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="roadmap-card">

                        <span>2</span>

                        <h3>Build Skills</h3>

                        <p>
                            Develop the technical and professional skills
                            required for your target roles.
                        </p>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="roadmap-card">

                        <span>3</span>

                        <h3>Prepare</h3>

                        <p>
                            Improve your resume, portfolio and interview
                            preparation before applying.
                        </p>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="roadmap-card">

                        <span>4</span>

                        <h3>Take Action</h3>

                        <p>
                            Apply consistently, learn from feedback and
                            continue improving your approach.
                        </p>

                    </div>

                </div>

            </div>

        </div>

    </section>


    <!-- ==========================================
         CTA
    =========================================== -->

    <section class="cta-section">

        <div class="container">

            <h2>Ready to Find Your Next Opportunity?</h2>

            <p>
                Explore jobs that match your skills, experience and
                preferred location on Success24.
            </p>

            <a href="<%= ResolveUrl("~/Jobs.aspx") %>"
               class="cta-btn">

                <i class="fas fa-search me-2"></i>
                Search Jobs

            </a>

        </div>

    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
