using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
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
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> AddNewSyllabus(ProgramSyllabusDTO dto)
        {
            // var chk = await repo.AddSyllabus(dto);
            return Ok(dto); 
        }

    }
}