using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class Post
    {
        public int Id { get; set; }
        public string Body { get; set; }
        public string AddedBy { get; set; }
        public string UserTo { get; set; }
        public DateTime DateAdded { get; set; }
        public string UserClosed { get; set; }
        public string Deleted { get; set; }
        public int Likes { get; set; }
        public string Image { get; set; }
    }
}
