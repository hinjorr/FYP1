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
        public string DisplayLink { get; set; }
        public string DisplayName { get; set; }
        public int? Parent { get; set; }
        public string Icon { get; set; }
    }
}