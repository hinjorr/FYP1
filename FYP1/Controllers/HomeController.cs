using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    // [Authorize]
    public class HomeController : Controller
    {
        // [Authorize(Roles ="Admin,Faculty,Student")]

        [HttpGet("Home")]
        public IActionResult Index()
        {
            return View();
        }

    }
}
