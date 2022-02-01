using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblClass
    {
        public TblClass()
        {
            TblAssesments = new HashSet<TblAssesment>();
            TblAttendences = new HashSet<TblAttendence>();
            TblClassContents = new HashSet<TblClassContent>();
            TblCourseEligiblities = new HashSet<TblCourseEligiblity>();
            TblFacultyCourseRegistrations = new HashSet<TblFacultyCourseRegistration>();
            TblMarks = new HashSet<TblMark>();
            TblStudentCourseRegistrations = new HashSet<TblStudentCourseRegistration>();
            TblUrls = new HashSet<TblUrl>();
        }

        public int ClassId { get; set; }
        public int? ClassStrength { get; set; }
        public int? EnrolledStd { get; set; }
        public int? CourseId { get; set; }
        public int? SemesterId { get; set; }
        public int? ProgramId { get; set; }
        public int? DayId { get; set; }
        public int? TimeId { get; set; }
        public ulong? IsActive { get; set; }
        public string ClassImage { get; set; }

        public virtual TblCourse Course { get; set; }
        public virtual TblDay Day { get; set; }
        public virtual TblProgram Program { get; set; }
        public virtual TblSemester Semester { get; set; }
        public virtual TblTime Time { get; set; }
        public virtual ICollection<TblAssesment> TblAssesments { get; set; }
        public virtual ICollection<TblAttendence> TblAttendences { get; set; }
        public virtual ICollection<TblClassContent> TblClassContents { get; set; }
        public virtual ICollection<TblCourseEligiblity> TblCourseEligiblities { get; set; }
        public virtual ICollection<TblFacultyCourseRegistration> TblFacultyCourseRegistrations { get; set; }
        public virtual ICollection<TblMark> TblMarks { get; set; }
        public virtual ICollection<TblStudentCourseRegistration> TblStudentCourseRegistrations { get; set; }
        public virtual ICollection<TblUrl> TblUrls { get; set; }
    }
}
