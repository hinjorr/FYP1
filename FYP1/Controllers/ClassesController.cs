using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{

    [AuthorizedUserFilter]

    public class ClassesController : Controller
    {
        private readonly IClasses repo;

        public ClassesController(IClasses repo)
        {
            this.repo = repo;
        }

        [HttpGet("AssignClasses")]
        public IActionResult AssignNewClass()
        {
            return View();
        }

        public async Task<IActionResult> AssignNewClass(ClassDTO dto)
        {
            if (dto.CourseId != null)
            {
                var chk = await repo.AddNewClass(dto);
                return Ok(chk);
            }
            return Ok(false);
        }

        [HttpGet("ViewClass/{id}")]
        public IActionResult ViewClass()
        {

            return View();
        }

        [HttpGet("ViewAllClasses")]
        public IActionResult ViewClasses()
        {
            return View();
        }

        [HttpGet("GetClass/{id}")]
        public async Task<IActionResult> GetSingleClass(int id)
        {
            var data = await repo.GetSingleClass(id);
            return Ok(data);
        }
        public async Task<IActionResult> ViewAllClasses()
        {
            var classes = await repo.ViewAllClass();
            return Ok(classes);
        }
        public async Task<IActionResult> ViewClassesbyId(string username)
        {
            var classes = await repo.ViewClassesbyId(username);
            return Ok(classes);
        }

        public async Task<IActionResult> ViewStudentbyClass(int cid)
        {
            var classes = await repo.ViewStudentbyClass(cid);
            return Json(new { data = classes });
        }

        public async Task<IActionResult> ViewAllActiveCourses()
        {
            var courses = await repo.ViewAllActiveCourses();
            return Ok(courses);
        }

        public async Task<IActionResult> GetClassesByCourse(int id)
        {
            var classes = await repo.GetClassesByCourse(id);
            return Ok(classes);
        }

        public async Task<IActionResult> ViewAllClassesinJson()
        {
            var classes = await repo.ViewAllClass();
            return Json(new { data = classes });
        }



    }
}