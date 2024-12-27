<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupplierQuotes.aspx.cs" Inherits="Tech_Fix.SupplierQuotes" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Quotes - TechFix</title>

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Link to External Stylesheet -->
    <link href="Content/Supplier.css" rel="stylesheet" />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- JavaScript for CRUD operations -->
    <script>
        $(document).ready(function () {
            // Load quotes when the page loads
            loadQuotes();

            // Function to load quotes based on the logged-in supplier's ID
            function loadQuotes() {
                var supplierId = '<%= Session["UserId"] %>'; // Assuming supplierId is stored in the session

                $.ajax({
                    url: '/api/quotes?supplierId=' + supplierId,
                    type: 'GET',
                    success: function (data) {
                        var quoteTable = $('#quoteTableBody');
                        quoteTable.empty(); // Clear existing rows

                        $.each(data, function (index, quote) {
                            var row = `<tr>
                        <td>${quote.quoteId}</td>
                        <td>${quote.productId}</td>
                        <td>${quote.requestedQuantity}</td>
                        <td>${quote.quotedPrice}</td>
                        <td>
                            <select class="statusDropdown" data-id="${quote.quoteId}">
                                <option value="requested" ${quote.status === 'requested' ? 'selected' : ''}>Requested</option>
                                <option value="responded" ${quote.status === 'responded' ? 'selected' : ''}>Responded</option>
                                <option value="approved" ${quote.status === 'approved' ? 'selected' : ''}>Approved</option>
                                <option value="rejected" ${quote.status === 'rejected' ? 'selected' : ''}>Rejected</option>
                            </select>
                        </td>
                        <td><button class="updateStatusBtnQuote" data-id="${quote.quoteId}">Update Status</button></td>
                    </tr>`;
                            quoteTable.append(row);
                        });
                    },
                    error: function (error) {
                        console.error("Error loading quotes: ", error);
                    }
                });
            }

            // Update quote status
            $(document).on('click', '.updateStatusBtnQuote', function () {
                var quoteId = $(this).data('id');
                var newStatus = $(this).closest('tr').find('.statusDropdown').val();


                var updatedQuote = {
                    quoteId: quoteId,
                    status: newStatus
                };

                console.log('Updating quote:', updatedQuote); // Debugging line
                var supplierId = '<%= Session["UserId"] %>';

                $.ajax({
                    url: '/api/quotes/' + updatedQuote.quoteId + '?supplierId=' + supplierId,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(updatedQuote), // Only send the status field
                    success: function (data) {
                        console.log('Quote status updated successfully!');
                        alert('Quote status updated successfully!');
                        loadQuotes(); // Reload quotes to reflect the changes
                    },
                    error: function (error) {
                        console.error("Error updating quote: ", error);
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

        <!-- Quotes Table -->
        <div class="quote-container">
            <h2>Your Quotes</h2>
            <table class="quote-table">
                <thead>
                    <tr>
                        <th>Quote ID</th>
                        <th>Product ID</th>
                        <th>Requested Quantity</th>
                        <th>Quoted Price</th>
                        <th>Status</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody id="quoteTableBody">
                    <!-- Quote rows will be dynamically populated here -->
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
