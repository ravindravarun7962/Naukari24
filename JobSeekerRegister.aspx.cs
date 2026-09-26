using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class JobSeekerRegister : Page
    {
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
            string email = txtEmail.Text.Trim().ToLowerInvariant();
            string mobile = txtMobile.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

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
            // FULL NAME VALIDATION
            // =========================================

            if (!Regex.IsMatch(fullName, @"^[A-Za-z]+(?:\s+[A-Za-z]+)*$"))
            {
                ShowError("Full name must contain alphabets and spaces only.");
                return;
            }


            // =========================================
            // EMAIL VALIDATION
            // =========================================

            if (!Regex.IsMatch(
                email,
                @"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"))
            {
                ShowError("Please enter a valid email address.");
                return;
            }


            // =========================================
            // MOBILE VALIDATION
            // =========================================

            if (!Regex.IsMatch(mobile, @"^[6-9][0-9]{9}$"))
            {
                ShowError("Please enter a valid 10-digit mobile number.");
                return;
            }


            // =========================================
            // PASSWORD VALIDATION
            // =========================================

            if (!Regex.IsMatch(
                password,
                @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,100}$"))
            {
                ShowError(
                    "Password must contain at least 8 characters, including uppercase, lowercase, number and special character."
                );

                return;
            }

            // =========================================
            // CONFIRM PASSWORD
            // =========================================

            if (password != confirmPassword)
            {
                ShowError(
                    "Passwords do not match."
                );

                return;
            }

            try
            {
                // =================================
                // CHECK DUPLICATE EMAIL
                // =================================

                string checkEmailQuery = @"SELECT COUNT(*) FROM Users WHERE Email = @Email";
                int emailExists = Convert.ToInt32(Utility.ExecuteScalar24(checkEmailQuery,new SqlParameter("@Email",SqlDbType.NVarChar,150)
                            {
                                Value = email
                            })
                 );


                if (emailExists > 0)
                {
                    ShowError(
                        "An account with this email address already exists."
                    );

                    return;
                }


                // =================================
                // CHECK DUPLICATE MOBILE
                // =================================

                string checkMobileQuery = @"SELECT COUNT(*) FROM Users WHERE Mobile = @Mobile";
                int mobileExists = Convert.ToInt32(Utility.ExecuteScalar24(checkMobileQuery,new SqlParameter("@Mobile",SqlDbType.NVarChar,15)
                            {
                                Value = mobile
                            })
                );


                if (mobileExists > 0)
                {
                    ShowError(
                        "An account with this mobile number already exists."
                    );

                    return;
                }


                // =================================
                // HASH PASSWORD
                // =================================

                string passwordHash = BCrypt.Net.BCrypt.HashPassword(password,workFactor: 12);

                // =================================
                // START TRANSACTION
                // =================================

                // =========================
                // INSERT USER
                // =========================

                string insertUserQuery = @"INSERT INTO Users (FullName,Email,Mobile,PasswordHash,UserRole,IsEmailVerified,IsMobileVerified,IsActive,CreatedAt) VALUES (@FullName,@Email,@Mobile,@PasswordHash,@UserRole,0,0,1,SYSDATETIME()); SELECT CAST(SCOPE_IDENTITY() AS INT);";
                // =========================
                // CREATE JOB SEEKER PROFILE
                // =========================

                string profileQuery = @"INSERT INTO JobSeekerProfiles (UserId,ProfileCompletion,CreatedAt) VALUES (@UserId,10,SYSDATETIME());";
                int userId = Utility.ExecuteTransaction24(insertUserQuery,new SqlParameter[]
                        {
                            new SqlParameter("@FullName",SqlDbType.NVarChar,100)
                            {
                                Value = fullName
                            },

                            new SqlParameter("@Email",SqlDbType.NVarChar,150)
                            {
                                Value = email
                            },

                            new SqlParameter("@Mobile",SqlDbType.NVarChar,15)
                            {
                                Value = mobile
                            },

                            new SqlParameter("@PasswordHash",SqlDbType.NVarChar,500)
                            {
                                Value = passwordHash
                            },

                            new SqlParameter("@UserRole",SqlDbType.NVarChar,20)
                            {
                                Value = "JobSeeker"
                            }
                        },

                        profileQuery,

                        new SqlParameter[]
                        {
                            new SqlParameter(
                                "@UserId",
                                SqlDbType.Int
                            )
                            {
                                Value = 0
                            }
                        }
                    );


                // =================================
                // REDIRECT WITH SUCCESS FLAG
                // =================================

                Response.Redirect(
                    "~/Login.aspx?registered=1",
                    false
                );

                Context.ApplicationInstance.CompleteRequest();
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

    
