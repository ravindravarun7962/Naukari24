using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class Companies : System.Web.UI.Page
    {
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
                Response.Redirect("~/Recruiter/Login.aspx");
                return;
            }


            int userId;
            if (!int.TryParse(Convert.ToString(Session["UserId"]),out userId))
            {
                Session.Clear();
                Response.Redirect("~/Recruiter/Login.aspx");
                return;
            }

            const string query = @"SELECT COUNT(*) FROM RecruiterProfiles WHERE UserId = @UserId AND IsVerified = 1;";
            int count = Convert.ToInt32(Utility.ExecuteScalar24(query,new SqlParameter("@UserId",SqlDbType.Int)
            {
                Value = userId
            })
            );


            if (count == 0)
            {
                Session.Clear();
                Response.Redirect("~/Recruiter/Login.aspx");
            }
        }


        // =========================================
        // LOAD COMPANIES
        // =========================================

        private void LoadCompanies()
        {
            const string query = @"SELECT CompanyId,CompanyName,CompanyLogo,Website,Industry,CompanySize,FoundedYear,Description,Address,City,State,Pincode,IsVerified,IsActive,CreatedAt FROM Companies ORDER BY CompanyName ASC;";
            DataTable dt = Utility._GetDataTable24(query);
            gvCompanies.DataSource = dt;
            gvCompanies.DataBind();
        }

       
        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblMessage.Visible = false;

        }

        private void ClearForm()
        {
            txtCompanyName.Text = "";
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

        private void ShowMessage(string message,bool success)
        {
            lblMessage.Text = Server.HtmlEncode(message);
            lblMessage.Visible = true;
            lblMessage.CssClass =
                success
                    ? "message success"
                    : "message error";
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            string companyName = txtCompanyName.Text.Trim();
            string website = txtWebsite.Text.Trim();
            string industry = txtIndustry.Text.Trim();
            string companySize = ddlCompanySize.SelectedValue;
            string foundedYearText = txtFoundedYear.Text.Trim();
            string description = txtDescription.Text.Trim();
            string address = txtAddress.Text.Trim();
            string city = txtCity.Text.Trim();
            string state = txtState.Text.Trim();
            string pincode = txtPincode.Text.Trim();
            bool isActive = chkIsActive.Checked;

            // =========================================
            // VALIDATION
            // =========================================

            if (string.IsNullOrWhiteSpace(companyName))
            {
                ShowMessage("Please enter company name.",false);
                return;
            }


            int foundedYear = 0;
            if (!string.IsNullOrWhiteSpace(foundedYearText))
            {
                if (!int.TryParse(foundedYearText,out foundedYear))
                {
                    ShowMessage("Please enter a valid founded year.",false);
                    return;
                }
            }

            // =========================================
            // LOGO UPLOAD
            // =========================================

            string logoPath = null;
            if (fuCompanyLogo.HasFile)
            {
                string extension = Path.GetExtension(fuCompanyLogo.FileName).ToLowerInvariant();
                string[] allowedExtensions =
                {
                    ".jpg",
                    ".jpeg",
                    ".png",
                    ".webp"
                };

                bool validExtension = false;
                foreach (string allowedExtension in allowedExtensions)
                {
                    if (extension == allowedExtension)
                    {
                        validExtension = true;
                        break;
                    }
                }

                if (!validExtension)
                {
                    ShowMessage("Only JPG, JPEG, PNG and WEBP files are allowed.",false);
                    return;
                }


                // =====================================
                // MAX SIZE = 2 MB
                // =====================================

                if (fuCompanyLogo.PostedFile.ContentLength>2 * 1024 * 1024)
                {
                    ShowMessage("Company logo must be less than 2 MB.",false);
                    return;
                }

                // =====================================
                // CREATE FOLDER
                // =====================================

                string folderPath =Server.MapPath("~/Uploads/CompanyLogos/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                // =====================================
                // UNIQUE FILE NAME
                // =====================================

                string fileName = Guid.NewGuid().ToString("N") + extension;
                string physicalPath = Path.Combine(folderPath,fileName);
                // =====================================
                // SAVE FILE
                // =====================================

                fuCompanyLogo.SaveAs(physicalPath);
                // Path saved in database

                logoPath = "~/Uploads/CompanyLogos/" + fileName;
            }

            try
            {
                // =====================================
                // DUPLICATE COMPANY CHECK
                // =====================================

                const string duplicateQuery = @"SELECT COUNT(*) FROM Companies WHERE CompanyName = @CompanyName;";
                int count = Convert.ToInt32(Utility.ExecuteScalar24(duplicateQuery,new SqlParameter("@CompanyName",SqlDbType.NVarChar,300)
                {
                    Value = companyName
                })
                );

                if (count > 0)
                {
                    ShowMessage("This company already exists.",false);
                    return;
                }

                // =====================================
                // INSERT
                // =====================================

                const string insertQuery = @"INSERT INTO Companies (CompanyName,CompanyLogo,Website,Industry,CompanySize,FoundedYear,Description,Address,City,State,Pincode,IsVerified,IsActive,CreatedAt) VALUES (@CompanyName,@CompanyLogo,@Website,@Industry,@CompanySize,@FoundedYear,@Description,@Address,@City,@State,@Pincode,1,@IsActive,SYSDATETIME());";
                Utility.ExecuteQuery24(insertQuery,new SqlParameter("@CompanyName",SqlDbType.NVarChar,300)
                    {
                        Value = companyName
                    },

                    new SqlParameter("@CompanyLogo",SqlDbType.NVarChar,500)
                    {
                        Value =
                            string.IsNullOrWhiteSpace(logoPath)
                                ? (object)DBNull.Value
                                : logoPath
                    },

                    new SqlParameter("@Website",SqlDbType.NVarChar,500)
                    {
                        Value = string.IsNullOrWhiteSpace(website)? (object)DBNull.Value: website
                    },

                    new SqlParameter("@Industry",SqlDbType.NVarChar,200)
                    {
                        Value = string.IsNullOrWhiteSpace(industry)? (object)DBNull.Value: industry
                    },

                    new SqlParameter("@CompanySize",SqlDbType.NVarChar,100)
                    {
                        Value = string.IsNullOrWhiteSpace(companySize)? (object)DBNull.Value: companySize
                    },

                    new SqlParameter("@FoundedYear",SqlDbType.Int)
                    {
                        Value = foundedYear == 0 ? (object)DBNull.Value: foundedYear
                    },

                    new SqlParameter("@Description",SqlDbType.NVarChar)
                    {
                        Value = string.IsNullOrWhiteSpace(description)? (object)DBNull.Value: description
                    },

                    new SqlParameter("@Address",SqlDbType.NVarChar,500)
                    {
                        Value = string.IsNullOrWhiteSpace(address)? (object)DBNull.Value: address
                    },

                    new SqlParameter("@City",SqlDbType.NVarChar,200)
                    {
                        Value = string.IsNullOrWhiteSpace(city)? (object)DBNull.Value: city
                    },

                    new SqlParameter("@State",SqlDbType.NVarChar,200)
                    {
                        Value = string.IsNullOrWhiteSpace(state)? (object)DBNull.Value: state
                    },

                    new SqlParameter("@Pincode",SqlDbType.NVarChar,20)
                    {
                        Value = string.IsNullOrWhiteSpace(pincode)? (object)DBNull.Value: pincode
                    },

                    new SqlParameter("@IsActive",SqlDbType.Bit)
                    {
                        Value = isActive
                    }
                );


                ShowMessage("Company added successfully.",true);
                ClearForm();
                LoadCompanies();
            }
            catch (Exception ex)
            {
                ShowMessage("Unable to save company: " + ex.Message,false);
            }

        }

        // =========================================
        // LOCATION
        // =========================================

        protected string GetLocation(object cityObject,object stateObject)
        {
            string city = Convert.ToString(cityObject);
            string state = Convert.ToString(stateObject);

            if (string.IsNullOrWhiteSpace(city) && string.IsNullOrWhiteSpace(state))
            {
                return "-";
            }


            if (string.IsNullOrWhiteSpace(city))
            {
                return Server.HtmlEncode(state);
            }


            if (string.IsNullOrWhiteSpace(state))
            {
                return Server.HtmlEncode(city);
            }

            return Server.HtmlEncode(city + ", " + state);

        }




        protected void gvCompanies_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "ToggleStatus")
            {
                return;
            }

            int companyId;

            if (!int.TryParse(Convert.ToString(e.CommandArgument),out companyId))
            {
                return;
            }


            try
            {
                const string query = @"UPDATE Companies SET IsActive =CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE CompanyId = @CompanyId;";
                Utility.ExecuteQuery24(query,new SqlParameter("@CompanyId",SqlDbType.Int)
                    {
                        Value = companyId
                    }
                );

                ShowMessage("Company status updated successfully.",true);
                LoadCompanies();
            }
            catch (Exception ex)
            {
                ShowMessage("Unable to update company status: " + ex.Message,false);
            }

        }
    }
}