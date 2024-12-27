<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TechFixOrders.aspx.cs" Inherits="Tech_Fix.TechFixOrders" Async="true" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechFix Orders - Centralized Order Management</title>

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Link to External Stylesheet -->
    <link href="Content/TechFix.css" rel="stylesheet" />
    <link href="Content/TechFixOrder.css" rel="stylesheet" />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- JavaScript for CRUD operations -->
    <script>
        $(document).ready(function () {
            // Load orders when the page loads
            loadOrders();

            // Function to load orders
            function loadOrders() {
                var techfixId = '<%= Session["UserId"] %>';

                $.ajax({
                    url: '/api/techfixorders?techfixId=' + techfixId, // Updated API URL
                    type: 'GET',
                    success: function (data) {
                        var orderTable = $('#orderTableBody');
                        orderTable.empty(); // Clear existing rows

                        $.each(data, function (index, order) {
                            var row = '<tr>' +
                                '<td>' + order.orderId + '</td>' +
                                '<td>' + order.techfixId + '</td>' +
                                '<td>' + order.supplierId + '</td>' +
                                '<td>' + order.productId + '</td>' +
                                '<td><input type="number" value="' + order.orderQuantity + '" class="quantityInput" data-id="' + order.orderId + '" data-product-id="' + order.productId + '"></td>' +
                                '<td class="totalPriceCell">' + order.totalPrice.toFixed(2) + '</td>' +
                                '<td>' + order.orderStatus + '</td>' +
                                '<td><button class="editBtn" data-id="' + order.orderId + '">Edit</button></td>' +
                                '<td><button class="deleteBtn" data-id="' + order.orderId + '">Delete</button></td>' +
                                '</tr>';
                            orderTable.append(row);
                        });
                    },
                    error: function (error) {
                        console.error("Error loading orders: ", error);
                    }
                });
            }

            // Edit order
            $(document).on('click', '.editBtn', function () {
                var orderId = $(this).data('id');
                var updatedOrder = {
                    orderId: orderId,
                    orderQuantity: $('.quantityInput[data-id="' + orderId + '"]').val(),
                    totalPrice: $('.totalPriceCell[data-id="' + orderId + '"]').text()
                    // Assuming totalPrice is not editable, otherwise include it
                    // totalPrice: $('.priceInput[data-id="' + orderId + '"]').val()
                };

                var techfixId = '<%= Session["UserId"] %>';

                $.ajax({
                    url: '/api/techfixorders/' + updatedOrder.orderId + '?techfixId=' + techfixId, // Updated API URL
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(updatedOrder),
                    success: function (data) {
                        alert('Order updated successfully!');
                        loadOrders(); // Reload orders after update
                    },
                    error: function (error) {
                        console.error("Error updating order: ", error);
                    }
                });
            });

            // Update total price when quantity changes
            $(document).on('input', '.quantityInput', function () {
                var quantity = $(this).val();
                var productId = $(this).data('product-id');
                var orderId = $(this).data('id');

                fetchUnitPriceEdit(productId, quantity, orderId);
            });

            function fetchUnitPriceEdit(productId, quantity, orderId) {
                if (productId) {
                    $.ajax({
                        url: '/api/products/' + productId,
                        type: 'GET',
                        success: function (data) {
                            var unitPrice = data.price;
                            var totalPrice = (quantity * unitPrice).toFixed(2);

                            // Update the correct total price cell
                            $('#orderTableBody tr').each(function () {
                                if ($(this).find('.editBtn').data('id') == orderId) {
                                    $(this).find('.totalPriceCell').text(totalPrice); // Ensure you're updating the right cell
                                    $(this).find('.totalPriceCell').attr('data-id', orderId);
                                }
                            });
                        },
                        error: function (error) {
                            console.error("Error fetching unit price: ", error);
                        }
                    });
                }
            }


            // Delete order
            $(document).on('click', '.deleteBtn', function () {
                var orderId = $(this).data('id');
                var techfixId = '<%= Session["UserId"] %>';

                if (confirm('Are you sure you want to delete this order?')) {
                    $.ajax({
                        url: '/api/techfixorders/' + orderId + '?techfixId=' + techfixId, // Updated API URL
                        type: 'DELETE',
                        success: function (data) {
                            alert('Order deleted successfully!');
                            loadOrders(); // Reload orders after deletion
                        },
                        error: function (error) {
                            console.error("Error deleting order: ", error);
                        }
                    });
                }
            });

            // Add new order
            $('#addOrderForm').submit(function (event) {
                event.preventDefault();
                var newOrder = {
                    techfixId: '<%= Session["UserId"] %>',
                    supplierId: $('#addSupplierId').val(),
                    productId: $('#addProductId').val(),
                    orderQuantity: $('#addOrderQuantity').val(),
                    totalPrice: $('#addTotalPrice').val()
                };

                $.ajax({
                    url: '/api/techfixorders', // Updated API URL
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(newOrder),
                    success: function (data) {
                        alert('New order added successfully!');
                        loadOrders(); // Reload orders after adding
                        $('#addOrderModal').hide(); // Hide modal after adding
                    },
                    error: function (error) {
                        console.error("Error adding order: ", error);
                    }
                });
            });

            // Fetch unit price and calculate total price
            $('#addProductId').change(function () {
                fetchUnitPrice();
            });

            $('#addOrderQuantity').on('input', function () {
                calculateTotalPrice();
            });

            function fetchUnitPrice() {
                var productId = $('#addProductId').val();

                if (productId) {
                    $.ajax({
                        url: '/api/products/' + productId, // Updated API URL
                        type: 'GET',
                        success: function (data) {
                            $('#unitPrice').val(data.price);
                            calculateTotalPrice(); // Recalculate total price when unit price is fetched
                        },
                        error: function (error) {
                            console.error("Error fetching unit price: ", error);
                        }
                    });
                }
            }

            function calculateTotalPrice() {
                var quantity = $('#addOrderQuantity').val();
                var unitPrice = $('#unitPrice').val();

                if (quantity && unitPrice) {
                    var totalPrice = (quantity * unitPrice).toFixed(2);
                    $('#addTotalPrice').val(totalPrice);
                }
            }
        });
        
    </script>
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

        <!-- Orders Table -->
        <div class="order-container">
            <h2>Order Management</h2>
            <button onclick="$('#addOrderModal').show();">Place An Order</button>
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>TechFix ID</th>
                        <th>Supplier ID</th>
                        <th>Product ID</th>
                        <th>Order Quantity</th>
                        <th>Total Price</th>
                        <th>Status</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody id="orderTableBody">
                    <!-- Order rows will be dynamically populated here -->
                </tbody>
            </table>
        </div>

        <!-- Add Order Modal -->
        <div id="addOrderModal" style="display: none;">
            <h2>Add New Order</h2>
            <form id="addOrderForm">
                <label for="addSupplierId">Supplier ID:</label>
                <input type="text" id="addSupplierId" name="addSupplierId" required />

                <label for="addProductId">Product ID:</label>
                <input type="text" id="addProductId" name="addProductId" required />

                <label for="addOrderQuantity">Order Quantity:</label>
                <input type="number" id="addOrderQuantity" name="addOrderQuantity" required />

                <label for="addTotalPrice">Total Price:</label>
                <input type="number" id="addTotalPrice" name="addTotalPrice" required readonly />

                <input type="hidden" id="unitPrice" />

                <button type="button" runat="server" onserverclick="AddOrder_ServerClick">Place an Order</button>
                <button type="button" onclick="$('#addOrderModal').hide();">Cancel</button>
            </form>
        </div>
    </form>

    <!-- Footer -->
    <footer>
        <div class="footer-bottom">
            <p>&copy; 2024 - TechFix. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
