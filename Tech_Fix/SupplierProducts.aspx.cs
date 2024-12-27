using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Web.UI;
using System.Diagnostics;  // Add this for logging

namespace Tech_Fix
{
    public partial class SupplierProducts : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Account.aspx");
                }
            }
        }

        // Server-side method to handle form submission and API call
        protected async void AddProduct_ServerClick(object sender, EventArgs e)
        {
            // Retrieve data from the form
            var supplierId = Session["UserId"].ToString();
            var productName = Request.Form["productName"];
            var productDescription = Request.Form["productDescription"];
            var productCategory = Request.Form["productCategory"];
            var productPrice = Request.Form["productPrice"];
            var productStock = Request.Form["productStock"];

            // Prepare the product object
            var newProduct = new
            {
                SupplierId = supplierId,
                Name = productName,
                Description = productDescription,
                Category = productCategory,
                Price = productPrice,
                StockQuantity = productStock
            };

            // Serialize the object to JSON
            var jsonContent = JsonConvert.SerializeObject(newProduct);
            var content = new StringContent(jsonContent, Encoding.UTF8, "application/json");

            using (var client = new HttpClient())
            {
                try
                {
                    // API URL for adding a new product
                    string apiUrl = "https://localhost:44343/api/products";

                    // Log details before sending the request
                    Debug.WriteLine("Sending request to API...");
                    Debug.WriteLine("Request URL: " + apiUrl);
                    Debug.WriteLine("Request Content: " + jsonContent);

                    // Make the POST request
                    HttpResponseMessage response = await client.PostAsync(apiUrl, content);

                    // Log the response details
                    Debug.WriteLine("Response Status Code: " + response.StatusCode);
                    var responseContent = await response.Content.ReadAsStringAsync();
                    Debug.WriteLine("Response Content: " + responseContent);

                    if (response.IsSuccessStatusCode)
                    {
                        // Product added successfully
                        Response.Write("<script>alert('Product added successfully!');</script>");
                    }
                    else
                    {
                        // Error handling
                        Response.Write("<script>alert('Error adding product: " + responseContent + "');</script>");
                    }
                }
                catch (HttpRequestException ex)
                {
                    // Handle request-specific exceptions
                    Debug.WriteLine("Request error: " + ex.Message);
                    Response.Write("<script>alert('Request error: " + ex.Message + "');</script>");
                }
                catch (Exception ex)
                {
                    // Handle general exceptions
                    Debug.WriteLine("General error: " + ex.Message);
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }
    }
}
