using System.Net;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    public class MarksController : Controller
    {

        [HttpGet("ViewResults")]
        public IActionResult StudentTestResults()
        {
            return View();
        }
        [HttpGet("UploadResults")]
        public IActionResult UploadTestResults()
        {
            return View();
        }

    }
}