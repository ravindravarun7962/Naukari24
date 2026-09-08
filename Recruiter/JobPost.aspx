<%@ Page Title="" Language="C#" MasterPageFile="~/Recruiter/Recruiter.Master" AutoEventWireup="true" CodeBehind="JobPost.aspx.cs" Inherits="Success24_Job_Portal.Recruiter.JobPost" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>

    .job-post-page {
        max-width: 1100px;
        margin: 0 auto;
        padding: 32px;
    }

    .job-post-header {
        margin-bottom: 25px;
    }

    .job-post-header h1 {
        margin: 0 0 7px;
        font-size: 30px;
        color: #111827;
    }

    .job-post-header p {
        margin: 0;
        color: #6b7280;
        font-size: 14px;
    }

    .job-form-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 16px;
        padding: 28px;
        margin-bottom: 20px;
    }

    .section-title {
        margin: 0 0 20px;
        font-size: 19px;
        font-weight: 700;
        color: #111827;
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 18px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 7px;
    }

    .form-group.full {
        grid-column: 1 / -1;
    }

    .form-label {
        font-size: 13px;
        font-weight: 600;
        color: #374151;
    }

    .form-control,
    .form-select {
        width: 100%;
        box-sizing: border-box;
        min-height: 44px;
        border: 1px solid #d1d5db;
        border-radius: 9px;
        padding: 9px 12px;
        font-size: 14px;
        outline: none;
        background: #fff;
    }

    textarea.form-control {
        min-height: 130px;
        resize: vertical;
    }

    .form-control:focus,
    .form-select:focus {
        border-color: #6b7280;
    }

    .form-help {
        font-size: 11px;
        color: #9ca3af;
    }

    .checkbox-row {
        display: flex;
        align-items: center;
        gap: 8px;
        min-height: 44px;
    }

    .checkbox-row label {
        font-size: 14px;
        color: #374151;
    }

    .action-row {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }

    .btn {
        border: 0;
        border-radius: 9px;
        padding: 11px 20px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
    }

    .btn-primary {
        background: #111827;
        color: #fff;
    }

    .btn-secondary {
        background: #f3f4f6;
        color: #374151;
    }

    .message {
        display: block;
        padding: 12px 14px;
        border-radius: 9px;
        margin-bottom: 20px;
        font-size: 13px;
    }

    .success {
        background: #ecfdf5;
        color: #047857;
    }

    .error {
        background: #fef2f2;
        color: #b91c1c;
    }

    @media (max-width: 750px) {

        .job-post-page {
            padding: 20px 14px;
        }

        .form-grid {
            grid-template-columns: 1fr;
        }

        .form-group.full {
            grid-column: auto;
        }

        .action-row {
            flex-direction: column;
        }

        .action-row .btn {
            width: 100%;
        }
    }

</style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
     <div class="job-post-page">


     <div class="job-post-header">

         <h1>
             Post a New Job
         </h1>

         <p>
             Create a job vacancy and publish it
             for job seekers.
         </p>

     </div>


     <asp:Label
         ID="lblMessage"
         runat="server"
         Visible="false">
     </asp:Label>


     <!-- =========================================
          BASIC JOB INFORMATION
     ========================================== -->

     <div class="job-form-card">

         <h2 class="section-title">
             Job Information
         </h2>


         <div class="form-grid">


             <div class="form-group">

                 <asp:Label
                     runat="server"
                     Text="Company"
                     CssClass="form-label">
                 </asp:Label>

                <asp:DropDownList
                ID="ddlCompany"
                runat="server"
                CssClass="form-select"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged">
            </asp:DropDownList>

            <asp:TextBox
                ID="txtOtherCompany"
                runat="server"
                CssClass="form-control"
                placeholder="Enter company name"
                Visible="false">
            </asp:TextBox>

             </div>


             <div class="form-group">

                 <asp:Label
                     runat="server"
                     Text="Category"
                     CssClass="form-label">
                 </asp:Label>

               <asp:DropDownList
                ID="ddlCategory"
                runat="server"
                CssClass="form-select"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
            </asp:DropDownList>

            <asp:TextBox
                ID="txtOtherCategory"
                runat="server"
                CssClass="form-control"
                placeholder="Enter category name"
                Visible="false">
            </asp:TextBox>

             </div>


             <div class="form-group full">

                 <asp:Label
                     runat="server"
                     Text="Job Title *"
                     CssClass="form-label">
                 </asp:Label>

                 <asp:TextBox
                     ID="txtJobTitle"
                     runat="server"
                     CssClass="form-control"
                     MaxLength="300"
                     placeholder="e.g. Full Stack .NET Developer">
                 </asp:TextBox>

             </div>


             <div class="form-group full">

                 <asp:Label
                     runat="server"
                     Text="Job Description *"
                     CssClass="form-label">
                 </asp:Label>

                 <asp:TextBox
                     ID="txtJobDescription"
                     runat="server"
                     CssClass="form-control"
                     TextMode="MultiLine"
                     placeholder="Describe the role, team and opportunity...">
                 </asp:TextBox>

             </div>


             <div class="form-group full">

                 <asp:Label
                     runat="server"
                     Text="Responsibilities"
                     CssClass="form-label">
                 </asp:Label>

                 <asp:TextBox
                     ID="txtResponsibilities"
                     runat="server"
                     CssClass="form-control"
                     TextMode="MultiLine"
                     placeholder="Enter key responsibilities...">
                 </asp:TextBox>

             </div>


             <div class="form-group full">

                 <asp:Label
                     runat="server"
                     Text="Requirements"
                     CssClass="form-label">
                 </asp:Label>

                 <asp:TextBox
                     ID="txtRequirements"
                     runat="server"
                     CssClass="form-control"
                     TextMode="MultiLine"
                     placeholder="Enter required skills and qualifications...">
                 </asp:TextBox>

             </div>

         </div>

     </div>


     <!-- =========================================
          WORK DETAILS
     ========================================== -->

     <div class="job-form-card">

         <h2 class="section-title">
             Work Details
         </h2>


         <div class="form-grid">


             <div class="form-group">

                 <label class="form-label">
                     Employment Type *
                 </label>

                 <asp:DropDownList
                     ID="ddlEmploymentType"
                     runat="server"
                     CssClass="form-select">

                     <asp:ListItem
                         Text="Select Employment Type"
                         Value="">
                     </asp:ListItem>

                     <asp:ListItem
                         Text="Full Time"
                         Value="Full Time">
                     </asp:ListItem>

                     <asp:ListItem
                         Text="Part Time"
                         Value="Part Time">
                     </asp:ListItem>

                     <asp:ListItem
                         Text="Contract"
                         Value="Contract">
                     </asp:ListItem>

                     <asp:ListItem
                         Text="Internship"
                         Value="Internship">
                     </asp:ListItem>

                     <asp:ListItem
                         Text="Freelance"
                         Value="Freelance">
                     </asp:ListItem>

                 </asp:DropDownList>

             </div>


             <div class="form-group">

                 <label class="form-label">
                     Work Mode
                 </label>

                 <asp:DropDownList
                     ID="ddlWorkMode"
                     runat="server"
                     CssClass="form-select">

                     <asp:ListItem
                         Text="Select Work Mode"
                         Value="">
                     </asp:ListItem>

                     <asp:ListItem
                         Text="Work From Office"
                         Value="Work From Office">
                     </asp:ListItem>

                     <asp:ListItem
                         Text="Remote"
                         Value="Remote">
                     </asp:ListItem>

                     <asp:ListItem
                         Text="Hybrid"
                         Value="Hybrid">
                     </asp:ListItem>

                 </asp:DropDownList>

             </div>


             <div class="form-group">

                 <label class="form-label">
                     Minimum Experience (Months)
                 </label>

                 <asp:TextBox
                     ID="txtMinExperience"
                     runat="server"
                     CssClass="form-control"
                     TextMode="Number">
                 </asp:TextBox>

             </div>


             <div class="form-group">

                 <label class="form-label">
                     Maximum Experience (Months)
                 </label>

                 <asp:TextBox
                     ID="txtMaxExperience"
                     runat="server"
                     CssClass="form-control"
                     TextMode="Number">
                 </asp:TextBox>

             </div>


             <div class="form-group">

                 <label class="form-label">
                     Minimum Salary
                 </label>

                 <asp:TextBox
                     ID="txtMinSalary"
                     runat="server"
                     CssClass="form-control"
                     TextMode="Number">
                 </asp:TextBox>

             </div>


             <div class="form-group">

                 <label class="form-label">
                     Maximum Salary
                 </label>

                 <asp:TextBox
                     ID="txtMaxSalary"
                     runat="server"
                     CssClass="form-control"
                     TextMode="Number">
                 </asp:TextBox>

             </div>


             <div class="form-group">

                 <label class="form-label">
                     City
                 </label>

                 <asp:TextBox
                     ID="txtCity"
                     runat="server"
                     CssClass="form-control"
                     placeholder="e.g. Noida">
                 </asp:TextBox>

             </div>


             <div class="form-group">

                 <label class="form-label">
                     State
                 </label>

                 <asp:TextBox
                     ID="txtState"
                     runat="server"
                     CssClass="form-control"
                     placeholder="e.g. Uttar Pradesh">
                 </asp:TextBox>

             </div>


             <div class="form-group">

                 <label class="form-label">
                     Number of Openings *
                 </label>

                 <asp:TextBox
                     ID="txtOpenings"
                     runat="server"
                     CssClass="form-control"
                     TextMode="Number"
                     Text="1">
                 </asp:TextBox>

             </div>


             <div class="form-group">

                 <label class="form-label">
                     Education Requirement
                 </label>

                 <asp:TextBox
                     ID="txtEducation"
                     runat="server"
                     CssClass="form-control"
                     placeholder="e.g. B.Tech / MCA">
                 </asp:TextBox>

             </div>


         </div>

     </div>


     <!-- =========================================
          APPLICATION & VISIBILITY
     ========================================== -->

     <div class="job-form-card">

         <h2 class="section-title">
             Application & Visibility
         </h2>


         <div class="form-grid">


             <div class="form-group">

                 <label class="form-label">
                     Application Deadline
                 </label>

                 <asp:TextBox
                     ID="txtDeadline"
                     runat="server"
                     CssClass="form-control"
                     TextMode="Date">
                 </asp:TextBox>

             </div>


             <div class="form-group">

                 <label class="form-label">
                     Job Status
                 </label>

                 <asp:DropDownList
                     ID="ddlJobStatus"
                     runat="server"
                     CssClass="form-select">

                     <asp:ListItem
                         Text="Active"
                         Value="Active">
                     </asp:ListItem>

                     <asp:ListItem
                         Text="Draft"
                         Value="Draft">
                     </asp:ListItem>

                     <asp:ListItem
                         Text="Closed"
                         Value="Closed">
                     </asp:ListItem>

                 </asp:DropDownList>

             </div>


             <div class="form-group">

                 <div class="checkbox-row">

                     <asp:CheckBox
                         ID="chkSalaryVisible"
                         runat="server"
                         Checked="true" />

                     <label for="<%= chkSalaryVisible.ClientID %>">
                         Show salary to job seekers
                     </label>

                 </div>

             </div>


             <div class="form-group">

                 <div class="checkbox-row">

                     <asp:CheckBox
                         ID="chkFeatured"
                         runat="server" />

                     <label for="<%= chkFeatured.ClientID %>">
                         Mark as featured job
                     </label>

                 </div>

             </div>


         </div>

     </div>


     <!-- =========================================
          ACTIONS
     ========================================== -->

     <div class="job-form-card">

         <div class="action-row">

             <asp:Button
                 ID="btnClear"
                 runat="server"
                 Text="Clear"
                 CssClass="btn btn-secondary"
                 CausesValidation="false"
                 OnClick="btnClear_Click" />

             <asp:Button
                 ID="btnPostJob"
                 runat="server"
                 Text="Post Job"
                 CssClass="btn btn-primary"
                 OnClick="btnPostJob_Click" />

         </div>

     </div>

 </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
