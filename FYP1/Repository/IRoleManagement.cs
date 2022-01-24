using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IRoleManagement
    {
        Task<GeneralDTO> CreateRole(RoleDTO dto);
        Task<List<GeneralDTO>> GetScreens(int Role_ID);
        Task<GeneralDTO> AssignPermission(List<RoleMenuDTO> dto);
        Task<GeneralDTO> GetSingleRole(int id);
        Task<GeneralDTO> DeleteRole(int id);
        Task<bool> CheckPermission(string _controller, string _action,int Role_ID);


    }
}