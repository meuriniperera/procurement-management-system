<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupplierProducts.aspx.cs" Inherits="Tech_Fix.SupplierProducts" Async="true" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Products - TechFix</title>

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
            // Load products when the page loads
            loadProducts();

            // Function to load products based on the logged-in supplier's ID
            function loadProducts() {
                var supplierId = '<%= Session["UserId"] %>'; // Assuming supplierId is stored in the session

                $.ajax({
                    url: '/api/products?supplierId=' + supplierId,
                    type: 'GET',
                    success: function (data) {
                        var productTable = $('#productTableBody');
                        productTable.empty(); // Clear existing rows

                        $.each(data, function (index, product) {
                            var row = '<tr>' +
                                '<td>' + product.productId + '</td>' +
                                '<td>' + product.name + '</td>' +
                                '<td>' + product.description + '</td>' +
                                '<td>' + product.category + '</td>' +
                                '<td>' + product.price + '</td>' +
                                '<td>' + product.stockQuantity + '</td>' +
                                '<td><button class="editBtn" data-id="' + product.productId + '">Edit</button></td>' +
                                '<td><button class="deleteBtn" data-id="' + product.productId + '">Delete</button></td>' +
                                '</tr>';
                            productTable.append(row);
                        });
                    },
                    error: function (error) {
                        console.error("Error loading products: ", error);
                    }
                });
            }


            // Edit product
            $(document).on('click', '.editBtn', function () {
                var productId = $(this).data('id');

                // Fetch the current product details
                $.ajax({
                    url: '/api/products/' + productId,
                    type: 'GET',
                    success: function (product) {
                        $('#editProductId').val(product.productId);
                        $('#editProductName').val(product.name);
                        $('#editProductDescription').val(product.description);
                        $('#editProductCategory').val(product.category);
                        $('#editProductPrice').val(product.price);
                        $('#editProductStock').val(product.stockQuantity);
                        $('#editProductModal').show();
                    },
                    error: function (error) {
                        console.error("Error fetching product: ", error);
                    }
                });
            });

            // Update product
            $('#editProductForm').submit(function (event) {
                event.preventDefault();

                var updatedProduct = {
                    productId: $('#editProductId').val(),
                    name: $('#editProductName').val(),
                    description: $('#editProductDescription').val(),
                    category: $('#editProductCategory').val(),
                    price: $('#editProductPrice').val(),
                    stockQuantity: $('#editProductStock').val()
                };

                $.ajax({
                    url: '/api/products/' + updatedProduct.productId,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(updatedProduct),
                    success: function (data) {
                        alert('Product updated successfully!');
                        loadProducts(); // Reload products
                        $('#editProductModal').hide(); // Hide modal
                    },
                    error: function (error) {
                        console.error("Error updating product: ", error);
                    }
                });
            });

            // Delete product
            $(document).on('click', '.deleteBtn', function () {
                var productId = $(this).data('id');
                var confirmDelete = confirm("Are you sure you want to delete this product?");

                if (confirmDelete) {
                    $.ajax({
                        url: '/api/products/' + productId,
                        type: 'DELETE',
                        success: function (data) {
                            alert('Product deleted successfully!');
                            loadProducts(); // Reload products
                        },
                        error: function (error) {
                            console.error("Error deleting product: ", error);
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
            <div class="logo">TechFix Supplier Dashboard</div>
            <div class="nav-links">
                <a href="SupplierDashboard.aspx">Home</a>
                <a href="SupplierProducts.aspx">Products</a>
                <a href="SupplierQuotes.aspx">Quotes</a>
                <a href="SupplierOrders.aspx">Orders</a>
                <a href="Default.aspx">LogOut</a>
            </div>
        </div>

        <!-- Product Table -->
        <div class="product-container">
            <h2>Your Products</h2>
            <table class="product-table">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock Quantity</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody id="productTableBody">
                    <!-- Product rows will be dynamically populated here -->
                </tbody>
            </table>
        </div>

        <!-- Add Product Form -->
        <div class="add-product-container">
            <h2>Add New Product</h2>
            <form id="addProductForm">

                <input type="hidden" id="supplierId" name="supplierId" value="<%= Session["UserId"] %>" />

                <label for="productName">Name:</label>
                <input type="text" id="productName" name="productName" required />

                <label for="productDescription">Description:</label>
                <textarea id="productDescription" name="productDescription"></textarea>

                <label for="productCategory">Category:</label>
                <input type="text" id="productCategory" name="productCategory" />

                <label for="productPrice">Price:</label>
                <input type="number" id="productPrice" name="productPrice" step="0.01" required />

                <label for="productStock">Stock Quantity:</label>
                <input type="number" id="productStock" name="productStock" required />

                <button type="submit" runat="server" onserverclick="AddProduct_ServerClick">Add Product</button>
            </form>
        </div>

        <!-- Edit Product Modal -->
        <div id="editProductModal" style="display: none;">
            <h2>Edit Product</h2>
            <form id="editProductForm">
                <input type="hidden" id="editProductId" name="editProductId" />

                <label for="editProductName">Name:</label>
                <input type="text" id="editProductName" name="editProductName" required />

                <label for="editProductDescription">Description:</label>
                <textarea id="editProductDescription" name="editProductDescription"></textarea>

                <label for="editProductCategory">Category:</label>
                <input type="text" id="editProductCategory" name="editProductCategory" />

                <label for="editProductPrice">Price:</label>
                <input type="number" id="editProductPrice" name="editProductPrice" step="0.01" required />

                <label for="editProductStock">Stock Quantity:</label>
                <input type="number" id="editProductStock" name="editProductStock" required />

                <button type="submit">Update Product</button>
            </form>
        </div>
    </form>
        <footer>
    <div class="footer-bottom">
            <p>&copy; 2024 - TechFix. All rights reserved.</p>
        </div>
</footer>
</body>
</html>
