using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblRole
    {
        public TblRole()
        {
            TblUsers = new HashSet<TblUser>();
        }

        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public ulong? IsActive { get; set; }

        public virtual ICollection<TblUser> TblUsers { get; set; }
    }
}
