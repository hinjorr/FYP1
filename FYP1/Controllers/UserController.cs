using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Hosting;
using System;
using FYP1.Helpers__Filters;

namespace FYP1.Controllers
{

    public class UserController : Controller
    {
        private readonly IUser repo;

        public IWebHostEnvironment Env { get; }

        public UserController(IUser _repo, IWebHostEnvironment Env)
        {
            repo = _repo;
            this.Env = Env;
        }
        [AuthenticateFilter]
        [HttpGet("NewUser")]
        public IActionResult AddNewUser()
        {

            return View();
        }


        [HttpPost]
        public async Task<IActionResult> AddNewUser([FromForm] GeneralDTO dto)
        {

            var RoleChk = await repo.Role_NIC_Check(dto);
            if (RoleChk.Text == null)
            {
                var data = await repo.RegisterUser(dto);
                return Ok(data);
            }
            else
            {
                return Ok(RoleChk);
            }
        }

        // [HttpPost]
        // public async Task<IActionResult> UpdateUser([FromForm] ProfileDTO dto)
        // {

        // }
        public async Task<IActionResult> DeleteUser(string username)
        {
            username.ToLower();
            var chk = await repo.DeleteUser(username);
            return Ok(chk);
        }
        public async Task<IActionResult> RoleCheck(GeneralDTO dto)
        {
            var chk = await repo.Role_NIC_Check(dto);
            return Ok(chk);
        }
        [AuthenticateFilter]
        [HttpGet("ViewUsers")]
        public IActionResult ViewUsers()
        {
            return View();
        }

        [AuthenticateFilter]
        [HttpGet("Profile/{id}")]
        public IActionResult ViewProfile()
        {
            return View();
        }


        [HttpGet("GetProfile")]
        public async Task<IActionResult> GetProfile(string username)
        {
            username.ToLower();
            var data = await repo.GetProfile(username);
            return Ok(data);
        }


        [HttpPost("UpdateProfile")]
        public ActionResult UpdateProfile([FromForm] ProfileDTO dto)
        {
            return Ok(dto);
        }
        public async Task<JsonResult> GetUsers()
        {
            var users = await repo.GetUsers();
            return Json(new { data = users });
        }

        // [HttpGet("UploadUsers")]
        // public IActionResult UploadBulkUsers()
        // {
        //     return View();
        // }

        [AuthenticateFilter]
        [HttpGet("Calender")]
        public IActionResult Calender()
        {
            return View();
        }


    }
}