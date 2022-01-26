using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{

    public class MarksController : Controller
    {
        private readonly IMarks repo;

        public MarksController(IMarks _repo)
        {
            repo = _repo;
        }

         [AuthenticateFilter]
        [HttpGet("ViewResults")]
        public IActionResult StudentTestResults()
        {
            return View();
        }

         [AuthenticateFilter]
        [HttpGet("UploadResults")]
        public IActionResult UploadTestResults()
        {
            return View();
        }
        public async Task<IActionResult> UploadMarks(List<MarksDTO> dto)
        {
            var data = await repo.UploadMarks(dto);
            return Ok(data);
        }
        public async Task<IActionResult> GetResults(MarksDTO dto)
        {
            var data = await repo.GetResults(dto);
            return Ok(data);
        }

    }
}