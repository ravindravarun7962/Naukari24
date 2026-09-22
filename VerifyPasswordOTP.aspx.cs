using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class VerifyPasswordOTP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmail();
            }

        }

        // =========================================================
        // LOAD EMAIL
        // =========================================================

        private void LoadEmail()
        {
            string email =
                Convert.ToString(
                    Session["PasswordResetEmail"]
                ).Trim();

            if (string.IsNullOrWhiteSpace(email))
            {
                Response.Redirect(
                    "~/ForgotPassword.aspx",
                    false
                );

                Context.ApplicationInstance.CompleteRequest();

                return;
            }

            lblEmail.Text =
                "Code sent to <strong>" +
                Server.HtmlEncode(email) +
                "</strong>";
        }


        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string email =
                Convert.ToString(
                    Session["PasswordResetEmail"]
                ).Trim();

            string otp =
                txtOTP.Text.Trim();

            if (string.IsNullOrWhiteSpace(email))
            {
                Response.Redirect(
                    "~/ForgotPassword.aspx",
                    false
                );

                Context.ApplicationInstance.CompleteRequest();

                return;
            }

            try
            {
                const string query = @"
            SELECT TOP 1
                ResetId,
                UserId,
                Email,
                OTPHash,
                ExpiresAt,
                IsUsed
            FROM PasswordResetTokens
            WHERE Email = @Email
              AND IsUsed = 0
              AND ExpiresAt > GETDATE()
            ORDER BY ResetId DESC;
        ";

                DataRow row =
                    Utility._GetDataRow24(
                        query,
                        new SqlParameter(
                            "@Email",
                            SqlDbType.NVarChar,
                            150)
                        {
                            Value = email
                        }
                    );

                if (row == null)
                {
                    ShowError(
                        "This verification code has expired or is invalid. " +
                        "Please request a new code."
                    );

                    return;
                }

                int resetId =
                    Convert.ToInt32(row["ResetId"]);

                int userId =
                    Convert.ToInt32(row["UserId"]);

                string otpHash =
                    Convert.ToString(row["OTPHash"]);

                bool validOTP = false;

                try
                {
                    validOTP =
                        BCrypt.Net.BCrypt.Verify(
                            otp,
                            otpHash
                        );
                }
                catch
                {
                    validOTP = false;
                }

                if (!validOTP)
                {
                    ShowError(
                        "The verification code is incorrect."
                    );

                    return;
                }

                // OTP is valid — now mark it as used
                MarkOTPUsed(resetId);

                Session["PasswordResetUserId"] =
                    userId;

                Session["PasswordResetVerified"] =
                    true;

                Response.Redirect(
                    "~/ResetPassword.aspx",
                    false
                );

                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception)
            {
                ShowError(
                    "Something went wrong. Please try again."
                );
            }
        }

        // =========================================================
        // MARK OTP USED
        // =========================================================

        private void MarkOTPUsed(int resetId)
        {
            const string query = @"
                UPDATE PasswordResetTokens
                SET IsUsed = 1
                WHERE ResetId = @ResetId;
            ";

            Utility.ExecuteQuery24(
                query,

                new SqlParameter(
                    "@ResetId",
                    SqlDbType.Int)
                {
                    Value = resetId
                }
            );
        }

                
        protected void btnResendOTP_Click(object sender, EventArgs e)
        {
            string email =
               Convert.ToString(
                   Session["PasswordResetEmail"]
               ).Trim();

            if (string.IsNullOrWhiteSpace(email))
            {
                Response.Redirect(
                    "~/ForgotPassword.aspx",
                    false
                );

                Context.ApplicationInstance.CompleteRequest();

                return;
            }


            try
            {
                // =============================================
                // GET USER
                // =============================================

                const string userQuery = @"
                    SELECT TOP 1
                        UserId,
                        FullName,
                        Email,
                        IsActive
                    FROM Users
                    WHERE Email = @Email;
                ";


                DataRow userRow =
                    Utility._GetDataRow24(
                        userQuery,

                        new SqlParameter(
                            "@Email",
                            SqlDbType.NVarChar,
                            150)
                        {
                            Value = email
                        }
                    );


                if (userRow == null)
                {
                    ShowError(
                        "Unable to send a new verification code."
                    );

                    return;
                }


                bool isActive =
                    Convert.ToBoolean(
                        userRow["IsActive"]
                    );


                if (!isActive)
                {
                    ShowError(
                        "Unable to send a new verification code."
                    );

                    return;
                }


                int userId =
                    Convert.ToInt32(
                        userRow["UserId"]
                    );

                string fullName =
                    Convert.ToString(
                        userRow["FullName"]
                    );

                string userEmail =
                    Convert.ToString(
                        userRow["Email"]
                    );


                // =============================================
                // GENERATE NEW OTP
                // =============================================

                Random random =
                    new Random();

                string otp =
                    random.Next(
                        100000,
                        1000000
                    ).ToString();


                // =============================================
                // HASH OTP
                // =============================================

                string otpHash =
                    BCrypt.Net.BCrypt.HashPassword(
                        otp
                    );


                // =============================================
                // INVALIDATE OLD OTP
                // =============================================

                const string expireQuery = @"
                    UPDATE PasswordResetTokens
                    SET IsUsed = 1
                    WHERE UserId = @UserId
                      AND IsUsed = 0;
                ";


                Utility.ExecuteQuery24(
                    expireQuery,

                    new SqlParameter(
                        "@UserId",
                        SqlDbType.Int)
                    {
                        Value = userId
                    }
                );


                // =============================================
                // INSERT NEW OTP
                // =============================================

                const string insertQuery = @"
                    INSERT INTO PasswordResetTokens
                    (
                        UserId,
                        Email,
                        OTPHash,
                        ExpiresAt,
                        IsUsed,
                        CreatedAt
                    )
                    VALUES
                    (
                        @UserId,
                        @Email,
                        @OTPHash,
                        DATEADD(MINUTE, 10, GETDATE()),
                        0,
                        GETDATE()
                    );
                ";


                Utility.ExecuteQuery24(
                    insertQuery,

                    new SqlParameter(
                        "@UserId",
                        SqlDbType.Int)
                    {
                        Value = userId
                    },

                    new SqlParameter(
                        "@Email",
                        SqlDbType.NVarChar,
                        150)
                    {
                        Value = userEmail
                    },

                    new SqlParameter(
                        "@OTPHash",
                        SqlDbType.NVarChar,
                        255)
                    {
                        Value = otpHash
                    }
                );


                // =============================================
                // SEND EMAIL
                // =============================================

                string subject =
                    "Naukari24 - New Password Reset Code";


                string body =
                    BuildOTPEmail(
                        fullName,
                        otp
                    );


                bool emailSent =
                    Utility.SendEmail(
                        userEmail,
                        subject,
                        body,
                        true
                    );


                if (!emailSent)
                {
                    ShowError(
                        "We could not send the new verification code. " +
                        "Please try again later."
                    );

                    return;
                }


                ShowSuccess(
                    "A new verification code has been sent to your email."
                );

                txtOTP.Text = "";
            }
            catch (Exception)
            {
                ShowError(
                    "Something went wrong. Please try again."
                );
            }
        }


        // =========================================================
        // OTP EMAIL
        // =========================================================

        private string BuildOTPEmail(
            string fullName,
            string otp)
        {
            if (string.IsNullOrWhiteSpace(fullName))
            {
                fullName = "User";
            }

            StringBuilder body =
                new StringBuilder();

            body.Append(@"
                <div style='font-family:Arial,Helvetica,sans-serif;
                            background:#f5f7fb;
                            padding:30px;'>

                    <div style='max-width:600px;
                                margin:auto;
                                background:#ffffff;
                                border-radius:12px;
                                padding:30px;
                                border:1px solid #e5e7eb;'>

                        <h2 style='color:#2563eb;
                                   margin-top:0;'>
                            Success24
                        </h2>

                        <p style='font-size:16px;
                                  color:#374151;'>
            ");

            body.Append(
                "Hello " +
                Server.HtmlEncode(fullName) +
                ","
            );

            body.Append(@"
                        </p>

                        <p style='font-size:15px;
                                  color:#4b5563;
                                  line-height:1.6;'>
                            Here is your new verification code
                            for resetting your Naukari24 password.
                        </p>

                        <div style='font-size:32px;
                                    font-weight:bold;
                                    letter-spacing:8px;
                                    text-align:center;
                                    padding:20px;
                                    background:#eff6ff;
                                    color:#2563eb;
                                    border-radius:8px;
                                    margin:20px 0;'>
            ");

            body.Append(otp);

            body.Append(@"
                        </div>

                        <p style='font-size:14px;
                                  color:#6b7280;'>
                            This code will expire in
                            <strong>10 minutes</strong>.
                        </p>

                        <p style='font-size:14px;
                                  color:#6b7280;'>
                            If you did not request this code,
                            you can safely ignore this email.
                        </p>

                        <hr style='border:none;
                                   border-top:1px solid #e5e7eb;
                                   margin:25px 0;' />

                        <p style='font-size:12px;
                                  color:#9ca3af;'>
                            This is an automated email from Naukari24.
                        </p>

                    </div>

                </div>
            ");

            return body.ToString();
        }


        // =========================================================
        // ERROR MESSAGE
        // =========================================================

        private void ShowError(string message)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;

            lblMessage.Style["background"] =
                "#fff2f2";

            lblMessage.Style["color"] =
                "#c62828";

            lblMessage.Style["border"] =
                "1px solid #ffd5d5";
        }


        // =========================================================
        // SUCCESS MESSAGE
        // =========================================================

        private void ShowSuccess(string message)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;

            lblMessage.Style["background"] =
                "#ecfdf3";

            lblMessage.Style["color"] =
                "#16794b";

            lblMessage.Style["border"] =
                "1px solid #b7ebcf";

        }
    }
}