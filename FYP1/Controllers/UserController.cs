using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
    public class UserController : Controller
    {

        public IActionResult AddNewUser()
        {
            return View();
        }
        public IActionResult ViewUsers()
        {
            return View();
        }
        public IActionResult UploadBulkUsers()
        {
            return View();
        }

    }
}