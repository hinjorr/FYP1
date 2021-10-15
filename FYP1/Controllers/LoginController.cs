using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
   
    public class LoginController : Controller
    {

        public IActionResult Login()
        {
            return View();
        }

       
    }
}