using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblNotificaionTo
    {
        public int Id { get; set; }
        public int? NotificationId { get; set; }
        public int? To { get; set; }
        public bool? IsSeen { get; set; }

        public virtual TblNotification Notification { get; set; }
        public virtual TblUser ToNavigation { get; set; }
    }
}
