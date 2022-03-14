using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IChat
    {
        Task<List<GeneralDTO>> GetAllUsers();
        Task<GeneralDTO> SingleChat(int userId);
    }
}