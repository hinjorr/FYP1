using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class RoleDTO
    {
          public int RoleId { get; set; }
        public string RoleName { get; set; }
        public ulong? IsActive { get; set; }
    }
}