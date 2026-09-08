using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.Recruiter
{
    public partial class RecruiterRegister : System.Web.UI.Page
    {
        private readonly string connectionString =
           ConfigurationManager
               .ConnectionStrings["Success24Connection"]
               .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName =
                txtFullName.Text.Trim();

            string email =
                txtEmail.Text.Trim().ToLower();

            string mobile =
                txtPhone.Text.Trim();

            string designation =
                txtDesignation.Text.Trim();

            string password =
                txtPassword.Text;

            string confirmPassword =
                txtConfirmPassword.Text;


            // =========================================
            // VALIDATION
            // =========================================

            if (string.IsNullOrWhiteSpace(fullName))
            {
                ShowMessage(
                    "Please enter your full name.",
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


            if (string.IsNullOrWhiteSpace(mobile))
            {
                ShowMessage(
                    "Please enter your mobile number.",
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
                using (
                    SqlConnection con =
                        new SqlConnection(
                            connectionString))
                {
                    con.Open();


                    // =========================================
                    // CHECK EMAIL
                    // =========================================

                    const string checkEmailQuery = @"
                        SELECT COUNT(1)
                        FROM Users
                        WHERE Email = @Email;";


                    using (
                        SqlCommand checkEmailCmd =
                            new SqlCommand(
                                checkEmailQuery,
                                con))
                    {
                        checkEmailCmd.Parameters.Add(
                            "@Email",
                            SqlDbType.NVarChar,
                            250
                        ).Value = email;


                        int emailExists =
                            Convert.ToInt32(
                                checkEmailCmd.ExecuteScalar()
                            );


                        if (emailExists > 0)
                        {
                            ShowMessage(
                                "An account with this email already exists.",
                                false
                            );

                            return;
                        }
                    }


                    // =========================================
                    // CHECK MOBILE
                    // =========================================

                    const string checkMobileQuery = @"
                        SELECT COUNT(1)
                        FROM Users
                        WHERE Mobile = @Mobile;";


                    using (
                        SqlCommand checkMobileCmd =
                            new SqlCommand(
                                checkMobileQuery,
                                con))
                    {
                        checkMobileCmd.Parameters.Add(
                            "@Mobile",
                            SqlDbType.NVarChar,
                            30
                        ).Value = mobile;


                        int mobileExists =
                            Convert.ToInt32(
                                checkMobileCmd.ExecuteScalar()
                            );


                        if (mobileExists > 0)
                        {
                            ShowMessage(
                                "An account with this mobile number already exists.",
                                false
                            );

                            return;
                        }
                    }


                    // =========================================
                    // PASSWORD HASH
                    // =========================================

                    string passwordHash =
                        HashPassword(password);


                    // =========================================
                    // TRANSACTION
                    // =========================================

                    using (
                        SqlTransaction transaction =
                            con.BeginTransaction())
                    {
                        try
                        {
                            // =================================
                            // INSERT USERS
                            // =================================

                            const string userQuery = @"
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
                                    CreatedAt,
                                    UpdatedAt
                                )
                                OUTPUT INSERTED.UserId
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
                                    SYSDATETIME(),
                                    SYSDATETIME()
                                );";


                            int userId;


                            using (
                                SqlCommand userCmd =
                                    new SqlCommand(
                                        userQuery,
                                        con,
                                        transaction))
                            {
                                userCmd.Parameters.Add(
                                    "@FullName",
                                    SqlDbType.NVarChar,
                                    200
                                ).Value =
                                    fullName;


                                userCmd.Parameters.Add(
                                    "@Email",
                                    SqlDbType.NVarChar,
                                    250
                                ).Value =
                                    email;


                                userCmd.Parameters.Add(
                                    "@Mobile",
                                    SqlDbType.NVarChar,
                                    30
                                ).Value =
                                    mobile;


                                userCmd.Parameters.Add(
                                    "@PasswordHash",
                                    SqlDbType.NVarChar,
                                    500
                                ).Value =
                                    passwordHash;


                                userCmd.Parameters.Add(
                                    "@UserRole",
                                    SqlDbType.NVarChar,
                                    50
                                ).Value =
                                    "Recruiter";


                                userId =
                                    Convert.ToInt32(
                                        userCmd.ExecuteScalar()
                                    );
                            }


                            // =================================
                            // INSERT RECRUITER PROFILE
                            // =================================

                            const string profileQuery = @"
                                INSERT INTO RecruiterProfiles
                                (
                                    UserId,
                                    Designation,
                                    ProfilePhoto,
                                    IsVerified,
                                    CreatedAt,
                                    UpdatedAt
                                )
                                VALUES
                                (
                                    @UserId,
                                    @Designation,
                                    NULL,
                                    1,
                                    SYSDATETIME(),
                                    SYSDATETIME()
                                );";


                            using (
                                SqlCommand profileCmd =
                                    new SqlCommand(
                                        profileQuery,
                                        con,
                                        transaction))
                            {
                                profileCmd.Parameters.Add(
                                    "@UserId",
                                    SqlDbType.Int
                                ).Value =
                                    userId;


                                profileCmd.Parameters.Add(
                                    "@Designation",
                                    SqlDbType.NVarChar,
                                    300
                                ).Value =
                                    designation;


                                profileCmd.ExecuteNonQuery();
                            }


                            // =================================
                            // COMMIT
                            // =================================

                            transaction.Commit();


                            ShowMessage(
                                "Recruiter account created successfully. You can now login.",
                                true
                            );


                            ClearForm();
                        }
                        catch
                        {
                            transaction.Rollback();

                            throw;
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                if (
                    ex.Number == 2601 ||
                    ex.Number == 2627)
                {
                    ShowMessage(
                        "Email or mobile number is already registered.",
                        false
                    );
                }
                else
                {
                    ShowMessage(
                        "Database error: " +
                        ex.Message,
                        false
                    );
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Registration failed: " +
                    ex.Message,
                    false
                );
            }


        }
        // =========================================
        // PASSWORD HASH
        // =========================================

        private string HashPassword(
            string password)
        {
            byte[] salt =
                new byte[16];


            using (
                RandomNumberGenerator rng =
                    RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }


            using (
                var pbkdf2 =
                    new System.Security.Cryptography.Rfc2898DeriveBytes(
                        password,
                        salt,
                        100000,
                        HashAlgorithmName.SHA256))
            {
                byte[] hash =
                    pbkdf2.GetBytes(32);


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

        private void ShowMessage(
            string message,
            bool success)
        {
            lblMessage.Text =
                Server.HtmlEncode(message);


            lblMessage.Visible = true;


            lblMessage.CssClass =
                success
                    ? "message success"
                    : "message error";
        }

    }
}