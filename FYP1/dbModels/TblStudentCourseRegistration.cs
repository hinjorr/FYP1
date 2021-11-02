using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblStudentCourseRegistration
    {
        public int ScrId { get; set; }
        public int? StudentId { get; set; }
        public int? ElgibiltyId { get; set; }
    }
}
