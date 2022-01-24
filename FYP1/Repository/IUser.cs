using System.Collections.Generic;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IUser
    {
        Task<GeneralDTO> RegisterUser(GeneralDTO dto);
        Task<GeneralDTO> Role_NIC_Check(GeneralDTO dto);
        Task<List<GeneralDTO>> GetUsers();
        Task<GeneralDTO> DeleteUser(string username);
        Task<GeneralDTO> GetProfile(string username);
    }
}
