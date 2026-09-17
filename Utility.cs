using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
namespace Success24_Job_Portal
{
    public class Utility
    {
        // =========================================================
        // CONNECTION STRING
        // =========================================================

        private static string Success24ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["Success24Connection"].ConnectionString;
            }
        }


        // =========================================================
        // DROPDOWN
        // =========================================================

        public static void _BindDropdown(DropDownList ddl,string Query,string ValueField,string TestField)
        {
            DataTable dt = _GetDataTable24(Query);
            ddl.DataSource = dt;
            ddl.DataTextField = TestField;
            ddl.DataValueField = ValueField;
            ddl.DataBind();

            ddl.Items.Insert(
                0,
                new ListItem("None", "0")
            );
        }

       
        public static void _BindDropdown(DropDownList ddl,string Query,string ValueField,string TestField,string selectedValue)
        {
            DataTable dt = _GetDataTable24(Query);
            ddl.DataSource = dt;
            ddl.DataTextField = TestField;
            ddl.DataValueField = ValueField;
            ddl.DataBind();

            ddl.Items.Insert(
                0,
                new ListItem("None", "0")
            );

            if (!string.IsNullOrEmpty(selectedValue))
            {
                ListItem item =
                    ddl.Items.FindByValue(selectedValue);

                if (item != null)
                {
                    ddl.SelectedValue = selectedValue;
                }
            }
        }


        // =========================================================
        // CHECKBOX LIST
        // =========================================================

        public static void _BindChechboxList(CheckBoxList chklist,string Query,string ValueField,string TestField)
        {
            DataTable dt = _GetDataTable24(Query);
            chklist.DataSource = dt;
            chklist.DataTextField = TestField;
            chklist.DataValueField = ValueField;
            chklist.DataBind();
        }


        // =========================================================
        // GRIDVIEW
        // =========================================================

        public static void _BindGridView(GridView gv,string Query)
        {
            DataTable dt = _GetDataTable24(Query);
            gv.DataSource = dt;
            gv.DataBind();
        }


        // =========================================================
        // GET DATATABLE - S24
        // =========================================================

        public static DataTable _GetDataTable24(string Query)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(Success24ConnectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(Query, con))
                {
                    adapter.Fill(dt);
                }
            }

            return dt;
        }


        // =========================================================
        // GET DATATABLE - PARAMETERIZED
        // =========================================================

        public static DataTable _GetDataTable24(string Query,params SqlParameter[] Parameters)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(Success24ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(Query, con))
                {
                    if (Parameters != null)
                    {
                        cmd.Parameters.AddRange(Parameters);
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);
                    }
                }
            }

            return dt;
        }


        // =========================================================
        // EXECUTE QUERY
        // =========================================================

        public static void ExecuteQuery24(string Query)
        {
            using (SqlConnection con = new SqlConnection(Success24ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(Query, con))
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }


        // =========================================================
        // EXECUTE QUERY - PARAMETERIZED
        // =========================================================

        public static int ExecuteQuery24(string Query,params SqlParameter[] Parameters)
        {
            using (SqlConnection con = new SqlConnection(Success24ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(Query, con))
                {
                    if (Parameters != null)
                    {
                        cmd.Parameters.AddRange(Parameters);
                    }

                    con.Open();

                    return cmd.ExecuteNonQuery();
                }
            }
        }


        // =========================================================
        // EXECUTE SCALAR
        // =========================================================

        public static object ExecuteScalar24(string Query,params SqlParameter[] Parameters)
        {
            using (SqlConnection con = new SqlConnection(Success24ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(Query, con))
                {
                    if (Parameters != null)
                    {
                        cmd.Parameters.AddRange(Parameters);
                    }

                    con.Open();

                    return cmd.ExecuteScalar();
                }
            }
        }


        // =========================================================
        // EXECUTE STORED PROCEDURE
        // =========================================================

        public static int ExecuteProcedure24(string ProcedureName,params SqlParameter[] Parameters)
        {
            using (SqlConnection con = new SqlConnection(Success24ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(ProcedureName, con))
                {
                    cmd.CommandType =     CommandType.StoredProcedure;

                    if (Parameters != null)
                    {
                        cmd.Parameters.AddRange(Parameters);
                    }

                    con.Open();

                    return cmd.ExecuteNonQuery();
                }
            }
        }


        // =========================================================
        // EXISTS / COUNT
        // =========================================================

        public static bool Exists24(string Query,params SqlParameter[] Parameters)
        {
            object result = ExecuteScalar24(Query, Parameters);

            if (result == null || result == DBNull.Value)
            {
                return false;
            }

            return Convert.ToInt32(result) > 0;
        }

        public static DataRow _GetDataRow24(string Query,params SqlParameter[] Parameters)
        {
            DataTable dt = _GetDataTable24(Query,Parameters);
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0];
            }

            return null;
        }

       
        public static int ExecuteTransaction24(string FirstQuery,SqlParameter[] FirstParameters,string SecondQuery,SqlParameter[] SecondParameters)
        {
            using (SqlConnection con = new SqlConnection(Success24ConnectionString))
            {
                con.Open();
                using (SqlTransaction transaction = con.BeginTransaction())
                {
                    try
                    {
                        int firstId;
                        using (SqlCommand cmd = new SqlCommand(FirstQuery,con,transaction))
                        {
                            if (FirstParameters != null)
                            {
                                cmd.Parameters.AddRange(FirstParameters);
                            }

                            firstId = Convert.ToInt32(cmd.ExecuteScalar());
                        }

                        using (SqlCommand cmd = new SqlCommand(SecondQuery,con,transaction))
                        {
                            if (SecondParameters != null)
                            {
                                cmd.Parameters.AddRange(SecondParameters);
                            }

                            cmd.Parameters["@UserId"].Value = firstId;
                            cmd.ExecuteNonQuery();
                        }

                        transaction.Commit();

                        return firstId;
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }

    }
}