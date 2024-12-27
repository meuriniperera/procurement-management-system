<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TechFixInventory.aspx.cs" Inherits="Tech_Fix.TechFixInventory" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechFix Inventory - Centralized Quoting Platform</title>

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Link to External Stylesheet -->
    <link href="Content/Inventory.css" rel="stylesheet" />
    <link href="Content/TechFix.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
     <!-- Navbar -->
     <div class="navbar">
         <div class="logo">TechFix Central Dashboard</div>
         <div>
             <a href="TechFixDashboard.aspx">Home</a>
             <a href="TechFixQuotes.aspx">Quotes</a>
             <a href="TechFixOrders.aspx">Orders</a>
             <a href="TechFixInventory.aspx">Inventory</a>
             <a href="Default.aspx">LogOut</a>
         </div>
     </div>
      <div>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="inventory-table">
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="Product ID" />
            <asp:BoundField DataField="Name" HeaderText="Product Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₨ {0:N2}" />
            <asp:BoundField DataField="StockQuantity" HeaderText="Available Quantity" />
            <asp:BoundField DataField="SupplierID" HeaderText="Supplier ID" />
        </Columns>
    </asp:GridView>
</div>
    </form>
     <footer>
     <div class="footer-bottom">
         <p>&copy; 2024 - TechFix. All rights reserved.</p>
     </div>
 </footer>
</body>
</html>
