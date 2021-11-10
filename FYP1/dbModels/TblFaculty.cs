using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblFaculty
    {
        public TblFaculty()
        {
            TblFacultycourseregistrations = new HashSet<TblFacultycourseregistration>();
        }

        public int FacultyId { get; set; }
        public int? UserId { get; set; }

        public virtual TblUser User { get; set; }
        public virtual ICollection<TblFacultycourseregistration> TblFacultycourseregistrations { get; set; }
    }
}
