using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblAssesmetnAttachment
    {
        public int FileId { get; set; }
        public int? AssesmentId { get; set; }
        public string Path { get; set; }

        public virtual TblAssesment Assesment { get; set; }
    }
}
