using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblProgram
    {
        public int ProgramId { get; set; }
        public string ProgramFullName { get; set; }
        public string ProgramShortName { get; set; }
        public ulong? IsActive { get; set; }
    }
}
