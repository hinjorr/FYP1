using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class UrlDTO
    {
        public int UrlId { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }
        public string DisplayName { get; set; }
        public string Link { get; set; }
    }
}