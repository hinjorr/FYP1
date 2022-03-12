using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblNotificationType
    {
        public TblNotificationType()
        {
            TblNotifications = new HashSet<TblNotification>();
        }

        public int TypeId { get; set; }
        public string Type { get; set; }
        public string Icon { get; set; }

        public virtual ICollection<TblNotification> TblNotifications { get; set; }
    }
}
