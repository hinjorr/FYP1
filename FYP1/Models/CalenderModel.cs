using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;

namespace FYP1.Models
{
    public class CalenderModel : ICalender
    {
        private readonly IHttpContextAccessor http;
        private readonly LMS_DBContext db;
        GeneralDTO session_data;

        public CalenderModel(IHttpContextAccessor http, LMS_DBContext db)
        {
            this.http = http;
            this.db = db;
            session_data = this.http.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
        }

        private async Task<List<GeneralDTO>> GetFacultyCalender(int UserId)
        {
            try
            {
                var data = await db.TblFacultyCourseRegistrations.Where(x => x.UserId == UserId && x.IsActive == Convert.ToUInt16(true))
                 .Select(x => new GeneralDTO
                 {
                     Classes = new ClassDTO
                     {
                         ClassId = Convert.ToInt32(x.ClassId)
                     },
                     Course = new CourseDTO
                     {
                         FullName = x.Class.Course.FullName
                     },
                     Day = new DayDTO
                     {
                         DayName = x.Class.Day.DayName
                     },
                     Time = new TimeDTO
                     {
                         TimeName = x.Class.Time.TimeName
                     }
                 })
                .ToListAsync();
                return data;
            }
            catch (System.Exception ex)
            {
                // TODO
                return null;
            }
        }

        private async Task<List<GeneralDTO>> GetStudentCalender(int UserId)
        {
            try
            {
                var data = await db.TblStudentCourseRegistrations.Where(x => x.UserId == UserId && x.IsActive == Convert.ToUInt16(true))
                 .Select(x => new GeneralDTO
                 {
                     Classes = new ClassDTO
                     {
                         ClassId = Convert.ToInt32(x.ClassId)
                     },
                     Course = new CourseDTO
                     {
                         FullName = x.Class.Course.FullName
                     },
                     Day = new DayDTO
                     {
                         DayName = x.Class.Day.DayName
                     },
                     Time = new TimeDTO
                     {
                         TimeName = x.Class.Time.TimeName
                     }
                 })
                .ToListAsync();
                return data;
            }
            catch (System.Exception ex)
            {
                // TODO
                return null;
            }
        }

        private async Task<List<GeneralDTO>> GetAdminCalender()
        {
            try
            {
                var classes = await db.TblClasses.Where(x => x.IsActive == Convert.ToUInt16(true)).OrderBy(x => x.DayId).ThenBy(x => x.TimeId)
                .Select(x => new GeneralDTO
                {
                    Classes = new ClassDTO
                    {
                        ClassId = x.ClassId
                    },
                    Course = new CourseDTO
                    {
                        FullName = x.Course.FullName
                    },
                    Day = new DayDTO
                    {
                        DayName = x.Day.DayName
                    },
                    Time = new TimeDTO
                    {
                        TimeName = x.Time.TimeName
                    },
                }).ToListAsync();
                return classes;

            }
            catch (System.Exception ex)
            {
                // TODO
                return null;
            }
        }

        public async Task<List<GeneralDTO>> GetCalender()
        {
            try
            {
                List<GeneralDTO> _list;
                var role = session_data.Role.RoleId;
                var userId = session_data.User.UserId;
                if (role == 2)
                {
                    _list = await GetFacultyCalender(userId);
                }
                else if (role == 3)
                {
                    _list = await GetStudentCalender(userId);
                }
                else
                {
                    _list = await GetAdminCalender();
                }
                return _list;
            }
            catch (System.Exception ex)
            {
                // TODO
                return null;
            }
        }
    }
}