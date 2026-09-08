<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Success24_Job_Portal.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>

        .register-section {
            min-height: 75vh;
            display: flex;
            align-items: center;
            padding: 80px 0;
            background: #f8fafc;
        }

        .register-heading {
            text-align: center;
            max-width: 600px;
            margin: 0 auto 45px;
        }

        .register-heading .small-title {
            display: inline-block;
            color: #2557a7;
            background: #edf4ff;
            padding: 7px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .register-heading h1 {
            color: #111827;
            font-size: 36px;
            font-weight: 800;
            letter-spacing: -1.2px;
            margin-bottom: 12px;
        }

        .register-heading p {
            color: #6b7280;
            font-size: 15px;
            line-height: 1.7;
            margin: 0;
        }


        /* ACCOUNT CARDS */

        .account-card {
            position: relative;
            height: 100%;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 18px;
            padding: 38px;
            transition: .25s ease;
            overflow: hidden;
        }

        .account-card:hover {
            transform: translateY(-5px);
            border-color: #b9cbe7;
            box-shadow: 0 20px 45px rgba(30, 50, 80, .09);
        }

        .account-icon {
            width: 68px;
            height: 68px;
            border-radius: 17px;
            background: #edf4ff;
            color: #2557a7;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 25px;
        }

        .employer-card .account-icon {
            background: #fff3ef;
            color: #ef6848;
        }

        .account-card h2 {
            color: #172033;
            font-size: 22px;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .account-description {
            color: #6b7280;
            font-size: 14px;
            line-height: 1.7;
            margin-bottom: 25px;
        }


        /* FEATURES */

        .account-features {
            list-style: none;
            padding: 0;
            margin: 0 0 30px;
        }

        .account-features li {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 13px;
            color: #4b5563;
            font-size: 13px;
        }

        .account-features i {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #edf4ff;
            color: #2557a7;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
        }

        .employer-card .account-features i {
            background: #fff3ef;
            color: #ef6848;
        }


        /* BUTTONS */

        .account-btn {
            width: 100%;
            height: 48px;
            border-radius: 9px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-size: 14px;
            font-weight: 700;
            transition: .2s;
        }

        .jobseeker-btn {
            background: #2557a7;
            color: white;
        }

        .jobseeker-btn:hover {
            background: #17478f;
            color: white;
        }

        .employer-btn {
            background: #ef6848;
            color: white;
        }

        .employer-btn:hover {
            background: #dc5839;
            color: white;
        }


        /* LOGIN */

        .already-account {
            text-align: center;
            margin-top: 35px;
            color: #6b7280;
            font-size: 14px;
        }

        .already-account a {
            color: #2557a7;
            font-weight: 700;
        }

        .already-account a:hover {
            text-decoration: underline;
        }


        /* RESPONSIVE */

        @media (max-width: 767px) {

            .register-section {
                padding: 55px 0;
            }

            .register-heading h1 {
                font-size: 30px;
            }

            .account-card {
                padding: 28px;
            }

        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="register-section">

        <div class="container">

            <!-- Heading -->

            <div class="register-heading">

                <span class="small-title">
                    JOIN NAUKARI24
                </span>

                <h1>
                    How do you want to use NAUKARI24?
                </h1>

                <p>
                    Choose the account that matches your needs.
                    You can find your next opportunity or start
                    hiring talented candidates.
                </p>

            </div>


            <div class="row justify-content-center g-4">


                <!-- =====================================
                     JOB SEEKER
                ====================================== -->

                <div class="col-lg-5 col-md-6">

                    <div class="account-card">

                        <div class="account-icon">

                            <i class="bi bi-person"></i>

                        </div>


                        <h2>
                            I'm looking for a job
                        </h2>


                        <p class="account-description">

                            Create your professional profile,
                            discover relevant opportunities and
                            apply directly to companies.

                        </p>


                        <ul class="account-features">

                            <li>

                                <i class="bi bi-check-lg"></i>

                                Create your professional profile

                            </li>

                            <li>

                                <i class="bi bi-check-lg"></i>

                                Search thousands of jobs

                            </li>

                            <li>

                                <i class="bi bi-check-lg"></i>

                                Upload and manage your resume

                            </li>

                            <li>

                                <i class="bi bi-check-lg"></i>

                                Track your applications

                            </li>

                            <li>

                                <i class="bi bi-check-lg"></i>

                                Get interview notifications

                            </li>

                        </ul>


                        <a href="<%= ResolveUrl("~/JobSeekerRegister.aspx") %>"
                           class="account-btn jobseeker-btn">

                            Register as Job Seeker

                            <i class="bi bi-arrow-right"></i>

                        </a>

                    </div>

                </div>



                <!-- =====================================
                     EMPLOYER
                ====================================== -->

                <div class="col-lg-5 col-md-6">

                    <div class="account-card employer-card">

                        <div class="account-icon">

                            <i class="bi bi-building"></i>

                        </div>


                        <h2>
                            I'm hiring candidates
                        </h2>


                        <p class="account-description">

                            Create your employer account,
                            post jobs and connect with candidates
                            who match your requirements.

                        </p>


                        <ul class="account-features">

                            <li>

                                <i class="bi bi-check-lg"></i>

                                Create your company profile

                            </li>

                            <li>

                                <i class="bi bi-check-lg"></i>

                                Post and manage jobs

                            </li>

                            <li>

                                <i class="bi bi-check-lg"></i>

                                Receive job applications

                            </li>

                            <li>

                                <i class="bi bi-check-lg"></i>

                                Shortlist candidates

                            </li>

                            <li>

                                <i class="bi bi-check-lg"></i>

                                Schedule interviews

                            </li>

                        </ul>


                        <a href="<%= ResolveUrl("~/Recruiter/RecruiterRegister.aspx") %>"
                           class="account-btn employer-btn">

                            Register as Employer

                            <i class="bi bi-arrow-right"></i>

                        </a>

                    </div>

                </div>

            </div>


            <!-- Already registered -->

            <div class="already-account">

                Already have a NAUKARI24 account?

                <a href="<%= ResolveUrl("~/Login.aspx") %>">
                    Login here
                </a>

            </div>

        </div>

    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
