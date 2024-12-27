<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TechFixQuotes.aspx.cs" Inherits="Tech_Fix.TechFixQuotes" Async="true" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechFix Quotes - Centralized Quoting Platform</title>

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Link to External Stylesheet -->
    <link href="Content/TechFix.css" rel="stylesheet" />
    <link href="Content/Quote.css" rel="stylesheet" />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- JavaScript for CRUD operations -->
    <script>
        $(document).ready(function () {
            // Load quotes when the page loads
            loadQuotes();

            // Function to load quotes for a specific techfixId
            function loadQuotes() {
                // Get the techfixId from query string or any other source
                var techfixId = '<%= Session["UserId"] %>';

                $.ajax({
                    url: '/api/techfixquotes?techfixId=' + techfixId, // Updated API URL
                    type: 'GET',
                    success: function (data) {
                        var quoteTable = $('#quoteTableBody');
                        quoteTable.empty(); // Clear existing rows

                        $.each(data, function (index, quote) {
                            var row = '<tr>' +
                                '<td>' + quote.quoteId + '</td>' +
                                '<td>' + quote.supplierId + '</td>' +
                                '<td>' + quote.productId + '</td>' +
                                '<td><input type="number" value="' + quote.requestedQuantity + '" class="quantityInput" data-id="' + quote.quoteId + '"></td>' +
                                '<td><input type="number" value="' + quote.quotedPrice + '" class="priceInput" data-id="' + quote.quoteId + '"></td>' +
                                '<td>' + quote.status + '</td>' +
                                '<td><button class="editBtn" data-id="' + quote.quoteId + '">Edit</button></td>' +
                                '<td><button class="deleteBtn" data-id="' + quote.quoteId + '">Delete</button></td>' +
                                '</tr>';
                            quoteTable.append(row);
                        });
                    },
                    error: function (error) {
                        console.error("Error loading quotes: ", error);
                    }
                });
            }

            // Get URL parameter function
            function getUrlParameter(name) {
                name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
                var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
                var results = regex.exec(location.search);
                return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
            }

            // Edit quote
            $(document).on('click', '.editBtn', function () {
                var quoteId = $(this).data('id');
                var updatedQuote = {
                    quoteId: quoteId,
                    requestedQuantity: $('.quantityInput[data-id="' + quoteId + '"]').val(),
                    quotedPrice: $('.priceInput[data-id="' + quoteId + '"]').val()
                };

                var techfixId = '<%= Session["UserId"] %>';

                $.ajax({
                    url: '/api/techfixquotes/' + updatedQuote.quoteId + '?techfixId=' + techfixId, // Updated API URL
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(updatedQuote),
                    success: function (data) {
                        alert('Quote updated successfully!');
                        loadQuotes(); // Reload quotes after update
                    },
                    error: function (error) {
                        console.error("Error updating quote: ", error);
                    }
                });
            });

            // Delete quote
            $(document).on('click', '.deleteBtn', function () {
                var quoteId = $(this).data('id');
                var techfixId = '<%= Session["UserId"] %>';

                if (confirm('Are you sure you want to delete this quote?')) {
                    $.ajax({
                        url: '/api/techfixquotes/' + quoteId + '?techfixId=' + techfixId, // Updated API URL
                        type: 'DELETE',
                        success: function (data) {
                            alert('Quote deleted successfully!');
                            loadQuotes(); // Reload quotes after deletion
                        },
                        error: function (error) {
                            console.error("Error deleting quote: ", error);
                        }
                    });
                }
            });
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

        <!-- Quotes Table -->
        <div class="quote-container">
            <h2>Supplier Quotes</h2>
            <button onclick="$('#addQuoteModal').show();">Request New Quote</button>
            <table class="quote-table">
                <thead>
                    <tr>
                        <th>Quote ID</th>
                        <th>Supplier ID</th>
                        <th>Product ID</th>
                        <th>Requested Quantity</th>
                        <th>Quoted Price</th>
                        <th>Status</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody id="quoteTableBody">
                    <!-- Quote rows will be dynamically populated here -->
                </tbody>
            </table>
        </div>

        <!-- Add Quote Modal -->
        <div id="addQuoteModal" style="display: none;">
            <h2>Add New Quote</h2>
            <form id="addQuoteForm">
                <label for="addsupplierId">Supplier ID:</label>
                <input type="text" id="addsupplierId" name="addsupplierId" required />

                <label for="addProductId">Product ID:</label>
                <input type="text" id="addProductId" name="addProductId" required />

                <label for="addRequestedQuantity">Requested Quantity:</label>
                <input type="number" id="addRequestedQuantity" name="addRequestedQuantity" required />

                <label for="addQuotedPrice">Quoted Price:</label>
                <input type="number" id="addQuotedPrice" name="addQuotedPrice" required />

                <button type="button" runat="server" onserverclick="AddQuote_ServerClick">Request a Quote</button>
                <button type="button" onclick="$('#addQuoteModal').hide();">Cancel</button>
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

