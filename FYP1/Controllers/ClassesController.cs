using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{



    public class ClassesController : Controller
    {
        private readonly IClasses repo;

        public ClassesController(IClasses repo)
        {
            this.repo = repo;
        }

        [AuthenticateFilter]
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

        [AuthenticateFilter]
        [HttpGet("ViewClass/{id}")]
        public IActionResult ViewClass()
        {

            return View();
        }

        [AuthenticateFilter]
        [HttpGet("ViewAllClasses")]
        public IActionResult ViewClasses()
        {
            return View();
        }


        [HttpGet("GetClass/{id}")]
        public async Task<IActionResult> GetSingleClass(int id)
        {
            var data = await repo.ClassInformation(id);
            return Ok(data);
        }

        public async Task<IActionResult> ViewClassesbyId()
        {
            var classes = await repo.ViewClassesbyId();
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

        [Route("DeleteClass/{id}")]
        public async Task<IActionResult> DeleteClass(int id)
        {
            var chk = await repo.DeleteClass(id);
            if (chk)
            {
                return Ok(new { type = "success", msg = "Class Deleted!" });
            }
            else
            {
                return Ok(new { type = "error", msg = "Class deletion failed!" });
            }
        }

        [AuthenticateFilter]
        [HttpGet("Class/{id}")]
        public IActionResult ClassInformation()
        {
            return View();
        }

        public async Task<IActionResult> GetSessionsForClass(int Cid)
        {
            var data = await repo.GetSessionsforClass(Cid);
            return Ok(data);
        }

    }
}