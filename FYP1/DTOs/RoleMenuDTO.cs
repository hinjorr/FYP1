using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class RoleMenuDTO
    {
        public int Id { get; set; }
        public int? MenuId { get; set; }
        public int? RoleId { get; set; }
        public bool? Check { get; set; }
    }
}