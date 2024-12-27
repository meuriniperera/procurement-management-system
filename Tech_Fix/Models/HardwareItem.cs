using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Tech_Fix.Models
{
    public class HardwareItem
    {
        public string ItemName { get; set; }
        public string SupplierName { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
    }
}
