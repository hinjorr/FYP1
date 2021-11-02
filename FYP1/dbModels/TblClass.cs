using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblClass
    {
        public int ClassId { get; set; }
        public int? ClassStrength { get; set; }
        public int? ClassDay { get; set; }
        public int? ClassTime { get; set; }
        public int? CourseId { get; set; }
        public int? SemesterId { get; set; }
    }
}
