using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Tech_Fix
{
    public partial class SupplierDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["SupplierID"] != null)
                {
                    LoadDashboardData(Convert.ToInt32(Session["SupplierID"]));
                }
                else
                {
                    // Redirect to login page or handle error if SupplierID is not found
                    Response.Redirect("Account.aspx");
                }
            }
        }

        private void LoadDashboardData(int supplierId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["TechFixConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Total Products Query
                string queryTotalProducts = "SELECT COUNT(*) FROM products WHERE supplier_id = @SupplierId";
                SqlCommand cmdTotalProducts = new SqlCommand(queryTotalProducts, connection);
                cmdTotalProducts.Parameters.AddWithValue("@SupplierId", supplierId);

                lblTotalProducts.Text = cmdTotalProducts.ExecuteScalar().ToString();

                // Total Orders Query
                string queryTotalOrders = "SELECT COUNT(*) FROM orders WHERE supplier_id = @SupplierId";
                SqlCommand cmdTotalOrders = new SqlCommand(queryTotalOrders, connection);
                cmdTotalOrders.Parameters.AddWithValue("@SupplierId", supplierId);

                lblTotalOrders.Text = cmdTotalOrders.ExecuteScalar().ToString();

                // Total Quotes Query
                string queryTotalQuotes = "SELECT COUNT(*) FROM quotes WHERE supplier_id = @SupplierId";
                SqlCommand cmdTotalQuotes = new SqlCommand(queryTotalQuotes, connection);
                cmdTotalQuotes.Parameters.AddWithValue("@SupplierId", supplierId);

                lblTotalQuotes.Text = cmdTotalQuotes.ExecuteScalar().ToString();
            }
        }
    }
}

