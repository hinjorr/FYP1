using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{

    public class AdminClassesController : Controller
    {
        private readonly IClasses repo;

        public AdminClassesController(IClasses repo)
        {
            this.repo = repo;
        }
        [HttpGet("AssignClasses")]
        public IActionResult AssignNewClass()
        {
            return View();
        }
        [HttpPost("AssignClass")]
        public async Task<IActionResult> AssignNewClass(ClassDTO dto)
        {
            var chk=await repo.AddNewClass(dto);
            return Ok(chk);
        }
        
    }
}