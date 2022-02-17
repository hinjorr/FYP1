using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblAssesmentSubmission
    {
        public int SubmissionId { get; set; }
        public int? UserId { get; set; }
        public int? AssesmentId { get; set; }
        public string FilePath { get; set; }
        public string DisplayName { get; set; }
        public string Link { get; set; }
        public DateTime? SubmissionTime { get; set; }

        public virtual TblAssesment Assesment { get; set; }
        public virtual TblUser User { get; set; }
    }
}
