using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblUser
    {
        public TblUser()
        {
            MessageUserFromNavigations = new HashSet<Message>();
            MessageUserToNavigations = new HashSet<Message>();
            TblAssesmentSubmissions = new HashSet<TblAssesmentSubmission>();
            TblAttendences = new HashSet<TblAttendence>();
            TblFacultyCourseRegistrations = new HashSet<TblFacultyCourseRegistration>();
            TblMarks = new HashSet<TblMark>();
            TblNotificaionTos = new HashSet<TblNotificaionTo>();
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
        public virtual ICollection<Message> MessageUserFromNavigations { get; set; }
        public virtual ICollection<Message> MessageUserToNavigations { get; set; }
        public virtual ICollection<TblAssesmentSubmission> TblAssesmentSubmissions { get; set; }
        public virtual ICollection<TblAttendence> TblAttendences { get; set; }
        public virtual ICollection<TblFacultyCourseRegistration> TblFacultyCourseRegistrations { get; set; }
        public virtual ICollection<TblMark> TblMarks { get; set; }
        public virtual ICollection<TblNotificaionTo> TblNotificaionTos { get; set; }
        public virtual ICollection<TblStudentCourseRegistration> TblStudentCourseRegistrations { get; set; }
        public virtual ICollection<TblStudent> TblStudents { get; set; }
    }
}
