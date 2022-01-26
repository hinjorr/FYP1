using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{

    public class RolesController : Controller
    {
        private readonly IRoleManagement repo;

        public RolesController(IRoleManagement _repo)
        {
            repo = _repo;
        }

         [AuthenticateFilter]
        [HttpGet("Permissions")]
        public IActionResult AssignPermissions()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> AssignPermissions(List<RoleMenuDTO> dto)
        {
            var data = await repo.AssignPermission(dto);
            return Ok(data);
        }

        public async Task<IActionResult> GetMenus(int id)
        {
            var _data = await repo.GetScreens(id);
            return Json(new { data = _data });
        }

        public async Task<IActionResult> CreateRole(RoleDTO dto)
        {
            var data = await repo.CreateRole(dto);
            return Ok(data);
        }
        public async Task<IActionResult> DeleteRole(int id)
        {
            var data = await repo.DeleteRole(id);
            return Ok(data);
        }
        public async Task<IActionResult> GetSingleRole(int id)
        {
            var data = await repo.GetSingleRole(id);
            return Ok(data);
        }

    }
}