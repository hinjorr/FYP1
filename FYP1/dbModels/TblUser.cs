using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblUser
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public int RoleId { get; set; }
        public int ProfileId { get; set; }
        public ulong? IsActive { get; set; }
        public string UserDate { get; set; }
    }
}
