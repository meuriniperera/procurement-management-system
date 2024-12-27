using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Tech_Fix.Models
{
    public class Order
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("order_id")] // Match the database column name
        public int OrderId { get; set; }

        [Required]
        [Column("techfix_id")] // Match the database column name
        public int TechfixId { get; set; }

        [Required]
        [Column("supplier_id")] // Match the database column name
        public int SupplierId { get; set; }

        [Required]
        [Column("product_id")] // Match the database column name
        public int ProductId { get; set; }

        [Column("order_quantity")] // Match the database column name
        public int? OrderQuantity { get; set; }

        [Required]
        [Column("total_price", TypeName = "decimal")] // Match the database column name, decimal type
        public decimal TotalPrice { get; set; }  // Required, so no nullable type

        [Column("order_status")] // Match the database column name
        [StringLength(50)]
        public string OrderStatus { get; set; } = "pending";  // Default value is 'pending'

        [Column("created_at")] // Match the database column name
        public DateTime CreatedAt { get; set; } = DateTime.Now;

        [Column("updated_at")] // Match the database column name
        public DateTime UpdatedAt { get; set; } = DateTime.Now;

        // Navigation properties
        [ForeignKey("TechfixId")]
        public User Techfix { get; set; }  // The TechFix user who placed the order

        [ForeignKey("SupplierId")]
        public User Supplier { get; set; }  // The Supplier fulfilling the order

        [ForeignKey("ProductId")]
        public Product Product { get; set; }  // The Product being ordered
    }
}
