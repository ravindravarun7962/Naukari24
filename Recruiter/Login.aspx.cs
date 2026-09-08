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
    public partial class Login : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager
                .ConnectionStrings["Success24Connection"]
                .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Already logged in recruiter
                // can go directly to dashboard.

                if (Session["UserId"] != null)
                {
                    int recruiterId =
                        GetRecruiterId(
                            Convert.ToInt32(
                                Session["UserId"]
                            )
                        );


                    if (recruiterId > 0)
                    {
                        Response.Redirect(
                            "~/Recruiter/Dashboard.aspx"
                        );
                    }
                }
            }

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email =
    txtEmail.Text.Trim().ToLower();


            string password =
                txtPassword.Text;


            // =========================================
            // VALIDATION
            // =========================================

            if (string.IsNullOrWhiteSpace(email))
            {
                ShowMessage(
                    "Please enter your email address."
                );

                return;
            }


            if (string.IsNullOrWhiteSpace(password))
            {
                ShowMessage(
                    "Please enter your password."
                );

                return;
            }


            try
            {
                const string query = @"
                    SELECT
                        U.UserId,
                        U.FullName,
                        U.Email,
                        U.PasswordHash,
                        U.IsActive,
                        U.UserRole,

                        RP.RecruiterId,
                        RP.IsVerified

                    FROM Users U

                    INNER JOIN RecruiterProfiles RP
                        ON U.UserId = RP.UserId

                    WHERE LOWER(U.Email) = @Email

                      AND U.UserRole = 'Recruiter';";


                using (
                    SqlConnection con =
                        new SqlConnection(
                            connectionString))
                using (
                    SqlCommand cmd =
                        new SqlCommand(
                            query,
                            con))
                {
                    cmd.Parameters.Add(
                        "@Email",
                        SqlDbType.NVarChar,
                        250
                    ).Value = email;


                    con.Open();


                    using (
                        SqlDataReader reader =
                            cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            ShowMessage(
                                "Invalid email or password."
                            );

                            return;
                        }


                        // =================================
                        // ACCOUNT STATUS
                        // =================================

                        bool isActive =
                            Convert.ToBoolean(
                                reader["IsActive"]
                            );


                        if (!isActive)
                        {
                            ShowMessage(
                                "Your account is inactive. Please contact administrator."
                            );

                            return;
                        }


                        // =================================
                        // RECRUITER VERIFICATION
                        // =================================

                        bool isVerified =
                            Convert.ToBoolean(
                                reader["IsVerified"]
                            );


                        if (!isVerified)
                        {
                            ShowMessage(
                                "Your recruiter profile is not verified yet."
                            );

                            return;
                        }


                        // =================================
                        // PASSWORD
                        // =================================

                        string storedHash =
                            Convert.ToString(
                                reader["PasswordHash"]
                            );


                        if (!VerifyPassword(
                            password,
                            storedHash))
                        {
                            ShowMessage(
                                "Invalid email or password."
                            );

                            return;
                        }


                        // =================================
                        // GET DATA
                        // =================================

                        int userId =
                            Convert.ToInt32(
                                reader["UserId"]
                            );


                        int recruiterId =
                            Convert.ToInt32(
                                reader["RecruiterId"]
                            );


                        string fullName =
                            Convert.ToString(
                                reader["FullName"]
                            );


                        // =================================
                        // SESSION
                        // =================================

                        Session.Clear();


                        Session["UserId"] =
                            userId;


                        Session["RecruiterId"] =
                            recruiterId;


                        Session["FullName"] =
                            fullName;


                        Session["UserRole"] =
                            "Recruiter";


                        Session["IsRecruiterLoggedIn"] =
                            true;


                        // =================================
                        // UPDATE LAST LOGIN
                        // =================================

                        reader.Close();


                        UpdateLastLogin(
                            userId
                        );


                        // =================================
                        // REDIRECT
                        // =================================

                        Response.Redirect(
                            "~/Recruiter/Dashboard.aspx"
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Login failed: " +
                    ex.Message
                );
            }

        }
        // =========================================
        // VERIFY PASSWORD
        // =========================================

        private bool VerifyPassword(
            string password,
            string storedHash)
        {
            try
            {
                if (
                    string.IsNullOrWhiteSpace(
                        storedHash))
                {
                    return false;
                }


                // Expected format:
                //
                // PBKDF2$100000$salt$hash

                string[] parts =
                    storedHash.Split('$');


                if (
                    parts.Length != 4)
                {
                    return false;
                }


                if (
                    parts[0] != "PBKDF2")
                {
                    return false;
                }


                int iterations;

                if (
                    !int.TryParse(
                        parts[1],
                        out iterations))
                {
                    return false;
                }


                byte[] salt =
                    Convert.FromBase64String(
                        parts[2]
                    );


                byte[] storedPasswordHash =
                    Convert.FromBase64String(
                        parts[3]
                    );


                using (
                    var pbkdf2 =
                        new Rfc2898DeriveBytes(
                            password,
                            salt,
                            iterations,
                            HashAlgorithmName.SHA256))
                {
                    byte[] calculatedHash =
                        pbkdf2.GetBytes(
                            storedPasswordHash.Length
                        );


                    return FixedTimeEquals(
                        calculatedHash,
                        storedPasswordHash
                    );
                }
            }
            catch
            {
                return false;
            }
        }


        // =========================================
        // FIXED TIME COMPARISON
        // =========================================

        private bool FixedTimeEquals(
            byte[] first,
            byte[] second)
        {
            if (
                first == null ||
                second == null ||
                first.Length != second.Length)
            {
                return false;
            }


            int result = 0;


            for (
                int i = 0;
                i < first.Length;
                i++)
            {
                result |=
                    first[i] ^ second[i];
            }


            return result == 0;
        }


        // =========================================
        // GET RECRUITER ID
        // =========================================

        private int GetRecruiterId(
            int userId)
        {
            const string query = @"
                SELECT RecruiterId
                FROM RecruiterProfiles
                WHERE UserId = @UserId
                  AND IsVerified = 1;";


            using (
                SqlConnection con =
                    new SqlConnection(
                        connectionString))
            using (
                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con))
            {
                cmd.Parameters.Add(
                    "@UserId",
                    SqlDbType.Int
                ).Value = userId;


                con.Open();


                object result =
                    cmd.ExecuteScalar();


                if (
                    result == null ||
                    result == DBNull.Value)
                {
                    return 0;
                }


                return Convert.ToInt32(
                    result
                );
            }
        }


        // =========================================
        // UPDATE LAST LOGIN
        // =========================================

        private void UpdateLastLogin(
            int userId)
        {
            const string query = @"
                UPDATE Users
                SET LastLoginAt = SYSDATETIME(),
                    UpdatedAt = SYSDATETIME()
                WHERE UserId = @UserId;";


            using (
                SqlConnection con =
                    new SqlConnection(
                        connectionString))
            using (
                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con))
            {
                cmd.Parameters.Add(
                    "@UserId",
                    SqlDbType.Int
                ).Value = userId;


                con.Open();

                cmd.ExecuteNonQuery();
            }
        }


        // =========================================
        // MESSAGE
        // =========================================

        private void ShowMessage(
            string message)
        {
            lblMessage.Text =
                Server.HtmlEncode(
                    message
                );

            lblMessage.Visible =
                true;

            lblMessage.CssClass =
                "message error";
        }

    }
}