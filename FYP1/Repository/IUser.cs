using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IUser
    {
        Task<bool> AddNewUser(ProfileDTO dto);
        Task<string> Role_NIC_Check(ProfileDTO dto);
        Task<List<ProfileDTO>> GetUsers();
        Task<bool> DeleteUser(string username);

       // Task<GeneralDTO> GetProfile(string username);
    }
}