using System.Net.Http;
using System.Threading.Tasks;
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

        public AuthenticationController(IAuthentication repo, IHttpContextAccessor httpContext)
        {
            this.repo = repo;
            _httpContext = httpContext;
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
            return View("Login");
        }

        [HttpGet("404Error")]
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