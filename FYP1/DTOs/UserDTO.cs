using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using Microsoft.AspNetCore.Http;

namespace FYP1.DTOs
{
    public class UserDTO
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public int RoleId { get; set; }
        public int ProfileId { get; set; }
        public bool IsActive { get; set; }
        public string UserDate { get; set; }

        public ProfileDTO Profile { get; set; }
        public RoleDTO Role { get; set; }

    }
}