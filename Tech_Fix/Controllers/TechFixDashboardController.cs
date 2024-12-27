using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Tech_Fix.Models;

namespace Tech_Fix.Controllers
{
    [RoutePrefix("api/TechFixDashboard")]
    public class TechFixDashboardController : ApiController
    {
        // Database context
        private MyDbContext db = new MyDbContext();

        // GET: api/TechFixDashboard/GetHardwareItems
        [HttpGet]
        [Route("GetHardwareItems")]
        public IHttpActionResult GetHardwareItems()
        {
            var hardwareItems = db.HardwareItems.ToList();  // Fetching from the database
            return Ok(hardwareItems);
        }

        // POST: api/TechFixDashboard/FilterHardwareItems
        [HttpPost]
        [Route("FilterHardwareItems")]
        public IHttpActionResult FilterHardwareItems([FromBody] HardwareItem filterCriteria)
        {
            var filteredItems = db.HardwareItems
                .Where(item =>
                    (string.IsNullOrEmpty(filterCriteria.ItemName) || item.ItemName.ToLower().Contains(filterCriteria.ItemName.ToLower())) &&
                    (string.IsNullOrEmpty(filterCriteria.SupplierName) || item.SupplierName.ToLower().Contains(filterCriteria.SupplierName.ToLower())) &&
                    (filterCriteria.Quantity == 0 || item.Quantity >= filterCriteria.Quantity) &&
                    (filterCriteria.Price == 0 || item.Price <= filterCriteria.Price))
                .ToList();

            return Ok(filteredItems);
        }

        // POST: api/TechFixDashboard/ConfirmOrder
        [HttpPost]
        [Route("ConfirmOrder")]
        public IHttpActionResult ConfirmOrder([FromBody] Order order)
        {
            if (order == null)
                return BadRequest("Order data is invalid.");

            db.Orders.Add(order);  // Adding order to the database
            db.SaveChanges();

            // Add notification for the order
            var notification = new Notification
            {
                Message = $"New order for {order.ItemName} confirmed.",
                Date = DateTime.Now,
                IsRead = false
            };

            db.Notifications.Add(notification);  // Adding notification to the database
            db.SaveChanges();

            return Ok("Order confirmed successfully.");
        }

        // GET: api/TechFixDashboard/GetNotifications
        [HttpGet]
        [Route("GetNotifications")]
        public IHttpActionResult GetNotifications()
        {
            var unreadNotifications = db.Notifications.Where(n => !n.IsRead).ToList();  // Fetching unread notifications
            return Ok(unreadNotifications);
        }

        // POST: api/TechFixDashboard/MarkNotificationAsRead
        [HttpPost]
        [Route("MarkNotificationAsRead")]
        public IHttpActionResult MarkNotificationAsRead([FromBody] int notificationId)
        {
            var notification = db.Notifications.Find(notificationId);  // Finding the notification by ID
            if (notification == null)
                return NotFound();

            notification.IsRead = true;
            db.SaveChanges();  // Updating the notification in the database

            return Ok("Notification marked as read.");
        }
    }
}
