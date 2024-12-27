using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tech_Fix
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected void btnGetQuote_Click(object sender, EventArgs e)
        {
            // Redirect to Account.aspx when the "Get a Quote" button is clicked
            Response.Redirect("Account.aspx");
        }
    }
}