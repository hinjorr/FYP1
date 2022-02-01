using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblAssesment
    {
        public int AssesmentId { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }
        public string AssesmentName { get; set; }
        public string Description { get; set; }
        public int? AttachmentId { get; set; }
        public string Start { get; set; }
        public string End { get; set; }
        public ulong? LateSubmission { get; set; }

        public virtual TblClass Class { get; set; }
        public virtual TblClassSession Session { get; set; }
    }
}
