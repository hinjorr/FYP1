using System.Collections.Generic;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    // [ApiController]
    // [Route("api/[controller]")]

    // [Authorize(Roles ="Admin")]
    public class ProgramSyllabusController : Controller
    {
        private readonly IProgramSyllabus repo;

        public ProgramSyllabusController(IProgramSyllabus repo)
        {
            this.repo = repo;
        }

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
            if (dto != null)
            {
                var chk = await repo.AddSyllabus(dto);
                if (chk)
                {
                    return Ok(new { type = "success", msg = "New Syllabus Added!" });
                }
                else
                {
                    return Ok(new { type = "error", msg = "Registration Failed!" });
                }
            }
            else
            {
                return Ok(new { type = "warning", msg = "Please Fill the Form!" });
            }

        }
        [HttpPost]
        public async Task<IActionResult> GetCrHr(CourseDTO dto)
        {
            var crhr = await repo.GetCrHr(dto);
            return Ok(crhr);
        }

    }
}