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
        public int? CourseId { get; set; }
        public int? SemesterId { get; set; }
        public int? ProgramId { get; set; }
        public int? DayId { get; set; }
        public int? TimeId { get; set; }
        public ulong? IsActive { get; set; }
        public DayDTO Day { get; set; }
        public TimeDTO Time { get; set; }
        public CourseDTO Course { get; set; }
        public ProgramDTO Program { get; set; }
        public SemesterDTO Semester { get; set; }

    }
}