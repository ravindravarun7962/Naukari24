using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.Recruiter
{
    public partial class CompanyProfile : System.Web.UI.Page
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

                profileSection.Visible = false;
            }
        }

        // =========================================
        // CHECK RECRUITER
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
        // LOAD COMPANY DROPDOWN
        // =========================================

        private void LoadCompanies()
        {
            const string query = @"
                SELECT
                    CompanyId,
                    CompanyName

                FROM Companies

                WHERE IsActive = 1

                ORDER BY CompanyName ASC;";


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
                con.Open();


                using (
                    SqlDataReader reader =
                        cmd.ExecuteReader())
                {
                    ddlCompany.DataSource =
                        reader;

                    ddlCompany.DataTextField =
                        "CompanyName";

                    ddlCompany.DataValueField =
                        "CompanyId";

                    ddlCompany.DataBind();
                }
            }


            ddlCompany.Items.Insert(
                0,
                new ListItem(
                    "Select Company",
                    ""
                )
            );
        }

        // =========================================
        // LOAD SELECTED COMPANY
        // =========================================

        private void LoadSelectedCompany()
        {
            if (
                string.IsNullOrWhiteSpace(
                    ddlCompany.SelectedValue))
            {
                profileSection.Visible = false;

                return;
            }


            int companyId =
                Convert.ToInt32(
                    ddlCompany.SelectedValue
                );


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
                    IsActive

                FROM Companies

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
                ).Value = companyId;


                con.Open();


                using (
                    SqlDataReader reader =
                        cmd.ExecuteReader())
                {
                    if (!reader.Read())
                    {
                        ShowMessage(
                            "Company not found.",
                            false
                        );

                        profileSection.Visible =
                            false;

                        return;
                    }


                    txtCompanyName.Text =
                        Convert.ToString(
                            reader["CompanyName"]
                        );


                    txtCompanyLogo.Text =
                        GetString(
                            reader["CompanyLogo"]
                        );


                    txtWebsite.Text =
                        GetString(
                            reader["Website"]
                        );


                    txtIndustry.Text =
                        GetString(
                            reader["Industry"]
                        );


                    string companySize =
                        GetString(
                            reader["CompanySize"]
                        );


                    SetCompanySize(
                        companySize
                    );


                    if (
                        reader["FoundedYear"] !=
                        DBNull.Value)
                    {
                        txtFoundedYear.Text =
                            Convert.ToString(
                                reader["FoundedYear"]
                            );
                    }
                    else
                    {
                        txtFoundedYear.Text = "";
                    }


                    txtDescription.Text =
                        GetString(
                            reader["Description"]
                        );


                    txtAddress.Text =
                        GetString(
                            reader["Address"]
                        );


                    txtCity.Text =
                        GetString(
                            reader["City"]
                        );


                    txtState.Text =
                        GetString(
                            reader["State"]
                        );


                    txtPincode.Text =
                        GetString(
                            reader["Pincode"]
                        );


                    bool isVerified =
                        Convert.ToBoolean(
                            reader["IsVerified"]
                        );


                    bool isActive =
                        Convert.ToBoolean(
                            reader["IsActive"]
                        );


                    lblVerification.Text =
                        isVerified
                            ? "Verified"
                            : "Not Verified";


                    lblActiveStatus.Text =
                        isActive
                            ? "Active"
                            : "Inactive";


                    lblCompanyHeading.Text =
                        GetString(
                            reader["CompanyName"]
                        );


                    string logo =
                        GetString(
                            reader["CompanyLogo"]
                        );


                    if (
                        !string.IsNullOrWhiteSpace(
                            logo))
                    {
                        imgCompanyLogo.ImageUrl =
                            logo;

                        imgCompanyLogo.Visible =
                            true;

                        divLogoPlaceholder.Visible =
                            false;
                    }
                    else
                    {
                        imgCompanyLogo.Visible =
                            false;

                        divLogoPlaceholder.Visible =
                            true;
                    }


                    profileSection.Visible =
                        true;
                }
            }
        }



        protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadSelectedCompany();
        }

        protected void btnLoadCompany_Click(object sender, EventArgs e)
        {
            LoadSelectedCompany();

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            LoadSelectedCompany();

        }

        // =========================================
        // HELPERS
        // =========================================

        private string GetString(
            object value)
        {
            if (
                value == null ||
                value == DBNull.Value)
            {
                return "";
            }


            return Convert.ToString(value);
        }


        private object NullIfEmpty(
            string value)
        {
            if (
                string.IsNullOrWhiteSpace(
                    value))
            {
                return DBNull.Value;
            }


            return value.Trim();
        }


        private void SetCompanySize(
            string value)
        {
            ListItem item =
                ddlCompanySize.Items.FindByValue(
                    value
                );


            if (item != null)
            {
                ddlCompanySize.SelectedValue =
                    value;
            }
            else
            {
                ddlCompanySize.SelectedIndex = 0;
            }
        }


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
            if (
                string.IsNullOrWhiteSpace(
                    ddlCompany.SelectedValue))
            {
                ShowMessage(
                    "Please select a company.",
                    false
                );

                return;
            }


            string companyName =
                txtCompanyName.Text.Trim();


            if (
                string.IsNullOrWhiteSpace(
                    companyName))
            {
                ShowMessage(
                    "Company name is required.",
                    false
                );

                return;
            }


            int companyId =
                Convert.ToInt32(
                    ddlCompany.SelectedValue
                );


            int foundedYear = 0;


            if (
                !string.IsNullOrWhiteSpace(
                    txtFoundedYear.Text))
            {
                if (!int.TryParse(
                    txtFoundedYear.Text.Trim(),
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
                const string query = @"
                    UPDATE Companies

                    SET

                        CompanyName =
                            @CompanyName,

                        CompanyLogo =
                            @CompanyLogo,

                        Website =
                            @Website,

                        Industry =
                            @Industry,

                        CompanySize =
                            @CompanySize,

                        FoundedYear =
                            @FoundedYear,

                        Description =
                            @Description,

                        Address =
                            @Address,

                        City =
                            @City,

                        State =
                            @State,

                        Pincode =
                            @Pincode

                    WHERE CompanyId =
                          @CompanyId;";


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
                    ).Value = companyId;


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
                        NullIfEmpty(
                            txtCompanyLogo.Text
                        );


                    cmd.Parameters.Add(
                        "@Website",
                        SqlDbType.NVarChar,
                        500
                    ).Value =
                        NullIfEmpty(
                            txtWebsite.Text
                        );


                    cmd.Parameters.Add(
                        "@Industry",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        NullIfEmpty(
                            txtIndustry.Text
                        );


                    cmd.Parameters.Add(
                        "@CompanySize",
                        SqlDbType.NVarChar,
                        100
                    ).Value =
                        NullIfEmpty(
                            ddlCompanySize.SelectedValue
                        );


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
                        NullIfEmpty(
                            txtDescription.Text
                        );


                    cmd.Parameters.Add(
                        "@Address",
                        SqlDbType.NVarChar,
                        500
                    ).Value =
                        NullIfEmpty(
                            txtAddress.Text
                        );


                    cmd.Parameters.Add(
                        "@City",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        NullIfEmpty(
                            txtCity.Text
                        );


                    cmd.Parameters.Add(
                        "@State",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        NullIfEmpty(
                            txtState.Text
                        );


                    cmd.Parameters.Add(
                        "@Pincode",
                        SqlDbType.NVarChar,
                        20
                    ).Value =
                        NullIfEmpty(
                            txtPincode.Text
                        );


                    con.Open();


                    int rows =
                        cmd.ExecuteNonQuery();


                    if (rows > 0)
                    {
                        ShowMessage(
                            "Company profile updated successfully.",
                            true
                        );


                        LoadSelectedCompany();
                    }
                    else
                    {
                        ShowMessage(
                            "Company profile could not be updated.",
                            false
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Unable to update company: " +
                    ex.Message,
                    false
                );
            }

        }
    }
}