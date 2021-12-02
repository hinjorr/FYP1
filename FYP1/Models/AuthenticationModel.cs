using System.Security.Claims;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Authentication.Cookies;
using FYP1.dbModels;
using AutoMapper;
using Microsoft.EntityFrameworkCore;

namespace FYP1.Models
{

    public class AuthenticationModel : IAuthentication
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;

        public AuthenticationModel(LMS_DBContext db, IMapper mapper)
        {
            this.db = db;
            this.mapper = mapper;
        }
        public async Task<GeneralDTO> Login(UserDTO dto)
        {
            GeneralDTO model = new GeneralDTO();

            try
            {
                ClaimsIdentity identity = null;
                bool isAuthenticate = false;
                var data = await db.TblUsers.Where(x => x.UserName == dto.UserName && x.Password == dto.Password).FirstOrDefaultAsync();
                if (data != null)
                {
                    //Admin=1
                    if (data.RoleId == 1)
                    {
                        identity = new ClaimsIdentity(new[]{
                    new Claim(ClaimTypes.Name,dto.UserName),
                    new Claim(ClaimTypes.Role,"Admin")
                    }, CookieAuthenticationDefaults.AuthenticationScheme);
                        isAuthenticate = true;
                    }
                    //Faculty=2
                    else if (data.RoleId == 2)
                    {
                        identity = new ClaimsIdentity(new[]{
                    new Claim(ClaimTypes.Name,dto.UserName),
                    new Claim(ClaimTypes.Role,"Faculty")
                    }, CookieAuthenticationDefaults.AuthenticationScheme);
                        isAuthenticate = true;
                    }
                    //Student=3
                    else if (data.RoleId == 3)
                    {
                        identity = new ClaimsIdentity(new[]{
                    new Claim(ClaimTypes.Name,dto.UserName),
                    new Claim(ClaimTypes.Role,"Student")
                    }, CookieAuthenticationDefaults.AuthenticationScheme);
                        isAuthenticate = true;
                    }
                    
                }

                if (isAuthenticate)
                {
                    model.principle = new ClaimsPrincipal(identity);
                    model.boolchk = true;
                }
                else
                {
                    model.boolchk = false;
                }
                return model;
            }
            catch (System.Exception)
            {
                model.boolchk = false;
                throw;
            }
        }
    }
}