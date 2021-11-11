using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class ClassDTO
    {
        
       public int ClassId { get; set; }
        public int? ClassStrength { get; set; }
        public int? ClassDay { get; set; }
        public int? ClassTime { get; set; }
        public int? CourseId { get; set; }
        public int? SemesterId { get; set; }
        public int? ProgramId { get; set; }
    }
}