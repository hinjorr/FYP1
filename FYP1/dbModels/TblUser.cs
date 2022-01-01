using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblUser
    {
        public TblUser()
        {
            TblAdmins = new HashSet<TblAdmin>();
            TblFaculties = new HashSet<TblFaculty>();
            TblFacultyCourseRegistrations = new HashSet<TblFacultyCourseRegistration>();
            TblStudentCourseRegistrations = new HashSet<TblStudentCourseRegistration>();
            TblStudents = new HashSet<TblStudent>();
        }

        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public int RoleId { get; set; }
        public int ProfileId { get; set; }
        public ulong? IsActive { get; set; }
        public string UserDate { get; set; }

        public virtual TblProfile Profile { get; set; }
        public virtual TblRole Role { get; set; }
        public virtual ICollection<TblAdmin> TblAdmins { get; set; }
        public virtual ICollection<TblFaculty> TblFaculties { get; set; }
        public virtual ICollection<TblFacultyCourseRegistration> TblFacultyCourseRegistrations { get; set; }
        public virtual ICollection<TblStudentCourseRegistration> TblStudentCourseRegistrations { get; set; }
        public virtual ICollection<TblStudent> TblStudents { get; set; }
    }
}
