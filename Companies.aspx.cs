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
    public partial class Companies : System.Web.UI.Page
    {
        private readonly string connectionString =
           ConfigurationManager
               .ConnectionStrings["Success24Connection"]
               .ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckRecruiter();

                LoadCompanies();
            }

        }
        // =========================================
        // CHECK RECRUITER LOGIN
        // =========================================

        private void CheckRecruiter()
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Recruiter/Login.aspx"
                );

                return;
            }


            int userId;

            if (!int.TryParse(
                Convert.ToString(
                    Session["UserId"]),
                out userId))
            {
                Session.Clear();

                Response.Redirect(
                    "~/Recruiter/Login.aspx"
                );

                return;
            }


            const string query = @"
                SELECT COUNT(*)
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


                int count =
                    Convert.ToInt32(
                        cmd.ExecuteScalar()
                    );


                if (count == 0)
                {
                    Session.Clear();

                    Response.Redirect(
                        "~/Recruiter/Login.aspx"
                    );
                }
            }
        }


        // =========================================
        // LOAD COMPANIES
        // =========================================

        private void LoadCompanies()
        {
            const string query = @"
                SELECT
                    CompanyId,
                    CompanyName,
                    CompanyLogo,
                    Website,
                    Industry,
                    CompanySize,
                    FoundedYear,
                    Description,
                    Address,
                    City,
                    State,
                    Pincode,
                    IsVerified,
                    IsActive,
                    CreatedAt
                FROM Companies
                ORDER BY
                    CompanyName ASC;";


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
                using (
                    SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                {
                    DataTable dt =
                        new DataTable();


                    da.Fill(dt);


                    gvCompanies.DataSource =
                        dt;

                    gvCompanies.DataBind();
                }
            }
        }


        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();

            lblMessage.Visible = false;

        }

        private void ClearForm()
        {
            txtCompanyName.Text = "";
            txtCompanyLogo.Text = "";
            txtWebsite.Text = "";
            txtIndustry.Text = "";

            ddlCompanySize.SelectedIndex = 0;

            txtFoundedYear.Text = "";
            txtDescription.Text = "";
            txtAddress.Text = "";
            txtCity.Text = "";
            txtState.Text = "";
            txtPincode.Text = "";

            chkIsActive.Checked = true;
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


        protected void btnSave_Click(object sender, EventArgs e)
        {
            string companyName =
    txtCompanyName.Text.Trim();

            string logo =
                txtCompanyLogo.Text.Trim();

            string website =
                txtWebsite.Text.Trim();

            string industry =
                txtIndustry.Text.Trim();

            string companySize =
                ddlCompanySize.SelectedValue;

            string foundedYearText =
                txtFoundedYear.Text.Trim();

            string description =
                txtDescription.Text.Trim();

            string address =
                txtAddress.Text.Trim();

            string city =
                txtCity.Text.Trim();

            string state =
                txtState.Text.Trim();

            string pincode =
                txtPincode.Text.Trim();

            bool isActive =
                chkIsActive.Checked;


            // =========================================
            // VALIDATION
            // =========================================

            if (string.IsNullOrWhiteSpace(companyName))
            {
                ShowMessage(
                    "Please enter company name.",
                    false
                );

                return;
            }


            int foundedYear = 0;


            if (!string.IsNullOrWhiteSpace(
                foundedYearText))
            {
                if (!int.TryParse(
                    foundedYearText,
                    out foundedYear))
                {
                    ShowMessage(
                        "Please enter a valid founded year.",
                        false
                    );

                    return;
                }
            }


            try
            {
                // =====================================
                // DUPLICATE COMPANY CHECK
                // =====================================

                const string duplicateQuery = @"
                    SELECT COUNT(*)
                    FROM Companies
                    WHERE CompanyName = @CompanyName;";


                using (
                    SqlConnection con =
                        new SqlConnection(
                            connectionString))
                using (
                    SqlCommand cmd =
                        new SqlCommand(
                            duplicateQuery,
                            con))
                {
                    cmd.Parameters.Add(
                        "@CompanyName",
                        SqlDbType.NVarChar,
                        300
                    ).Value =
                        companyName;


                    con.Open();


                    int count =
                        Convert.ToInt32(
                            cmd.ExecuteScalar()
                        );


                    if (count > 0)
                    {
                        ShowMessage(
                            "This company already exists.",
                            false
                        );

                        return;
                    }
                }


                // =====================================
                // INSERT
                // =====================================

                const string insertQuery = @"
                    INSERT INTO Companies
                    (
                        CompanyName,
                        CompanyLogo,
                        Website,
                        Industry,
                        CompanySize,
                        FoundedYear,
                        Description,
                        Address,
                        City,
                        State,
                        Pincode,
                        IsVerified,
                        IsActive,
                        CreatedAt
                    )
                    VALUES
                    (
                        @CompanyName,
                        @CompanyLogo,
                        @Website,
                        @Industry,
                        @CompanySize,
                        @FoundedYear,
                        @Description,
                        @Address,
                        @City,
                        @State,
                        @Pincode,
                        1,
                        @IsActive,
                        SYSDATETIME()
                    );";


                using (
                    SqlConnection con =
                        new SqlConnection(
                            connectionString))
                using (
                    SqlCommand cmd =
                        new SqlCommand(
                            insertQuery,
                            con))
                {
                    cmd.Parameters.Add(
                        "@CompanyName",
                        SqlDbType.NVarChar,
                        300
                    ).Value =
                        companyName;


                    cmd.Parameters.Add(
                        "@CompanyLogo",
                        SqlDbType.NVarChar,
                        500
                    ).Value =
                        string.IsNullOrWhiteSpace(logo)
                            ? (object)DBNull.Value
                            : logo;


                    cmd.Parameters.Add(
                        "@Website",
                        SqlDbType.NVarChar,
                        500
                    ).Value =
                        string.IsNullOrWhiteSpace(website)
                            ? (object)DBNull.Value
                            : website;


                    cmd.Parameters.Add(
                        "@Industry",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        string.IsNullOrWhiteSpace(industry)
                            ? (object)DBNull.Value
                            : industry;


                    cmd.Parameters.Add(
                        "@CompanySize",
                        SqlDbType.NVarChar,
                        100
                    ).Value =
                        string.IsNullOrWhiteSpace(companySize)
                            ? (object)DBNull.Value
                            : companySize;


                    cmd.Parameters.Add(
                        "@FoundedYear",
                        SqlDbType.Int
                    ).Value =
                        foundedYear == 0
                            ? (object)DBNull.Value
                            : foundedYear;


                    cmd.Parameters.Add(
                        "@Description",
                        SqlDbType.NVarChar
                    ).Value =
                        string.IsNullOrWhiteSpace(description)
                            ? (object)DBNull.Value
                            : description;


                    cmd.Parameters.Add(
                        "@Address",
                        SqlDbType.NVarChar,
                        500
                    ).Value =
                        string.IsNullOrWhiteSpace(address)
                            ? (object)DBNull.Value
                            : address;


                    cmd.Parameters.Add(
                        "@City",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        string.IsNullOrWhiteSpace(city)
                            ? (object)DBNull.Value
                            : city;


                    cmd.Parameters.Add(
                        "@State",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        string.IsNullOrWhiteSpace(state)
                            ? (object)DBNull.Value
                            : state;


                    cmd.Parameters.Add(
                        "@Pincode",
                        SqlDbType.NVarChar,
                        20
                    ).Value =
                        string.IsNullOrWhiteSpace(pincode)
                            ? (object)DBNull.Value
                            : pincode;


                    cmd.Parameters.Add(
                        "@IsActive",
                        SqlDbType.Bit
                    ).Value =
                        isActive;


                    con.Open();

                    cmd.ExecuteNonQuery();
                }


                ShowMessage(
                    "Company added successfully.",
                    true
                );


                ClearForm();

                LoadCompanies();
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Unable to save company: " +
                    ex.Message,
                    false
                );
            }

        }

        // =========================================
        // LOCATION
        // =========================================

        protected string GetLocation(
            object cityObject,
            object stateObject)
        {
            string city =
                Convert.ToString(cityObject);

            string state =
                Convert.ToString(stateObject);


            if (
                string.IsNullOrWhiteSpace(city) &&
                string.IsNullOrWhiteSpace(state))
            {
                return "-";
            }


            if (
                string.IsNullOrWhiteSpace(city))
            {
                return Server.HtmlEncode(state);
            }


            if (
                string.IsNullOrWhiteSpace(state))
            {
                return Server.HtmlEncode(city);
            }


            return Server.HtmlEncode(
                city + ", " + state
            );
        }




        protected void gvCompanies_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (
                e.CommandName !=
                "ToggleStatus")
            {
                return;
            }


            int companyId;


            if (!int.TryParse(
                Convert.ToString(
                    e.CommandArgument),
                out companyId))
            {
                return;
            }


            try
            {
                const string query = @"
                    UPDATE Companies
                    SET IsActive =
                        CASE
                            WHEN IsActive = 1
                            THEN 0
                            ELSE 1
                        END
                    WHERE CompanyId = @CompanyId;";


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
                        "@CompanyId",
                        SqlDbType.Int
                    ).Value =
                        companyId;


                    con.Open();

                    cmd.ExecuteNonQuery();
                }


                ShowMessage(
                    "Company status updated successfully.",
                    true
                );


                LoadCompanies();
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Unable to update company status: " +
                    ex.Message,
                    false
                );
            }

        }
    }
}