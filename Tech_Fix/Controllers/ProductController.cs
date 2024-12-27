using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Tech_Fix.Models;

namespace Tech_Fix.Controllers
{
    [RoutePrefix("api/products")]
    public class ProductController : ApiController
    {
        private MyDbContext db = new MyDbContext();

        // GET: api/products?supplierId=2
        [HttpGet]
        [Route("")]
        public IHttpActionResult GetProducts([FromUri] int supplierId)
        {
            var products = db.Products.Where(p => p.SupplierId == supplierId).ToList();
            return Ok(products);
        }

        // GET: api/products/5
        [HttpGet]
        [Route("{id:int}")]
        public IHttpActionResult GetProduct(int id)
        {
            var product = db.Products.Find(id);
            if (product == null)
            {
                return NotFound();
            }
            return Ok(product);
        }

        // POST: api/products
        [HttpPost]
        [Route("")]
        public IHttpActionResult PostProduct([FromBody] Product product)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Products.Add(product);
            db.SaveChanges();
            return CreatedAtRoute("DefaultApi", new { controller = "Products", id = product.ProductId }, product);
        }

        // PUT: api/products/5
        [HttpPut]
        [Route("{id:int}")]
        public IHttpActionResult PutProduct(int id, [FromBody] Product product)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var existingProduct = db.Products.Find(id);
            if (existingProduct == null)
            {
                return NotFound();
            }

            existingProduct.Name = product.Name;
            existingProduct.Description = product.Description;
            existingProduct.Category = product.Category;
            existingProduct.Price = product.Price;
            existingProduct.StockQuantity = product.StockQuantity;
            existingProduct.UpdatedAt = System.DateTime.Now;

            db.SaveChanges();
            return Ok(existingProduct);
        }

        // DELETE: api/products/5
        [HttpDelete]
        [Route("{id:int}")]
        public IHttpActionResult DeleteProduct(int id)
        {
            var product = db.Products.Find(id);
            if (product == null)
            {
                return NotFound();
            }

            db.Products.Remove(product);
            db.SaveChanges();
            return Ok();
        }
    }
}
