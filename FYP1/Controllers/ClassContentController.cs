using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    public class ClassContentController : Controller
    {
        private readonly IClassContent repo;

        public ClassContentController(IClassContent _repo)
        {
            repo = _repo;
        }
        public async Task<IActionResult> AddUrl(UrlDTO dto)
        {
            var data = await repo.AddUrl(dto);
            return Ok(data);
        }
        public async Task<IActionResult> GetUrls(int sessionId, int classId)
        {
            var data = await repo.GetUrls(sessionId, classId);
            return Ok(data);
        }
        public async Task<IActionResult> GetSingleUrl(int id)
        {
            var data = await repo.GetSingleUrl(id);
            return Ok(data);
        }

        public IActionResult DeleteUrl(int id)
        {
            repo.DeleteUrl(id);
            return Ok();
        }
    }
}
