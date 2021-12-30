using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace FYP1.DTOs
{
    public class ClassDTO:GeneralDTO
    {

        public int ClassId { get; set; }
        public int? ClassStrength { get; set; }
        public int? CourseId { get; set; }
        public string ClassImage { get; set; }
        public IFormFile GetImage { get; set; }
        public int? SemesterId { get; set; }
        public int? ProgramId { get; set; }
        public int? DayId { get; set; }
        public int? TimeId { get; set; }
        public ulong? IsActive { get; set; }
       

    }
}