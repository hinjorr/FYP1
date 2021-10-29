using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using FYP1.DTOs;

namespace FYP1.Controllers
{
    public class UserController : Controller
    {

        public IActionResult AddNewUser()
        {
            return View();
        }
        [HttpPost]
        public IActionResult AddNewUser(ProfileDTO model)
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
        public IActionResult Calender()
        {
            return View();
        }
        public IActionResult StudentTestResults()
        {
            return View();
        }
       
    }
}