using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblSemester
    {
        public TblSemester()
        {
            TblClassSessions = new HashSet<TblClassSession>();
            TblClasses = new HashSet<TblClass>();
            TblFacultyCourseRegistrations = new HashSet<TblFacultyCourseRegistration>();
            TblStudentCourseRegistrations = new HashSet<TblStudentCourseRegistration>();
        }

        public int SemesterId { get; set; }
        public string SemesterName { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public ulong? IsActive { get; set; }

        public virtual ICollection<TblClassSession> TblClassSessions { get; set; }
        public virtual ICollection<TblClass> TblClasses { get; set; }
        public virtual ICollection<TblFacultyCourseRegistration> TblFacultyCourseRegistrations { get; set; }
        public virtual ICollection<TblStudentCourseRegistration> TblStudentCourseRegistrations { get; set; }
    }
}
