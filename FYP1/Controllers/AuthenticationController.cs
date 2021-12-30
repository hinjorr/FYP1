using System.Net.Http;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
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

        [HttpGet("404Error")]
        public IActionResult Error404Page()
        {
            return View();
        }


        [HttpPost("LoginPost")]
        public async Task<IActionResult> LoginPost(UserDTO dto)
        {

            var chk = await repo.Login(dto);
            if (chk == true)
            {
                //   var data = _httpContext.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
               
                //   data.Role.RoleId
                  
                return Ok(new { icon = "success", text = "Login Succesfull!" });
            }
            else
            {
                return Ok(new { icon = "error", text = "Username/Password Invalid!", userData = false });
            }

        }
        [HttpGet("Logout")]
        public IActionResult Logout()
        {
            _httpContext.HttpContext.Session.Remove("UserDetails");
            return View("Login");
        }


    }
}