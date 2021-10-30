using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
    public class UserValidationController : Controller
    {
        private readonly IUserValidation repo;

        public UserValidationController(IUserValidation _repo)
        {
            repo = _repo;
        }
        public async Task<IActionResult> NICCheck(ProfileDTO dto)
        {
            var data=await repo.CheckNIC(dto);
            return Ok(data);
        }


    }
}