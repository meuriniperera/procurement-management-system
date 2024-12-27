using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Tech_Fix.Models;

namespace Tech_Fix.Controllers
{
    [RoutePrefix("api/techfixorders")]
    public class TechFixOrderController : ApiController
    {
        private MyDbContext db = new MyDbContext();

        // GET: api/techfixorders?techfixId=1
        [HttpGet]
        [Route("")]
        public IHttpActionResult GetOrders([FromUri] int techfixId)
        {
            var orders = db.Orders.Where(o => o.TechfixId == techfixId).ToList();
            return Ok(orders);
        }

        // GET: api/techfixorders/5
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

        // POST: api/techfixorders
        [HttpPost]
        [Route("")]
        public IHttpActionResult PostOrder([FromBody] Order newOrder)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            newOrder.CreatedAt = System.DateTime.Now;
            newOrder.UpdatedAt = System.DateTime.Now;

            db.Orders.Add(newOrder);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { controller = "Orders", id = newOrder.OrderId }, newOrder);
        }

        // PUT: api/techfixorders/5?techfixId=1
        [HttpPut]
        [Route("{id:int}")]
        public IHttpActionResult PutOrder(int id, [FromBody] Order updatedOrder, [FromUri] int techfixId)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var existingOrder = db.Orders.FirstOrDefault(o => o.OrderId == id && o.TechfixId == techfixId);
            if (existingOrder == null)
            {
                return NotFound();
            }

            // TechFix can update order quantity and total price
            existingOrder.OrderQuantity = updatedOrder.OrderQuantity;
            existingOrder.TotalPrice = updatedOrder.TotalPrice;
            existingOrder.OrderStatus = updatedOrder.OrderStatus;
            existingOrder.UpdatedAt = System.DateTime.Now;

            db.SaveChanges();
            return Ok(existingOrder);
        }

        // DELETE: api/techfixorders/5?techfixId=1
        [HttpDelete]
        [Route("{id:int}")]
        public IHttpActionResult DeleteOrder(int id, [FromUri] int techfixId)
        {
            var order = db.Orders.FirstOrDefault(o => o.OrderId == id && o.TechfixId == techfixId);
            if (order == null)
            {
                return NotFound();
            }

            db.Orders.Remove(order);
            db.SaveChanges();
            return Ok();
        }
    }
}
