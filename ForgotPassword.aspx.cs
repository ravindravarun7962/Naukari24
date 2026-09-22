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
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string email = txtEmail.Text.Trim().ToLowerInvariant();

            try
            {
                // =============================================
                // FIND ACTIVE USER
                // =============================================

                const string query = @"
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
                        query,
                        new SqlParameter(
                            "@Email",
                            System.Data.SqlDbType.NVarChar,
                            150)
                        {
                            Value = email
                        }
                    );


                // =============================================
                // SECURITY
                // Don't reveal whether email exists
                // =============================================

                if (userRow == null)
                {
                    ShowSuccess(
                        "If an account exists with this email address, " +
                        "a verification code has been sent."
                    );

                    return;
                }


                bool isActive =
                    Convert.ToBoolean(userRow["IsActive"]);

                if (!isActive)
                {
                    ShowSuccess(
                        "If an account exists with this email address, " +
                        "a verification code has been sent."
                    );

                    return;
                }


                int userId =
                    Convert.ToInt32(userRow["UserId"]);

                string fullName =
                    Convert.ToString(userRow["FullName"]);

                string userEmail =
                    Convert.ToString(userRow["Email"]);


                // =============================================
                // GENERATE OTP
                // =============================================

                Random random = new Random();

                string otp =
                    random.Next(100000, 1000000).ToString();


                // =============================================
                // HASH OTP
                // =============================================

                string otpHash =
                    BCrypt.Net.BCrypt.HashPassword(otp);


                // =============================================
                // EXPIRE OLD OTPs
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
                // SAVE NEW OTP
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
                // EMAIL
                // =============================================

                string subject =
                    "Success24 - Password Reset Verification Code";


                string body = BuildOTPEmail(
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


                // =============================================
                // EMAIL FAILED
                // =============================================

                if (!emailSent)
                {
                    ShowError(
                        "We could not send the verification email. " +
                        "Please try again later."
                    );

                    return;
                }


                // =============================================
                // STORE EMAIL IN SESSION
                // =============================================

                Session["PasswordResetEmail"] = userEmail;


                // =============================================
                // REDIRECT TO VERIFY PAGE
                // =============================================

                Response.Redirect(
                    "~/VerifyPasswordOTP.aspx",
                    false
                );

                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception)
            {
                ShowError(
                    "Something went wrong. Please try again later."
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
                            We received a request to reset your
                            Success24 account password.
                        </p>

                        <p style='font-size:15px;
                                  color:#4b5563;'>
                            Your verification code is:
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
                            This verification code will expire
                            in <strong>10 minutes</strong>.
                        </p>

                        <p style='font-size:14px;
                                  color:#6b7280;'>
                            If you did not request a password reset,
                            you can safely ignore this email.
                        </p>

                        <hr style='border:none;
                                   border-top:1px solid #e5e7eb;
                                   margin:25px 0;' />

                        <p style='font-size:12px;
                                  color:#9ca3af;'>
                            This is an automated email from Success24.
                            Please do not reply to this email.
                        </p>

                    </div>

                </div>
            ");

            return body.ToString();
        }


        // =========================================================
        // ERROR
        // =========================================================

        private void ShowError(string message)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;

            lblMessage.Style["background"] = "#fff2f2";
            lblMessage.Style["color"] = "#c62828";
            lblMessage.Style["border"] =
                "1px solid #ffd5d5";
        }


        // =========================================================
        // SUCCESS
        // =========================================================

        private void ShowSuccess(string message)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;

            lblMessage.Style["background"] = "#ecfdf3";
            lblMessage.Style["color"] = "#16794b";
            lblMessage.Style["border"] =
                "1px solid #b7ebcf";
        }
    }
    
}