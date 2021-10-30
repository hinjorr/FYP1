using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
    public class DropDownController : Controller
    {
        private readonly IDropDown repo;

        public DropDownController(IDropDown _repo)
        {
            repo = _repo;
        }
        public async Task<IActionResult> GetRoles()
        {
            var data = await repo.GetRole();
            return Ok(data);
        }
        public async Task<IActionResult> GetPrograms()
        {
            var data=await repo.GetPrograms();
            return Ok(data);
        }

    }
}