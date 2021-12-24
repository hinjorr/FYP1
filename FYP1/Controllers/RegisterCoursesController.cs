using System.Net;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using FYP1.Helpers__Filters;

namespace FYP1.Controllers
{
        [AuthorizedUserFilter]

    public class RegisterCoursesController : Controller
    {

        [HttpGet("RegisterCourse")]
        public IActionResult RegsiterCourse()
        {
            return View();
        }

    }
}