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
            TblCourseEligiblities = new HashSet<TblCourseEligiblity>();
            TblProgramSyllabusCourses = new HashSet<TblProgramSyllabus>();
            TblProgramSyllabusRqdCourses = new HashSet<TblProgramSyllabus>();
        }

        public int CourseId { get; set; }
        public string FullName { get; set; }
        public string ShortName { get; set; }
        public int? CrHr { get; set; }
        public ulong? IsActive { get; set; }

        public virtual ICollection<TblClass> TblClasses { get; set; }
        public virtual ICollection<TblCourseEligiblity> TblCourseEligiblities { get; set; }
        public virtual ICollection<TblProgramSyllabus> TblProgramSyllabusCourses { get; set; }
        public virtual ICollection<TblProgramSyllabus> TblProgramSyllabusRqdCourses { get; set; }
    }
}
