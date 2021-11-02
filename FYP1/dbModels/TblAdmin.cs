using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblAdmin
    {
        public int AdminId { get; set; }
        public int? UserId { get; set; }
    }
}
