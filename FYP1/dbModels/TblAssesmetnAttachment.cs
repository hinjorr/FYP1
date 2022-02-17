using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblAssesmetnAttachment
    {
        public int FileId { get; set; }
        public int? AssesmentId { get; set; }
        public string DisplayName { get; set; }
        public string PathId { get; set; }

        public virtual TblAssesment Assesment { get; set; }
    }
}
