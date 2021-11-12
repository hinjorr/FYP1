using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Authorization;

namespace FYP1.Controllers
{
    // [Authorize(Roles ="Admin")]
    public class UserController : Controller
    {
        private readonly IUser repo;
        private readonly IWebHostEnvironment env;

        public UserController(IUser _repo,IWebHostEnvironment env)
        {
            repo = _repo;
            this.env = env;
        }
        [HttpGet("NewUser")]
        public IActionResult AddNewUser()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> AddNewUser(ProfileDTO dto)
        {
            
            var RoleChk = await repo.Role_NIC_Check(dto);
            if (RoleChk == null)
            {
                var data = await repo.AddNewUser(dto);
                return Ok(data);
            }
            else
            {
                return Ok(RoleChk);
            }
        }

        [HttpGet("ViewUsers")]
        public IActionResult ViewUsers()
        {
            return View();
        }
        public async Task<IActionResult> ViewUser()
        {
            var data = await repo.GetUsers();
            return Ok(data);
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