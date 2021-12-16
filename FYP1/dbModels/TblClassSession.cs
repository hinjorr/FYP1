﻿using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblClassSession
    {
        public TblClassSession()
        {
            TblClassContents = new HashSet<TblClassContent>();
        }

        public int SessionId { get; set; }
        public int? SemesterId { get; set; }
        public string SessionName { get; set; }

        public virtual TblSemester Semester { get; set; }
        public virtual ICollection<TblClassContent> TblClassContents { get; set; }
    }
}