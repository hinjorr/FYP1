using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblCourse
    {
        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public string CourseShortName { get; set; }
        public ulong? IsActive { get; set; }
    }
}
