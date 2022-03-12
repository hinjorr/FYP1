using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class NotificationDTO
    {
        public int NotificationId { get; set; }
        public string From { get; set; }
        public int? TypeId { get; set; }
        public string Message { get; set; }
        public DateTime? UploadedTime { get; set; }
        public string Timespan { get; set; }
        public int? ClassId { get; set; }
    }
}