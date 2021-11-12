using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
    public class AuthenticationController : Controller
    {
        private readonly IAuthentication repo;

        public AuthenticationController(IAuthentication repo)
        {
            this.repo = repo;

        }
        // [HttpGet("Login")]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost("LoginPost")]
        public async Task<IActionResult> Login(UserDTO dto)
        {
            var model = await repo.Login(dto);
            if (model.boolchk)
            {
                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, model.principle);
                return Ok(true);
            }
            else
            {
                return Ok(false);
            }
        }


    }
}