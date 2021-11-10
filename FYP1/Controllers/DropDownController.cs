using System.Threading.Tasks;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    public class DropDownController : Controller
    {
        private readonly IDropDown repo;

        public DropDownController(IDropDown _repo)
        {
            repo = _repo;
        }
        public async Task<IActionResult> GetRoles()
        {
            var data = await repo.GetRole();
            return Ok(data);
        }
        public async Task<IActionResult> GetPrograms()
        {
            var data = await repo.GetPrograms();
            return Ok(data);
        }
        public async Task<IActionResult> GetDays()
        {
            var data = await repo.GetDays();
            return Ok(data);
        }
        public async Task<IActionResult> GetTime()
        {
            var data = await repo.GetTime();
            return Ok(data);
        }
        public async Task<IActionResult> GetCourses()
        {
            var data = await repo.GetCourses();
            return Ok(data);
        }
        public async Task<IActionResult> GetCoursesFullName()
        {
            var data = await repo.GetCoursesFullName();
            return Ok(data);
        }
        [HttpGet("GetCoursesbyPrograms")]
        public async Task<IActionResult> GetCoursesbyPrograms(int id)
        {
            var data = await repo.GetCoursesbyPrograms(id);
            return Ok(data);
        }

    }
}