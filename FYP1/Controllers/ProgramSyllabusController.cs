using System.Collections.Generic;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{

    public class ProgramSyllabusController : Controller
    {
        private readonly IProgramSyllabus repo;

        public ProgramSyllabusController(IProgramSyllabus repo)
        {
            this.repo = repo;
        }

         [AuthenticateFilter]
        [HttpGet("NewSyllabus")]
        public IActionResult AddNewSyllabus()
        {
            return View();
        }

        [HttpGet("GetProgramSyllabus/{id}")]
        public async Task<IActionResult> GetProgramSyllabus(int id)
        {
            var data = await repo.GetProgramSyllabus(id);
            return Ok(data);
        }

        [HttpPost]
        public async Task<IActionResult> AddNewSyllabus(List<ProgramSyllabusDTO> dto)
        {

            var data = await repo.AddSyllabus(dto);
            return Ok(data);
        }
        [HttpPost]
        public async Task<IActionResult> GetCrHr(CourseDTO dto)
        {
            var crhr = await repo.GetCrHr(dto);
            return Ok(crhr);
        }

    }
}