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
    public class NotificationsModel : INotifications
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        private readonly IHttpContextAccessor http;
        private readonly IConfiguration config;
        private readonly GeneralDTO session_data;

        public NotificationsModel(LMS_DBContext db, IMapper mapper, IHttpContextAccessor http, IConfiguration config)
        {
            this.db = db;
            this.mapper = mapper;
            this.http = http;
            this.config = config;
            session_data = this.http.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");

        }
        public async Task Send_GroupNotification(int class_id, int notification_type, string message)
        {
            try
            {
                List<TblNotificaionTo> tos_list = new List<TblNotificaionTo>();
                var students_list = await db.TblStudentCourseRegistrations.Where(x => x.ClassId == class_id).ToListAsync();
                var class_name = await db.TblClasses.Where(x => x.ClassId == class_id).Include(x => x.Course).FirstOrDefaultAsync();

                TblNotification notification = new TblNotification()
                {
                    From = class_name.Course.ShortName + " " + class_id,
                    TypeId = notification_type,
                    Message = message,
                    ClassId = class_id,
                    UploadedTime = DateTime.Now

                };
                await db.TblNotifications.AddAsync(notification);
                await db.SaveChangesAsync();
                foreach (var student in students_list)
                {
                    TblNotificaionTo to_tbl = new TblNotificaionTo();
                    to_tbl.NotificationId = notification.NotificationId;
                    to_tbl.To = student.UserId;
                    to_tbl.IsSeen = false;
                    tos_list.Add(to_tbl);
                }
                await db.TblNotificaionTos.AddRangeAsync(tos_list);
                await db.SaveChangesAsync();
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
            }
        }
        public async Task SendSingleNotification(int _To, string _From, int _Type, string _Message, int _ClassId)
        {
            try
            {
                
                TblNotification tbl_notfication = new TblNotification()
                {
                    From = _From,
                    TypeId = _Type,
                    Message = _Message,
                    UploadedTime = DateTime.Now,
                    ClassId = _ClassId
                };
                await db.TblNotifications.AddAsync(tbl_notfication);
                await db.SaveChangesAsync();    
                TblNotificaionTo tbl_to = new TblNotificaionTo()
                {
                    IsSeen = false,
                    To = _To,
                    NotificationId = tbl_notfication.NotificationId
                };
                await db.TblNotificaionTos.AddAsync(tbl_to);
                await db.SaveChangesAsync();
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
            }
        }
        public async Task<List<GeneralDTO>> ReceiveNotifications()
        {
            try
            {
                List<GeneralDTO> _list = new List<GeneralDTO>();
                var notifications = await db.TblNotificaionTos.Where(x => x.To == session_data.User.UserId).Include(x => x.Notification).Include(x => x.Notification.Type).ToListAsync();

                foreach (var item in notifications)
                {
                    GeneralDTO dto = new GeneralDTO();
                    mapper.Map(item.Notification.Type, dto.notificationType = new NotificationTypeDTO());
                    mapper.Map(item, dto.NotificationTo = new NotificationToDTO());
                    mapper.Map(item.Notification, dto.Notification = new NotificationDTO());
                    dto.Notification.Timespan = Misc.TimeAgo(Convert.ToDateTime(item.Notification.UploadedTime));
                    _list.Add(dto);
                }
                var new_list = _list.OrderByDescending(x => x.Notification.NotificationId).ToList();
                return new_list;
            }
            catch (System.Exception )
            {
                return null;
            }
        }
        public async Task MarkAsReadNotifications()
        {
            try
            {
                var read = await db.TblNotificaionTos.Where(x => x.To == session_data.User.UserId).ToListAsync();
                read.ForEach(x => x.IsSeen = true);
                await db.SaveChangesAsync();
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
            }
        }
    }
}