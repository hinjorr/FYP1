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
            return View();
        }

        [HttpGet("404Error")]
        public IActionResult Error404Page()
        {
            return View();
        }


        [HttpPost("LoginPost")]
        public async Task<IActionResult> Login(UserDTO dto)
        {

            var chk = await repo.Login(dto);
            if (chk == true)
            {
                // var data = _httpContext.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
                System.Console.WriteLine("masood");
                return Ok(new { icon = "success", text = "Login Succesfull!" });
            }
            else
            {
                return Ok(new { icon = "error", text = "Username/Password Invalid!" });
            }

        }
                    // HttpContext.Session.Remove("userObject");


    }
}