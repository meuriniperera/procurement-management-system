using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Tech_Fix
{
    public partial class TechFixDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["TechFixID"] != null)
                {
                    LoadDashboardData();
                }
                else
                {
                    // Redirect to login page or handle error if TechFixID is not found
                    Response.Redirect("Account.aspx");
                }
            }
        }

        private void LoadDashboardData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["TechFixConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Total Suppliers Query
                string queryTotalSuppliers = "SELECT COUNT(*) FROM users WHERE role = 'supplier'";
                SqlCommand cmdTotalSuppliers = new SqlCommand(queryTotalSuppliers, connection);
                lblTotalSuppliers.Text = cmdTotalSuppliers.ExecuteScalar().ToString();

                // Total Quotes Query
                string queryTotalQuotes = "SELECT COUNT(*) FROM quotes";
                SqlCommand cmdTotalQuotes = new SqlCommand(queryTotalQuotes, connection);
                lblTotalQuotes.Text = cmdTotalQuotes.ExecuteScalar().ToString();

                // Total Orders Query
                string queryTotalOrders = "SELECT COUNT(*) FROM orders";
                SqlCommand cmdTotalOrders = new SqlCommand(queryTotalOrders, connection);
                lblTotalOrders.Text = cmdTotalOrders.ExecuteScalar().ToString();

            }
        }

    }
}
