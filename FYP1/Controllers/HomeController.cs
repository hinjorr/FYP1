using FYP1.Helpers__Filters;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    [AuthenticateFilter]

    public class HomeController : Controller
    {
         
        [HttpGet("Home")]
        public IActionResult Index()
        {
            return View();
        }

    }
}
