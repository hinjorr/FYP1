using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class CourseEligiblityDTO
    {
        public int ElgibiltyId { get; set; }
        public int? ClassId { get; set; }
        public int? ProgramId { get; set; }
        public int? RqdCourseId { get; set; }
    }
}