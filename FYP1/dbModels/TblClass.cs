using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblClass
    {
        public TblClass()
        {
            TblCourseeligiblities = new HashSet<TblCourseeligiblity>();
            TblFacultycourseregistrations = new HashSet<TblFacultycourseregistration>();
        }

        public int ClassId { get; set; }
        public int? ClassStrength { get; set; }
        public int? ClassDay { get; set; }
        public int? ClassTime { get; set; }
        public int? CourseId { get; set; }
        public int? SemesterId { get; set; }

        public virtual TblDay ClassDayNavigation { get; set; }
        public virtual TblTime ClassTimeNavigation { get; set; }
        public virtual TblCourse Course { get; set; }
        public virtual TblSemester Semester { get; set; }
        public virtual ICollection<TblCourseeligiblity> TblCourseeligiblities { get; set; }
        public virtual ICollection<TblFacultycourseregistration> TblFacultycourseregistrations { get; set; }
    }
}
