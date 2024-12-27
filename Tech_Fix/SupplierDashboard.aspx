<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupplierDashboard.aspx.cs" Inherits="Tech_Fix.SupplierDashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Dashboard - TechFix</title>

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Link to External Stylesheet -->
    <link href="Content/Supplier.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <div class="navbar">
            <div class="logo">TechFix Supplier Dashboard</div>
            <div>
                <a href="SupplierDashboard.aspx">Home</a>
                <a href="SupplierProducts.aspx">Products</a>
                <a href="SupplierQuotes.aspx">Quotes</a>
                <a href="SupplierOrders.aspx">Orders</a>
                 <a href="Default.aspx">LogOut</a>
            </div>
        </div>

        <!-- Container -->
        <div class="container">
            <h1>Supplier Dashboard</h1>

            <!-- Dashboard Statistics Section -->
            <div class="dashboard-section">
                <!-- Total Products Card -->
                <div class="dashboard-card">
                    <i class="fas fa-boxes"></i>
                    <h2>Total Products</h2>
                    <p><asp:Label ID="lblTotalProducts" runat="server" Text="0"></asp:Label></p>
                    <small>All products listed by you</small>
                </div>

                <!-- Total Orders Card -->
                <div class="dashboard-card">
                    <i class="fas fa-shopping-cart"></i>
                    <h2>Total Orders</h2>
                    <p><asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label></p>
                    <small>All orders received</small>
                </div>

                <!-- Total Quotes Card -->
                <div class="dashboard-card">
                    <i class="fas fa-file-invoice-dollar"></i>
                    <h2>Total Quotes</h2>
                    <p><asp:Label ID="lblTotalQuotes" runat="server" Text="0"></asp:Label></p>
                    <small>Quotes submitted by you</small>
                </div>
            </div>
        </div>
    </form>
    <footer>
    <div class="footer-bottom">
            <p>&copy; 2024 - TechFix. All rights reserved.</p>
        </div>
</footer>
</body>
</html>

