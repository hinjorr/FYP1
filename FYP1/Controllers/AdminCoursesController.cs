using System.Net;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    public class AdminCoursesController : Controller
    {
        private readonly ICourse repo;

        public AdminCoursesController(ICourse repo)
        {
            this.repo = repo;
        }

        [HttpGet("AddNewCourse")]
        public IActionResult AddNewCourse()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> AddNewCourse(CourseDTO dto)
        {
            if (dto.CourseId != 0)
            {
                var chk = await repo.UpdateDetails(dto);
                return Ok(chk);
            }
            else
            {
                var data = await repo.AddNewCourse(dto);
                return Ok(data);
            }

        }

        public async Task<JsonResult> GetCourses()
        {
            var courses = await repo.GetCourses();
            return Json(new { data = courses });
        }

        public async Task<IActionResult> GetCoursebyID(int id)
        {
            var course = await repo.GetCoursebyID(id);
            return Ok(course);
        }
    }
}