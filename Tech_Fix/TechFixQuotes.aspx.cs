using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Web.UI;


namespace Tech_Fix
{
    public partial class TechFixQuotes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize data or session variables if needed
                // For example, you might want to check if the user is logged in
                // and if they have the correct permissions to view this page.
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Account.aspx");
                }
                else
                {
                    // Perform any additional initialization or data loading here if needed
                }
            }
        }

        // Method to handle the form submission for adding a new quote
        protected async void AddQuote_ServerClick(object sender, EventArgs e)
        {
            var techfixId = Session["UserId"].ToString();
            var supplierId = Request.Form["addsupplierId"];
            var productId = Request.Form["addProductId"];
            var requestedQuantity = Request.Form["addRequestedQuantity"];
            var quotedPrice = Request.Form["addQuotedPrice"];

            // Prepare the quote object to send to the API
            var newQuote = new
            {
                TechFixId = techfixId,
                SupplierId = supplierId,
                ProductId = productId,
                RequestedQuantity = requestedQuantity,
                QuotedPrice = quotedPrice
            };

            // Serialize the quote object to JSON
            var jsonContent = JsonConvert.SerializeObject(newQuote);
            var content = new StringContent(jsonContent, Encoding.UTF8, "application/json");

            using (var client = new HttpClient())
            {
                try
                {
                    string apiUrl = "https://localhost:44343/api/techfixquotes"; // API endpoint for adding a new quote

                    // Send the POST request to add the new quote
                    HttpResponseMessage response = await client.PostAsync(apiUrl, content);
                    var responseContent = await response.Content.ReadAsStringAsync();

                    if (response.IsSuccessStatusCode)
                    {
                        // Successfully added quote
                        Response.Write("<script>alert('New quote added successfully!');</script>");
                    }
                    else
                    {
                        // Handle error
                        Response.Write("<script>alert('Error adding quote: " + responseContent + "');</script>");
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
            }
        }
    }
}