using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Tech_Fix.Models;

namespace Tech_Fix.Controllers
{
    [RoutePrefix("api/quotes")]
    public class QuoteController : ApiController
    {
        private MyDbContext db = new MyDbContext();

        // GET: api/quotes?supplierId=2
        [HttpGet]
        [Route("")]
        public IHttpActionResult GetQuotes([FromUri] int supplierId)
        {
            var quotes = db.Quotes.Where(q => q.SupplierId == supplierId).ToList();
            return Ok(quotes);
        }

        // GET: api/quotes/5
        [HttpGet]
        [Route("{id:int}")]
        public IHttpActionResult GetQuote(int id)
        {
            var quote = db.Quotes.Find(id);
            if (quote == null)
            {
                return NotFound();
            }
            return Ok(quote);
        }

        // PUT: api/quotes/5?supplierId=2
        [HttpPut]
        [Route("{id:int}")]
        public IHttpActionResult PutQuote(int id, [FromBody] Quote updatedQuote, [FromUri] int supplierId)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Find the existing quote based on both id and supplierId
            var existingQuote = db.Quotes.FirstOrDefault(q => q.QuoteId == id && q.SupplierId == supplierId);
            if (existingQuote == null)
            {
                return NotFound();
            }

            // Update only the status field
            existingQuote.Status = updatedQuote.Status;
            existingQuote.UpdatedAt = System.DateTime.Now;

            db.SaveChanges();
            return Ok(existingQuote);
        }

    }
}
