using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FYP1.Controllers
{
    public class ChatController : Controller
    {
        private readonly IChat repo;

        public ChatController(IChat _repo)
        {
            repo = _repo;
        }
        [AuthenticateFilter]
        [HttpGet("ViewChats")]
        public IActionResult ViewAllChats()
        {
            return View();
        }

        public async Task<IActionResult> GetAllUsers()
        {
            var data = await repo.GetAllUsers();
            return Ok(data);
        }
        public async Task<IActionResult> SingleChat(int UserId)
        {
            var data = await repo.SingleChat(UserId);
            return Ok(data);
        }
    }
}