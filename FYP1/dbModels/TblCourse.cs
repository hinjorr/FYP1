using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblCourse
    {
        public TblCourse()
        {
            TblClasses = new HashSet<TblClass>();
            TblCourseeligiblities = new HashSet<TblCourseeligiblity>();
            TblProgramsyllabusCourses = new HashSet<TblProgramsyllabus>();
            TblProgramsyllabusRqdCourses = new HashSet<TblProgramsyllabus>();
        }

        public int CourseId { get; set; }
        public string FullName { get; set; }
        public string ShortName { get; set; }
        public int? CrHr { get; set; }
        public ulong? IsActive { get; set; }

        public virtual ICollection<TblClass> TblClasses { get; set; }
        public virtual ICollection<TblCourseeligiblity> TblCourseeligiblities { get; set; }
        public virtual ICollection<TblProgramsyllabus> TblProgramsyllabusCourses { get; set; }
        public virtual ICollection<TblProgramsyllabus> TblProgramsyllabusRqdCourses { get; set; }
    }
}
