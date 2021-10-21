using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
    public class DepartmentController : Controller
    {

        public IActionResult AddNewDpt()
        {
            return View();
        }
        public IActionResult ViewDpt()
        {
            return View();
        }
        public IActionResult EnrollClasses()
        {
            return View();
        }


    }
}