using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblStudent
    {
        public int StudentId { get; set; }
        public int? ProgramId { get; set; }
        public int? UserId { get; set; }

        public virtual TblProgram Program { get; set; }
        public virtual TblUser User { get; set; }
    }
}
