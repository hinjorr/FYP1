using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IChat
    {
        Task<List<GeneralDTO>> GetAllUsers();
        Task<GeneralDTO> OpenChat(int userId);
        Task<List<MessageDTO>> GetMessages(int UserId);
        Task SendMessage(Message dto);
    }
}