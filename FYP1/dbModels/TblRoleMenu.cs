using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblRoleMenu
    {
        public int Id { get; set; }
        public int? MenuId { get; set; }
        public int? RoleId { get; set; }

        public virtual TblMenu Menu { get; set; }
        public virtual TblRole Role { get; set; }
    }
}
