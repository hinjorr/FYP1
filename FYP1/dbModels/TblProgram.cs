using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblProgram
    {
        public TblProgram()
        {
            TblClasses = new HashSet<TblClass>();
            TblCourseEligiblities = new HashSet<TblCourseEligiblity>();
            TblProgramSyllabi = new HashSet<TblProgramSyllabus>();
            TblStudents = new HashSet<TblStudent>();
        }

        public int ProgramId { get; set; }
        public string ProgramFullName { get; set; }
        public string ProgramShortName { get; set; }
        public ulong? IsActive { get; set; }

        public virtual ICollection<TblClass> TblClasses { get; set; }
        public virtual ICollection<TblCourseEligiblity> TblCourseEligiblities { get; set; }
        public virtual ICollection<TblProgramSyllabus> TblProgramSyllabi { get; set; }
        public virtual ICollection<TblStudent> TblStudents { get; set; }
    }
}
