using System;

namespace FYP1.DTOs
{
    public class MessageDTO
    {
        public int Id { get; set; }
        public int UserTo { get; set; }
        public int UserFrom { get; set; }
        public int TotalUnread { get; set; }
        public string Body { get; set; }
        public string Timespan { get; set; }
        public DateTime Date { get; set; }
        public bool? IsSeen { get; set; }

        public bool Mine { get; set; }
    }
}