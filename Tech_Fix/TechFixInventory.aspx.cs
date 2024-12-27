using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace Tech_Fix
{
    public partial class TechFixInventory : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the user is logged in
                if (Session["UserId"] == null)
                {
                    // Redirect to login page if the user is not logged in
                    Response.Redirect("Account.aspx");
                }
                else
                {
                    // Load the product data into the GridView
                    BindGrid();
                }
            }
        }

        // Method to bind product data to the GridView
        private void BindGrid()
        {
            // Get the connection string from the web.config file
            string connectionString = ConfigurationManager.ConnectionStrings["TechFixConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // SQL query to select product details
                using (SqlCommand cmd = new SqlCommand("SELECT product_id AS ProductID, name AS Name, description AS Description, price AS Price, stock_quantity AS StockQuantity, supplier_id AS SupplierID FROM products", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        // Bind the DataTable to the GridView
                        GridView2.DataSource = dt;
                        GridView2.DataBind();
                    }
                }
            }
        }
    }
}
