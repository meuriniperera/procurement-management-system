using System;
using System.Web.UI;

namespace Tech_Fix
{
    public partial class SupplierOrders : Page
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
    }
}