using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class ProfileDTO
    {
        public int ProfileId { get; set; }
        public string Name { get; set; }
        public string FatherName { get; set; }
        public string Email { get; set; }
        public string Nic { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public string Picture { get; set; }
        public string DoB { get; set; }
        public string Gender { get; set; }
        public string PhoneNumber { get; set; }
        public ulong? IsActive { get; set; }
        public UserDTO User { get; set; }
        public StudentDTO Student { get; set; }   
    }
}