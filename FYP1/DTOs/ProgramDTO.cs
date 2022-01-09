using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class ProgramDTO
    {
         public int ProgramId { get; set; }
         public int Enrolled_Courses { get; set; }
         public int Enrolled_Classes { get; set; }
         public int Enrolled_Students { get; set; }
        public string ProgramFullName { get; set; }
        public string ProgramShortName { get; set; }
        public ulong? IsActive { get; set; }


    }
}