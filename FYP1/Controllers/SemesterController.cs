using System.Collections.Generic;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    [AuthorizedUserFilter]

    public class SemesterController : Controller
    {
        private readonly ISemester repo;
        public SemesterController(ISemester repo)
        {
            this.repo = repo;

        }
        [HttpGet("Semester")]
        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> StartSemester(SemesterDTO dto)
        {
            var data = await repo.StartSemester(dto);
            return Ok(data);
        }
        [HttpPost]
        public async Task<IActionResult> EndSemester(SemesterDTO dto)
        {
            var data = await repo.EndSemester(dto);
            return Ok(data);
        }

        public async Task<IActionResult> GetCurrentSemester()
        {
            var data = await repo.GetCurrentSemester();
            return Ok(data);
        }
        public async Task<IActionResult> AddClassSessions(List<ClassSessionDTO> dto)
        {
            var data = await repo.AddClassSession(dto);
            if (data == true)
            {
                return Ok(new { type = "success", msg = "Sessions Added!" });
            }
            else
            {
                return Ok(new { type = "error", msg = "Server Error!" });
            }
        }
        public async Task<IActionResult> GetAlllSessions()
        {
            var data = await repo.GetAllSessions();
            return Ok(data);
        }

    }
}
