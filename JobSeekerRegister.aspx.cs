using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class JobSeekerRegister : System.Web.UI.Page
    {
        private readonly string connectionString =
           ConfigurationManager
           .ConnectionStrings["Success24Connection"]
           .ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;


            string fullName = txtFullName.Text.Trim();

            string email = txtEmail.Text
                .Trim()
                .ToLowerInvariant();

            string mobile = txtMobile.Text.Trim();

            string password = txtPassword.Text;


            // =========================================
            // TERMS CHECK
            // =========================================

            if (!chkTerms.Checked)
            {
                ShowError(
                    "Please accept the Terms & Conditions and Privacy Policy."
                );

                return;
            }


            // =========================================
            // EXTRA SERVER-SIDE PASSWORD CHECK
            // =========================================

            if (password.Length < 8)
            {
                ShowError(
                    "Password must contain at least 8 characters."
                );

                return;
            }


            try
            {
                using (SqlConnection con =
                       new SqlConnection(connectionString))
                {
                    con.Open();


                    // =================================
                    // CHECK DUPLICATE EMAIL
                    // =================================

                    string checkEmailQuery = @"
                        SELECT COUNT(*)
                        FROM Users
                        WHERE Email = @Email";


                    using (SqlCommand checkEmailCmd =
                           new SqlCommand(checkEmailQuery, con))
                    {
                        checkEmailCmd.Parameters.Add(
                            "@Email",
                            SqlDbType.NVarChar,
                            150
                        ).Value = email;


                        int emailExists =
                            Convert.ToInt32(
                                checkEmailCmd.ExecuteScalar()
                            );


                        if (emailExists > 0)
                        {
                            ShowError(
                                "An account with this email address already exists."
                            );

                            return;
                        }
                    }


                    // =================================
                    // CHECK DUPLICATE MOBILE
                    // =================================

                    string checkMobileQuery = @"
                        SELECT COUNT(*)
                        FROM Users
                        WHERE Mobile = @Mobile";


                    using (SqlCommand checkMobileCmd =
                           new SqlCommand(checkMobileQuery, con))
                    {
                        checkMobileCmd.Parameters.Add(
                            "@Mobile",
                            SqlDbType.NVarChar,
                            15
                        ).Value = mobile;


                        int mobileExists =
                            Convert.ToInt32(
                                checkMobileCmd.ExecuteScalar()
                            );


                        if (mobileExists > 0)
                        {
                            ShowError(
                                "An account with this mobile number already exists."
                            );

                            return;
                        }
                    }


                    // =================================
                    // HASH PASSWORD
                    // =================================

                    string passwordHash =
                        BCrypt.Net.BCrypt.HashPassword(
                            password,
                            workFactor: 12
                        );


                    // =================================
                    // START TRANSACTION
                    // =================================

                    using (SqlTransaction transaction =
                           con.BeginTransaction())
                    {
                        try
                        {
                            // =========================
                            // INSERT USER
                            // =========================

                            string insertUserQuery = @"
                                INSERT INTO Users
                                (
                                    FullName,
                                    Email,
                                    Mobile,
                                    PasswordHash,
                                    UserRole,
                                    IsEmailVerified,
                                    IsMobileVerified,
                                    IsActive,
                                    CreatedAt
                                )
                                VALUES
                                (
                                    @FullName,
                                    @Email,
                                    @Mobile,
                                    @PasswordHash,
                                    @UserRole,
                                    0,
                                    0,
                                    1,
                                    SYSDATETIME()
                                );

                                SELECT CAST(
                                    SCOPE_IDENTITY() AS INT
                                );";


                            int userId;


                            using (SqlCommand cmd =
                                   new SqlCommand(
                                       insertUserQuery,
                                       con,
                                       transaction
                                   ))
                            {
                                cmd.Parameters.Add(
                                    "@FullName",
                                    SqlDbType.NVarChar,
                                    100
                                ).Value = fullName;


                                cmd.Parameters.Add(
                                    "@Email",
                                    SqlDbType.NVarChar,
                                    150
                                ).Value = email;


                                cmd.Parameters.Add(
                                    "@Mobile",
                                    SqlDbType.NVarChar,
                                    15
                                ).Value = mobile;


                                cmd.Parameters.Add(
                                    "@PasswordHash",
                                    SqlDbType.NVarChar,
                                    500
                                ).Value = passwordHash;


                                cmd.Parameters.Add(
                                    "@UserRole",
                                    SqlDbType.NVarChar,
                                    20
                                ).Value = "JobSeeker";


                                userId =
                                    Convert.ToInt32(
                                        cmd.ExecuteScalar()
                                    );
                            }


                            // =========================
                            // CREATE JOB SEEKER PROFILE
                            // =========================

                            string profileQuery = @"
                                INSERT INTO JobSeekerProfiles
                                (
                                    UserId,
                                    ProfileCompletion,
                                    CreatedAt
                                )
                                VALUES
                                (
                                    @UserId,
                                    10,
                                    SYSDATETIME()
                                );";


                            using (SqlCommand profileCmd =
                                   new SqlCommand(
                                       profileQuery,
                                       con,
                                       transaction
                                   ))
                            {
                                profileCmd.Parameters.Add(
                                    "@UserId",
                                    SqlDbType.Int
                                ).Value = userId;


                                profileCmd.ExecuteNonQuery();
                            }


                            // =========================
                            // COMMIT
                            // =========================

                            transaction.Commit();


                            // Redirect with success flag

                            Response.Redirect(
                                "~/Login.aspx?registered=1",
                                false
                            );

                            Context.ApplicationInstance
                                .CompleteRequest();
                        }
                        catch
                        {
                            transaction.Rollback();

                            throw;
                        }
                    }
                }
            }
            catch (SqlException)
            {
                ShowError(
                    "We couldn't create your account right now. Please try again."
                );
            }
            catch (Exception)
            {
                ShowError(
                    "Something went wrong. Please try again."
                );
            }
        }
              private void ShowError(string message)
              {
                lblMessage.Text = message;

                lblMessage.Style["background"] = "#fff2f2";
                lblMessage.Style["color"] = "#c62828";
                lblMessage.Style["border"] = "1px solid #ffd5d5";
              }

    }
    
}