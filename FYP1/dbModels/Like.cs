using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class Like
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public int PostId { get; set; }
    }
}
