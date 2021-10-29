using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblTime
    {
        public TblTime()
        {
            TblClasses = new HashSet<TblClass>();
        }

        public int TimeId { get; set; }
        public string TimeName { get; set; }

        public virtual ICollection<TblClass> TblClasses { get; set; }
    }
}
