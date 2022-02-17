﻿using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblFile
    {
        public int FileId { get; set; }
        public string FilePath { get; set; }
        public string DisplayName { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }

        public virtual TblClass Class { get; set; }
        public virtual TblClassSession Session { get; set; }
    }
}
