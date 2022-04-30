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
using MoreLinq;

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
                var Userid = session_data.User.UserId;
                var Role = session_data.Role.RoleId;

                if (Role == 3)
                {
                    _list = await GetUsersForStudent(Userid);
                }
                else if (Role == 2)
                {
                    _list = await GetUsersForFaculty(Userid);
                }
                else
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

        private async Task<List<GeneralDTO>> GetUsersForStudent(int userId)
        {
            try
            {
                List<GeneralDTO> students = new List<GeneralDTO>();
                var user_enrolledClasses = await db.TblStudentCourseRegistrations.Where(x => x.UserId == userId && x.IsActive == 1).ToListAsync();
                foreach (var _class in user_enrolledClasses)
                {
                    //faculty chat
                    var class_user = await db.TblStudentCourseRegistrations.Where(x => x.ClassId == _class.ClassId).ToListAsync();
                    foreach (var classes in class_user)
                    {
                        var faculty = await db.TblFacultyCourseRegistrations.Where(x => x.ClassId == classes.ClassId).Include(x => x.User.Role).Include(x => x.User).Include(x => x.User.Profile).FirstOrDefaultAsync();
                        var chk_msg = await db.Messages.Where(x => x.UserTo == userId && x.UserFrom == faculty.UserId).FirstOrDefaultAsync();
                        GeneralDTO dto = new GeneralDTO();
                        mapper.Map(chk_msg, dto._Message = new MessageDTO());
                        mapper.Map(faculty.User, dto.User = new UserDTO());
                        mapper.Map(faculty.User.Profile, dto.Profile = new ProfileDTO());
                        mapper.Map(faculty.User.Role, dto.Role = new RoleDTO());
                        students.Add(dto);
                    }

                    //students chat
                    foreach (var student in class_user)
                    {
                        GeneralDTO dto = new GeneralDTO();
                        var _student = await db.TblUsers.Where(x => x.UserId == student.UserId).Include(x => x.Profile).Include(x => x.Role).FirstOrDefaultAsync();
                        var chk_msg = await db.Messages.Where(x => x.UserTo == userId && x.UserFrom == _student.UserId).FirstOrDefaultAsync();
                        mapper.Map(chk_msg, dto._Message = new MessageDTO());
                        mapper.Map(_student, dto.User = new UserDTO());
                        mapper.Map(_student.Profile, dto.Profile = new ProfileDTO());
                        mapper.Map(_student.Role, dto.Role = new RoleDTO());
                        students.Add(dto);
                    }

                }
                var distinct_list = students.DistinctBy(x => x.User.UserId).OrderBy(x => x.Role.RoleId).ToList();
                return distinct_list;
            }
            catch (System.Exception ex)
            {
                return null;
            }
        }

        private async Task<List<GeneralDTO>> GetUsersForFaculty(int userId)
        {
            try
            {
                List<GeneralDTO> students = new List<GeneralDTO>();
                var user_enrolledClasses = await db.TblFacultyCourseRegistrations.Where(x => x.UserId == userId && x.IsActive == 1).ToListAsync();
                foreach (var _class in user_enrolledClasses)
                {
                    var class_user = await db.TblStudentCourseRegistrations.Where(x => x.ClassId == _class.ClassId).ToListAsync();
                    foreach (var student in class_user)
                    {
                        GeneralDTO dto = new GeneralDTO();
                        var _student = await db.TblUsers.Where(x => x.UserId == student.UserId).Include(x => x.Profile).Include(x => x.Role).FirstOrDefaultAsync();
                        mapper.Map(_student, dto.User = new UserDTO());
                        mapper.Map(_student.Profile, dto.Profile = new ProfileDTO());
                        mapper.Map(_student.Role, dto.Role = new RoleDTO());
                        students.Add(dto);
                    }
                }
                var distinct_list = students.DistinctBy(x => x.User.UserId).ToList();
                return distinct_list;
            }
            catch (System.Exception ex)
            {
                return null;
            }
        }
        public async Task<GeneralDTO> OpenChat(int userId)
        {
            try
            {
                // it will show name and picture of the user when we open a specific chat 
                var data = await db.TblUsers.Where(x => x.UserId == userId).Include(x => x.Profile)
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


        public async Task<List<MessageDTO>> GetMessages(int UserId)
        {
            try
            {
                // it will show which msg is mine and which msg is other's
                List<MessageDTO> _list = new List<MessageDTO>();
                var _messages = await db.Messages.Where(x => (x.UserFrom == session_data.User.UserId && x.UserTo == UserId) || x.UserFrom == UserId && x.UserTo == session_data.User.UserId).ToListAsync();
                var unRead = await db.Messages.Where(x => x.UserTo == session_data.User.UserId && x.UserFrom == UserId && x.IsSeen == false).ToListAsync();
                unRead.ForEach(x => x.IsSeen = true);
                await db.SaveChangesAsync();

                foreach (var item in _messages)
                {
                    if (item.UserFrom == session_data.User.UserId)
                    {
                        MessageDTO dto = new MessageDTO();
                        mapper.Map(item, dto);
                        dto.Timespan = Misc.TimeAgo(item.Date);
                        _list.Add(dto);
                        //mine msg
                        dto.Mine = true;
                    }
                    else
                    {
                        //other's msg
                        MessageDTO dto = new MessageDTO();
                        mapper.Map(item, dto);
                        dto.Timespan = Misc.TimeAgo(item.Date);
                        _list.Add(dto);
                    }
                }

                var order_list = _list.OrderBy(x => x.Date).ToList();
                return order_list;
            }
            catch (System.Exception)
            {
                // TODO
                return null;
            }
        }

        public async Task<List<GeneralDTO>> Inbox()
        {
            try
            {
                List<GeneralDTO> _unreadUsers = new List<GeneralDTO>();
                var _messages = await db.Messages.Where(x => x.UserTo == session_data.User.UserId).OrderByDescending(x => x.Date).Include(x => x.UserFromNavigation.Profile).Include(x => x.UserFromNavigation.Role).ToListAsync();
                var distinct_list = _messages.DistinctBy(x => x.UserFrom).ToList();
                foreach (var item in distinct_list)
                {
                    GeneralDTO dto = new GeneralDTO();
                    var all_msg = await db.Messages.Where(x => x.UserTo == session_data.User.UserId && x.UserFrom == item.UserFrom).ToListAsync();
                    var last_msg = all_msg.LastOrDefault();
                    var total_count = await db.Messages.Where(x => x.UserTo == session_data.User.UserId && x.UserFrom == item.UserFrom && x.IsSeen == false).CountAsync();

                    dto._Message = new MessageDTO()
                    {
                        Timespan = Misc.TimeAgo(last_msg.Date),
                        TotalUnread = total_count
                    };
                    mapper.Map(item.UserFromNavigation.Profile, dto.Profile = new ProfileDTO());
                    mapper.Map(item.UserFromNavigation.Role, dto.Role = new RoleDTO());
                    mapper.Map(item.UserFromNavigation, dto.User = new UserDTO());
                    _unreadUsers.Add(dto);
                }


                return _unreadUsers;
            }
            catch (System.Exception ex)
            {
                return null;
                // TODO
            }
        }
        public async Task<List<GeneralDTO>> Sent_Message()
        {
            try
            {
                List<GeneralDTO> _receivers = new List<GeneralDTO>();
                var _messages = await db.Messages.Where(x => x.UserFrom == session_data.User.UserId).OrderByDescending(x => x.Date).Include(x => x.UserToNavigation.Profile).Include(x => x.UserToNavigation.Role).ToListAsync();
                var distinct_list = _messages.DistinctBy(x => x.UserTo).ToList();
                foreach (var item in distinct_list)
                {
                    GeneralDTO dto = new GeneralDTO();
                    var all_msg = await db.Messages.Where(x => x.UserTo == item.UserTo && x.UserFrom == session_data.User.UserId).ToListAsync();
                    var last_msg = all_msg.LastOrDefault();
                    dto._Message = new MessageDTO()
                    {
                        Timespan = Misc.TimeAgo(last_msg.Date)
                    };
                    mapper.Map(item.UserToNavigation.Profile, dto.Profile = new ProfileDTO());
                    mapper.Map(item.UserToNavigation.Role, dto.Role = new RoleDTO());
                    mapper.Map(item.UserToNavigation, dto.User = new UserDTO());
                    _receivers.Add(dto);
                }
                return _receivers;
            }
            catch (System.Exception ex)
            {
                return null;
                // TODO
            }
        }
        public async Task SendMessage(Message dto)
        {
            try
            {
                Message tbl = new Message()
                {
                    Body = dto.Body,
                    Date = DateTime.Now,
                    UserTo = dto.UserTo,
                    UserFrom = session_data.User.UserId,
                    IsSeen = false
                };
                await db.Messages.AddAsync(tbl);
                await db.SaveChangesAsync();
            }
            catch (System.Exception ex)
            {
                // TODO
            }
        }
    }
}