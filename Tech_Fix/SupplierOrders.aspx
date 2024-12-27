<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupplierOrders.aspx.cs" Inherits="Tech_Fix.SupplierOrders" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Orders - TechFix</title>

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Link to External Stylesheet -->
    <link href="Content/Supplier.css" rel="stylesheet" />
    <link href="Content/Order.css" rel="stylesheet" />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- JavaScript for CRUD operations -->
    <script>
        $(document).ready(function () {
            // Load orders when the page loads
            loadOrders();

            // Function to load orders based on the logged-in supplier's ID
            function loadOrders() {
                var supplierId = '<%= Session["UserId"] %>'; // Assuming supplierId is stored in the session

                $.ajax({
                    url: '/api/orders?supplierId=' + supplierId,
                    type: 'GET',
                    success: function (data) {
                        var orderTable = $('#orderTableBody');
                        orderTable.empty(); // Clear existing rows

                        $.each(data, function (index, order) {
                            var row = '<tr>' +
                                '<td>' + order.orderId + '</td>' +
                                '<td>' + order.productId + '</td>' +
                                '<td>' + order.orderQuantity + '</td>' +
                                '<td>' + order.totalPrice + '</td>' +
                                '<td><select class="statusSelect" data-id="' + order.orderId + '">' +
                                '<option value="pending"' + (order.orderStatus === 'pending' ? ' selected' : '') + '>Pending</option>' +
                                '<option value="processed"' + (order.orderStatus === 'processed' ? ' selected' : '') + '>Processed</option>' +
                                '<option value="shipped"' + (order.orderStatus === 'shipped' ? ' selected' : '') + '>Shipped</option>' +
                                '<option value="delivered"' + (order.orderStatus === 'delivered' ? ' selected' : '') + '>Delivered</option>' +
                                '<option value="cancelled"' + (order.orderStatus === 'cancelled' ? ' selected' : '') + '>Cancelled</option>' +
                                '</select></td>' +
                                '<td><button class="updateStatusBtn" data-id="' + order.orderId + '">Update Status</button></td>' +
                                '</tr>';
                            orderTable.append(row);
                        });
                    },
                    error: function (error) {
                        console.error("Error loading orders: ", error);
                    }
                });
            }

            // Update order status
            $(document).on('click', '.updateStatusBtn', function () {
                var orderId = $(this).data('id');
                var newStatus = $('.statusSelect[data-id="' + orderId + '"]').val();

                $.ajax({
                    url: '/api/orders/' + orderId,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify({ orderId: orderId, orderStatus: newStatus }),
                    success: function (data) {
                        alert('Order status updated successfully!');
                        loadOrders(); // Reload orders
                    },
                    error: function (error) {
                        console.error("Error updating order status: ", error);
                    }
                });
            });
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <div class="navbar">
            <div class="logo">TechFix Supplier Dashboard</div>
            <div class="nav-links">
                <a href="SupplierDashboard.aspx">Home</a>
                <a href="SupplierProducts.aspx">Products</a>
                <a href="SupplierQuotes.aspx">Quotes</a>
                <a href="SupplierOrders.aspx">Orders</a>
                <a href="Default.aspx">LogOut</a>
            </div>
        </div>

        <!-- Orders Table -->
        <div class="order-container">
            <h2>Your Orders</h2>
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product ID</th>
                        <th>Order Quantity</th>
                        <th>Total Price</th>
                        <th>Status</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody id="orderTableBody">
                    <!-- Order rows will be dynamically populated here -->
                </tbody>
            </table>
        </div>

    </form>
    <footer>
        <div class="footer-bottom">
            <p>&copy; 2024 - TechFix. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
