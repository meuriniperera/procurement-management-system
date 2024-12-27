using System.Linq;
using System.Web.Http;
using Tech_Fix.Models;

namespace Tech_Fix.Controllers
{
    [RoutePrefix("api/orders")]
    public class OrderController : ApiController
    {
        private MyDbContext db = new MyDbContext();

        // GET: api/orders?supplierId=2
        [HttpGet]
        [Route("")]
        public IHttpActionResult GetOrders([FromUri] int supplierId)
        {
            var orders = db.Orders.Where(o => o.SupplierId == supplierId).ToList();
            if (!orders.Any())
            {
                return NotFound(); // No orders found for this supplier
            }

            return Ok(orders);
        }

        // GET: api/orders/5
        [HttpGet]
        [Route("{id:int}")]
        public IHttpActionResult GetOrder(int id)
        {
            var order = db.Orders.Find(id);
            if (order == null)
            {
                return NotFound();
            }
            return Ok(order);
        }

        // PUT: api/orders/5
        [HttpPut]
        [Route("{id:int}")]
        public IHttpActionResult PutOrder(int id, [FromBody] Order updatedOrder)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var existingOrder = db.Orders.Find(id);
            if (existingOrder == null)
            {
                return NotFound();
            }

            // Update the fields in the existing order
            existingOrder.OrderStatus = updatedOrder.OrderStatus; // Update status
            existingOrder.UpdatedAt = System.DateTime.Now; // Update timestamp

            db.SaveChanges();
            return Ok(existingOrder);
        }
    }
}
