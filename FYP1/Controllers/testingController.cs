using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class testingController : ControllerBase
    {
        private readonly ISemester repo;

        public testingController(ISemester repo)
        {
            this.repo = repo;

        }
        [HttpPost("AddClassSessions")]
        public async Task<IActionResult> AddClassSessions(List<ClassSessionDTO> dto)
        {
            var data = await repo.AddClassSession(dto);
            return Ok(data);
            // return Ok(dto);
        }
    }
}
