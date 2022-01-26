using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblParentMenu
    {
        public TblParentMenu()
        {
            TblMenus = new HashSet<TblMenu>();
        }

        public int ParentId { get; set; }
        public string DisplayName { get; set; }
        public string Icon { get; set; }

        public virtual ICollection<TblMenu> TblMenus { get; set; }
    }
}
