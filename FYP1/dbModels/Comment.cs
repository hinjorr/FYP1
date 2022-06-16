using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class Comment
    {
        public int Id { get; set; }
        public string PostBody { get; set; }
        public string PostedBy { get; set; }
        public string PostedTo { get; set; }
        public DateTime DateAdded { get; set; }
        public string Removed { get; set; }
        public int PostId { get; set; }
    }
}
