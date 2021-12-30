using Microsoft.AspNetCore.Mvc;
using FYP1.Helpers__Filters;

namespace FYP1.Controllers
{
    [AuthorizedUserFilter]

    public class RegisterCoursesController : Controller
    {

        [HttpGet("EnrollStdents")]
        public IActionResult EnrollStdents()
        {
            return View();
        }

        [HttpGet("EnrollFaculty")]
        public IActionResult EnrollFaculty()
        {
            return View();
        }


    }
}