using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using FYP1.DTOs;
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