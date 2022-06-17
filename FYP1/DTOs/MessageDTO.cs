using System;

namespace FYP1.DTOs
{
    public class MessageDTO
    {
        public int Id { get; set; }
        public string UserTo { get; set; }
        public string UserFrom { get; set; }
        public string Body { get; set; }
        public DateTime Date { get; set; }
        public string Opened { get; set; }
        public string Viewed { get; set; }
        public string Deleted { get; set; }
        public int TotalUnread { get; set; }
        public string Timespan { get; set; }
        public bool? IsSeen { get; set; }
        public bool Mine { get; set; }
        
    }
}