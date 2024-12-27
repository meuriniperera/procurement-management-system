using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Web.UI;
using Tech_Fix.Models;

namespace Tech_Fix
{
    public partial class TechFixOrders : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize data or session variables if needed
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Account.aspx");
                }
                else
                {
                    // Additional page initialization if necessary
                }
            }
        }

        // Method to handle form submission for adding a new order
        protected async void AddOrder_ServerClick(object sender, EventArgs e)
        {
            var techfixId = Session["UserId"].ToString();
            var supplierId = Request.Form["addSupplierId"];
            var productId = Request.Form["addProductId"];
            var orderQuantity = Request.Form["addOrderQuantity"];

            try
            {
                // Convert orderQuantity to integer
                int quantity = int.Parse(orderQuantity);

                // Fetch the unit price from an external API using productId
                var unitPrice = await GetUnitPriceFromApi(productId);

                if (unitPrice > 0)
                {
                    // Calculate the total price
                    var totalPrice = unitPrice * quantity;

                    // Prepare the new order object
                    var newOrder = new
                    {
                        TechFixId = techfixId,
                        SupplierId = supplierId,
                        ProductId = productId,
                        OrderQuantity = orderQuantity,
                        TotalPrice = totalPrice.ToString("F2")  // Format as 2 decimal places
                    };

                    // Serialize the order object to JSON
                    var jsonContent = JsonConvert.SerializeObject(newOrder);
                    var content = new StringContent(jsonContent, Encoding.UTF8, "application/json");

                    // Send the order data to the API
                    using (var client = new HttpClient())
                    {
                        string apiUrl = "https://localhost:44343/api/techfixorders"; // Your API endpoint

                        HttpResponseMessage response = await client.PostAsync(apiUrl, content);
                        var responseContent = await response.Content.ReadAsStringAsync();

                        if (response.IsSuccessStatusCode)
                        {
                            Response.Write("<script>alert('New order added successfully!');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Error adding order: " + responseContent + "');</script>");
                        }
                    }
                }
                else
                {
                    // Handle the case where no unit price was returned
                    Response.Write("<script>alert('Error fetching unit price for the selected product.');</script>");
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        // Method to fetch the unit price of a product from an API
        private async Task<decimal> GetUnitPriceFromApi(string productId)
        {
            decimal unitPrice = 0;

            try
            {
                using (var client = new HttpClient())
                {
                    string apiUrl = "https://localhost:44343/api/products/" + productId; // API to fetch product by ID

                    HttpResponseMessage response = await client.GetAsync(apiUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        var responseContent = await response.Content.ReadAsStringAsync();
                        var product = JsonConvert.DeserializeObject<Product>(responseContent);  // Assuming the API returns a product object
                        unitPrice = product.Price;  // Extract unit price
                    }
                }
            }
            catch (HttpRequestException ex)
            {
                // Handle HTTP request error
                Response.Write("<script>alert('Request error: " + ex.Message + "');</script>");
            }
            catch (Exception ex)
            {
                // Handle general exceptions
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            return unitPrice;
        }
    }
}
