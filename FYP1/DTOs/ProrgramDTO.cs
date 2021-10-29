using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class ProrgramDTO
    {
         public int ProgramId { get; set; }
        public string ProgramName { get; set; }
        public ulong? IsActive { get; set; }
    }
}