using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class FriendRequest
    {
        public int Id { get; set; }
        public string UserTo { get; set; }
        public string UserFrom { get; set; }
    }
}
