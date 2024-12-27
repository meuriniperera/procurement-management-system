using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Tech_Fix.Models
{
    public class Quote
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("quote_id")] // Match the database column name
        public int QuoteId { get; set; }

        [Required]
        [Column("techfix_id")] // Match the database column name
        public int TechfixId { get; set; }

        [Required]
        [Column("supplier_id")] // Match the database column name
        public int SupplierId { get; set; }

        [Required]
        [Column("product_id")] // Match the database column name
        public int ProductId { get; set; }

        [Column("requested_quantity")] // Match the database column name
        public int? RequestedQuantity { get; set; }

        [Column("quoted_price", TypeName = "decimal")] // Match the database column name
        public decimal? QuotedPrice { get; set; }

        [Column("status")] // Match the database column name
        [StringLength(50)]
        public string Status { get; set; } = "requested"; // Default value

        [Column("created_at")] // Match the database column name
        public DateTime CreatedAt { get; set; } = DateTime.Now;

        [Column("updated_at")] // Match the database column name
        public DateTime UpdatedAt { get; set; } = DateTime.Now;

        // Navigation properties
        [ForeignKey("TechfixId")]
        public User Techfix { get; set; }  // Techfix user who created the quote

        [ForeignKey("SupplierId")]
        public User Supplier { get; set; }  // Supplier who is the recipient of the quote

        [ForeignKey("ProductId")]
        public Product Product { get; set; }  // Product being quoted
    }
}
