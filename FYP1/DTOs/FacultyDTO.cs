using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class FacultyDTO:GeneralDTO
    {
        public int FacultyId { get; set; }
        public int? UserId { get; set; }
    }
}