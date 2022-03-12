using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblNotification
    {
        public TblNotification()
        {
            TblNotificaionTos = new HashSet<TblNotificaionTo>();
        }

        public int NotificationId { get; set; }
        public string From { get; set; }
        public int? TypeId { get; set; }
        public string Message { get; set; }
        public DateTime? UploadedTime { get; set; }
        public int? ClassId { get; set; }

        public virtual TblNotificationType Type { get; set; }
        public virtual ICollection<TblNotificaionTo> TblNotificaionTos { get; set; }
    }
}
