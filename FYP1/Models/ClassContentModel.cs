using System.Threading;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Http;
using FYP1.Helpers__Filters;

namespace FYP1.Models
{
    public class ClassContentModel : IClassContent
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        private readonly IWebHostEnvironment Env;
        private readonly IConfiguration config;
        private readonly IHttpContextAccessor http;
        GeneralDTO general = new GeneralDTO();
        GeneralDTO session_data;
        TblAssesment tbl_assesment = new TblAssesment();
        public ClassContentModel(LMS_DBContext _db, IMapper _mapper, IWebHostEnvironment env, IConfiguration config, IHttpContextAccessor http)
        {
            db = _db;
            mapper = _mapper;
            Env = env;
            this.config = config;
            this.http = http;
            session_data = this.http.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
        }

        public async Task<GeneralDTO> AddUrl(UrlDTO dto)
        {
            try
            {
                if (dto.UrlId == 0)
                {
                    TblUrl tbl = new TblUrl();
                    mapper.Map(dto, tbl);
                    await db.TblUrls.AddAsync(tbl);
                }
                else
                {
                    var update = await db.TblUrls.Where(x => x.UrlId == dto.UrlId).FirstOrDefaultAsync();
                    update.Link = dto.Link;
                    update.DisplayName = dto.DisplayName;
                }
                await db.SaveChangesAsync();
                general.type = "success";
                general.message = "Url Added";
                return general;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.type = "error";
                general.message = "Server Error";
                return general;
            }
        }

        public async Task<List<UrlDTO>> GetUrls(int _sessionId, int _classId)
        {
            try
            {
                List<UrlDTO> _list = new List<UrlDTO>();
                var data = await db.TblUrls.Where(x => x.ClassId == _classId && x.SessionId == _sessionId).ToListAsync();
                mapper.Map(data, _list);
                return _list;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                return null;

            }
        }

        public void DeleteUrl(int _id)
        {
            try
            {
                var data = db.TblUrls.Where(x => x.UrlId == _id).FirstOrDefault();
                db.TblUrls.Remove(data);
                db.SaveChanges();
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
            }
        }

        public async Task<UrlDTO> GetSingleUrl(int _id)
        {
            UrlDTO dto = new UrlDTO();
            try
            {
                var data = await db.TblUrls.Where(x => x.UrlId == _id).FirstOrDefaultAsync();
                mapper.Map(data, dto);
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                // TODO
            }
            return dto;

        }

        public async Task<GeneralDTO> UploadAssesment(AssesmentDTO dto)
        {
            using (var transaction = await db.Database.BeginTransactionAsync())
            {
                try
                {
                    mapper.Map(dto, tbl_assesment);
                    await db.TblAssesments.AddAsync(tbl_assesment);
                    await db.SaveChangesAsync();
                    if (dto.Attachments != null)
                    {
                        foreach (var item in dto.Attachments)
                        {
                            TblAssesmetnAttachment tbl = new TblAssesmetnAttachment();
                            tbl.AssesmentId = tbl_assesment.AssesmentId;
                            tbl.DisplayName = item.FileName;
                            tbl.Path = Misc.UploadFile(item, Env);
                            await db.TblAssesmetnAttachments.AddAsync(tbl);
                        }
                        await db.SaveChangesAsync();
                    }
                    await transaction.CommitAsync();
                    general.type = "success";
                    general.message = "Assesment Uploaded";
                    return general;
                }
                catch (System.Exception ex)
                {
                    Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                    thr.Start();
                    general.type = "error";
                    general.message = "Server Error";
                    return general;
                }
            }
        }

        public async Task<List<AssesmentDTO>> GetAssesment(int _sessionId, int _classId)
        {
            try
            {
                List<AssesmentDTO> _list = new List<AssesmentDTO>();
                var data = await db.TblAssesments.Where(x => x.ClassId == _classId && x.SessionId == _sessionId).ToListAsync();
                mapper.Map(data, _list);
                return _list;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                return null;
            }
        }
        public void DeleteAssesment(int _id)
        {
            try
            {
                var data = db.TblAssesments.Where(x => x.AssesmentId == _id).FirstOrDefault();
                db.TblAssesments.Remove(data);
                db.SaveChanges();
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                // TODO
            }
        }

        public async Task<GeneralDTO> GetAssesmentDetail(int id)
        {
            try
            {
                var assesment_details = await db.TblAssesments.Where(x => x.AssesmentId == id).Include(x => x.Class).FirstOrDefaultAsync();
                var course_name = await db.TblCourses.Where(x => x.CourseId == assesment_details.Class.CourseId).FirstOrDefaultAsync();
                var attachments = await db.TblAssesmetnAttachments.Where(x => x.AssesmentId == assesment_details.AssesmentId).ToListAsync();
                general.Course = new CourseDTO() { CourseId = assesment_details.Class.ClassId, FullName = course_name.FullName };
                mapper.Map(assesment_details, general.Assesment = new AssesmentDTO());
                mapper.Map(attachments, general.AssesmentAttachmentList = new List<AssesmetnAttachmentDTO>());
                return general;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.type = "error";
                general.message = "Server Error";
                return general;
            }
        }

        public async Task<List<GeneralDTO>> AssesmentStudents(int class_id, int assesment_id)
        {
            List<GeneralDTO> _list = new List<GeneralDTO>();
            try
            {
                var class_students = await db.TblStudentCourseRegistrations.Where(x => x.ClassId == class_id).Include(x => x.User).ToListAsync();
                foreach (var item in class_students)
                {
                    GeneralDTO dto = new GeneralDTO();
                    var profile = await db.TblProfiles.Where(x => x.ProfileId == item.User.ProfileId).FirstOrDefaultAsync();
                    var submitted_assesment = await db.TblAssesmentSubmissions.Where(x => x.UserId == item.UserId && x.AssesmentId == assesment_id).FirstOrDefaultAsync();
                    var marks = await db.TblMarks.Where(x => x.ClassId == class_id && x.UserId == item.UserId).FirstOrDefaultAsync();
                    mapper.Map(profile, dto.Profile = new ProfileDTO());
                    mapper.Map(item.User, dto.User = new UserDTO());
                    mapper.Map(submitted_assesment, dto.AssesmentSubmission = new AssesmentSubmissionDTO());
                    mapper.Map(marks, dto.Marks = new MarksDTO());
                    _list.Add(dto);
                }
                List<GeneralDTO> orders = _list.OrderByDescending(x => x.AssesmentSubmission.SubmissionTime).ToList();
                return orders;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                return null;
            }
        }

        public async Task<GeneralDTO> AssesmentSubmission(AssesmentSubmissionDTO dto)
        {
            try
            {
                TblAssesmentSubmission tbl = new TblAssesmentSubmission();
                dto.UserId = session_data.User.UserId;
                var assesment_info = await db.TblAssesments.Where(x => x.AssesmentId == dto.AssesmentId).FirstOrDefaultAsync();
                dto.DisplayName = session_data.User.UserName + "-" + session_data.Profile.Name + "-" + assesment_info.AssesmentName + "-" + assesment_info.ClassId;
                dto.SubmissionTime = DateTime.Now;
                // int chkTime = DateTime.Compare(assesment_info.End, dto.SubmissionTime);
                // if (chkTime > 0)
                // {
                //     dto.LateSubmit = true;
                // }
                dto.FilePath = Misc.UploadFile(dto.Attachment, Env, dto.DisplayName);
                mapper.Map(dto, tbl);
                await db.TblAssesmentSubmissions.AddAsync(tbl);
                await db.SaveChangesAsync();
                general.Icon = "success";
                general.Text = "Assesment Submitted";
                return general;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Icon = "error";
                general.Text = "Server Error";
                return general;
            }
        }

        public async Task<GeneralDTO> GetSingleAssesment(int assesment_id)
        {
            try
            {
                var data = await db.TblAssesmentSubmissions.Where(x => x.AssesmentId == assesment_id && x.UserId == session_data.User.UserId).FirstOrDefaultAsync();
                mapper.Map(data, general.AssesmentSubmission = new AssesmentSubmissionDTO());
                return general;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Icon = "error";
                general.Text = "Server Error";
                return general;
            }
        }
    }
}
