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
    public class AttendenceModel : IAttendence
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        private readonly IConfiguration config;
        TblAttendence tbl = new TblAttendence();
        GeneralDTO general = new GeneralDTO();
        private readonly INotifications notification;
        private readonly IHttpContextAccessor http;
        GeneralDTO session_data;

        public AttendenceModel(LMS_DBContext _db, IMapper _mapper, IConfiguration config, INotifications notification, IHttpContextAccessor http)
        {
            this.notification = notification;
            this.http = http;
            db = _db;
            mapper = _mapper;
            this.config = config;
            session_data = this.http.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
        }

        public async Task<List<GeneralDTO>> GetAttendenceStudents(AttendenceDTO dto)
        {
            //class_id and session_id ayegi user se
            List<GeneralDTO> studentlist = new List<GeneralDTO>();
            try
            {
                //class ka data ayega student_course_resgistration se 
                var class_data = await db.TblStudentCourseRegistrations.Where(x => x.ClassId == dto.ClassId).ToListAsync();
                if (class_data.Count != 0)
                {
                    //semester id uthani h current
                    var semester = await db.TblSemesters.Where(x => x.IsActive == Convert.ToUInt16(true)).FirstOrDefaultAsync();
                    //total sessions uthane h phr unko 2 se multiply krna h taake ik din me 2 session bn ske
                    var sessions = await db.TblClassSessions.Where(x => x.SemesterId == semester.SemesterId).CountAsync();
                    sessions = sessions * 2;

                    //loop
                    foreach (var item in class_data)
                    {

                        GeneralDTO model = new GeneralDTO();
                        var get_users = await db.TblUsers.Where(x => x.UserId == item.UserId).Include(x => x.Profile).FirstOrDefaultAsync();
                        var get_attendence = await db.TblAttendences.Where(x => x.ClassId == dto.ClassId && x.UserId == get_users.UserId && x.SessionId == dto.SessionId).FirstOrDefaultAsync();
                        var present_1 = await db.TblAttendences.Where(x => x.ClassId == dto.ClassId && x.UserId == get_users.UserId && x._1st == Convert.ToUInt16(true)).Select(x => x._1st).CountAsync();
                        var present_2 = await db.TblAttendences.Where(x => x.ClassId == dto.ClassId && x.UserId == get_users.UserId && x._2nd == Convert.ToUInt16(true)).Select(x => x._2nd).CountAsync();
                        var current_marked_attedence = await db.TblAttendences.Where(x => x.ClassId == dto.ClassId && x.UserId == get_users.UserId).CountAsync();
                        current_marked_attedence = current_marked_attedence * 2;
                        model.TotalSessions = sessions;
                        mapper.Map(get_users, model.User = new UserDTO());
                        mapper.Map(get_users.Profile, model.Profile = new ProfileDTO());
                        if (get_attendence != null)
                        {
                            model.Attendence = new AttendenceDTO()
                            {
                                _1st = get_attendence._1st,
                                _2nd = get_attendence._2nd,
                                TotalPresent = present_1 + present_2,
                                TotalAbsent = (current_marked_attedence - (present_1 + present_2)),
                                TotalMarkedSesion = current_marked_attedence
                            };
                        }
                        else
                        {

                            model.Attendence = new AttendenceDTO()
                            {
                                TotalPresent = present_1 + present_2,
                                TotalAbsent = (current_marked_attedence - (present_1 + present_2)),
                                TotalMarkedSesion = current_marked_attedence
                            };


                        }
                        studentlist.Add(model);
                    }
                    return studentlist;
                }
                else
                {
                    general.Text = "Class is Empty!";
                    general.Icon = "error";
                    studentlist.Add(general);
                    return studentlist;
                }
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Text = "Server Error!";
                general.Icon = "error";
                studentlist.Add(general);
                return studentlist;

            }
        }
        public async Task<GeneralDTO> MarkAttendence(List<AttendenceDTO> dto)
        {
            try
            {
                var chkclass = dto.ElementAt(0);
                if (chkclass != null)
                {
                    var data = await db.TblAttendences.Where(x => x.ClassId == chkclass.ClassId && x.SessionId == chkclass.SessionId).ToListAsync();
                    db.TblAttendences.RemoveRange(data);
                    await db.SaveChangesAsync();
                }
                List<AttendenceDTO> studentlist = new List<AttendenceDTO>();
                foreach (var item in dto)
                {
                    var user = await db.TblUsers.Where(x => x.UserName == item.UserName).FirstOrDefaultAsync();
                    item.UserId = user.UserId;
                    mapper.Map(item, tbl);
                    await db.TblAttendences.AddAsync(tbl);
                    await db.SaveChangesAsync();
                }
                var sessionName = await db.TblClassSessions.Where(x => x.SessionId == dto[0].SessionId).FirstOrDefaultAsync();
                await notification.Send_GroupNotification(Convert.ToInt32(dto[0].ClassId), 4, "Your attendence of " + sessionName.SessionName + " has been marked.");
                general.Text = "Attendence Uploaded!";
                general.Icon = "success";
                return general;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Text = "Server Error";
                general.Icon = "error";
                return general;
            }
        }

        public async Task<List<GeneralDTO>> StudentAttendenceReport()
        {
            List<GeneralDTO> studentList = new List<GeneralDTO>();

            try
            {
                //student jis jis class me enroll h wo uthayae ge
                var get_classes = await db.TblStudentCourseRegistrations.Where(x => x.UserId == session_data.User.UserId && x.IsActive == Convert.ToUInt64(true)).Include(x => x.Class).ToListAsync();
                if (get_classes != null)
                {
                    foreach (var item in get_classes)
                    {
                        GeneralDTO dto = new GeneralDTO();

                        //student ki class k name uthaye ge
                        var courses = await db.TblClasses.Where(x => x.ClassId == item.ClassId).Include(x => x.Course).FirstOrDefaultAsync();
                        dto.Course = new CourseDTO()
                        {
                            FullName = courses.Course.FullName,
                            CourseId = courses.ClassId
                        };

                        //student ki class ki faculty
                        var get_faculty = await db.TblFacultyCourseRegistrations.Where(x => x.ClassId == courses.ClassId).FirstOrDefaultAsync();
                        if (get_faculty != null)
                        {
                            var faculty_name = await db.TblUsers.Where(x => x.UserId == get_faculty.UserId).Include(x => x.Profile).FirstOrDefaultAsync();
                            dto.Profile = new ProfileDTO()
                            {
                                Name = faculty_name.Profile.Name
                            };
                        }
                        else
                        {
                            dto.Profile = null;
                        }

                        //student ki attendence 
                        var present_1 = await db.TblAttendences.Where(x => x.ClassId == item.ClassId && x.UserId == item.UserId && x._1st == Convert.ToUInt16(true)).Select(x => x._1st).CountAsync();
                        var present_2 = await db.TblAttendences.Where(x => x.ClassId == item.ClassId && x.UserId == item.UserId && x._2nd == Convert.ToUInt16(true)).Select(x => x._2nd).CountAsync();
                        var current_marked_attedence = await db.TblAttendences.Where(x => x.ClassId == item.ClassId && x.UserId == item.UserId).CountAsync();
                        current_marked_attedence = current_marked_attedence * 2;
                        dto.Attendence = new AttendenceDTO()
                        {
                            TotalPresent = present_1 + present_2,
                            TotalAbsent = (current_marked_attedence - (present_1 + present_2)),
                            TotalMarkedSesion = current_marked_attedence
                        };

                        studentList.Add(dto);
                    }

                }
                if (studentList.Count != 0)
                {
                    var _list = studentList.OrderBy(x => x.Course.CourseId).ToList();
                    return _list;
                }
                else
                {
                    return null;
                }
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Text = "Server Error!";
                general.Icon = "error";
                studentList.Add(general);
                return studentList;
            }

        }
    }
}