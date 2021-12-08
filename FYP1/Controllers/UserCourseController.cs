using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    public class UserCourseController : Controller
    {

        [HttpGet("ViewClass/{id}")]
        public IActionResult ViewCourse(int id)
        {
            ViewData["ClassID"]=id;
            return View();
        }
        [HttpGet("ViewAllClasses")]
        public IActionResult ViewAllClasses()
        {
            return View();
        }

        // public async Task<IActionResult> GetClassesList()
        // {
        //     return View();
        // }
    }
}