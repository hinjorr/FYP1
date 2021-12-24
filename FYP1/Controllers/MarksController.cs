using System.Net;
using FYP1.Helpers__Filters;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
        [AuthorizedUserFilter]

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