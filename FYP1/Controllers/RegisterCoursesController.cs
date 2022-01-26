using Microsoft.AspNetCore.Mvc;
using FYP1.Helpers__Filters;
using FYP1.DTOs;
using FYP1.Repository;
using System.Threading.Tasks;

namespace FYP1.Controllers
{

    public class RegisterCoursesController : Controller
    {
        private readonly IRegisterCourses repo;

        public RegisterCoursesController(IRegisterCourses _repo)
        {
            repo = _repo;
        }

         [AuthenticateFilter]
        [HttpGet("EnrollStdents")]
        public IActionResult EnrollStdents()
        {
            return View();
        }

         [AuthenticateFilter]
        [HttpGet("EnrollFaculty")]
        public IActionResult EnrollFaculty()
        {
            return View();
        }

        public async Task<IActionResult> ResgisterStudent(StudentCourseRegistrationDTO dto)
        {
            //student
            var data = await repo.ResgisterStudent(dto);
            return Ok(data);
        }
        public async Task<IActionResult> DropCourse(StudentCourseRegistrationDTO dto)
        {
            //student
            var data = await repo.DropCourse(dto);
            return Ok(data);
        }
        public async Task<IActionResult> DropFacultyCourse(FacultyCourseRegistrationDTO dto)
        {
            var data = await repo.DropFacultyCourse(dto);
            return Ok(data);
        }
        public async Task<IActionResult> ResgisterFaculty(FacultyCourseRegistrationDTO dto)
        {
            var data = await repo.ResgisterFaculty(dto);
            return Ok(data);
        }

        public async Task<IActionResult> GetClassesByCourse(int id)
        {
            var classes = await repo.GetClassesByCourse(id);
            return Ok(classes);
        }

        public async Task<IActionResult> GetRegisteredCourses(string username)
        {
            //student
            var data = await repo.GetRegisteredCourses(username);
            return Ok(data);
        }
        public async Task<IActionResult> GetFacultyRegisteredCourses(string username)
        {
            //faculty
            var data = await repo.GetFacultyRegisteredCourses(username);
            return Ok(data);
        }

    }
}