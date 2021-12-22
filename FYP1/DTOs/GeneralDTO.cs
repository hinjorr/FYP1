using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class GeneralDTO
    {
        public bool ResponseBool { get; set; }
        public string ResponceMsg { get; set; }

        public ProfileDTO Profile { get; set; }
        public UserDTO User { get; set; }
        public RoleDTO Role { get; set; }

    }
}