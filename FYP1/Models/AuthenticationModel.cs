using System.Threading;
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
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;

namespace FYP1.Models
{

    public class AuthenticationModel : IAuthentication
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        IHttpContextAccessor _httpContext;
        private readonly IWebHostEnvironment Env;
        private readonly IConfiguration config;
        GeneralDTO general = new GeneralDTO();
        YoutubeMix _youtube;
        public AuthenticationModel(LMS_DBContext db, IMapper mapper, IHttpContextAccessor httpContext, IWebHostEnvironment env, IConfiguration config)
        {
            this.db = db;
            this.mapper = mapper;
            _httpContext = httpContext;
            Env = env;
            this.config = config;
            _youtube = new YoutubeMix(config);
        }
        public async Task<GeneralDTO> Login(UserDTO dto)
        {
            try
            {
                dto.UserName.ToLower();
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
                        await GetPermissions(data.Role.RoleId);
                        general.ReturnUrl = _httpContext.HttpContext.Session.GetString("ReturnUrl");
                        mapper.Map(data, general.User = new UserDTO());
                        mapper.Map(data.Role, general.Role = new RoleDTO());
                        mapper.Map(data.Profile, general.Profile = new ProfileDTO());
                        _httpContext.HttpContext.Session.SetObjectAsJson("UserDetails", general);

                        general.Icon = "success";
                        general.Text = "Login Succesfull!";

                        if (TokenConfig.expiry_date < DateTime.Now)
                        {
                            Thread th = new Thread(async () => await _youtube.GetAccessToken());
                            th.Start();
                        }

                        // CookieOptions options = new CookieOptions()
                        // {
                        //     Expires = DateTime.Now.AddMinutes(59)
                        // };
                        // _httpContext.HttpContext.Response.Cookies.Append("AccessToken", youtube_token, options);
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
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
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
                List<GeneralDTO> ordered = general_list.OrderBy(x => x.Menu.MenuId).ToList();
                _httpContext.HttpContext.Session.SetObjectAsJson("Permissions", ordered);
                return true;
            }
            catch (System.Exception ex)
            {

                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                return false;
            }
        }
        string verification_code = null;
        public async Task<GeneralDTO> ForgetPassword(string _username, string _email)
        {
            try
            {
                string email = null;
                var chk_username = await db.TblUsers.Where(x => x.UserName == _username).FirstOrDefaultAsync();
                if (chk_username != null)
                {
                    var chk_email = await db.TblProfiles.Where(x => x.ProfileId == chk_username.ProfileId && x.Email == _email).FirstOrDefaultAsync();
                    if (chk_email != null)
                    {
                        email = chk_email.Email;
                    }
                }
                if (chk_username != null && email != null)
                {
                    var current_date = DateTime.Now;
                    var nxt10minutes = current_date.AddMinutes(10);
                    verification_code = new DateTimeOffset(nxt10minutes).ToUnixTimeSeconds().ToString();
                    verification_code = verification_code + "-" + chk_username.UserId;
                    Thread thread = new Thread(() => Misc.ForgetPasswordEmail(_username, verification_code, _email, Env, config));
                    thread.Start();
                    general.Icon = "success";
                    general.Text = "A verification Link has been sent to your registered Email Address";
                }
                else
                {
                    general.Icon = "error";
                    general.Text = "No Username/Email found in Gramiq!";
                }
                return general;

            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Icon = "error";
                general.Text = "Server Error!";
                return general;
            }
        }

        public async Task<GeneralDTO> ResetPassword(UserDTO dto)
        {
            try
            {
                var chk_user = await db.TblUsers.Where(x => x.UserId == dto.UserId).FirstOrDefaultAsync();
                if (chk_user != null)
                {
                    chk_user.Password = dto.Password;
                    await db.SaveChangesAsync();
                    general.Icon = "success";
                    general.Text = "Password Updated!";
                }
                else
                {
                    general.Icon = "error";
                    general.Text = "No Username found in Gramiq!";
                }
                return general;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Icon = "error";
                general.Text = "Server Error!";
                return general;
            }
        }
    }
}