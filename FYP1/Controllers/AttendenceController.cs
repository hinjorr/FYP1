using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{


    public class AttendenceController : Controller
    {
        private readonly IAttendence repo;

        public AttendenceController(IAttendence _repo)
        {
            repo = _repo;
        }

        [AuthenticateFilter]
        [HttpGet("MarkAttendence")]
        public IActionResult MarkAttedence()
        {
            return View();
        }

        [AuthenticateFilter]
        [HttpGet("AttendenceReport")]
        public IActionResult AttendenceReport()
        {
            return View();
        }

        public async Task<IActionResult> GetAttendenceStudents(AttendenceDTO dto)
        {
            var studetns = await repo.GetAttendenceStudents(dto);
            return Ok(studetns);
            // return Json(new { data = studetns });
        }
        public async Task<IActionResult> MarkAttendence(List<AttendenceDTO> dto)
        {
            var studetns = await repo.MarkAttendence(dto);
            return Ok(studetns);
        }
        public async Task<IActionResult> StudentAttendenceReport()
        {

            var data = await repo.StudentAttendenceReport();
            return Ok(data);
        }

    }
}