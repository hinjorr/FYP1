using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class MarksDTO
    {
        public int MarksId { get; set; }
        public int? ClassId { get; set; }
        public string AssementName { get; set; }
        public int? UserId { get; set; }
        public string UserName { get; set; }
        public double TotalMarks { get; set; }
        public double ObtainedMakrs { get; set; }
    }
}