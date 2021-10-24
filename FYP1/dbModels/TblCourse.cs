using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblCourse
    {
        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public int? CourseCrHr { get; set; }
        public int? RequiredCrHr { get; set; }
    }
}
