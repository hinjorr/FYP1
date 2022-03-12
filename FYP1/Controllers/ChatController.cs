using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using FYP1.Helpers__Filters;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
    public class ChatController : Controller
    {
        [AuthenticateFilter]
        [HttpGet("ViewChats")]
        public IActionResult ViewAllChats()
        {
            return View();
        }
    }
}