using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblProgramSyllabus
    {
        public int SyllabusId { get; set; }
        public int? ProgramId { get; set; }
        public int? CourseId { get; set; }
        public int? RqdCourseId { get; set; }
    }
}
