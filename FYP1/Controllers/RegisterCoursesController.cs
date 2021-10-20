using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
    public class RegisterCoursesController : Controller
    {
      
        public IActionResult RegsiterCourse()
        {
            return View();
        }

    }
}