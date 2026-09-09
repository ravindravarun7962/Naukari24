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
    public partial class JobPost : Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["Success24Connection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckRecruiter();
                LoadCompanies();
                LoadCategories();
            }
        }

        // =========================================
        // CHECK RECRUITER
        // =========================================

        private int GetRecruiterId()
        {
            if (Session["UserId"] == null)
            {
                return 0;
            }


            int userId;

            if (!int.TryParse(Convert.ToString(Session["UserId"]),out userId))
            {
                return 0;
            }


            const string query = @"SELECT RecruiterId FROM RecruiterProfiles WHERE UserId = @UserId AND IsVerified = 1;";
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query,con))
            {
                cmd.Parameters.Add("@UserId",SqlDbType.Int).Value = userId;
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result == null || result == DBNull.Value)
                {
                    return 0;
                }

                return Convert.ToInt32(result);
            }
        }


        private void CheckRecruiter()
        {
            int recruiterId = GetRecruiterId();


            if (recruiterId == 0)
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        // =========================================
        // LOAD COMPANIES
        // =========================================

        private void LoadCompanies()
        {
            const string query = @"SELECT CompanyId,CompanyName FROM Companies WHERE IsActive = 1 ORDER BY CompanyName;";
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query,con))
            {
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    ddlCompany.DataSource = reader;
                    ddlCompany.DataTextField = "CompanyName";
                    ddlCompany.DataValueField = "CompanyId";
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

            ddlCompany.Items.Add(
                new ListItem(
                    "Other",
                    "OTHER"
                )
            );
        }


        // =========================================
        // LOAD CATEGORIES
        // =========================================

        private void LoadCategories()
        {
            const string query = @"SELECT CategoryId,CategoryName FROM JobCategories WHERE IsActive = 1 ORDER BY CategoryName;";
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query,con))
            {
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    ddlCategory.DataSource = reader;
                    ddlCategory.DataTextField = "CategoryName";
                    ddlCategory.DataValueField = "CategoryId";
                    ddlCategory.DataBind();
                }
            }


            ddlCategory.Items.Insert(
                0,
                new ListItem(
                    "Select Category",
                    ""
                )
            );

            ddlCategory.Items.Add(
                new ListItem(
                    "Other",
                    "OTHER"
                )
            );
        }



        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            txtJobTitle.Text = "";
            txtJobDescription.Text = "";
            txtResponsibilities.Text = "";
            txtRequirements.Text = "";
            ddlCompany.SelectedIndex = 0;
            ddlCategory.SelectedIndex = 0;
            txtOtherCompany.Text = "";
            txtOtherCompany.Visible = false;
            txtOtherCategory.Text = "";
            txtOtherCategory.Visible = false;
            ddlEmploymentType.SelectedIndex = 0;
            ddlWorkMode.SelectedIndex = 0;
            txtMinExperience.Text = "";
            txtMaxExperience.Text = "";
            txtMinSalary.Text = "";
            txtMaxSalary.Text = "";
            txtCity.Text = "";
            txtState.Text = "";
            txtOpenings.Text = "1";
            txtEducation.Text = "";
            txtDeadline.Text = "";
            ddlJobStatus.SelectedValue ="Active";
            chkSalaryVisible.Checked = true;
            chkFeatured.Checked = false;
        }


        // =========================================
        // HELPERS
        // =========================================

        private object DbValue(string value)
        {
            return string.IsNullOrWhiteSpace(value)? (object)DBNull.Value: value.Trim();
        }

        private int GetInt(string value)
        {
            int result;
            return int.TryParse(value,out result)? result: 0;
        }


        private int? GetNullableInt(string value)
        {
            int result;
            if (int.TryParse(value,out result))
            {
                return result;
            }

            return null;
        }


        private decimal? GetNullableDecimal(string value)
        {
            decimal result;
            if (decimal.TryParse(value,out result))
            {
                return result;
            }

            return null;
        }


        private DateTime? GetNullableDate(string value)
        {
            DateTime result;
            if (DateTime.TryParse(value,out result))
            {
                return result;
            }

            return null;
        }


        private void ShowMessage(string message,bool success)
        {
            lblMessage.Text = Server.HtmlEncode(message);
            lblMessage.Visible = true;

            lblMessage.CssClass =
                success
                    ? "message success"
                    : "message error";
        }


        protected void btnPostJob_Click(object sender, EventArgs e)
        {
            try
            {
                int recruiterId = GetRecruiterId();


                if (recruiterId == 0)
                {
                    ShowMessage(
                        "Recruiter profile not found or not verified.",
                        false
                    );

                    return;
                }


                // ---------------------------------
                // REQUIRED VALIDATION
                // ---------------------------------

                string jobTitle = txtJobTitle.Text.Trim();
                string jobDescription = txtJobDescription.Text.Trim();


                if (string.IsNullOrWhiteSpace(jobTitle))
                {
                    ShowMessage(
                        "Please enter job title.",
                        false
                    );

                    return;
                }


                if (string.IsNullOrWhiteSpace(jobDescription))
                {
                    ShowMessage(
                        "Please enter job description.",
                        false
                    );

                    return;
                }
                              

                if (string.IsNullOrWhiteSpace(ddlEmploymentType.SelectedValue))
                {
                    ShowMessage(
                        "Please select employment type.",
                        false
                    );

                    return;
                }


                if (string.IsNullOrWhiteSpace(ddlCompany.SelectedValue))
                {
                    ShowMessage(
                        "Please select company.",
                        false
                    );

                    return;
                }


                int companyId;
                // =========================================
                // COMPANY
                // =========================================

                if (ddlCompany.SelectedValue == "OTHER")
                {
                    string otherCompany = txtOtherCompany.Text.Trim();
                    if (string.IsNullOrWhiteSpace(otherCompany))
                    {
                        ShowMessage(
                            "Please enter company name.",
                            false
                        );

                        return;
                    }

                    companyId = GetOrCreateCompany(otherCompany);
                }
                else
                {
                    companyId = Convert.ToInt32(ddlCompany.SelectedValue);
                }


                // ---------------------------------
                // OPTIONAL VALUES
                // ---------------------------------

                int? categoryId = null;

                // =========================================
                // CATEGORY
                // =========================================

                if (ddlCategory.SelectedValue == "OTHER")
                {
                    string otherCategory = txtOtherCategory.Text.Trim();

                    if (string.IsNullOrWhiteSpace(otherCategory))
                    {
                        ShowMessage(
                            "Please enter category name.",
                            false
                        );

                        return;
                    }

                    categoryId = GetOrCreateCategory(otherCategory);
                }
                else
                {
                    categoryId = GetNullableInt(ddlCategory.SelectedValue);
                }

                int? minExperience = GetNullableInt(txtMinExperience.Text);
                int? maxExperience = GetNullableInt(txtMaxExperience.Text);
                decimal? minSalary = GetNullableDecimal(txtMinSalary.Text);
                decimal? maxSalary = GetNullableDecimal(txtMaxSalary.Text);
                int openings = GetInt(txtOpenings.Text);

                if (openings <= 0)
                {
                    ShowMessage(
                        "Number of openings must be greater than zero.",
                        false
                    );

                    return;
                }


                DateTime? deadline = GetNullableDate(txtDeadline.Text);
                // ---------------------------------
                // EXPERIENCE VALIDATION
                // ---------------------------------

                if (minExperience.HasValue && maxExperience.HasValue && minExperience.Value > maxExperience.Value)
                {
                    ShowMessage(
                        "Minimum experience cannot be greater than maximum experience.",
                        false
                    );

                    return;
                }


                // ---------------------------------
                // SALARY VALIDATION
                // ---------------------------------

                if (minSalary.HasValue && maxSalary.HasValue && minSalary.Value > maxSalary.Value)
                {
                    ShowMessage(
                        "Minimum salary cannot be greater than maximum salary.",
                        false
                    );

                    return;
                }


                // ---------------------------------
                // INSERT JOB
                // ---------------------------------

                const string query = @"INSERT INTO Jobs (CompanyId,RecruiterId,CategoryId,JobTitle,JobDescription,Responsibilities,Requirements,EmploymentType,WorkMode,MinExperienceMonths,MaxExperienceMonths,MinSalary,MaxSalary,SalaryVisible,City,State,NumberOfOpenings,EducationRequirement,ApplicationDeadline,JobStatus,IsFeatured,CreatedAt,UpdatedAt) VALUES (@CompanyId,@RecruiterId,@CategoryId,@JobTitle,@JobDescription,@Responsibilities,@Requirements,@EmploymentType,@WorkMode,@MinExperienceMonths,@MaxExperienceMonths,@MinSalary,@MaxSalary,@SalaryVisible,@City,@State,@NumberOfOpenings,@EducationRequirement,@ApplicationDeadline,@JobStatus,@IsFeatured,SYSDATETIME(),SYSDATETIME());";
                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query,con))
                {
                    cmd.Parameters.Add("@CompanyId",SqlDbType.Int).Value = companyId;
                    cmd.Parameters.Add("@RecruiterId",SqlDbType.Int).Value = recruiterId;
                    cmd.Parameters.Add("@CategoryId",SqlDbType.Int).Value = categoryId.HasValue? (object)categoryId.Value: DBNull.Value;
                    cmd.Parameters.Add("@JobTitle",SqlDbType.NVarChar,500).Value =jobTitle;
                    cmd.Parameters.Add("@JobDescription",SqlDbType.NVarChar).Value =jobDescription;
                    cmd.Parameters.Add("@Responsibilities",SqlDbType.NVarChar).Value =DbValue(txtResponsibilities.Text);
                    cmd.Parameters.Add("@Requirements",SqlDbType.NVarChar).Value =DbValue(txtRequirements.Text);
                    cmd.Parameters.Add("@EmploymentType",SqlDbType.NVarChar,100).Value =ddlEmploymentType.SelectedValue;
                    cmd.Parameters.Add("@WorkMode",SqlDbType.NVarChar,100).Value =DbValue(ddlWorkMode.SelectedValue);
                    cmd.Parameters.Add("@MinExperienceMonths",SqlDbType.Int).Value =minExperience.HasValue? (object)minExperience.Value: DBNull.Value;
                    cmd.Parameters.Add("@MaxExperienceMonths",SqlDbType.Int).Value =maxExperience.HasValue? (object)maxExperience.Value: DBNull.Value;
                    SqlParameter minSalaryParameter =cmd.Parameters.Add("@MinSalary",SqlDbType.Decimal);
                    minSalaryParameter.Precision =12;
                    minSalaryParameter.Scale =2;
                    minSalaryParameter.Value =minSalary.HasValue? (object)minSalary.Value: DBNull.Value;
                    SqlParameter maxSalaryParameter =cmd.Parameters.Add("@MaxSalary",SqlDbType.Decimal);
                    maxSalaryParameter.Precision =12;
                    maxSalaryParameter.Scale =2;
                    maxSalaryParameter.Value =maxSalary.HasValue? (object)maxSalary.Value: DBNull.Value;
                    cmd.Parameters.Add("@SalaryVisible",SqlDbType.Bit).Value =chkSalaryVisible.Checked;
                    cmd.Parameters.Add("@City",SqlDbType.NVarChar,200).Value =DbValue(txtCity.Text);
                    cmd.Parameters.Add("@State",SqlDbType.NVarChar,200).Value =DbValue(txtState.Text);
                    cmd.Parameters.Add("@NumberOfOpenings",SqlDbType.Int).Value =openings;
                    cmd.Parameters.Add("@EducationRequirement",SqlDbType.NVarChar,500).Value =DbValue(txtEducation.Text);
                    cmd.Parameters.Add("@ApplicationDeadline",SqlDbType.Date).Value =deadline.HasValue? (object)deadline.Value.Date: DBNull.Value;
                    cmd.Parameters.Add("@JobStatus",SqlDbType.NVarChar,50).Value =ddlJobStatus.SelectedValue;
                    cmd.Parameters.Add("@IsFeatured",SqlDbType.Bit).Value =chkFeatured.Checked;
                    con.Open();
                    int rows =cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        ShowMessage(
                            "Job posted successfully.",
                            true
                        );

                        ClearForm();
                    }
                    else
                    {
                        ShowMessage(
                            "Job could not be posted.",
                            false
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error: " +
                    ex.Message,
                    false
                );
            }

        }

        private int GetOrCreateCompany(string companyName)
        {
            const string query = @"
        IF EXISTS
        (
            SELECT 1
            FROM Companies
            WHERE CompanyName = @CompanyName
        )
        BEGIN
            SELECT CompanyId
            FROM Companies
            WHERE CompanyName = @CompanyName;
        END
        ELSE
        BEGIN
            INSERT INTO Companies
            (
                CompanyName,
                IsActive,
                CreatedAt
                
            )
            OUTPUT INSERTED.CompanyId
            VALUES
            (
                @CompanyName,
                1,
                SYSDATETIME()
            );
        END";


            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query,con))
            {
                cmd.Parameters.Add("@CompanyName",SqlDbType.NVarChar,200).Value = companyName;
                con.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private int GetOrCreateCategory(string categoryName)
        {
            const string query = @"
        IF EXISTS
        (
            SELECT 1
            FROM JobCategories
            WHERE CategoryName = @CategoryName
        )
        BEGIN
            SELECT CategoryId
            FROM JobCategories
            WHERE CategoryName = @CategoryName;
        END
        ELSE
        BEGIN
            INSERT INTO JobCategories
            (
                CategoryName,
                IsActive,
                CreatedAt
            )
            OUTPUT INSERTED.CategoryId
            VALUES
            (
                @CategoryName,
                1,
                SYSDATETIME()
            );
        END";


            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query,con))
            {
                cmd.Parameters.Add("@CategoryName",SqlDbType.NVarChar,200).Value = categoryName;
                con.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }
        protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtOtherCompany.Visible = ddlCompany.SelectedValue == "OTHER";

            if (ddlCompany.SelectedValue != "OTHER")
            {
                txtOtherCompany.Text = "";
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtOtherCategory.Visible =
            ddlCategory.SelectedValue == "OTHER";

            if (ddlCategory.SelectedValue != "OTHER")
            {
                txtOtherCategory.Text = "";
            }
        }
    }
}