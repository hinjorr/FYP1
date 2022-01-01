using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class FacultyCourseRegistrationDTO : GeneralDTO
    {
        public int FcrId { get; set; }
        public int? UserId { get; set; }
        public string Username { get; set; }
        public int? ClassId { get; set; }
        public ulong? IsActive { get; set; }

    }
}