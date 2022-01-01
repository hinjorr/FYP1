using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblMenu
    {
        public TblMenu()
        {
            TblRoleMenus = new HashSet<TblRoleMenu>();
        }

        public int MenuId { get; set; }
        public string ControllerAction { get; set; }

        public virtual ICollection<TblRoleMenu> TblRoleMenus { get; set; }
    }
}
