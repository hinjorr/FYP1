using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblProgram
    {
        public TblProgram()
        {
            TblCourseeligiblities = new HashSet<TblCourseeligiblity>();
            TblProgramsyllabi = new HashSet<TblProgramsyllabus>();
            TblStudents = new HashSet<TblStudent>();
        }

        public int ProgramId { get; set; }
        public string ProgramFullName { get; set; }
        public string ProgramShortName { get; set; }
        public ulong? IsActive { get; set; }

        public virtual ICollection<TblCourseeligiblity> TblCourseeligiblities { get; set; }
        public virtual ICollection<TblProgramsyllabus> TblProgramsyllabi { get; set; }
        public virtual ICollection<TblStudent> TblStudents { get; set; }
    }
}
