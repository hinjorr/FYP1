using System.Net;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.Controllers
{
    public class HomeController : Controller
    {
        // [Authorize(Roles ="Admin,Faculty,Student")]

        [HttpGet("Home")]
        public IActionResult Index()
        {
            return View();
        }
      
    }
}
