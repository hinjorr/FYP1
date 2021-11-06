using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class ProgramSyllabusDTO
    {
        public int SyllabusId { get; set; }
        public int? ProgramId { get; set; }
        public int? CourseId { get; set; }
        public int? RqdCourseId { get; set; }
        public int? RequiredCrHr { get; set; }

        public  CourseDTO Course { get; set; }
        public  ProgramDTO Program { get; set; }
        public  CourseDTO RqdCourse { get; set; }
    }
}