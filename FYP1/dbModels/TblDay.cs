using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblDay
    {
        public TblDay()
        {
            TblClasses = new HashSet<TblClass>();
        }

        public int DayId { get; set; }
        public string DayName { get; set; }

        public virtual ICollection<TblClass> TblClasses { get; set; }
    }
}
