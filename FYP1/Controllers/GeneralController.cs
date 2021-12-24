using System.Threading.Tasks;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{

    public class GeneralController : Controller
    {
        private readonly IGeneral repo;

        public GeneralController(IGeneral _repo)
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
        public async Task<IActionResult> TotalUsers()
        {
            var data = await repo.ToTalUsers();
            return Ok(data);
        }
        public async Task<IActionResult> ToTalStudents()
        {
            var data = await repo.ToTalStudents();
            return Ok(data);
        }
        public async Task<IActionResult> ToTalFaculty()
        {
            var data = await repo.ToTalFaculty();
            return Ok(data);
        }
        public async Task<IActionResult> ToTalAdmins()
        {
            var data = await repo.ToTalAdmins();
            return Ok(data);
        }
        public async Task<IActionResult> ToTalPrograms()
        {
            var data = await repo.ToTalPrograms();
            return Ok(data);
        }
        public async Task<IActionResult> ToTalCourses()
        {
            var data = await repo.ToTalCourses();
            return Ok(data);
        }
        public async Task<IActionResult> ToTalActiveClasses()
        {
            var data = await repo.ToTalActiveClasses();
            return Ok(data);
        }

    }
}