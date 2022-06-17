using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class Message
    {
        public int Id { get; set; }
        public string UserTo { get; set; }
        public string UserFrom { get; set; }
        public string Body { get; set; }
        public DateTime Date { get; set; }
        public string Opened { get; set; }
        public string Viewed { get; set; }
        public string Deleted { get; set; }
    }
}
