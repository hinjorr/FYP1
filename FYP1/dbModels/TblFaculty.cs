using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblFaculty
    {
        public TblFaculty()
        {
            TblFacultyCourseRegistrations = new HashSet<TblFacultyCourseRegistration>();
        }

        public int FacultyId { get; set; }
        public int? UserId { get; set; }

        public virtual TblUser User { get; set; }
        public virtual ICollection<TblFacultyCourseRegistration> TblFacultyCourseRegistrations { get; set; }
    }
}
