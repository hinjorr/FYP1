﻿using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblClassSession
    {
        public TblClassSession()
        {
            TblAssesments = new HashSet<TblAssesment>();
            TblAttendences = new HashSet<TblAttendence>();
            TblFiles = new HashSet<TblFile>();
            TblUrls = new HashSet<TblUrl>();
        }

        public int SessionId { get; set; }
        public int? SemesterId { get; set; }
        public string SessionName { get; set; }

        public virtual TblSemester Semester { get; set; }
        public virtual ICollection<TblAssesment> TblAssesments { get; set; }
        public virtual ICollection<TblAttendence> TblAttendences { get; set; }
        public virtual ICollection<TblFile> TblFiles { get; set; }
        public virtual ICollection<TblUrl> TblUrls { get; set; }
    }
}
