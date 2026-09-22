<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Jobs.aspx.cs" Inherits="Success24_Job_Portal.Jobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
        .jobs-page {
            background: #f7f9fc;
            min-height: 100vh;
        }

        /* HERO */
        .jobs-hero {
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 100%);
            padding: 70px 20px 85px;
            color: #fff;
        }

        .jobs-hero-inner {
            max-width: 1180px;
            margin: auto;
            text-align: center;
        }

        .jobs-hero h1 {
            margin: 0 0 12px;
            font-size: 42px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .jobs-hero p {
            margin: 0 auto 32px;
            max-width: 700px;
            color: #dbeafe;
            font-size: 17px;
        }

        /* SEARCH */
        .job-search-box {
            max-width: 1050px;
            margin: auto;
            background: #fff;
            padding: 12px;
            border-radius: 16px;
            box-shadow: 0 15px 40px rgba(0,0,0,.18);
        }

        .job-search-grid {
            display: grid;
            grid-template-columns: 1.5fr 1fr 1fr auto;
            gap: 10px;
        }

        .search-input,
        .search-select {
            width: 100%;
            height: 52px;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            padding: 0 15px;
            font-size: 14px;
            color: #374151;
            outline: none;
            box-sizing: border-box;
        }

        .search-input:focus,
        .search-select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,.1);
        }

        .search-btn {
            height: 52px;
            border: none;
            border-radius: 10px;
            padding: 0 28px;
            background: #2563eb;
            color: #fff;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
        }

        .search-btn:hover {
            background: #1d4ed8;
        }

        /* MAIN */
        .jobs-container {
            max-width: 1180px;
            margin: -30px auto 0;
            padding: 0 20px 60px;
            position: relative;
        }

        .jobs-layout {
            display: grid;
            grid-template-columns: 250px minmax(0, 1fr);
            gap: 24px;
        }

        /* FILTER */
        .filter-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 22px;
            height: fit-content;
        }

        .filter-title {
            font-size: 18px;
            font-weight: 750;
            color: #111827;
            margin-bottom: 22px;
        }

        .filter-group {
            margin-bottom: 22px;
        }

        .filter-label {
            display: block;
            margin-bottom: 9px;
            font-size: 13px;
            font-weight: 700;
            color: #374151;
        }

        .filter-control {
            width: 100%;
            height: 43px;
            border: 1px solid #dfe3e8;
            border-radius: 8px;
            padding: 0 10px;
            font-size: 13px;
            box-sizing: border-box;
            color: #374151;
        }

        .clear-btn {
            width: 100%;
            height: 42px;
            border: 1px solid #d1d5db;
            background: #fff;
            color: #374151;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
        }

        .clear-btn:hover {
            background: #f9fafb;
        }

        /* RESULTS */
        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .results-title {
            font-size: 20px;
            font-weight: 750;
            color: #111827;
        }

        .results-count {
            font-size: 13px;
            color: #6b7280;
        }

        /* JOB CARD */
        .job-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 23px;
            margin-bottom: 15px;
            transition: all .2s ease;
        }

        .job-card:hover {
            transform: translateY(-2px);
            border-color: #bfdbfe;
            box-shadow: 0 10px 30px rgba(15,23,42,.07);
        }

        .job-card-top {
            display: flex;
            gap: 16px;
        }

        .company-logo {
            width: 58px;
            height: 58px;
            border-radius: 12px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            font-weight: 800;
            flex-shrink: 0;
        }

        .job-main {
            flex: 1;
            min-width: 0;
        }

        .job-title {
            margin: 0 0 5px;
            font-size: 19px;
            font-weight: 750;
            color: #111827;
        }

        .job-title a {
            color: inherit;
            text-decoration: none;
        }

        .job-title a:hover {
            color: #2563eb;
        }

        .company-name {
            font-size: 14px;
            color: #4b5563;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .job-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 9px 18px;
            color: #6b7280;
            font-size: 13px;
        }

        .job-meta span {
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .job-meta i {
            color: #64748b;
        }

        .job-bottom {
            margin-top: 18px;
            padding-top: 15px;
            border-top: 1px solid #f0f1f3;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .job-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 7px;
        }

        .job-tag {
            background: #f1f5f9;
            color: #475569;
            border-radius: 6px;
            padding: 6px 9px;
            font-size: 11px;
            font-weight: 600;
        }

        .salary {
            color: #047857;
            font-size: 13px;
            font-weight: 700;
        }

        .view-job-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 17px;
            border-radius: 8px;
            background: #2563eb;
            color: #fff !important;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            white-space: nowrap;
        }

        .view-job-btn:hover {
            background: #1d4ed8;
        }

        /* EMPTY */
        .empty-jobs {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            text-align: center;
            padding: 65px 20px;
        }

        .empty-jobs i {
            font-size: 42px;
            color: #9ca3af;
        }

        .empty-jobs h3 {
            margin: 15px 0 6px;
            color: #111827;
        }

        .empty-jobs p {
            color: #6b7280;
            margin: 0;
        }

        /* RESPONSIVE */
        @media (max-width: 950px) {

            .job-search-grid {
                grid-template-columns: 1fr 1fr;
            }

            .jobs-layout {
                grid-template-columns: 1fr;
            }

            .filter-card {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 15px;
            }

            .filter-title {
                grid-column: 1 / -1;
                margin-bottom: 0;
            }

            .filter-group {
                margin-bottom: 0;
            }

            .clear-btn {
                align-self: end;
            }
        }

        @media (max-width: 650px) {

            .jobs-hero {
                padding: 50px 15px 65px;
            }

            .jobs-hero h1 {
                font-size: 31px;
            }

            .jobs-hero p {
                font-size: 14px;
            }

            .job-search-grid {
                grid-template-columns: 1fr;
            }

            .jobs-container {
                padding: 0 12px 40px;
            }

            .filter-card {
                display: block;
            }

            .filter-group {
                margin-bottom: 15px;
            }

            .job-card {
                padding: 17px;
            }

            .job-card-top {
                gap: 12px;
            }

            .company-logo {
                width: 48px;
                height: 48px;
                font-size: 18px;
            }

            .job-title {
                font-size: 16px;
            }

            .job-bottom {
                flex-direction: column;
                align-items: stretch;
            }

            .view-job-btn {
                width: 100%;
            }

            .results-header {
                align-items: flex-start;
                flex-direction: column;
                gap: 4px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jobs-page">

        <!-- HERO -->

        <section class="jobs-hero">

            <div class="jobs-hero-inner">

                <h1>Find Your Dream Job</h1>

                <p>
                    Discover exciting opportunities from top companies
                    and take the next step in your career.
                </p>


                <div class="job-search-box">

                    <div class="job-search-grid">

                        <asp:TextBox
                            ID="txtSearch"
                            runat="server"
                            CssClass="search-input"
                            placeholder="Job title, skills or keywords">
                        </asp:TextBox>


                        <asp:TextBox
                            ID="txtLocation"
                            runat="server"
                            CssClass="search-input"
                            placeholder="City or location">
                        </asp:TextBox>


                        <asp:DropDownList
                            ID="ddlSearchCategory"
                            runat="server"
                            CssClass="search-select">
                        </asp:DropDownList>


                        <asp:Button
                            ID="btnSearch"
                            runat="server"
                            Text="Search Jobs"
                            CssClass="search-btn"
                            OnClick="btnSearch_Click" />

                    </div>

                </div>

            </div>

        </section>


        <!-- JOB RESULTS -->

        <div class="jobs-container">

            <div class="jobs-layout">

                <!-- FILTER -->

                <aside class="filter-card">

                    <div class="filter-title">
                        Filter Jobs
                    </div>


                    <div class="filter-group">

                        <label class="filter-label">
                            Employment Type
                        </label>

                        <asp:DropDownList
                            ID="ddlEmploymentType"
                            runat="server"
                            CssClass="filter-control">

                            <asp:ListItem Text="All Types" Value=""></asp:ListItem>
                            <asp:ListItem Text="Full Time" Value="Full Time"></asp:ListItem>
                            <asp:ListItem Text="Part Time" Value="Part Time"></asp:ListItem>
                            <asp:ListItem Text="Contract" Value="Contract"></asp:ListItem>
                            <asp:ListItem Text="Internship" Value="Internship"></asp:ListItem>

                        </asp:DropDownList>

                    </div>


                    <div class="filter-group">

                        <label class="filter-label">
                            Work Mode
                        </label>

                        <asp:DropDownList
                            ID="ddlWorkMode"
                            runat="server"
                            CssClass="filter-control">

                            <asp:ListItem Text="All Modes" Value=""></asp:ListItem>
                            <asp:ListItem Text="On-site" Value="On-site"></asp:ListItem>
                            <asp:ListItem Text="Remote" Value="Remote"></asp:ListItem>
                            <asp:ListItem Text="Hybrid" Value="Hybrid"></asp:ListItem>

                        </asp:DropDownList>

                    </div>


                    <div class="filter-group">

                        <label class="filter-label">
                            Experience
                        </label>

                        <asp:DropDownList
                            ID="ddlExperience"
                            runat="server"
                            CssClass="filter-control">

                            <asp:ListItem Text="Any Experience" Value=""></asp:ListItem>
                            <asp:ListItem Text="Fresher" Value="0"></asp:ListItem>
                            <asp:ListItem Text="1 - 2 Years" Value="24"></asp:ListItem>
                            <asp:ListItem Text="2 - 5 Years" Value="60"></asp:ListItem>
                            <asp:ListItem Text="5+ Years" Value="61"></asp:ListItem>

                        </asp:DropDownList>

                    </div>


                    <asp:Button
                        ID="btnClearFilters"
                        runat="server"
                        Text="Clear Filters"
                        CssClass="clear-btn"
                        OnClick="btnClearFilters_Click" />

                </aside>


                <!-- RESULTS -->

                <main>

                    <div class="results-header">

                        <div class="results-title">
                            Latest Jobs
                        </div>

                        <asp:Label
                            ID="lblResultCount"
                            runat="server"
                            CssClass="results-count">
                        </asp:Label>

                    </div>


                    <asp:Repeater
                        ID="rptJobs"
                        runat="server">

                        <ItemTemplate>

                            <div class="job-card">

                                <div class="job-card-top">

                                    <div class="company-logo">
                                        <%# GetCompanyInitial(Eval("CompanyName")) %>
                                    </div>


                                    <div class="job-main">

                                        <h2 class="job-title">

                                            <a href='<%# ResolveUrl("~/JobDetails.aspx?JobId=" + Eval("JobId")) %>'>

                                                <%# Server.HtmlEncode(Convert.ToString(Eval("JobTitle"))) %>

                                            </a>

                                        </h2>


                                        <div class="company-name">
                                            <%# Server.HtmlEncode(Convert.ToString(Eval("CompanyName"))) %>
                                        </div>


                                        <div class="job-meta">

                                            <span>
                                                <i class="bi bi-geo-alt"></i>
                                                <%# GetLocation(Eval("City"), Eval("State")) %>
                                            </span>


                                            <span>
                                                <i class="bi bi-briefcase"></i>
                                                <%# Server.HtmlEncode(Convert.ToString(Eval("EmploymentType"))) %>
                                            </span>


                                            <span>
                                                <i class="bi bi-laptop"></i>
                                                <%# Server.HtmlEncode(Convert.ToString(Eval("WorkMode"))) %>
                                            </span>

                                        </div>

                                    </div>

                                </div>


                                <div class="job-bottom">

                                    <div class="job-tags">

                                        <span class="job-tag">
                                            <%# Server.HtmlEncode(Convert.ToString(Eval("CategoryName"))) %>
                                        </span>


                                        <span class="job-tag">
                                            <%# GetExperience(Eval("MinExperienceMonths"), Eval("MaxExperienceMonths")) %>
                                        </span>


                                        <asp:PlaceHolder
                                            runat="server"
                                            Visible='<%# Convert.ToBoolean(Eval("SalaryVisible")) %>'>

                                            <span class="salary">
                                                <%# GetSalary(Eval("MinSalary"), Eval("MaxSalary")) %>
                                            </span>

                                        </asp:PlaceHolder>

                                    </div>


                                 <a
                                    href='<%# GetJobDetailsUrl(
                                        Eval("City"),
                                         Eval("CompanyName"),
                                        Eval("JobTitle")
                                    ) %>'
                                    class="job-view-btn">

                                    View Details

                                    <i class="bi bi-arrow-right"></i>

                                </a>

                                </div>

                            </div>

                        </ItemTemplate>

                    </asp:Repeater>


                    <asp:Panel
                        ID="pnlNoJobs"
                        runat="server"
                        Visible="false"
                        CssClass="empty-jobs">

                        <i class="bi bi-search"></i>

                        <h3>
                            No jobs found
                        </h3>

                        <p>
                            Try changing your search or filters.
                        </p>

                    </asp:Panel>

                </main>

            </div>

        </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
