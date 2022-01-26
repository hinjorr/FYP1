using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{

    public class ProgramsController : Controller
    {
        private readonly IPrograms repo;

        public ProgramsController(IPrograms _repo)
        {
            repo = _repo;
        }

         [AuthenticateFilter]
        [HttpGet("AddNewProgram")]
        public IActionResult AddNewProgram()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> AddNewProgram(ProgramDTO dto)
        {

            var data = await repo.AddProgram(dto);
            if (data)
            {
                return Ok(new { type = "success", msg = "Program Registered!" });
            }
            else
            {
                return Ok(new { type = "error", msg = "Registration Failed!" });
            }
        }

        public async Task<IActionResult> GetPrograms()
        {
            var programs = await repo.GetPrograms();
            return Json(new { data = programs });
        }

    }
}