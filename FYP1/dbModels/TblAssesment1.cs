using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblAssesment1
    {
        public int AssesmentId { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }
        public string AssesmentName { get; set; }
        public string Description { get; set; }
        public DateTime? Start { get; set; }
        public DateTime? End { get; set; }
        public ulong? LateSubmission { get; set; }
    }
}
