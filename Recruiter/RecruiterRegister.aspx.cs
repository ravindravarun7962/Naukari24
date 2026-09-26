using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Web.UI;

namespace Success24_Job_Portal.Recruiter
{
    public partial class RecruiterRegister : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
                lblMessage.Visible = false;
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim().ToLowerInvariant();
            string mobile = txtPhone.Text.Trim();
            string designation = txtDesignation.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            // =========================================
            //  SERVER - SIDE VALIDATION
            // =========================================

            if (string.IsNullOrWhiteSpace(fullName))
            {
                ShowMessage(
                    "Please enter your full name.",
                    false
                );

                return;
            }
            if (!Regex.IsMatch(fullName,@"^[A-Za-z]+(?:\s+[A-Za-z]+)*$"))
            {
                ShowMessage(
                    "Full name must contain alphabets and spaces only.",
                    false
                );

                return;
            }

            if (string.IsNullOrWhiteSpace(email))
            {
                ShowMessage(
                    "Please enter your email address.",
                    false
                );

                return;
            }

            if (!Regex.IsMatch(email,@"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"))
            {
                ShowMessage(
                    "Please enter a valid email address, e.g. test@gmail.com.",
                    false
                );

                return;
            }


            if (string.IsNullOrWhiteSpace(mobile))
            {
                ShowMessage(
                    "Please enter your mobile number.",
                    false
                );

                return;
            }

            if (!Regex.IsMatch(mobile,@"^[6-9][0-9]{9}$"))
            {
                ShowMessage(
                    "Please enter a valid 10-digit mobile number.",
                    false
                );

                return;
            }


            if (string.IsNullOrWhiteSpace(designation))
            {
                ShowMessage(
                    "Please enter your designation.",
                    false
                );

                return;
            }

            if (!Regex.IsMatch(designation,@"^[A-Za-z]+(?:[A-Za-z.&/-]*)(?:\s+[A-Za-z.&/-]+)*$"))
            {
                ShowMessage(
                    "Please enter a valid designation.",
                    false
                );

                return;
            }

            if (string.IsNullOrWhiteSpace(password))
            {
                ShowMessage(
                    "Please enter a password.",
                    false
                );

                return;
            }



            if (password.Length < 6)
            {
                ShowMessage(
                    "Password must contain at least 6 characters.",
                    false
                );

                return;
            }


            if (password != confirmPassword)
            {
                ShowMessage(
                    "Password and confirm password do not match.",
                    false
                );

                return;
            }


            try
            {
                // =========================================
                // CHECK DUPLICATE EMAIL
                // =========================================

                string checkEmailQuery = @"SELECT COUNT(1) FROM Users WHERE Email = @Email;";
                int emailExists = Convert.ToInt32(
                    Utility.ExecuteScalar24(checkEmailQuery,new SqlParameter("@Email",SqlDbType.NVarChar,150)
                        {
                            Value = email
                        }
                    )
                );


                if (emailExists > 0)
                {
                    ShowMessage(
                        "An account with this email already exists.",
                        false
                    );

                    return;
                }


                // =========================================
                // CHECK DUPLICATE MOBILE
                // =========================================

                string checkMobileQuery = @"SELECT COUNT(1) FROM Users WHERE Mobile = @Mobile;";
                int mobileExists = Convert.ToInt32(
                    Utility.ExecuteScalar24(checkMobileQuery,new SqlParameter("@Mobile",SqlDbType.NVarChar,15)
                        {
                            Value = mobile
                        }
                    )
                );


                if (mobileExists > 0)
                {
                    ShowMessage(
                        "An account with this mobile number already exists.",
                        false
                    );

                    return;
                }


                // =========================================
                // PASSWORD HASH
                // =========================================

                string passwordHash = HashPassword(password);

                // =========================================
                // INSERT USER
                // =========================================

                string userQuery = @"INSERT INTO Users (FullName,Email,Mobile,PasswordHash,UserRole,IsEmailVerified,IsMobileVerified,IsActive,CreatedAt,UpdatedAt) VALUES (@FullName,@Email,@Mobile,@PasswordHash,@UserRole,0,0,1,SYSDATETIME(),SYSDATETIME()); SELECT CAST(SCOPE_IDENTITY() AS INT);";
                // =========================================
                // INSERT RECRUITER PROFILE
                // =========================================

                string profileQuery = @"INSERT INTO RecruiterProfiles (UserId,Designation,ProfilePhoto,IsVerified,CreatedAt,UpdatedAt) VALUES (@UserId,@Designation,NULL,1,SYSDATETIME(),SYSDATETIME());";
                // =========================================
                // TRANSACTION
                //
                // Utility.ExecuteTransaction24:
                //
                // 1. Inserts Users
                // 2. Gets UserId
                // 3. Automatically assigns UserId
                //    to @UserId in second query
                // 4. Inserts RecruiterProfiles
                // 5. Commits both
                // =========================================

                int userId =
                    Utility.ExecuteTransaction24(userQuery,new SqlParameter[]
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
                                Value = "Recruiter"
                            }
                        },

                        profileQuery,

                        new SqlParameter[]
                        {
                            new SqlParameter("@UserId",SqlDbType.Int)
                            {
                                Value = 0
                            },

                            new SqlParameter("@Designation",SqlDbType.NVarChar,300)
                            {
                                Value = designation
                            }
                        }
                    );


                // =========================================
                // SUCCESS
                // =========================================

                ShowMessage(
                    "Recruiter account created successfully. You can now login.",
                    true
                );

                ClearForm();
            }
            catch (SqlException ex)
            {
                // =========================================
                // DUPLICATE DATABASE CONSTRAINT
                // =========================================

                if (ex.Number == 2601 || ex.Number == 2627)
                {
                    ShowMessage(
                        "Email or mobile number is already registered.",
                        false
                    );
                }
                else
                {
                    ShowMessage(
                        "Database error. We couldn't create your account right now. Please try again.",
                        false
                    );
                }
            }
            catch (Exception)
            {
                ShowMessage(
                    "Registration failed. Please try again.",
                    false
                );
            }
        }

        
        // =========================================
        // PASSWORD HASH
        // =========================================

        private string HashPassword(string password)
        {
            byte[] salt = new byte[16];
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }


            using (var pbkdf2 = new Rfc2898DeriveBytes(password,salt,100000,HashAlgorithmName.SHA256))
            {
                byte[] hash = pbkdf2.GetBytes(32);
                return
                    "PBKDF2$100000$"
                    +
                    Convert.ToBase64String(salt)
                    +
                    "$"
                    +
                    Convert.ToBase64String(hash);
            }
        }


        // =========================================
        // CLEAR FORM
        // =========================================

        private void ClearForm()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtDesignation.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
        }


        // =========================================
        // MESSAGE
        // =========================================

        private void ShowMessage(string message,bool success)
        {
            lblMessage.Text = Server.HtmlEncode(message);
            lblMessage.Visible = true;
            lblMessage.CssClass =
                success
                    ? "message success"
                    : "message error";
        }

    }
}