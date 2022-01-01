using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblCourseEligiblity
    {
        public int ElgibiltyId { get; set; }
        public int? ClassId { get; set; }
        public int? ProgramId { get; set; }
        public int? RqdCourseId { get; set; }

        public virtual TblClass Class { get; set; }
        public virtual TblProgram Program { get; set; }
        public virtual TblCourse RqdCourse { get; set; }
    }
}
