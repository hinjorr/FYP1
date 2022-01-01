using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class StudentCourseRegistrationDTO : GeneralDTO
    {
        public int ScrId { get; set; }
        public int UserId { get; set; }
        public int ClassId { get; set; }
        public string Username { get; set; }
        public ulong IsActive { get; set; }

    }
}