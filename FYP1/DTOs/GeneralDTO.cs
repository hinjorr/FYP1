using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class GeneralDTO
    {
        public bool boolchk { get; set; }
        public ClaimsPrincipal principle { get; set; }
        public UserDTO User { get; set; }
        public ProfileDTO Profile { get; set; }
        
    }
}