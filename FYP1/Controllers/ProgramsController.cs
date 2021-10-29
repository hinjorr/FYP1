using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
    public class ProgramsController : Controller
    {

        public IActionResult AddNewProgram()
        {
            return View();
        }
        public IActionResult ViewPrograms()
        {
            return View();
        }
        public IActionResult EnrollClasses()
        {
            return View();
        }
        public IActionResult ProgramSyllabus()
        {
            return View();
        }

    }
}