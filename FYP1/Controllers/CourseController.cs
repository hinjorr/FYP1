using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    public class CourseController : Controller
    {

        public IActionResult ViewCourse()
        {
            return View();
        }
        public IActionResult ViewAllClasses()
        {
            return View();
        }
        
    }
}