using Microsoft.AspNetCore.Mvc;

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