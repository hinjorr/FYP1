using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblAttendence
    {
        public int Id { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }
        public int? UserId { get; set; }
        public string UserName { get; set; }
        public ulong? _1st { get; set; }
        public ulong? _2nd { get; set; }

        public virtual TblClass Class { get; set; }
        public virtual TblClassSession Session { get; set; }
        public virtual TblUser User { get; set; }
    }
}
