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
        public IActionResult AddNewCourse()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> AddNewCourse(CourseDTO dto)
        {
            var data = await repo.AddNewCourse(dto);
            return Ok(data);
        }

    }
}