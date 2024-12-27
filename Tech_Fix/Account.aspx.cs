using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Tech_Fix
{
    public partial class Account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optionally, you can add checks here for existing sessions to redirect already logged-in users
        }

        // Handle the login logic
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtLoginUsername.Text;
                string password = txtLoginPassword.Text;

                try
                {
                    string connString = WebConfigurationManager.ConnectionStrings["TechFixConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        string query = "SELECT user_id, role FROM users WHERE username = @username AND password = @password";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@password", password); // Consider hashing

                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.HasRows)
                        {
                            reader.Read();
                            int userId = Convert.ToInt32(reader["user_id"]);
                            string role = reader["role"].ToString();
                            Session["UserID"] = userId;
                            Session["UserRole"] = role; // Store the role in session

                            // Redirect based on role
                            if (role == "techfix")
                            {
                                Session["TechFixID"] = userId;
                                Response.Redirect("TechFixDashboard.aspx");
                            }
                            else if (role == "supplier")
                            {
                                Session["SupplierID"] = userId;
                                Response.Redirect("SupplierDashboard.aspx");
                            }
                        }
                        else
                        {
                            lblLoginError.Text = "Invalid username or password.";
                            lblLoginError.Visible = true;
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblLoginError.Text = "Error: " + ex.Message;
                    lblLoginError.Visible = true;
                }
            }
        }

        // Handle the signup logic
        protected void btnSignup_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtSignupUsername.Text;
                string password = txtSignupPassword.Text;
                string email = txtSignupEmail.Text;
                string role = ddlSignupRole.SelectedValue;

                if (string.IsNullOrEmpty(role) || role == "")
                {
                    lblSignupError.Text = "Please select a valid role.";
                    lblSignupError.Visible = true;
                    return;
                }

                try
                {
                    string connString = WebConfigurationManager.ConnectionStrings["TechFixConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        string query = "INSERT INTO users (username, password, role, email) VALUES (@username, @password, @role, @email)";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@password", password); // Consider hashing
                        cmd.Parameters.AddWithValue("@role", role);
                        cmd.Parameters.AddWithValue("@email", email);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        Response.Write("<script>alert('Registration successful. You can now log in.');</script>");

                        // Clear form fields
                        txtSignupUsername.Text = "";
                        txtSignupPassword.Text = "";
                        txtSignupEmail.Text = "";
                        ddlSignupRole.SelectedIndex = 0;
                    }
                }
                catch (Exception ex)
                {
                    lblSignupError.Text = "Error: " + ex.Message;
                    lblSignupError.Visible = true;
                }
            }
        }
    }
}

