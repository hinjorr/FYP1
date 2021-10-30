using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Models
{
    public interface IUserValidation
    {
     Task<ProfileDTO> CheckNIC(ProfileDTO dto);
    }
}