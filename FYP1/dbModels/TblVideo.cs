using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblVideo
    {
        public int VideoId { get; set; }
        public string YtubeVideoId { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }

        public virtual TblClass Class { get; set; }
        public virtual TblClassSession Session { get; set; }
    }
}
