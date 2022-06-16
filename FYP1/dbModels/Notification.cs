using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class Notification
    {
        public int Id { get; set; }
        public string UserTo { get; set; }
        public string UserFrom { get; set; }
        public string Message { get; set; }
        public string Link { get; set; }
        public DateTime Datetime { get; set; }
        public string Opened { get; set; }
        public string Viewed { get; set; }
    }
}
