using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
       public class MarksController : Controller
    {
     
         public IActionResult StudentTestResults()
        {
            return View();
        }
         public IActionResult UploadTestResults()
        {
            return View();
        }

    }
}