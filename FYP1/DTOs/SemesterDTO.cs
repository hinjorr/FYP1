using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class SemesterDTO : GeneralDTO
    {
        public int SemesterId { get; set; }
        public string SemesterName { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public ulong? IsActive { get; set; }



    }
}