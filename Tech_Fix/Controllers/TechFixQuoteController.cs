using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Tech_Fix.Models;

namespace Tech_Fix.Controllers
{
    [RoutePrefix("api/techfixquotes")]
    public class TechFixQuoteController : ApiController
    {
        private MyDbContext db = new MyDbContext();

        // GET: api/techfixquotes?techfixId=1
        [HttpGet]
        [Route("")]
        public IHttpActionResult GetQuotes([FromUri] int techfixId)
        {
            var quotes = db.Quotes.Where(q => q.TechfixId == techfixId).ToList();
            return Ok(quotes);
        }

        // GET: api/techfixquotes/5
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

        // POST: api/techfixquotes
        [HttpPost]
        [Route("")]
        public IHttpActionResult PostQuote([FromBody] Quote newQuote)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            newQuote.CreatedAt = System.DateTime.Now;
            newQuote.UpdatedAt = System.DateTime.Now;

            db.Quotes.Add(newQuote);
            db.SaveChanges();
            return CreatedAtRoute("DefaultApi", new { controller = "Quotes", id = newQuote.QuoteId }, newQuote);
        }

        // PUT: api/techfixquotes/5?techfixId=1
        [HttpPut]
        [Route("{id:int}")]
        public IHttpActionResult PutQuote(int id, [FromBody] Quote updatedQuote, [FromUri] int techfixId)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var existingQuote = db.Quotes.FirstOrDefault(q => q.QuoteId == id && q.TechfixId == techfixId);
            if (existingQuote == null)
            {
                return NotFound();
            }

            // TechFix can update requested quantity and quoted price
            existingQuote.RequestedQuantity = updatedQuote.RequestedQuantity;
            existingQuote.QuotedPrice = updatedQuote.QuotedPrice;
            existingQuote.UpdatedAt = System.DateTime.Now;

            db.SaveChanges();
            return Ok(existingQuote);
        }

        // DELETE: api/techfixquotes/5?techfixId=1
        [HttpDelete]
        [Route("{id:int}")]
        public IHttpActionResult DeleteQuote(int id, [FromUri] int techfixId)
        {
            var quote = db.Quotes.FirstOrDefault(q => q.QuoteId == id && q.TechfixId == techfixId);
            if (quote == null)
            {
                return NotFound();
            }

            db.Quotes.Remove(quote);
            db.SaveChanges();
            return Ok();
        }
    }
}
