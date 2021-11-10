using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblProgramsyllabus
    {
        public int SyllabusId { get; set; }
        public int? ProgramId { get; set; }
        public int? CourseId { get; set; }
        public int? RqdCourseId { get; set; }
        public int? RequiredCrHr { get; set; }

        public virtual TblCourse Course { get; set; }
        public virtual TblProgram Program { get; set; }
        public virtual TblCourse RqdCourse { get; set; }
    }
}
