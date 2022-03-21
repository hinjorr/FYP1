using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class Message
    {
        public int Id { get; set; }
        public int UserTo { get; set; }
        public int UserFrom { get; set; }
        public string Body { get; set; }
        public DateTime Date { get; set; }
        public bool? IsSeen { get; set; }

        public virtual TblUser UserFromNavigation { get; set; }
        public virtual TblUser UserToNavigation { get; set; }
    }
}
