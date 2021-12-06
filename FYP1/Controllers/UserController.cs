using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Hosting;


namespace FYP1.Controllers
{
    // [Authorize(Roles ="Admin")]
    public class UserController : Controller
    {
        private readonly IUser repo;

        public UserController(IUser _repo)
        {
            repo = _repo;
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


        public async Task<IActionResult> DeleteUser(string username)
        {
            return Ok(await repo.DeleteUser(username));
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