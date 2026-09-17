<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InterviewTips.aspx.cs" Inherits="Success24_Job_Portal.InterviewTips" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>

        /* =========================================
           INTERVIEW TIPS PAGE
        ========================================== */

        .interview-page {
            background: #f8fafc;
            padding: 50px 20px;
        }

        .interview-container {
            max-width: 1100px;
            margin: 0 auto;
        }


        /* =========================================
           HERO
        ========================================== */

        .interview-hero {
            background: #111827;
            border-radius: 16px;
            padding: 45px 50px;
            color: #ffffff;
            margin-bottom: 25px;
        }

        .interview-eyebrow {
            display: inline-block;
            margin-bottom: 10px;
            color: #d1d5db;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .interview-hero h1 {
            margin: 0 0 12px;
            font-size: 36px;
            line-height: 1.2;
            font-weight: 700;
        }

        .interview-hero p {
            max-width: 720px;
            margin: 0;
            color: #d1d5db;
            font-size: 14px;
            line-height: 1.8;
        }


        /* =========================================
           INTRO
        ========================================== */

        .interview-intro {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 30px;
            margin-bottom: 20px;
        }

        .interview-intro h2 {
            margin: 0 0 10px;
            color: #111827;
            font-size: 22px;
            font-weight: 700;
        }

        .interview-intro p {
            margin: 0;
            color: #4b5563;
            font-size: 14px;
            line-height: 1.8;
        }


        /* =========================================
           TIPS GRID
        ========================================== */

        .interview-tips-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .interview-tip {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 25px;
            transition: all 0.2s ease;
        }

        .interview-tip:hover {
            border-color: #d1d5db;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
            transform: translateY(-2px);
        }

        .interview-tip-top {
            display: flex;
            align-items: center;
            gap: 13px;
            margin-bottom: 13px;
        }

        .interview-tip-icon {
            width: 42px;
            height: 42px;
            min-width: 42px;
            border-radius: 9px;
            background: #f3f4f6;
            color: #374151;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .interview-tip-icon i {
            font-size: 18px;
        }

        .interview-tip-number {
            color: #9ca3af;
            font-size: 11px;
            font-weight: 700;
        }

        .interview-tip h3 {
            margin: 0;
            color: #111827;
            font-size: 16px;
            font-weight: 700;
        }

        .interview-tip p {
            margin: 0;
            color: #6b7280;
            font-size: 13px;
            line-height: 1.7;
        }


        /* =========================================
           BEFORE INTERVIEW
        ========================================== */

        .interview-checklist {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 30px;
            margin-top: 20px;
        }

        .interview-checklist h2 {
            margin: 0 0 18px;
            color: #111827;
            font-size: 21px;
            font-weight: 700;
        }

        .checklist-item {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 12px 0;
            border-top: 1px solid #f0f1f3;
        }

        .checklist-item:first-of-type {
            border-top: 0;
        }

        .checklist-icon {
            color: #374151;
            font-size: 16px;
            margin-top: 2px;
        }

        .checklist-item span {
            color: #4b5563;
            font-size: 13px;
            line-height: 1.6;
        }


        /* =========================================
           COMMON QUESTIONS
        ========================================== */

        .questions-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 30px;
            margin-top: 20px;
        }

        .questions-card h2 {
            margin: 0 0 18px;
            color: #111827;
            font-size: 21px;
            font-weight: 700;
        }

        .question-item {
            padding: 15px 0;
            border-top: 1px solid #f0f1f3;
        }

        .question-item:first-of-type {
            border-top: 0;
        }

        .question-item h3 {
            margin: 0 0 7px;
            color: #111827;
            font-size: 14px;
            font-weight: 700;
        }

        .question-item p {
            margin: 0;
            color: #6b7280;
            font-size: 13px;
            line-height: 1.7;
        }


        /* =========================================
           CTA
        ========================================== */

        .interview-cta {
            margin-top: 20px;
            padding: 35px;
            background: #111827;
            border-radius: 14px;
            text-align: center;
        }

        .interview-cta h2 {
            margin: 0 0 10px;
            color: #ffffff;
            font-size: 24px;
            font-weight: 700;
        }

        .interview-cta p {
            max-width: 650px;
            margin: 0 auto 20px;
            color: #d1d5db;
            font-size: 13px;
            line-height: 1.7;
        }

        .interview-cta-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 11px 18px;
            border-radius: 8px;
            background: #ffffff;
            color: #111827;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
        }

        .interview-cta-btn:hover {
            background: #f3f4f6;
            color: #111827;
            text-decoration: none;
        }


        /* =========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 800px) {

            .interview-tips-grid {
                grid-template-columns: 1fr;
            }

        }

        @media (max-width: 650px) {

            .interview-page {
                padding: 25px 15px;
            }

            .interview-hero {
                padding: 35px 25px;
            }

            .interview-hero h1 {
                font-size: 29px;
            }

            .interview-intro,
            .interview-checklist,
            .questions-card {
                padding: 25px 20px;
            }

        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="interview-page">

        <div class="interview-container">


            <!-- =====================================
                 HERO
            ====================================== -->

            <div class="interview-hero">

                <span class="interview-eyebrow">
                    CAREER GUIDANCE
                </span>

                <h1>
                    Interview Tips
                </h1>

                <p>
                    Prepare with confidence and improve your chances of
                    making a great impression. Explore practical interview
                    tips for freshers and experienced professionals.
                </p>

            </div>


            <!-- =====================================
                 INTRO
            ====================================== -->

            <div class="interview-intro">

                <h2>
                    Prepare Before Your Interview
                </h2>

                <p>
                    Good interview preparation helps you communicate your
                    skills, experience and career goals clearly. Research
                    the company, understand the job description and prepare
                    examples from your experience before attending the
                    interview.
                </p>

            </div>


            <!-- =====================================
                 INTERVIEW TIPS
            ====================================== -->

            <div class="interview-tips-grid">


                <!-- TIP 1 -->

                <div class="interview-tip">

                    <div class="interview-tip-top">

                        <div class="interview-tip-icon">
                            <i class="bi bi-building"></i>
                        </div>

                        <div>
                            <span class="interview-tip-number">
                                TIP 01
                            </span>

                            <h3>
                                Research the Company
                            </h3>
                        </div>

                    </div>

                    <p>
                        Learn about the company's products, services,
                        culture and recent activities before your interview.
                    </p>

                </div>


                <!-- TIP 2 -->

                <div class="interview-tip">

                    <div class="interview-tip-top">

                        <div class="interview-tip-icon">
                            <i class="bi bi-file-earmark-text"></i>
                        </div>

                        <div>
                            <span class="interview-tip-number">
                                TIP 02
                            </span>

                            <h3>
                                Understand the Job Description
                            </h3>
                        </div>

                    </div>

                    <p>
                        Carefully review the responsibilities and required
                        skills so you can connect your experience to the
                        position.
                    </p>

                </div>


                <!-- TIP 3 -->

                <div class="interview-tip">

                    <div class="interview-tip-top">

                        <div class="interview-tip-icon">
                            <i class="bi bi-person-video3"></i>
                        </div>

                        <div>
                            <span class="interview-tip-number">
                                TIP 03
                            </span>

                            <h3>
                                Practice Your Introduction
                            </h3>
                        </div>

                    </div>

                    <p>
                        Prepare a short and professional introduction
                        covering your experience, skills and career goals.
                    </p>

                </div>


                <!-- TIP 4 -->

                <div class="interview-tip">

                    <div class="interview-tip-top">

                        <div class="interview-tip-icon">
                            <i class="bi bi-chat-square-text"></i>
                        </div>

                        <div>
                            <span class="interview-tip-number">
                                TIP 04
                            </span>

                            <h3>
                                Communicate Clearly
                            </h3>

                        </div>

                    </div>

                    <p>
                        Listen carefully to questions and answer clearly.
                        Avoid unnecessary explanations and stay focused.
                    </p>

                </div>


                <!-- TIP 5 -->

                <div class="interview-tip">

                    <div class="interview-tip-top">

                        <div class="interview-tip-icon">
                            <i class="bi bi-code-slash"></i>
                        </div>

                        <div>
                            <span class="interview-tip-number">
                                TIP 05
                            </span>

                            <h3>
                                Prepare Technical Questions
                            </h3>

                        </div>

                    </div>

                    <p>
                        For technical roles, revise important concepts,
                        projects, programming fundamentals and technologies
                        mentioned in the job description.
                    </p>

                </div>


                <!-- TIP 6 -->

                <div class="interview-tip">

                    <div class="interview-tip-top">

                        <div class="interview-tip-icon">
                            <i class="bi bi-folder-check"></i>
                        </div>

                        <div>
                            <span class="interview-tip-number">
                                TIP 06
                            </span>

                            <h3>
                                Know Your Projects
                            </h3>

                        </div>

                    </div>

                    <p>
                        Be ready to explain your projects, your role,
                        technologies used, challenges faced and how you
                        solved problems.
                    </p>

                </div>


                <!-- TIP 7 -->

                <div class="interview-tip">

                    <div class="interview-tip-top">

                        <div class="interview-tip-icon">
                            <i class="bi bi-clock"></i>
                        </div>

                        <div>
                            <span class="interview-tip-number">
                                TIP 07
                            </span>

                            <h3>
                                Be Punctual
                            </h3>

                        </div>

                    </div>

                    <p>
                        Join online interviews a few minutes early and
                        reach the interview location with enough time
                        to settle in.
                    </p>

                </div>


                <!-- TIP 8 -->

                <div class="interview-tip">

                    <div class="interview-tip-top">

                        <div class="interview-tip-icon">
                            <i class="bi bi-person-check"></i>
                        </div>

                        <div>
                            <span class="interview-tip-number">
                                TIP 08
                            </span>

                            <h3>
                                Dress Professionally
                            </h3>

                        </div>

                    </div>

                    <p>
                        Choose clean and professional clothing suitable
                        for the company and interview environment.
                    </p>

                </div>


                <!-- TIP 9 -->

                <div class="interview-tip">

                    <div class="interview-tip-top">

                        <div class="interview-tip-icon">
                            <i class="bi bi-lightbulb"></i>
                        </div>

                        <div>
                            <span class="interview-tip-number">
                                TIP 09
                            </span>

                            <h3>
                                Use Real Examples
                            </h3>

                        </div>

                    </div>

                    <p>
                        When answering behavioral questions, use real
                        examples from your projects, internship or
                        professional experience.
                    </p>

                </div>


                <!-- TIP 10 -->

                <div class="interview-tip">

                    <div class="interview-tip-top">

                        <div class="interview-tip-icon">
                            <i class="bi bi-question-circle"></i>
                        </div>

                        <div>
                            <span class="interview-tip-number">
                                TIP 10
                            </span>

                            <h3>
                                Ask Relevant Questions
                            </h3>

                        </div>

                    </div>

                    <p>
                        Prepare a few thoughtful questions about the role,
                        team, responsibilities and growth opportunities.
                    </p>

                </div>

            </div>


            <!-- =====================================
                 CHECKLIST
            ====================================== -->

            <div class="interview-checklist">

                <h2>
                    Interview Day Checklist
                </h2>


                <div class="checklist-item">

                    <i class="bi bi-check-circle checklist-icon"></i>

                    <span>
                        Carry or keep a copy of your updated resume.
                    </span>

                </div>


                <div class="checklist-item">

                    <i class="bi bi-check-circle checklist-icon"></i>

                    <span>
                        Keep important documents and certificates ready
                        if required.
                    </span>

                </div>


                <div class="checklist-item">

                    <i class="bi bi-check-circle checklist-icon"></i>

                    <span>
                        Check your internet connection and microphone for
                        online interviews.
                    </span>

                </div>


                <div class="checklist-item">

                    <i class="bi bi-check-circle checklist-icon"></i>

                    <span>
                        Keep the job description and company information
                        available for quick reference.
                    </span>

                </div>


                <div class="checklist-item">

                    <i class="bi bi-check-circle checklist-icon"></i>

                    <span>
                        Stay calm, confident and professional throughout
                        the interview.
                    </span>

                </div>

            </div>


            <!-- =====================================
                 COMMON QUESTIONS
            ====================================== -->

            <div class="questions-card">

                <h2>
                    Common Interview Questions
                </h2>


                <div class="question-item">

                    <h3>
                        Tell me about yourself.
                    </h3>

                    <p>
                        Give a concise introduction covering your education,
                        experience, important skills, projects and current
                        career goal.
                    </p>

                </div>


                <div class="question-item">

                    <h3>
                        Why should we hire you?
                    </h3>

                    <p>
                        Explain how your skills, experience and approach
                        can contribute to the requirements of the role.
                    </p>

                </div>


                <div class="question-item">

                    <h3>
                        What are your strengths?
                    </h3>

                    <p>
                        Choose strengths that are relevant to the position
                        and support them with practical examples.
                    </p>

                </div>


                <div class="question-item">

                    <h3>
                        Tell me about your project.
                    </h3>

                    <p>
                        Explain the project's purpose, your responsibilities,
                        technologies used, challenges and solutions.
                    </p>

                </div>


                <div class="question-item">

                    <h3>
                        Do you have any questions for us?
                    </h3>

                    <p>
                        Ask relevant questions about the position, team,
                        responsibilities, expectations or career growth.
                    </p>

                </div>

            </div>


            <!-- =====================================
                 CTA
            ====================================== -->

            <div class="interview-cta">

                <h2>
                    Ready for Your Next Opportunity?
                </h2>

                <p>
                    Find jobs that match your skills and start your
                    next career opportunity with Success24 Job Portal.
                </p>

                <a
                    href="<%= ResolveUrl("~/Jobs.aspx") %>"
                    class="interview-cta-btn">

                    <i class="bi bi-search"></i>

                    Find Jobs

                </a>

            </div>


        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
