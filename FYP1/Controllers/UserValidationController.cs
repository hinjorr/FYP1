using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Models;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    public class UserValidationController : Controller
    {
        private readonly IUserValidation repo;

        public UserValidationController(IUserValidation _repo)
        {
            repo = _repo;
        }
       
        [HttpPost]
        public async Task<IActionResult> NICCheck(GeneralDTO dto)
        {
            var data=await repo.CheckNIC(dto);
            return Ok(data);
        }
    }
}