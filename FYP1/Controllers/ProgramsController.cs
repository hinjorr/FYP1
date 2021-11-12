using System.Threading.Tasks;
using FYP1.DTOs;
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

        [HttpGet("AddNewProgram")]
        public IActionResult AddNewProgram()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> AddNewProgram(ProgramDTO dto)
        {
           var data= await repo.AddProgram(dto);
            return Ok(data);
        }
       

    }
}