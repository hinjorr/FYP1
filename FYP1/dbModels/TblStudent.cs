using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblStudent
    {
        public TblStudent()
        {
            TblStudentCourseRegistrations = new HashSet<TblStudentCourseRegistration>();
        }

        public int StudentId { get; set; }
        public int? ProgramId { get; set; }
        public int? UserId { get; set; }
        public ulong? IsActive { get; set; }

        public virtual TblUser User { get; set; }
        public virtual ICollection<TblStudentCourseRegistration> TblStudentCourseRegistrations { get; set; }
    }
}
