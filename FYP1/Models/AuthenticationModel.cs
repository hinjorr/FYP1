using System.Runtime.InteropServices;
using System.Collections.Generic;
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

        GeneralDTO general = new GeneralDTO();
        public AuthenticationModel(LMS_DBContext db, IMapper mapper, IHttpContextAccessor httpContext)
        {
            this.db = db;
            this.mapper = mapper;
            _httpContext = httpContext;
        }
        public async Task<GeneralDTO> Login(UserDTO dto)
        {
            try
            {
                GeneralDTO general = new GeneralDTO();
                var data = await db.TblUsers.Where(x => x.UserName == dto.UserName && x.Password == dto.Password).Include(x => x.Role).Include(x => x.Profile).FirstOrDefaultAsync();
                if (data != null)
                {
                    if (data.IsActive == Convert.ToUInt16(false))
                    {
                        general.Icon = "error";
                        general.Text = "Your account is temporarily blocked my Administrator!";
                        return general;
                    }
                    else
                    {
                        general.ReturnUrl = _httpContext.HttpContext.Session.GetString("ReturnUrl");
                        mapper.Map(data, general.User = new UserDTO());
                        mapper.Map(data.Role, general.Role = new RoleDTO());
                        mapper.Map(data.Profile, general.Profile = new ProfileDTO());
                        _httpContext.HttpContext.Session.SetObjectAsJson("UserDetails", general);
                        await GetPermissions(general.Role.RoleId);
                        general.Icon = "success";
                        general.Text = "Login Succesfull!";
                        return general;
                    }
                }
                else
                {
                    general.Icon = "error";
                    general.Text = "Username/Password Invalid!";
                    return general;
                }

            }
            catch (System.Exception)
            {
                general.Icon = "error";
                general.Text = "Server Error!";
                return general;
                throw;
            }
        }
        public async Task<bool> GetPermissions(int Role_Id)
        {
            try
            {
                List<GeneralDTO> general_list = new List<GeneralDTO>();
                var _list = await db.TblRoleMenus.Where(x => x.RoleId == Role_Id && x.Check == Convert.ToUInt16(true)).ToListAsync();

                foreach (var item in _list)
                {
                    var menus = await db.TblMenus.Where(x => x.MenuId == item.MenuId).Include(x => x.ParentNavigation).FirstOrDefaultAsync();
                    GeneralDTO dto = new GeneralDTO();
                    mapper.Map(item, dto.RoleMenu = new RoleMenuDTO());
                    mapper.Map(menus, dto.Menu = new MenuDTO());
                    mapper.Map(menus.ParentNavigation, dto.ParentMenu = new ParentMenuDTO());
                    general_list.Add(dto);

                }
                _httpContext.HttpContext.Session.SetObjectAsJson("Permissions", general_list);
                return true;
            }
            catch (System.Exception)
            {


                return false;
            }
        }

    }
}