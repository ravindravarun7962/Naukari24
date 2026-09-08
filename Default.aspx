<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Success24_Job_Portal.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <link href="<%= ResolveUrl("~/Assets/css/home.css") %>" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <!-- ==========================================
         HERO SECTION
    =========================================== -->

    <section class="hero-section">

        <div class="container">

            <div class="row align-items-center">

                <div class="col-lg-7">

                    <div class="hero-content">

                        <span class="hero-badge">
                            <i class="bi bi-stars"></i>
                            Your career starts here
                        </span>

                        <h1>
                            Find the right job.
                            <span>Build your future.</span>
                        </h1>

                        <p class="hero-description">
                            Discover opportunities from trusted companies,
                            apply with your profile and take the next step
                            in your career.
                        </p>


                        <!-- SEARCH BOX -->

                        <div class="job-search-box">

                            <div class="search-field">

                                <i class="bi bi-search"></i>

                                <asp:TextBox
                                    ID="txtKeyword"
                                    runat="server"
                                    CssClass="form-control"
                                    placeholder="Job title, skill or company">
                                </asp:TextBox>

                            </div>


                            <div class="search-divider"></div>


                            <div class="search-field">

                                <i class="bi bi-geo-alt"></i>

                                <asp:TextBox
                                    ID="txtLocation"
                                    runat="server"
                                    CssClass="form-control"
                                    placeholder="City or location">
                                </asp:TextBox>

                            </div>


                            <asp:Button
                                ID="btnSearch"
                                runat="server"
                                Text="Search Jobs"
                                CssClass="btn search-btn"
                                onclick="btnSearch_Click"
                                 />

                        </div>


                        <!-- POPULAR SEARCH -->

                        <div class="popular-search">

                            <span>Popular:</span>

                            <a href="Jobs.aspx?keyword=.NET">
                                .NET Developer
                            </a>

                            <a href="Jobs.aspx?keyword=Java">
                                Java
                            </a>

                            <a href="Jobs.aspx?keyword=React">
                                React
                            </a>

                            <a href="Jobs.aspx?keyword=Sales">
                                Sales
                            </a>

                        </div>

                    </div>

                </div>


                <!-- HERO RIGHT -->

                <div class="col-lg-5 d-none d-lg-block">

                    <div class="hero-visual">

                        <div class="hero-card main-stat-card">

                            <div class="stat-icon">
                                <i class="bi bi-briefcase"></i>
                            </div>

                            <div>
                                <strong>10,000+</strong>
                                <span>Jobs available</span>
                            </div>

                        </div>


                        <div class="hero-card candidate-card">

                            <div class="candidate-avatar">
                                <i class="bi bi-person"></i>
                            </div>

                            <div>
                                <strong>Easy Apply</strong>
                                <span>Apply using your profile</span>
                            </div>

                        </div>


                        <div class="hero-center-icon">

                            <i class="bi bi-briefcase-fill"></i>

                        </div>


                        <div class="floating-icon icon-one">
                            <i class="bi bi-code-slash"></i>
                        </div>

                        <div class="floating-icon icon-two">
                            <i class="bi bi-bar-chart"></i>
                        </div>

                        <div class="floating-icon icon-three">
                            <i class="bi bi-megaphone"></i>
                        </div>

                    </div>

                </div>

            </div>

        </div>

    </section>



    <!-- ==========================================
         STATS
    =========================================== -->

    <section class="stats-section">

        <div class="container">

            <div class="stats-wrapper">

                <div class="stat-item">

                    <strong>10K+</strong>

                    <span>
                        Active Jobs
                    </span>

                </div>

                <div class="stat-item">

                    <strong>5K+</strong>

                    <span>
                        Companies
                    </span>

                </div>

                <div class="stat-item">

                    <strong>50K+</strong>

                    <span>
                        Job Seekers
                    </span>

                </div>

                <div class="stat-item">

                    <strong>25K+</strong>

                    <span>
                        Successful Hires
                    </span>

                </div>

            </div>

        </div>

    </section>



    <!-- ==========================================
         POPULAR CATEGORIES
    =========================================== -->

    <section class="section-padding">

        <div class="container">

            <div class="section-heading">

                <div>

                    <span class="section-small-title">
                        EXPLORE OPPORTUNITIES
                    </span>

                    <h2>
                        Popular Job Categories
                    </h2>

                    <p>
                        Find opportunities across industries and
                        build the career you want.
                    </p>

                </div>

                <a href="Jobs.aspx"
                   class="view-all-link">

                    View all jobs

                    <i class="bi bi-arrow-right"></i>

                </a>

            </div>


            <div class="row g-4">


                <!-- IT -->

                <div class="col-xl-3 col-md-6">

                    <a href="Jobs.aspx?category=Software Development"
                       class="category-card">

                        <div class="category-icon">
                            <i class="bi bi-code-square"></i>
                        </div>

                        <div>

                            <h3>
                                IT & Software
                            </h3>

                            <p>
                                2,450 Jobs
                            </p>

                        </div>

                        <i class="bi bi-arrow-right category-arrow"></i>

                    </a>

                </div>


                <!-- SALES -->

                <div class="col-xl-3 col-md-6">

                    <a href="Jobs.aspx?category=Sales"
                       class="category-card">

                        <div class="category-icon">
                            <i class="bi bi-graph-up-arrow"></i>
                        </div>

                        <div>

                            <h3>
                                Sales
                            </h3>

                            <p>
                                1,820 Jobs
                            </p>

                        </div>

                        <i class="bi bi-arrow-right category-arrow"></i>

                    </a>

                </div>


                <!-- MARKETING -->

                <div class="col-xl-3 col-md-6">

                    <a href="Jobs.aspx?category=Marketing"
                       class="category-card">

                        <div class="category-icon">
                            <i class="bi bi-megaphone"></i>
                        </div>

                        <div>

                            <h3>
                                Marketing
                            </h3>

                            <p>
                                1,240 Jobs
                            </p>

                        </div>

                        <i class="bi bi-arrow-right category-arrow"></i>

                    </a>

                </div>


                <!-- FINANCE -->

                <div class="col-xl-3 col-md-6">

                    <a href="Jobs.aspx?category=Finance"
                       class="category-card">

                        <div class="category-icon">
                            <i class="bi bi-bank"></i>
                        </div>

                        <div>

                            <h3>
                                Finance
                            </h3>

                            <p>
                                950 Jobs
                            </p>

                        </div>

                        <i class="bi bi-arrow-right category-arrow"></i>

                    </a>

                </div>


                <!-- HR -->

                <div class="col-xl-3 col-md-6">

                    <a href="Jobs.aspx?category=Human Resources"
                       class="category-card">

                        <div class="category-icon">
                            <i class="bi bi-people"></i>
                        </div>

                        <div>

                            <h3>
                                Human Resources
                            </h3>

                            <p>
                                720 Jobs
                            </p>

                        </div>

                        <i class="bi bi-arrow-right category-arrow"></i>

                    </a>

                </div>


                <!-- CUSTOMER SUPPORT -->

                <div class="col-xl-3 col-md-6">

                    <a href="Jobs.aspx?category=Customer Support"
                       class="category-card">

                        <div class="category-icon">
                            <i class="bi bi-headset"></i>
                        </div>

                        <div>

                            <h3>
                                Customer Support
                            </h3>

                            <p>
                                1,120 Jobs
                            </p>

                        </div>

                        <i class="bi bi-arrow-right category-arrow"></i>

                    </a>

                </div>


                <!-- DESIGN -->

                <div class="col-xl-3 col-md-6">

                    <a href="Jobs.aspx?category=Design"
                       class="category-card">

                        <div class="category-icon">
                            <i class="bi bi-palette"></i>
                        </div>

                        <div>

                            <h3>
                                Design
                            </h3>

                            <p>
                                640 Jobs
                            </p>

                        </div>

                        <i class="bi bi-arrow-right category-arrow"></i>

                    </a>

                </div>


                <!-- HEALTHCARE -->

                <div class="col-xl-3 col-md-6">

                    <a href="Jobs.aspx?category=Healthcare"
                       class="category-card">

                        <div class="category-icon">
                            <i class="bi bi-heart-pulse"></i>
                        </div>

                        <div>

                            <h3>
                                Healthcare
                            </h3>

                            <p>
                                880 Jobs
                            </p>

                        </div>

                        <i class="bi bi-arrow-right category-arrow"></i>

                    </a>

                </div>

            </div>

        </div>

    </section>



    <!-- ==========================================
         FEATURED JOBS
    =========================================== -->

    <section class="section-padding featured-jobs-section">

        <div class="container">

            <div class="section-heading">

                <div>

                    <span class="section-small-title">
                        RECOMMENDED FOR YOU
                    </span>

                    <h2>
                        Featured Jobs
                    </h2>

                    <p>
                        Explore opportunities from companies
                        actively hiring.
                    </p>

                </div>

                <a href="Jobs.aspx"
                   class="view-all-link">

                    Browse all jobs

                    <i class="bi bi-arrow-right"></i>

                </a>

            </div>


            <div class="row g-4">


                <!-- JOB 1 -->

                <div class="col-lg-6">

                    <div class="job-card">

                        <div class="job-card-top">

                            <div class="company-logo-box">
                                M
                            </div>

                            <div class="job-main-info">

                                <div class="job-title-row">

                                    <h3>
                                        Full Stack .NET Developer
                                    </h3>

                                    <button type="button"
                                            class="save-job-btn">

                                        <i class="bi bi-bookmark"></i>

                                    </button>

                                </div>

                                <p class="company-name">
                                    Microsoft Technologies
                                </p>

                            </div>

                        </div>


                        <div class="job-meta">

                            <span>
                                <i class="bi bi-geo-alt"></i>
                                Noida
                            </span>

                            <span>
                                <i class="bi bi-briefcase"></i>
                                1-3 Years
                            </span>

                            <span>
                                <i class="bi bi-currency-rupee"></i>
                                4-7 LPA
                            </span>

                        </div>


                        <div class="job-skills">

                            <span>C#</span>
                            <span>ASP.NET</span>
                            <span>SQL Server</span>
                            <span>JavaScript</span>

                        </div>


                        <div class="job-card-bottom">

                            <span class="posted-time">
                                <i class="bi bi-clock"></i>
                                2 hours ago
                            </span>

                            <a href="JobDetails.aspx?id=1"
                               class="job-view-btn">

                                View Job

                                <i class="bi bi-arrow-right"></i>

                            </a>

                        </div>

                    </div>

                </div>


                <!-- JOB 2 -->

                <div class="col-lg-6">

                    <div class="job-card">

                        <div class="job-card-top">

                            <div class="company-logo-box">
                                T
                            </div>

                            <div class="job-main-info">

                                <div class="job-title-row">

                                    <h3>
                                        Software Engineer
                                    </h3>

                                    <button type="button"
                                            class="save-job-btn">

                                        <i class="bi bi-bookmark"></i>

                                    </button>

                                </div>

                                <p class="company-name">
                                    Tech Solutions Pvt. Ltd.
                                </p>

                            </div>

                        </div>


                        <div class="job-meta">

                            <span>
                                <i class="bi bi-geo-alt"></i>
                                Bengaluru
                            </span>

                            <span>
                                <i class="bi bi-briefcase"></i>
                                2-5 Years
                            </span>

                            <span>
                                <i class="bi bi-currency-rupee"></i>
                                6-10 LPA
                            </span>

                        </div>


                        <div class="job-skills">

                            <span>Java</span>
                            <span>Spring Boot</span>
                            <span>MySQL</span>

                        </div>


                        <div class="job-card-bottom">

                            <span class="posted-time">
                                <i class="bi bi-clock"></i>
                                5 hours ago
                            </span>

                            <a href="JobDetails.aspx?id=2"
                               class="job-view-btn">

                                View Job

                                <i class="bi bi-arrow-right"></i>

                            </a>

                        </div>

                    </div>

                </div>


                <!-- JOB 3 -->

                <div class="col-lg-6">

                    <div class="job-card">

                        <div class="job-card-top">

                            <div class="company-logo-box">
                                D
                            </div>

                            <div class="job-main-info">

                                <div class="job-title-row">

                                    <h3>
                                        React Developer
                                    </h3>

                                    <button type="button"
                                            class="save-job-btn">

                                        <i class="bi bi-bookmark"></i>

                                    </button>

                                </div>

                                <p class="company-name">
                                    Digital Systems
                                </p>

                            </div>

                        </div>


                        <div class="job-meta">

                            <span>
                                <i class="bi bi-geo-alt"></i>
                                Gurgaon
                            </span>

                            <span>
                                <i class="bi bi-briefcase"></i>
                                1-4 Years
                            </span>

                            <span>
                                <i class="bi bi-currency-rupee"></i>
                                5-9 LPA
                            </span>

                        </div>


                        <div class="job-skills">

                            <span>React</span>
                            <span>JavaScript</span>
                            <span>HTML</span>
                            <span>CSS</span>

                        </div>


                        <div class="job-card-bottom">

                            <span class="posted-time">
                                <i class="bi bi-clock"></i>
                                1 day ago
                            </span>

                            <a href="JobDetails.aspx?id=3"
                               class="job-view-btn">

                                View Job

                                <i class="bi bi-arrow-right"></i>

                            </a>

                        </div>

                    </div>

                </div>


                <!-- JOB 4 -->

                <div class="col-lg-6">

                    <div class="job-card">

                        <div class="job-card-top">

                            <div class="company-logo-box">
                                S
                            </div>

                            <div class="job-main-info">

                                <div class="job-title-row">

                                    <h3>
                                        Business Development Executive
                                    </h3>

                                    <button type="button"
                                            class="save-job-btn">

                                        <i class="bi bi-bookmark"></i>

                                    </button>

                                </div>

                                <p class="company-name">
                                    Success Enterprises
                                </p>

                            </div>

                        </div>


                        <div class="job-meta">

                            <span>
                                <i class="bi bi-geo-alt"></i>
                                Delhi
                            </span>

                            <span>
                                <i class="bi bi-briefcase"></i>
                                Fresher
                            </span>

                            <span>
                                <i class="bi bi-currency-rupee"></i>
                                3-5 LPA
                            </span>

                        </div>


                        <div class="job-skills">

                            <span>Sales</span>
                            <span>Communication</span>
                            <span>CRM</span>

                        </div>


                        <div class="job-card-bottom">

                            <span class="posted-time">
                                <i class="bi bi-clock"></i>
                                1 day ago
                            </span>

                            <a href="JobDetails.aspx?id=4"
                               class="job-view-btn">

                                View Job

                                <i class="bi bi-arrow-right"></i>

                            </a>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </section>



    <!-- ==========================================
         TOP COMPANIES
    =========================================== -->

    <section class="section-padding">

        <div class="container">

            <div class="section-heading">

                <div>

                    <span class="section-small-title">
                        TRUSTED EMPLOYERS
                    </span>

                    <h2>
                        Top Companies Hiring
                    </h2>

                    <p>
                        Explore opportunities from leading employers.
                    </p>

                </div>

                <a href="Companies.aspx"
                   class="view-all-link">

                    View companies

                    <i class="bi bi-arrow-right"></i>

                </a>

            </div>


            <div class="row g-4">

                <div class="col-lg-3 col-md-6">

                    <div class="company-card">

                        <div class="large-company-logo">
                            T
                        </div>

                        <h3>TCS</h3>

                        <p>
                            IT Services & Consulting
                        </p>

                        <span>
                            325 Open Jobs
                        </span>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="company-card">

                        <div class="large-company-logo">
                            I
                        </div>

                        <h3>Infosys</h3>

                        <p>
                            Technology Services
                        </p>

                        <span>
                            280 Open Jobs
                        </span>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="company-card">

                        <div class="large-company-logo">
                            W
                        </div>

                        <h3>Wipro</h3>

                        <p>
                            IT & Consulting
                        </p>

                        <span>
                            190 Open Jobs
                        </span>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="company-card">

                        <div class="large-company-logo">
                            A
                        </div>

                        <h3>Accenture</h3>

                        <p>
                            Technology & Consulting
                        </p>

                        <span>
                            240 Open Jobs
                        </span>

                    </div>

                </div>

            </div>

        </div>

    </section>



    <!-- ==========================================
         JOBS BY LOCATION
    =========================================== -->

    <section class="section-padding location-section">

        <div class="container">

            <div class="text-center section-title-center">

                <span class="section-small-title">
                    FIND JOBS NEAR YOU
                </span>

                <h2>
                    Explore Jobs by Location
                </h2>

                <p>
                    Find opportunities in India's leading job markets.
                </p>

            </div>


            <div class="location-grid">

                <a href="Jobs.aspx?location=Delhi"
                   class="location-card">

                    <i class="bi bi-geo-alt"></i>

                    <div>
                        <strong>Delhi</strong>
                        <span>1,250 Jobs</span>
                    </div>

                </a>


                <a href="Jobs.aspx?location=Noida"
                   class="location-card">

                    <i class="bi bi-geo-alt"></i>

                    <div>
                        <strong>Noida</strong>
                        <span>980 Jobs</span>
                    </div>

                </a>


                <a href="Jobs.aspx?location=Gurgaon"
                   class="location-card">

                    <i class="bi bi-geo-alt"></i>

                    <div>
                        <strong>Gurgaon</strong>
                        <span>1,120 Jobs</span>
                    </div>

                </a>


                <a href="Jobs.aspx?location=Bengaluru"
                   class="location-card">

                    <i class="bi bi-geo-alt"></i>

                    <div>
                        <strong>Bengaluru</strong>
                        <span>2,450 Jobs</span>
                    </div>

                </a>


                <a href="Jobs.aspx?location=Hyderabad"
                   class="location-card">

                    <i class="bi bi-geo-alt"></i>

                    <div>
                        <strong>Hyderabad</strong>
                        <span>1,560 Jobs</span>
                    </div>

                </a>


                <a href="Jobs.aspx?location=Pune"
                   class="location-card">

                    <i class="bi bi-geo-alt"></i>

                    <div>
                        <strong>Pune</strong>
                        <span>1,340 Jobs</span>
                    </div>

                </a>

            </div>

        </div>

    </section>



    <!-- ==========================================
         HOW IT WORKS
    =========================================== -->

    <section class="section-padding how-it-works">

        <div class="container">

            <div class="text-center section-title-center">

                <span class="section-small-title">
                    SIMPLE & FAST
                </span>

                <h2>
                    Your Next Job in 4 Steps
                </h2>

                <p>
                    Create your profile and start connecting with
                    employers looking for talent like you.
                </p>

            </div>


            <div class="row g-4 mt-3">

                <div class="col-lg-3 col-md-6">

                    <div class="step-card">

                        <span class="step-number">
                            01
                        </span>

                        <div class="step-icon">
                            <i class="bi bi-person-plus"></i>
                        </div>

                        <h3>
                            Create Profile
                        </h3>

                        <p>
                            Register and build your professional
                            profile.
                        </p>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="step-card">

                        <span class="step-number">
                            02
                        </span>

                        <div class="step-icon">
                            <i class="bi bi-search"></i>
                        </div>

                        <h3>
                            Find Jobs
                        </h3>

                        <p>
                            Search jobs by skill, location and
                            experience.
                        </p>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="step-card">

                        <span class="step-number">
                            03
                        </span>

                        <div class="step-icon">
                            <i class="bi bi-send-check"></i>
                        </div>

                        <h3>
                            Apply
                        </h3>

                        <p>
                            Apply directly using your Success24
                            profile.
                        </p>

                    </div>

                </div>


                <div class="col-lg-3 col-md-6">

                    <div class="step-card">

                        <span class="step-number">
                            04
                        </span>

                        <div class="step-icon">
                            <i class="bi bi-trophy"></i>
                        </div>

                        <h3>
                            Get Hired
                        </h3>

                        <p>
                            Interview with employers and land
                            your next opportunity.
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

            <div class="cta-box">

                <div>

                    <span class="cta-small">
                        READY FOR YOUR NEXT OPPORTUNITY?
                    </span>

                    <h2>
                        Create your profile and start applying today.
                    </h2>

                    <p>
                        Join thousands of job seekers finding
                        opportunities through Success24.
                    </p>

                </div>


                <div class="cta-buttons">

                    <a href="Register.aspx"
                       class="btn create-profile-btn">

                        Create Free Profile

                        <i class="bi bi-arrow-right"></i>

                    </a>

                    <a href="Jobs.aspx"
                       class="btn browse-jobs-btn">

                        Browse Jobs

                    </a>

                </div>

            </div>

        </div>

    </section>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
