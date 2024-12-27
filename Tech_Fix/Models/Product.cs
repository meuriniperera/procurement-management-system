using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Tech_Fix.Models
{
    public class Product
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("product_id")] // Match the database column name
        public int ProductId { get; set; }

        [Required]
        [Column("supplier_id")] // Match the database column name
        public int SupplierId { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("name")] // Match the database column name
        public string Name { get; set; }

        [Column("description")] // Match the database column name
        public string Description { get; set; }

        [MaxLength(50)]
        [Column("category")] // Match the database column name
        public string Category { get; set; }

        [Required]
        [Column("price", TypeName = "decimal")] // Match the database column name
        public decimal Price { get; set; }

        [Column("stock_quantity")] // Match the database column name
        public int StockQuantity { get; set; }

        [Column("created_at")] // Match the database column name
        public DateTime CreatedAt { get; set; } = DateTime.Now;

        [Column("updated_at")] // Match the database column name
        public DateTime UpdatedAt { get; set; } = DateTime.Now;

        // Navigation property
        [ForeignKey("supplier_id")]
        public User Supplier { get; set; }  // Supplier who added the product
    }
}
