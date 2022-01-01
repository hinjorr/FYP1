using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblStudentCourseRegistration
    {
        public int ScrId { get; set; }
        public string Username { get; set; }
        public int UserId { get; set; }
        public int ClassId { get; set; }
        public ulong IsActive { get; set; }

        public virtual TblClass Class { get; set; }
        public virtual TblUser User { get; set; }
    }
}
