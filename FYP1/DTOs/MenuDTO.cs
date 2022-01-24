using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class MenuDTO
    {
        public int MenuId { get; set; }
        public string Controller { get; set; }
        public string Action { get; set; }
    }
}