using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
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
        [HttpGet("NewChat")]
        public IActionResult NewChat()
        {
            return View();
        }

        [AuthenticateFilter]
        [HttpGet("Inbox")]
        public IActionResult Inbox()
        {
            return View();
        }
        
        [AuthenticateFilter]
        [HttpGet("MessageSent")]
        public IActionResult Sent_Message()
        {
            return View();
        }

        public async Task<IActionResult> UnReadMessages()
        {
            var data = await repo.Inbox();
            return Ok(data);
        }
        public async Task<IActionResult> Sent_Messages()
        {
            var data = await repo.Sent_Message();
            return Ok(data);
        }
        public async Task<IActionResult> GetAllUsers()
        {
            var data = await repo.GetAllUsers();
            return Ok(data);
        }
        public async Task<IActionResult> OpenChat(int UserId)
        {
            var data = await repo.OpenChat(UserId);
            return Ok(data);
        }
        public async Task<IActionResult> GetMessages(int UserId)
        {
            var data = await repo.GetMessages(UserId);
            return Ok(data);
        }

        [HttpPost]
        public async Task<IActionResult> SendMessage(Message dto)
        {
            await repo.SendMessage(dto);
            return Ok();
        }
    }
}