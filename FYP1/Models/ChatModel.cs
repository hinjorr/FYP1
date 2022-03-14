using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace FYP1.Models
{
    public class ChatModel : IChat
    {
        private readonly LMS_DBContext db;
        private readonly IHttpContextAccessor http;
        private readonly IConfiguration config;
        private readonly IMapper mapper;
        GeneralDTO session_data;
        GeneralDTO general = new GeneralDTO();

        public ChatModel(LMS_DBContext db, IHttpContextAccessor http, IConfiguration config, IMapper mapper)
        {
            this.db = db;
            this.http = http;
            this.config = config;
            this.mapper = mapper;
            session_data = this.http.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
        }

        public async Task<List<GeneralDTO>> GetAllUsers()
        {
            try
            {
                List<GeneralDTO> _list = null;

                if (session_data.Role.RoleId == 1)
                {

                    _list = await db.TblUsers.Where(x => x.IsActive == Convert.ToUInt16(true))
                     .Select(x => new GeneralDTO
                     {
                         User = new UserDTO
                         {
                             UserId = x.UserId,
                             UserName = x.UserName
                         },
                         Profile = new ProfileDTO
                         {
                             Name = x.Profile.Name,
                             Picture = x.Profile.Picture

                         },
                         Role = new RoleDTO
                         {
                             RoleName = x.Role.RoleName
                         }
                     })
                     .ToListAsync();
                }
                return _list;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                return null;
            }
        }

        public async Task<GeneralDTO> SingleChat(int userId)
        {
            try
            {
                var data = await db.TblUsers.Where(x => x.UserId == userId)
                .Include(x => x.Profile)
                .FirstOrDefaultAsync();
                mapper.Map(data, general.User = new UserDTO());
                mapper.Map(data.Profile, general.Profile = new ProfileDTO());
                return general;
            }
            catch (System.Exception)
            {
                // TODO
                return null;
            }
        }
    }
}