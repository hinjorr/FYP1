using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class StudentDTO
    {
        public int StudentId { get; set; }
        public int ProgramId { get; set; }
        public int? UserId { get; set; }
        public ulong? IsActive { get; set; }
    }
}