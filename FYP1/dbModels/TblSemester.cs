using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblSemester
    {
        public TblSemester()
        {
            TblClasses = new HashSet<TblClass>();
        }

        public int SemesterId { get; set; }
        public string SemesterName { get; set; }

        public virtual ICollection<TblClass> TblClasses { get; set; }
    }
}
