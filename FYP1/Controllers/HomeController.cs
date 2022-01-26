using FYP1.Helpers__Filters;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{

    public class HomeController : Controller
    {
         [AuthenticateFilter]
        [HttpGet("Home")]
        public IActionResult Index()
        {
            return View();
        }

    }
}
