using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.Controllers
{
    public class MarksController : Controller
    {
        
        public IActionResult UploadResults()
        {
            return View();
        }
    }
}
