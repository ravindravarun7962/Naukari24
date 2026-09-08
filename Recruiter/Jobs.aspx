<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="Jobs.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.Jobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="<%= ResolveUrl("~/Assets/css/jobseeker-jobs.css") %>"
          rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="jobs-page">


        <!-- =========================================
             HEADER
        ========================================== -->

        <div class="jobs-page-header">

            <div>

                <span class="jobs-eyebrow">
                    JOB SEARCH
                </span>

                <h1>
                    Find your next opportunity
                </h1>

                <p>
                    Discover jobs that match your skills,
                    experience and career goals.
                </p>

            </div>

        </div>


        <!-- =========================================
             SEARCH
        ========================================== -->

        <div class="jobs-search-card">

            <div class="jobs-search-row">


                <!-- KEYWORD -->

                <div class="jobs-search-field">

                    <i class="bi bi-search"></i>

                    <asp:TextBox
                        ID="txtKeyword"
                        runat="server"
                        CssClass="jobs-search-input"
                        placeholder="Job title or company">
                    </asp:TextBox>

                </div>


                <!-- LOCATION -->

                <div class="jobs-search-field">

                    <i class="bi bi-geo-alt"></i>

                    <asp:TextBox
                        ID="txtLocation"
                        runat="server"
                        CssClass="jobs-search-input"
                        placeholder="City or state">
                    </asp:TextBox>

                </div>


                <!-- SEARCH -->

                <asp:Button
                    ID="btnSearch"
                    runat="server"
                    Text="Search Jobs"
                    CssClass="jobs-search-btn"
                    OnClick="btnSearch_Click" />

            </div>

        </div>


        <!-- =========================================
             RESULTS HEADER
        ========================================== -->

        <div class="jobs-results-header">

            <div>

                <h2>
                    Available Jobs
                </h2>

                <asp:Label
                    ID="lblJobCount"
                    runat="server"
                    CssClass="jobs-count">
                </asp:Label>

            </div>

            <asp:DropDownList
                ID="ddlSort"
                runat="server"
                CssClass="jobs-sort"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">

                <asp:ListItem
                    Text="Newest First"
                    Value="newest">
                </asp:ListItem>

                <asp:ListItem
                    Text="Oldest First"
                    Value="oldest">
                </asp:ListItem>

                <asp:ListItem
                    Text="Salary: High to Low"
                    Value="salary">
                </asp:ListItem>

            </asp:DropDownList>

        </div>


        <!-- =========================================
             JOB LIST
        ========================================== -->

        <asp:Panel
            ID="pnlJobs"
            runat="server">


            <div class="jobs-list">


                <asp:Repeater
                    ID="rptJobs"
                    runat="server">


                    <ItemTemplate>


                        <div class="job-card">


                            <!-- COMPANY ICON -->

                            <div class="job-company-logo">

                                <span>
                                    <%# GetCompanyInitial(
                                        Eval("CompanyName")
                                    ) %>
                                </span>

                            </div>


                            <!-- JOB CONTENT -->

                            <div class="job-main">


                                <div class="job-title-row">

                                    <div>

                                        <h3>
                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("JobTitle")
                                                )
                                            ) %>
                                        </h3>

                                        <strong class="job-company">

                                            <%# Server.HtmlEncode(
                                                Convert.ToString(
                                                    Eval("CompanyName")
                                                )
                                            ) %>

                                        </strong>

                                    </div>

                                </div>


                                <!-- JOB META -->

                                <div class="job-meta">


                                    <span>

                                        <i class="bi bi-geo-alt"></i>

                                        <%# GetLocation(
                                            Eval("City"),
                                            Eval("State")
                                        ) %>

                                    </span>


                                    <span>

                                        <i class="bi bi-briefcase"></i>

                                        <%# GetExperience(
                                            Eval("MinExperienceMonths"),
                                            Eval("MaxExperienceMonths")
                                        ) %>

                                    </span>


                                    <asp:PlaceHolder
                                        runat="server"
                                        Visible='<%# Convert.ToBoolean(Eval("SalaryVisible")) %>'>

                                        <span>

                                            <i class="bi bi-currency-rupee"></i>

                                            <%# GetSalary(
                                                Eval("MinSalary"),
                                                Eval("MaxSalary")
                                            ) %>

                                        </span>

                                    </asp:PlaceHolder>


                                </div>


                                <!-- FOOTER -->

                                <div class="job-card-footer">


                                    <span class="job-posted">

                                        <i class="bi bi-clock"></i>

                                        <%# GetPostedDate(
                                            Eval("CreatedAt")
                                        ) %>

                                    </span>


                                    <a
                                        href='<%# ResolveUrl(
                                            "~/JobSeeker/JobDetails.aspx?JobId="
                                            +
                                            Convert.ToString(
                                                Eval("JobId")
                                            )
                                        ) %>'
                                        class="job-view-btn">

                                        View Details

                                        <i class="bi bi-arrow-right"></i>

                                    </a>


                                </div>


                            </div>


                        </div>


                    </ItemTemplate>


                </asp:Repeater>


            </div>


        </asp:Panel>


        <!-- =========================================
             EMPTY STATE
        ========================================== -->

        <asp:Panel
            ID="pnlNoJobs"
            runat="server"
            Visible="false"
            CssClass="jobs-empty">


            <div class="jobs-empty-icon">

                <i class="bi bi-search"></i>

            </div>


            <h3>
                No jobs found
            </h3>


            <p>
                We couldn't find jobs matching your search.
                Try another keyword or location.
            </p>


            <asp:Button
                ID="btnClearSearch"
                runat="server"
                Text="View All Jobs"
                CssClass="jobs-clear-btn"
                OnClick="btnClearSearch_Click" />


        </asp:Panel>


    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">

</asp:Content>
