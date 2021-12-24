using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using FYP1.Helpers__Filters;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{

    [AuthorizedUserFilter]
    public class AttendenceController : Controller
    {
        [HttpGet("MarkAttendence")]
        public IActionResult MarkAttedence()
        {
            return View();
        }

    }
}