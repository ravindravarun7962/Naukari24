<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="SearchCandidates.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.SearchCandidates" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
     <style>
         /* =========================================================
   SEARCH CANDIDATES
========================================================= */

.candidate-page {
    max-width: 1400px;
    margin: 0 auto;
    padding: 30px 35px 60px;
}


/* =========================================================
   HEADER
========================================================= */

.candidate-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 28px;
}

.candidate-eyebrow {
    display: inline-block;
    font-size: 12px;
    font-weight: 800;
    letter-spacing: 1.5px;
    margin-bottom: 8px;
    opacity: .7;
}

.candidate-header h1 {
    margin: 0;
    font-size: 34px;
    font-weight: 800;
    letter-spacing: -.7px;
}

.candidate-header p {
    margin: 8px 0 0;
    font-size: 15px;
    opacity: .65;
}

.candidate-header-icon {
    width: 70px;
    height: 70px;
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #111827;
    color: white;
    font-size: 28px;
}


/* =========================================================
   SEARCH CARD
========================================================= */

.candidate-search-card {
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 22px;
    padding: 28px;
    margin-bottom: 35px;
    box-shadow: 0 10px 35px rgba(15, 23, 42, .06);
}

.search-title {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 25px;
}

.search-icon {
    width: 46px;
    height: 46px;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #eef2ff;
    color: #4f46e5;
    font-size: 20px;
}

.search-title h3 {
    margin: 0;
    font-size: 19px;
    font-weight: 750;
}

.search-title p {
    margin: 4px 0 0;
    color: #6b7280;
    font-size: 13px;
}


/* =========================================================
   SEARCH GRID
========================================================= */

.search-grid {
    display: grid;
    grid-template-columns:
        repeat(4, minmax(0, 1fr));
    gap: 18px;
}

.search-field label {
    display: block;
    margin-bottom: 8px;
    font-size: 13px;
    font-weight: 700;
    color: #374151;
}

.input-icon {
    position: relative;
}

.input-icon > i {
    position: absolute;
    left: 14px;
    top: 50%;
    transform: translateY(-50%);
    color: #9ca3af;
    z-index: 2;
}

.search-input {
    width: 100%;
    height: 48px;
    border: 1px solid #d1d5db;
    border-radius: 12px;
    background: #f9fafb;
    padding: 0 14px;
    font-size: 14px;
    outline: none;
    transition: .2s;
    box-sizing: border-box;
}

.input-icon .search-input {
    padding-left: 40px;
}

.search-input:focus {
    background: white;
    border-color: #6366f1;
    box-shadow:
        0 0 0 4px rgba(99, 102, 241, .10);
}


/* =========================================================
   BUTTONS
========================================================= */

.search-buttons {
    display: flex;
    gap: 12px;
    margin-top: 22px;
}

.btn-search-candidates {
    height: 46px;
    padding: 0 24px;
    border: none;
    border-radius: 11px;
    background: #111827;
    color: white;
    font-weight: 700;
    cursor: pointer;
    transition: .2s;
}

.btn-search-candidates:hover {
    transform: translateY(-1px);
    box-shadow: 0 8px 20px rgba(17, 24, 39, .18);
}

.btn-clear-candidates {
    height: 46px;
    padding: 0 22px;
    border: 1px solid #d1d5db;
    border-radius: 11px;
    background: white;
    color: #374151;
    font-weight: 650;
    cursor: pointer;
}


/* =========================================================
   RESULTS HEADER
========================================================= */

.results-header {
    display: flex;
    align-items: end;
    justify-content: space-between;
    margin-bottom: 18px;
}

.results-label {
    font-size: 11px;
    font-weight: 800;
    letter-spacing: 1.5px;
    color: #6b7280;
}

.results-header h2 {
    margin: 4px 0 0;
    font-size: 22px;
    font-weight: 800;
}

.candidate-count {
    display: flex;
    align-items: center;
    gap: 5px;
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    padding: 9px 13px;
    font-size: 13px;
    color: #6b7280;
}

.candidate-count span:first-child {
    font-weight: 800;
    color: #111827;
}


/* =========================================================
   CANDIDATE CARD
========================================================= */

.candidate-card {
    display: flex;
    gap: 22px;
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 19px;
    padding: 24px;
    margin-bottom: 16px;
    box-shadow: 0 5px 20px rgba(15, 23, 42, .04);
    transition: .2s;
}

.candidate-card:hover {
    transform: translateY(-2px);
    box-shadow:
        0 15px 35px rgba(15, 23, 42, .09);
}


/* =========================================================
   AVATAR
========================================================= */

.candidate-avatar {
    flex: 0 0 68px;
    width: 68px;
    height: 68px;
    position: relative;
}

.candidate-avatar img {
    width: 68px;
    height: 68px;
    object-fit: cover;
    border-radius: 18px;
    border: 1px solid #e5e7eb;
}

.candidate-initial {
    width: 68px;
    height: 68px;
    border-radius: 18px;
    background: #eef2ff;
    color: #4f46e5;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 25px;
    font-weight: 800;
}


/* =========================================================
   MAIN
========================================================= */

.candidate-main {
    flex: 1;
    min-width: 0;
}

.candidate-name-row {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}

.candidate-name-row h3 {
    margin: 0;
    font-size: 18px;
    font-weight: 800;
    color: #111827;
}

.profile-badge {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    padding: 4px 8px;
    border-radius: 20px;
    background: #ecfdf5;
    color: #047857;
    font-size: 10px;
    font-weight: 750;
}

.candidate-headline {
    margin-top: 5px;
    color: #4f46e5;
    font-size: 14px;
    font-weight: 650;
}


/* =========================================================
   META
========================================================= */

.candidate-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    margin-top: 12px;
}

.candidate-meta span {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    color: #6b7280;
    font-size: 12px;
}

.candidate-meta i {
    color: #9ca3af;
}


/* =========================================================
   SKILLS
========================================================= */

.candidate-skills {
    display: flex;
    flex-wrap: wrap;
    gap: 7px;
    margin-top: 13px;
}

.skill-tag {
    padding: 6px 10px;
    border-radius: 8px;
    background: #f3f4f6;
    color: #374151;
    font-size: 11px;
    font-weight: 650;
}


/* =========================================================
   SUMMARY
========================================================= */

.candidate-summary {
    margin: 13px 0 0;
    max-width: 850px;
    color: #6b7280;
    font-size: 13px;
    line-height: 1.6;
}


/* =========================================================
   ACTIONS
========================================================= */

.candidate-actions {
    flex: 0 0 150px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 9px;
}

.btn-view-profile,
.btn-view-resume {
    height: 40px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 7px;
    text-decoration: none;
    font-size: 12px;
    font-weight: 700;
}

.btn-view-profile {
    background: #111827;
    color: white;
}

.btn-view-profile:hover {
    color: white;
    background: #1f2937;
}

.btn-view-resume {
    background: white;
    border: 1px solid #d1d5db;
    color: #374151;
}

.btn-view-resume:hover {
    color: #111827;
    background: #f9fafb;
}


/* =========================================================
   MESSAGE
========================================================= */

.candidate-message {
    padding: 13px 16px;
    border-radius: 10px;
    margin-bottom: 18px;
    font-size: 13px;
}

.candidate-message.error {
    background: #fef2f2;
    border: 1px solid #fecaca;
    color: #b91c1c;
}

.candidate-message.success {
    background: #ecfdf5;
    border: 1px solid #a7f3d0;
    color: #047857;
}


/* =========================================================
   EMPTY
========================================================= */

.no-candidates {
    background: white;
    border: 1px dashed #d1d5db;
    border-radius: 18px;
    padding: 65px 20px;
    text-align: center;
}

.empty-icon {
    width: 65px;
    height: 65px;
    margin: 0 auto 15px;
    border-radius: 18px;
    background: #f3f4f6;
    color: #6b7280;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 27px;
}

.no-candidates h3 {
    margin: 0;
    font-size: 18px;
}

.no-candidates p {
    margin: 7px 0 0;
    color: #6b7280;
    font-size: 13px;
}


/* =========================================================
   RESPONSIVE
========================================================= */

@media (max-width: 1100px) {

    .search-grid {
        grid-template-columns:
            repeat(2, minmax(0, 1fr));
    }

    .candidate-card {
        flex-wrap: wrap;
    }

    .candidate-actions {
        flex: 1 1 100%;
        flex-direction: row;
        justify-content: flex-start;
    }

    .btn-view-profile,
    .btn-view-resume {
        padding: 0 18px;
    }
}


@media (max-width: 700px) {

    .candidate-page {
        padding: 20px 15px 40px;
    }

    .candidate-header {
        align-items: flex-start;
    }

    .candidate-header-icon {
        display: none;
    }

    .candidate-header h1 {
        font-size: 27px;
    }

    .candidate-search-card {
        padding: 18px;
    }

    .search-grid {
        grid-template-columns: 1fr;
    }

    .search-buttons {
        flex-direction: column;
    }

    .btn-search-candidates,
    .btn-clear-candidates {
        width: 100%;
    }

    .results-header {
        align-items: flex-start;
        flex-direction: column;
        gap: 12px;
    }

    .candidate-card {
        padding: 18px;
        gap: 15px;
    }

    .candidate-avatar {
        flex: 0 0 55px;
        width: 55px;
        height: 55px;
    }

    .candidate-avatar img,
    .candidate-initial {
        width: 55px;
        height: 55px;
        border-radius: 14px;
    }

    .candidate-actions {
        width: 100%;
        flex-direction: column;
    }

    .btn-view-profile,
    .btn-view-resume {
        width: 100%;
    }
}
     </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
     <div class="candidate-page">

        <!-- ========================================= -->
        <!-- PAGE HEADER -->
        <!-- ========================================= -->

        <div class="candidate-header">

            <div>

                <span class="candidate-eyebrow">
                    RECRUITER PORTAL
                </span>

                <h1>
                    Search Candidates
                </h1>

                <p>
                    Find the right candidates based on skills,
                    experience, location and profile.
                </p>

            </div>

            <div class="candidate-header-icon">

                <i class="bi bi-people"></i>

            </div>

        </div>


        <!-- ========================================= -->
        <!-- SEARCH PANEL -->
        <!-- ========================================= -->

        <div class="candidate-search-card">

            <div class="search-title">

                <div class="search-icon">
                    <i class="bi bi-search"></i>
                </div>

                <div>
                    <h3>Find Candidates</h3>

                    <p>
                        Use the filters below to find suitable candidates.
                    </p>
                </div>

            </div>


            <div class="search-grid">

                <!-- KEYWORD -->

                <div class="search-field">

                    <label>
                        Keyword
                    </label>

                    <div class="input-icon">

                        <i class="bi bi-search"></i>

                        <asp:TextBox
                            ID="txtKeyword"
                            runat="server"
                            CssClass="search-input"
                            placeholder="Name, role, skill...">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- SKILL -->

                <div class="search-field">

                    <label>
                        Skill
                    </label>

                    <div class="input-icon">

                        <i class="bi bi-code-slash"></i>

                        <asp:TextBox
                            ID="txtSkill"
                            runat="server"
                            CssClass="search-input"
                            placeholder="e.g. C#, SQL, React">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- LOCATION -->

                <div class="search-field">

                    <label>
                        Location
                    </label>

                    <div class="input-icon">

                        <i class="bi bi-geo-alt"></i>

                        <asp:TextBox
                            ID="txtLocation"
                            runat="server"
                            CssClass="search-input"
                            placeholder="City or state">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- EXPERIENCE -->

                <div class="search-field">

                    <label>
                        Experience
                    </label>

                    <asp:DropDownList
                        ID="ddlExperience"
                        runat="server"
                        CssClass="search-input">

                        <asp:ListItem Value="">
                            Any Experience
                        </asp:ListItem>

                        <asp:ListItem Value="0">
                            Fresher
                        </asp:ListItem>

                        <asp:ListItem Value="1">
                            1+ Years
                        </asp:ListItem>

                        <asp:ListItem Value="2">
                            2+ Years
                        </asp:ListItem>

                        <asp:ListItem Value="3">
                            3+ Years
                        </asp:ListItem>

                        <asp:ListItem Value="5">
                            5+ Years
                        </asp:ListItem>

                        <asp:ListItem Value="8">
                            8+ Years
                        </asp:ListItem>

                    </asp:DropDownList>

                </div>

            </div>


            <!-- BUTTONS -->

            <div class="search-buttons">

                <asp:Button
                    ID="btnSearch"
                    runat="server"
                    Text="Search Candidates"
                    CssClass="btn-search-candidates"
                    OnClick="btnSearch_Click" />

                <asp:Button
                    ID="btnClear"
                    runat="server"
                    Text="Clear Filters"
                    CssClass="btn-clear-candidates"
                    CausesValidation="false"
                    OnClick="btnClear_Click" />

            </div>

        </div>


        <!-- ========================================= -->
        <!-- RESULTS HEADER -->
        <!-- ========================================= -->

        <div class="results-header">

            <div>

                <span class="results-label">
                    CANDIDATES
                </span>

                <h2>
                    Candidate Results
                </h2>

            </div>

            <div class="candidate-count">

                <asp:Label
                    ID="lblCandidateCount"
                    runat="server"
                    Text="0">
                </asp:Label>

                <span>
                    candidates found
                </span>

            </div>

        </div>


        <!-- ========================================= -->
        <!-- MESSAGE -->
        <!-- ========================================= -->

        <asp:Panel
            ID="pnlMessage"
            runat="server"
            Visible="false"
            CssClass="candidate-message">

            <asp:Label
                ID="lblMessage"
                runat="server">
            </asp:Label>

        </asp:Panel>


        <!-- ========================================= -->
        <!-- CANDIDATE LIST -->
        <!-- ========================================= -->

        <asp:Repeater
            ID="rptCandidates"
            runat="server">

            <ItemTemplate>

                <div class="candidate-card">

                    <!-- LEFT -->

                    <div class="candidate-avatar">

                        <asp:Image
                            ID="imgCandidate"
                            runat="server"
                            Visible='<%# !string.IsNullOrWhiteSpace(Convert.ToString(Eval("ProfilePhoto"))) %>'
                            ImageUrl='<%# ResolveUrl(Convert.ToString(Eval("ProfilePhoto"))) %>'
                            AlternateText="Candidate" />

                        <div
                            class="candidate-initial"
                            style='<%# string.IsNullOrWhiteSpace(Convert.ToString(Eval("ProfilePhoto"))) ? "" : "display:none;" %>'>

                            <%# GetInitial(Eval("FullName")) %>

                        </div>

                    </div>


                    <!-- MIDDLE -->

                    <div class="candidate-main">

                        <div class="candidate-name-row">

                            <h3>
                                <%# Eval("FullName") %>
                            </h3>

                            <span class="profile-badge">
                                <i class="bi bi-check-circle"></i>
                                Profile
                            </span>

                        </div>


                        <div class="candidate-headline">

                            <%# Eval("Headline") %>

                        </div>


                        <div class="candidate-meta">

                            <span>

                                <i class="bi bi-geo-alt"></i>

                                <%# Eval("CurrentCity") %>

                                <%# !string.IsNullOrWhiteSpace(Convert.ToString(Eval("CurrentState")))
                                    ? ", " + Convert.ToString(Eval("CurrentState"))
                                    : "" %>

                            </span>


                            <span>

                                <i class="bi bi-briefcase"></i>

                                <%# GetExperienceText(Eval("ExperienceMonths")) %>

                            </span>


                            <span>

                                <i class="bi bi-mortarboard"></i>

                                <%# Eval("PreferredRole") %>

                            </span>

                        </div>


                        <!-- SKILLS -->

                        <div class="candidate-skills">

                            <asp:Repeater
                                ID="rptSkills"
                                runat="server"
                                DataSource='<%# GetSkills(Eval("JobSeekerId")) %>'>

                                <ItemTemplate>

                                    <span class="skill-tag">

                                        <%# Eval("SkillName") %>

                                    </span>

                                </ItemTemplate>

                            </asp:Repeater>

                        </div>


                        <!-- SUMMARY -->

                        <p class="candidate-summary">

                            <%# TruncateText(Eval("ProfessionalSummary"), 180) %>

                        </p>

                    </div>


                    <!-- RIGHT -->

                    <div class="candidate-actions">

                        <a
                            href='<%# ResolveUrl(
                                "~/Recruiter/CandidateProfile.aspx?JobSeekerId="
                                + Convert.ToString(Eval("JobSeekerId"))
                            ) %>'
                            class="btn-view-profile">

                            <i class="bi bi-person"></i>

                            View Profile

                        </a>


                        <a
                            href='<%# GetResumeUrl(Eval("ResumePath")) %>'
                            target="_blank"
                            class="btn-view-resume"
                            style='<%# string.IsNullOrWhiteSpace(Convert.ToString(Eval("ResumePath")))
                                ? "display:none;"
                                : "" %>'>

                            <i class="bi bi-file-earmark-pdf"></i>

                            Resume

                        </a>

                    </div>

                </div>

            </ItemTemplate>

        </asp:Repeater>


        <!-- ========================================= -->
        <!-- EMPTY STATE -->
        <!-- ========================================= -->

        <asp:Panel
            ID="pnlNoCandidates"
            runat="server"
            Visible="false"
            CssClass="no-candidates">

            <div class="empty-icon">

                <i class="bi bi-people"></i>

            </div>

            <h3>
                No candidates found
            </h3>

            <p>
                Try changing your search keywords,
                skills or location.
            </p>

        </asp:Panel>


    </div>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
