using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblFaculty
    {
        public int FacultyId { get; set; }
        public int? UserId { get; set; }

        public virtual TblUser User { get; set; }
    }
}
