using System.Collections.Generic;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    // [ApiController]
    // [Route("api/[controller]")]

    public class ProgramSyllabusController : Controller
    {
        private readonly IProgramSyllabus repo;

        public ProgramSyllabusController(IProgramSyllabus repo)
        {
            this.repo = repo;
        }

        [HttpGet]
        public IActionResult AddNewSyllabus()
        {
            return View();
        }

        [HttpPost("AddNewSyllabus")]
        public async Task<IActionResult> AddNewSyllabus(List<ProgramSyllabusDTO> dto)
        {
            var chk = await repo.AddSyllabus(dto);
            return Ok(chk);
        }
        [HttpPost]
        public async Task<IActionResult> GetCrHr(CourseDTO dto)
        {
            var crhr = await repo.GetCrHr(dto);
            return Ok(crhr);
        }

    }
}