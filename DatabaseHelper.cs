using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Success24_Job_Portal
{
   public static class DatabaseHelper
        {
           private static readonly string ConnectionString =
                ConfigurationManager
                    .ConnectionStrings["Success24Connection"]
                    .ConnectionString;


            // =========================================
            // GET DATATABLE
            // =========================================

            public static DataTable GetDataTable(
                string query,
                params SqlParameter[] parameters)
            {
                DataTable dt = new DataTable();

                using (SqlConnection con = new SqlConnection(ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.CommandType = CommandType.Text;

                    if (parameters != null && parameters.Length > 0)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }

                return dt;
            }


            // =========================================
            // EXECUTE NON QUERY
            // INSERT / UPDATE / DELETE
            // =========================================

            public static int ExecuteNonQuery(
                string query,
                params SqlParameter[] parameters)
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.CommandType = CommandType.Text;

                    if (parameters != null && parameters.Length > 0)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    con.Open();

                    return cmd.ExecuteNonQuery();
                }
            }


            // =========================================
            // EXECUTE SCALAR
            // =========================================

            public static object ExecuteScalar(
                string query,
                params SqlParameter[] parameters)
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.CommandType = CommandType.Text;

                    if (parameters != null && parameters.Length > 0)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    con.Open();

                    return cmd.ExecuteScalar();
                }
            }


            // =========================================
            // CHECK DATABASE CONNECTION
            // =========================================

            public static bool TestConnection()
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(ConnectionString))
                    {
                        con.Open();

                        return con.State == ConnectionState.Open;
                    }
                }
                catch
                {
                    return false;
                }
            }
   }
}