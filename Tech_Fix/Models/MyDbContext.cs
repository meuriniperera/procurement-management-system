using System.Data.Entity;

namespace Tech_Fix.Models
{
    public class MyDbContext : DbContext
    {
        // Constructor that uses the connection string name from the Web.config or App.config
        public MyDbContext() : base("name=TechFixConnectionString")
        {
        }

        // DbSet properties for the tables in the database
        public DbSet<Product> Products { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Quote> Quotes { get; set; }

        public DbSet<Order> Orders { get; set; }

        // Override OnModelCreating method to configure relationships and properties
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            // Define the relationship between User and Product models
            modelBuilder.Entity<User>()
                        .HasMany(u => u.Products)
                        .WithRequired(p => p.Supplier)
                        .HasForeignKey(p => p.SupplierId)
                        .WillCascadeOnDelete(false);

            // Define the relationships for the Quote model
            modelBuilder.Entity<Quote>()
                        .HasRequired(q => q.Techfix)
                        .WithMany() // Assuming a Techfix does not have a collection of Quotes
                        .HasForeignKey(q => q.TechfixId)
                        .WillCascadeOnDelete(false);

            modelBuilder.Entity<Quote>()
                        .HasRequired(q => q.Supplier)
                        .WithMany() // Assuming a Supplier does not have a collection of Quotes
                        .HasForeignKey(q => q.SupplierId)
                        .WillCascadeOnDelete(false);

            modelBuilder.Entity<Quote>()
                        .HasRequired(q => q.Product)
                        .WithMany() // Assuming a Product does not have a collection of Quotes
                        .HasForeignKey(q => q.ProductId)
                        .WillCascadeOnDelete(false);

            // Define relationships for the Order model
            modelBuilder.Entity<Order>()
                        .HasRequired(o => o.Techfix)   // Assuming an Order is placed by a TechFix user
                        .WithMany()                    // Assuming no collection of orders in User
                        .HasForeignKey(o => o.TechfixId)
                        .WillCascadeOnDelete(false);

            modelBuilder.Entity<Order>()
                        .HasRequired(o => o.Supplier)  // Assuming an Order is fulfilled by a Supplier
                        .WithMany()                    // Assuming no collection of orders in Supplier
                        .HasForeignKey(o => o.SupplierId)
                        .WillCascadeOnDelete(false);

            modelBuilder.Entity<Order>()
                        .HasRequired(o => o.Product)   // Assuming an Order contains a Product
                        .WithMany()                    // Assuming no collection of orders in Product
                        .HasForeignKey(o => o.ProductId)
                        .WillCascadeOnDelete(false);

            base.OnModelCreating(modelBuilder);

        }
    }
}

