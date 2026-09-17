using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.JobSeeker
{
    public partial class Resume : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadResume();
            }
        }

        private void LoadResume()
        {
            int jobSeekerId =
                GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                pnlCurrentResume.Visible = false;
                pnlNoResume.Visible = true;

                return;
            }


            const string query = @"
        SELECT TOP 1
            ResumeId,
            OriginalFileName,
            FilePath,
            FileExtension,
            FileSize,
            UploadedAt,
            UpdatedAt

        FROM JobSeekerResumes

        WHERE JobSeekerId =
            @JobSeekerId

        ORDER BY ResumeId DESC;";


            try
            {
                DataRow reader =
     Utility._GetDataRow24(
         query,
         new SqlParameter(
             "@JobSeekerId",
             SqlDbType.Int
         )
         {
             Value = jobSeekerId
         }
     );

                if (reader == null)
                {
                    pnlCurrentResume.Visible =
                        false;

                    pnlNoResume.Visible =
                        true;

                    return;
                }


                pnlCurrentResume.Visible =
                    true;

                pnlNoResume.Visible =
                    false;


                lblResumeFileName.Text =
                    Server.HtmlEncode(
                        Convert.ToString(
                            reader["OriginalFileName"]
                        )
                    );


                long fileSize =
                    Convert.ToInt64(
                        reader["FileSize"]
                    );


                DateTime uploadedAt =
                    Convert.ToDateTime(
                        reader["UploadedAt"]
                    );


                lblResumeMeta.Text =
                    Server.HtmlEncode(
                        FormatFileSize(fileSize)
                        +
                        " • Uploaded "
                        +
                        uploadedAt.ToString(
                            "dd MMM yyyy"
                        )
                    );


                string filePath =
                    Convert.ToString(
                        reader["FilePath"]
                    );


                lnkViewResume.NavigateUrl =
                    ResolveUrl(filePath);
            }
            catch
            {
                pnlCurrentResume.Visible = false;
                pnlNoResume.Visible = true;

                ShowMessage(
                    "Unable to load your resume.",
                    false
                );
            }
        }

        private int GetJobSeekerId()
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Login.aspx",
                    false
                );

                Context.ApplicationInstance
                    .CompleteRequest();

                return 0;
            }


            int userId;


            if (!int.TryParse(
                    Convert.ToString(
                        Session["UserId"]
                    ),
                    out userId))
            {
                return 0;
            }


            const string query = @"
        SELECT TOP 1 JobSeekerId

        FROM JobSeekerProfiles

        WHERE UserId = @UserId;";


            object result =
                Utility.ExecuteScalar24(
                    query,
                    new SqlParameter(
                        "@UserId",
                        SqlDbType.Int
                    )
                    {
                        Value = userId
                    }
                );


            if (result == null ||
                result == DBNull.Value)
            {
                return 0;
            }


            return Convert.ToInt32(result);
        }

        private SqlParameter[] AddResumeParameters(
     int jobSeekerId,
     string originalFileName,
     string storedFileName,
     string filePath,
     string extension,
     long fileSize)
        {
            return new SqlParameter[]
            {
        new SqlParameter(
            "@JobSeekerId",
            SqlDbType.Int
        )
        {
            Value = jobSeekerId
        },

        new SqlParameter(
            "@OriginalFileName",
            SqlDbType.NVarChar,
            255
        )
        {
            Value = originalFileName
        },

        new SqlParameter(
            "@StoredFileName",
            SqlDbType.NVarChar,
            255
        )
        {
            Value = storedFileName
        },

        new SqlParameter(
            "@FilePath",
            SqlDbType.NVarChar,
            500
        )
        {
            Value = filePath
        },

        new SqlParameter(
            "@FileExtension",
            SqlDbType.NVarChar,
            20
        )
        {
            Value = extension
        },

        new SqlParameter(
            "@FileSize",
            SqlDbType.BigInt
        )
        {
            Value = fileSize
        }
            };
        }
        protected void btnUploadResume_Click(object sender, EventArgs e)
        {
            int jobSeekerId =
                            GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                ShowMessage(
                    "Please complete your profile first.",
                    false
                );

                return;
            }


            if (!fuResume.HasFile)
            {
                ShowMessage(
                    "Please select a resume.",
                    false
                );

                return;
            }


            string originalFileName =
                Path.GetFileName(
                    fuResume.FileName
                );


            string extension =
                Path.GetExtension(
                    originalFileName
                ).ToLowerInvariant();


            if (extension != ".pdf" &&
                extension != ".docx")
            {
                ShowMessage(
                    "Only PDF and DOCX files are allowed.",
                    false
                );

                return;
            }


            const int maxFileSize =
                5 * 1024 * 1024;


            if (fuResume.PostedFile.ContentLength <= 0)
            {
                ShowMessage(
                    "The selected file is empty.",
                    false
                );

                return;
            }


            if (fuResume.PostedFile.ContentLength >
                maxFileSize)
            {
                ShowMessage(
                    "Resume cannot exceed 5 MB.",
                    false
                );

                return;
            }


            // Basic MIME validation.

            string contentType =
                (
                    fuResume.PostedFile.ContentType ??
                    ""
                ).ToLowerInvariant();


            bool validMime;


            if (extension == ".pdf")
            {
                validMime =
                    contentType == "application/pdf";
            }
            else
            {
                validMime =
                    contentType ==
                    "application/vnd.openxmlformats-officedocument.wordprocessingml.document"

                    ||

                    contentType ==
                    "application/octet-stream";
            }


            if (!validMime)
            {
                ShowMessage(
                    "The selected file type is invalid.",
                    false
                );

                return;
            }


            // ==========================================
            // RANDOM PHYSICAL FILE NAME
            // ==========================================

            string storedFileName =
                Guid.NewGuid()
                .ToString("N")
                +
                extension;


            string relativeDirectory =
                "~/Uploads/Resumes/";


            string physicalDirectory =
                Server.MapPath(
                    relativeDirectory
                );


            if (!Directory.Exists(
                    physicalDirectory))
            {
                Directory.CreateDirectory(
                    physicalDirectory
                );
            }


            string physicalPath =
                Path.Combine(
                    physicalDirectory,
                    storedFileName
                );


            string relativeFilePath =
                relativeDirectory
                +
                storedFileName;


            string oldPhysicalPath =
                null;


            try
            {
                // Save new file first.

                fuResume.SaveAs(
                    physicalPath
                );


                // =================================
                // FIND EXISTING RESUME
                // =================================

                const string existingQuery = @"
                    SELECT TOP 1
                        FilePath

                    FROM JobSeekerResumes

                    WHERE JobSeekerId =
                        @JobSeekerId;";


                object oldPath =
                    Utility.ExecuteScalar24(
                        existingQuery,
                        new SqlParameter(
                            "@JobSeekerId",
                            SqlDbType.Int
                        )
                        {
                            Value = jobSeekerId
                        }
                    );


                if (oldPath != null &&
                    oldPath != DBNull.Value)
                {
                    string oldRelativePath =
                        Convert.ToString(
                            oldPath
                        );


                    if (!string.IsNullOrWhiteSpace(
                            oldRelativePath))
                    {
                        oldPhysicalPath =
                            Server.MapPath(
                                oldRelativePath
                            );
                    }
                }


                // =================================
                // UPSERT RESUME
                // =================================

                const string upsertQuery = @"
                    IF EXISTS
                    (
                        SELECT 1
                        FROM JobSeekerResumes
                        WHERE JobSeekerId = @JobSeekerId
                    )
                    BEGIN

                        UPDATE JobSeekerResumes

                        SET
                            OriginalFileName =
                                @OriginalFileName,

                            StoredFileName =
                                @StoredFileName,

                            FilePath =
                                @FilePath,

                            FileExtension =
                                @FileExtension,

                            FileSize =
                                @FileSize,

                            IsPrimary = 1,

                            UpdatedAt =
                                SYSDATETIME()

                        WHERE JobSeekerId =
                            @JobSeekerId;

                    END
                    ELSE
                    BEGIN

                        INSERT INTO JobSeekerResumes
                        (
                            JobSeekerId,
                            OriginalFileName,
                            StoredFileName,
                            FilePath,
                            FileExtension,
                            FileSize,
                            IsPrimary,
                            UploadedAt
                        )

                        VALUES
                        (
                            @JobSeekerId,
                            @OriginalFileName,
                            @StoredFileName,
                            @FilePath,
                            @FileExtension,
                            @FileSize,
                            1,
                            SYSDATETIME()
                        );

                    END;";


                Utility.ExecuteQuery24(
                    upsertQuery,
                    AddResumeParameters(
                        jobSeekerId,
                        originalFileName,
                        storedFileName,
                        relativeFilePath,
                        extension,
                        fuResume.PostedFile
                            .ContentLength
                    )
                );


                // =========================================
                // DELETE OLD FILE AFTER DB SUCCESS
                // =========================================

                if (!string.IsNullOrWhiteSpace(
                        oldPhysicalPath)
                    &&
                    File.Exists(oldPhysicalPath)
                    &&
                    !string.Equals(
                        oldPhysicalPath,
                        physicalPath,
                        StringComparison.OrdinalIgnoreCase))
                {
                    try
                    {
                        File.Delete(
                            oldPhysicalPath
                        );
                    }
                    catch
                    {
                        // Do not fail the successful upload
                        // because old-file cleanup failed.
                    }
                }


                ShowMessage(
                    "Resume uploaded successfully.",
                    true
                );


                LoadResume();
            }
            catch
            {
                // New DB record failed, so clean
                // the newly uploaded file.

                if (File.Exists(
                        physicalPath))
                {
                    try
                    {
                        File.Delete(
                            physicalPath
                        );
                    }
                    catch
                    {
                    }
                }


                ShowMessage(
                    "Unable to upload resume.",
                    false
                );
            }

        }

        protected void btnDeleteResume_Click(object sender, EventArgs e)
        {
            int jobSeekerId =
                            GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                return;
            }


            string physicalPath =
                null;


            try
            {
                const string selectQuery = @"
                    SELECT TOP 1
                        FilePath

                    FROM JobSeekerResumes

                    WHERE JobSeekerId =
                        @JobSeekerId;";


                object result =
                    Utility.ExecuteScalar24(
                        selectQuery,
                        new SqlParameter(
                            "@JobSeekerId",
                            SqlDbType.Int
                        )
                        {
                            Value = jobSeekerId
                        }
                    );


                if (result == null ||
                    result == DBNull.Value)
                {
                    ShowMessage(
                        "Resume was not found.",
                        false
                    );

                    LoadResume();

                    return;
                }


                physicalPath =
                    Server.MapPath(
                        Convert.ToString(
                            result
                        )
                    );


                const string deleteQuery = @"
                    DELETE FROM JobSeekerResumes

                    WHERE JobSeekerId =
                        @JobSeekerId;";


                int affected =
                    Utility.ExecuteQuery24(
                        deleteQuery,
                        new SqlParameter(
                            "@JobSeekerId",
                            SqlDbType.Int
                        )
                        {
                            Value = jobSeekerId
                        }
                    );


                if (affected <= 0)
                {
                    ShowMessage(
                        "Resume was not found.",
                        false
                    );

                    LoadResume();

                    return;
                }


                if (!string.IsNullOrWhiteSpace(
                        physicalPath)
                    &&
                    File.Exists(physicalPath))
                {
                    try
                    {
                        File.Delete(
                            physicalPath
                        );
                    }
                    catch
                    {
                    }
                }


                ShowMessage(
                    "Resume deleted successfully.",
                    true
                );


                LoadResume();
            }
            catch
            {
                ShowMessage(
                    "Unable to delete resume.",
                    false
                );
            }

        }

        private string FormatFileSize(
    long bytes)
        {
            if (bytes >= 1024 * 1024)
            {
                return (
                    bytes /
                    (1024d * 1024d)
                ).ToString("0.##")
                + " MB";
            }


            if (bytes >= 1024)
            {
                return (
                    bytes / 1024d
                ).ToString("0.##")
                + " KB";
            }


            return bytes + " Bytes";
        }

        private void ShowMessage(
    string message,
    bool success)
        {
            lblMessage.Text =
                Server.HtmlEncode(message);


            lblMessage.CssClass =
                success
                    ? "resume-message resume-success"
                    : "resume-message resume-error";


            lblMessage.Visible =
                true;
        }

        protected void btnDownloadResume_Click(object sender, EventArgs e)
        {
            int jobSeekerId =
                            GetJobSeekerId();


            if (jobSeekerId == 0)
            {
                return;
            }


            const string query = @"
        SELECT TOP 1
            OriginalFileName,
            FilePath,
            FileExtension

        FROM JobSeekerResumes

        WHERE JobSeekerId =
            @JobSeekerId;";


            try
            {
                string originalFileName =
                    "";

                string filePath =
                    "";

                string extension =
                    "";


                DataRow reader =
                    Utility._GetDataRow24(
                        query,
                        new SqlParameter(
                            "@JobSeekerId",
                            SqlDbType.Int
                        )
                        {
                            Value = jobSeekerId
                        }
                    );


                if (reader == null)
                {
                    ShowMessage(
                        "Resume was not found.",
                        false
                    );

                    return;
                }


                originalFileName =
                    Convert.ToString(
                        reader["OriginalFileName"]
                    );


                filePath =
                    Convert.ToString(
                        reader["FilePath"]
                    );


                extension =
                    Convert.ToString(
                        reader["FileExtension"]
                    );


                string physicalPath =
                    Server.MapPath(
                        filePath
                    );


                if (!File.Exists(
                        physicalPath))
                {
                    ShowMessage(
                        "Resume file was not found on the server.",
                        false
                    );

                    return;
                }


                string contentType;


                if (extension.Equals(
                        ".pdf",
                        StringComparison.OrdinalIgnoreCase))
                {
                    contentType =
                        "application/pdf";
                }
                else
                {
                    contentType =
                        "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                }


                Response.Clear();

                Response.ContentType =
                    contentType;


                Response.AddHeader(
                    "Content-Disposition",
                    "attachment; filename=\""
                    +
                    HttpUtility.UrlPathEncode(
                        originalFileName
                    )
                    +
                    "\""
                );


                Response.TransmitFile(
                    physicalPath
                );


                Response.Flush();


                HttpContext.Current
                    .ApplicationInstance
                    .CompleteRequest();
            }
            catch
            {
                ShowMessage(
                    "Unable to download resume.",
                    false
                );
            }



        }
    }
}