using System;
using System.Net.Http;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    public class AuthenticationController : Controller
    {
        private readonly IAuthentication repo;
        private readonly IHttpContextAccessor _httpContext;
        private readonly LMS_DBContext db;

        public AuthenticationController(IAuthentication repo, IHttpContextAccessor httpContext, LMS_DBContext db)
        {
            this.repo = repo;
            _httpContext = httpContext;
            this.db = db;
        }
        public IActionResult Login()
        {
            //ye chk krne k liye h k agr user already login hua wa h tw usse /Home pr redirect kr den agr nh login tw phr yhi /Login pr hi rhe
            var data = _httpContext.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
            if (data != null)
            {
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return View();
            }
        }

        [HttpPost("LoginPost")]
        public async Task<IActionResult> LoginPost(UserDTO dto)
        {
            var chk = await repo.Login(dto);
            return Ok(chk);
        }


        [HttpGet("Logout")]
        public IActionResult Logout()
        {

            _httpContext.HttpContext.Session.Remove("UserDetails");
            db.DisposeAsync();
            return View("Login");
        }

        public async Task<IActionResult> ForgetPassword(string username, string email)
        {
            var data = await repo.ForgetPassword(username, email);
            return Ok(data);
        }
        public async Task<IActionResult> ResetPassword(UserDTO dto)
        {
            var data = await repo.ResetPassword(dto);
            return Ok(data);
        }

        [HttpGet("ResetPassword/{id}")]
        public IActionResult ResetPassword()
        {
            var data = _httpContext.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
            if (data != null)
            {
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return View();
            }
        }
        // [HttpGet("404Error")]
        public IActionResult Error404Page()
        {
            return View();
        }

        [HttpGet("ExceptionPage")]
        public IActionResult ExceptionPage()
        {
            var exceptionDetail = _httpContext.HttpContext.Features.Get<IExceptionHandlerPathFeature>();
            // ViewBag.
            return View();
        }


    }
}