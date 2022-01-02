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
    [AuthorizedUserFilter]
    public class UserController : Controller
    {
        private readonly IUser repo;

        public IWebHostEnvironment Env { get; }

        public UserController(IUser _repo, IWebHostEnvironment Env)
        {
            repo = _repo;
            this.Env = Env;
        }

        [HttpGet("NewUser")]
        public IActionResult AddNewUser()
        {

            return View();
        }


        [HttpPost]
        public async Task<IActionResult> AddNewUser([FromForm] ProfileDTO dto)
        {

            var RoleChk = await repo.Role_NIC_Check(dto);
            if (RoleChk == null)
            {
                var chk = await repo.AddNewUser(dto);
                if (chk)
                {
                    return Ok(new { type = "success", msg = "User Registered!" });
                }
                else
                {
                    return Ok(new { type = "error", msg = "Registration Failed!" });
                }
            }
            else
            {
                return Ok(new { type = "warning", msg = RoleChk });
            }
        }

        // [HttpPost]
        // public async Task<IActionResult> UpdateUser([FromForm] ProfileDTO dto)
        // {

        // }
        public async Task<IActionResult> DeleteUser(string username)
        {
            var chk = await repo.DeleteUser(username);
            if (chk == true)
            {
                return Ok(new { type = "success", msg = "Status Cahnged!" });
            }
            else
            {
                return Ok(new { type = "error", msg = "Task Failed!" });

            }
        }
        public async Task<IActionResult> RoleCheck(ProfileDTO dto)
        {
            var chk = await repo.Role_NIC_Check(dto);
            return Ok(chk);
        }

        [HttpGet("ViewUsers")]
        public IActionResult ViewUsers()
        {
            return View();
        }

        [HttpGet("Profile/{id}")]
        public IActionResult ViewProfile()
        {
            return View();
        }

        [HttpGet("GetProfile")]
        public async Task<IActionResult> GetProfile(string username)
        {
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

        [HttpGet("UploadUsers")]
        public IActionResult UploadBulkUsers()
        {
            return View();
        }

        [HttpGet("Calender")]
        public IActionResult Calender()
        {
            return View();
        }


    }
}