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
        public string AssesmentName { get; set; }
        public int? AssesmentId { get; set; }
        public int? UserId { get; set; }
        public int? TotalMarks { get; set; }
        public int? ObtainedMakrs { get; set; }
    }
}