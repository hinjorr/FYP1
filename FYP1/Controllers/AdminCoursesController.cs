using System.Net;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    [AuthenticateFilter]

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
                if (chk)
                {
                    return Ok(new { type = "success", msg = "Course Updated successfully!" });
                }
                else
                {
                    return Ok(new { type = "error", msg = chk });
                }

            }
            else
            {
                var data = await repo.AddNewCourse(dto);
                if (data)
                {
                    return Ok(new { type = "success", msg = "Course Registered!" });
                }
                else
                {
                    return Ok(new { type = "error", msg = data });
                }

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

        public async Task<IActionResult> DeleteCourse(int id)
        {
            var chk = await repo.DeleteCourse(id);
            if (chk)
            {
                return Ok(new { type = "success", msg = "Course Deleted!" });
            }
            else
            {
                return Ok(new { type = "error", msg = "Course Deletion failed!" });
            }
        }
    }
}