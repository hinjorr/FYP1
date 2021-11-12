using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    public class UserCourseController : Controller
    {

        [HttpGet("ViewClass")]
        public IActionResult ViewCourse()
        {
            return View();
        }
        [HttpGet("ViewAllClasses")]
        public IActionResult ViewAllClasses()
        {
            return View();
        }

    }
}