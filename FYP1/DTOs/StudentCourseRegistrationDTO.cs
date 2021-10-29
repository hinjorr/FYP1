using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class StudentCourseRegistrationDTO
    {
         public int ScrId { get; set; }
        public int? StudentId { get; set; }
        public int? ElgibiltyId { get; set; }

    }
}