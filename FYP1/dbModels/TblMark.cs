using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblMark
    {
        public int MarksId { get; set; }
        public int? ClassId { get; set; }
        public int? AssesmentId { get; set; }
        public int? UserId { get; set; }
        public int? TotalMarks { get; set; }
        public int? ObtainedMakrs { get; set; }

        public virtual TblAssesment Assesment { get; set; }
        public virtual TblClass Class { get; set; }
        public virtual TblUser User { get; set; }
    }
}
