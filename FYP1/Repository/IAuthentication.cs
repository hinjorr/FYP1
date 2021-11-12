using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IAuthentication
    {
        Task<GeneralDTO> Login(UserDTO dto);
    }
}