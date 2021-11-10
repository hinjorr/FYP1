using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblStudentcourseregistration
    {
        public int ScrId { get; set; }
        public int? StudentId { get; set; }
        public int? ElgibiltyId { get; set; }

        public virtual TblCourseeligiblity Elgibilty { get; set; }
        public virtual TblStudent Student { get; set; }
    }
}
