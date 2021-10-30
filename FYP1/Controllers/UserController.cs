using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using FYP1.DTOs;
using AutoMapper;
using FYP1.dbModels;
using FYP1.Repository;

namespace FYP1.Controllers
{
    public class UserController : Controller
    {
        private readonly IUser repo;

        public UserController(IUser _repo)
        {
            repo = _repo;
        }

        public IActionResult AddNewUser()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> AddNewUser(ProfileDTO dto)
        {
            var data = await repo.AddNewUser(dto);
            return Ok(data);
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