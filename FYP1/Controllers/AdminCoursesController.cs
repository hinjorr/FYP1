using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
    public class AdminCoursesController : Controller
    {
       
        
        public IActionResult AddNewCourse()
        {
            return View();
        }
        
        public IActionResult ViewCourses()
        {
            return View();
        }
         public IActionResult AssignNewClass()
        {
            return View();
        }
         public IActionResult ViewClasses()
        {
            return View();
        }
        public IActionResult EnrollUsers()
        {
            return View();
        }

    }
}