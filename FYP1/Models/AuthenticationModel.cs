using System;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
using FYP1.dbModels;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http;
using FYP1.Helpers__Filters;

namespace FYP1.Models
{

    public class AuthenticationModel : IAuthentication
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        IHttpContextAccessor _httpContext;

        public AuthenticationModel(LMS_DBContext db, IMapper mapper, IHttpContextAccessor httpContext)
        {
            this.db = db;
            this.mapper = mapper;
            _httpContext = httpContext;
        }
        public async Task<bool> Login(UserDTO dto)
        {
            try
            {
                var data = await db.TblUsers.Where(x => x.UserName == dto.UserName && x.Password == dto.Password && x.IsActive == Convert.ToUInt16(true)).Include(x => x.Role).Include(x => x.Profile).FirstOrDefaultAsync();
                if (data != null)
                {
                    GeneralDTO general = new GeneralDTO();
                    general.ResponseBool = true;
                    mapper.Map(data, general.User = new UserDTO());
                    mapper.Map(data.Role, general.Role = new RoleDTO());
                    mapper.Map(data.Profile, general.Profile = new ProfileDTO());

                    _httpContext.HttpContext.Session.SetObjectAsJson("UserDetails", general);
                    return true;
                }
                return false;
            }
            catch (System.Exception)
            {

                throw;
            }
        }


    }
}