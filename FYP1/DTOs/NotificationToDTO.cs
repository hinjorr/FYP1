using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class NotificationToDTO
    {
        public int Id { get; set; }
        public int? NotificationId { get; set; }
        public int? To { get; set; }
        public bool? IsSeen { get; set; }
    }
}