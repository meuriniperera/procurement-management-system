using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tech_Fix
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Handle form submission
            string name = txtName.Text;
            string email = txtEmail.Text;
            string subject = txtSubject.Text;
            string message = txtMessage.Text;

            // You can add code here to send the email or save the contact request

            // Example: Show a success message
            Response.Write("<script>alert('Thank you for your message. We will get back to you soon.');</script>");

            // Clear the form
            txtName.Text = "";
            txtEmail.Text = "";
            txtSubject.Text = "";
            txtMessage.Text = "";
        }
    }
}