<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Resume.aspx.cs" Inherits="Success24_Job_Portal.JobSeeker.Resume" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

        .resume-page {
            background: #f5f7fa;
            min-height: 100vh;
            padding: 35px 0 60px;
        }

        .resume-container {
            max-width: 900px;
            margin: auto;
            padding: 0 15px;
        }

        .resume-page-title {
            margin-bottom: 20px;
        }

        .resume-page-title h1 {
            font-size: 24px;
            font-weight: 700;
            color: #25344a;
            margin-bottom: 5px;
        }

        .resume-page-title p {
            color: #7b8798;
            font-size: 13px;
            margin: 0;
        }


        /* CARD */

        .resume-card {
            background: #fff;
            border: 1px solid #e4e9ef;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 18px;
        }

        .resume-card-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
        }

        .resume-header-icon {
            width: 44px;
            height: 44px;
            border-radius: 10px;
            background: #edf4ff;
            color: #2557a7;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 19px;
        }

        .resume-card-header h2 {
            font-size: 16px;
            color: #344054;
            margin: 0 0 3px;
            font-weight: 700;
        }

        .resume-card-header p {
            margin: 0;
            color: #8a94a4;
            font-size: 11px;
        }


        /* UPLOAD */

        .resume-upload-box {
            padding: 30px;
            border: 2px dashed #d7dee8;
            border-radius: 10px;
            text-align: center;
            background: #fafbfd;
        }

        .upload-icon {
            width: 55px;
            height: 55px;
            margin: 0 auto 12px;
            border-radius: 50%;
            background: #edf4ff;
            color: #2557a7;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }

        .resume-upload-box h3 {
            font-size: 14px;
            color: #3c485b;
            margin-bottom: 5px;
        }

        .resume-upload-box p {
            color: #8b95a4;
            font-size: 10px;
            margin-bottom: 16px;
        }

        .resume-file-input {
            width: 100%;
            max-width: 400px;
            margin: auto;
            padding: 10px;
            border: 1px solid #dce2e9;
            border-radius: 7px;
            background: #fff;
            font-size: 11px;
        }

        .resume-upload-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-top: 15px;
            padding: 10px 20px;
            border: 0;
            border-radius: 7px;
            background: #2557a7;
            color: #fff;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
        }

        .resume-upload-btn:hover {
            background: #1f4a8d;
        }


        /* MESSAGE */

        .resume-message {
            display: block;
            margin-bottom: 15px;
            padding: 10px 13px;
            border-radius: 7px;
            font-size: 11px;
        }

        .resume-success {
            background: #ecfdf3;
            color: #027a48;
            border: 1px solid #abefc6;
        }

        .resume-error {
            background: #fef3f2;
            color: #b42318;
            border: 1px solid #fecdca;
        }


        /* CURRENT RESUME */

        .current-resume {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            padding: 17px;
            border: 1px solid #e4e9ef;
            border-radius: 9px;
        }

        .resume-file-info {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 0;
        }

        .resume-file-icon {
            width: 45px;
            height: 45px;
            min-width: 45px;
            border-radius: 8px;
            background: #fff1f0;
            color: #d92d20;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .resume-file-details {
            min-width: 0;
        }

        .resume-file-details strong {
            display: block;
            color: #344054;
            font-size: 12px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            max-width: 400px;
        }

        .resume-file-details span {
            display: block;
            color: #98a2b3;
            font-size: 9px;
            margin-top: 3px;
        }


        /* ACTIONS */

        .resume-actions {
            display: flex;
            gap: 7px;
        }

        .resume-action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            padding: 8px 12px;
            border: 1px solid #dce2e9;
            border-radius: 6px;
            background: #fff;
            color: #596579;
            font-size: 9px;
            font-weight: 600;
            text-decoration: none;
        }

        .resume-action-btn:hover {
            border-color: #aac0df;
            color: #2557a7;
        }

        .resume-action-btn.delete:hover {
            border-color: #f0b8b8;
            color: #d92d20;
            background: #fff7f7;
        }


        /* EMPTY */

        .resume-empty {
            padding: 30px;
            text-align: center;
            border: 1px dashed #dce2e9;
            border-radius: 9px;
        }

        .resume-empty i {
            display: block;
            font-size: 25px;
            color: #a2acba;
            margin-bottom: 8px;
        }

        .resume-empty strong {
            display: block;
            color: #596579;
            font-size: 12px;
        }

        .resume-empty span {
            display: block;
            color: #98a2b3;
            font-size: 9px;
            margin-top: 4px;
        }


        @media(max-width:650px) {

            .current-resume {
                align-items: flex-start;
                flex-direction: column;
            }

            .resume-actions {
                width: 100%;
            }

            .resume-action-btn {
                flex: 1;
            }

        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="resume-page">

        <div class="resume-container">


            <div class="resume-page-title">

                <h1>My Resume</h1>

                <p>
                    Upload and manage the resume
                    recruiters will receive with your applications.
                </p>

            </div>


            <!-- MESSAGE -->

            <asp:Label
                ID="lblMessage"
                runat="server"
                Visible="false">
            </asp:Label>


            <!-- ==================================
                 CURRENT RESUME
            =================================== -->

            <div class="resume-card">

                <div class="resume-card-header">

                    <div class="resume-header-icon">
                        <i class="bi bi-file-earmark-person"></i>
                    </div>

                    <div>

                        <h2>Current Resume</h2>

                        <p>
                            Your active resume for job applications.
                        </p>

                    </div>

                </div>


                <asp:Panel
                    ID="pnlCurrentResume"
                    runat="server"
                    Visible="false">


                    <div class="current-resume">


                        <div class="resume-file-info">


                            <div class="resume-file-icon">

                                <i class="bi bi-file-earmark-text"></i>

                            </div>


                            <div class="resume-file-details">

                                <strong>

                                    <asp:Label
                                        ID="lblResumeFileName"
                                        runat="server">
                                    </asp:Label>

                                </strong>


                                <span>

                                    <asp:Label
                                        ID="lblResumeMeta"
                                        runat="server">
                                    </asp:Label>

                                </span>

                            </div>


                        </div>


                        <div class="resume-actions">


                            <asp:HyperLink
                                ID="lnkViewResume"
                                runat="server"
                                Target="_blank"
                                rel="noopener noreferrer"
                                CssClass="resume-action-btn">

                                <i class="bi bi-eye"></i>
                                View

                            </asp:HyperLink>


                            <asp:LinkButton
                                ID="btnDownloadResume"
                                runat="server"
                                CssClass="resume-action-btn"
                                CausesValidation="false"
                                OnClick="btnDownloadResume_Click">

                                <i class="bi bi-download"></i>
                                Download

                            </asp:LinkButton>


                            <asp:LinkButton
                                ID="btnDeleteResume"
                                runat="server"
                                CssClass="resume-action-btn delete"
                                CausesValidation="false"
                                OnClick="btnDeleteResume_Click"
                                OnClientClick="return confirm('Are you sure you want to delete your resume?');">

                                <i class="bi bi-trash"></i>
                                Delete

                            </asp:LinkButton>


                        </div>

                    </div>

                </asp:Panel>


                <asp:Panel
                    ID="pnlNoResume"
                    runat="server"
                    Visible="false"
                    CssClass="resume-empty">

                    <i class="bi bi-file-earmark-x"></i>

                    <strong>No resume uploaded</strong>

                    <span>
                        Upload your latest resume below.
                    </span>

                </asp:Panel>


            </div>


            <!-- ==================================
                 UPLOAD
            =================================== -->

            <div class="resume-card">


                <div class="resume-card-header">

                    <div class="resume-header-icon">
                        <i class="bi bi-cloud-arrow-up"></i>
                    </div>

                    <div>

                        <h2>Upload Resume</h2>

                        <p>
                            Upload PDF or DOCX. Maximum file size 5 MB.
                        </p>

                    </div>

                </div>


                <div class="resume-upload-box">


                    <div class="upload-icon">
                        <i class="bi bi-cloud-arrow-up"></i>
                    </div>


                    <h3>
                        Select your resume
                    </h3>


                    <p>
                        Supported formats: PDF and DOCX.
                        Maximum size: 5 MB.
                    </p>


                    <asp:FileUpload
                        ID="fuResume"
                        runat="server"
                        CssClass="resume-file-input"
                        accept=".pdf,.docx" />


                    <br />


                    <asp:Button
                        ID="btnUploadResume"
                        runat="server"
                        Text="Upload Resume"
                        CssClass="resume-upload-btn"
                        CausesValidation="false"
                        OnClick="btnUploadResume_Click"/>


                </div>


            </div>


        </div>

    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
