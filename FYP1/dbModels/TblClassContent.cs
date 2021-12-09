using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblClassContent
    {
        public int ContentId { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }
        public string ContentName { get; set; }
        public string ContentLink { get; set; }

        public virtual TblClass Class { get; set; }
        public virtual TblClassSession Session { get; set; }
    }
}
