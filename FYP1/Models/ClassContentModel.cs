using System.Runtime.CompilerServices;
using System.IO;
using System.Net.Mail;
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
        private readonly INotifications notifications;
        GeneralDTO general = new GeneralDTO();
        GeneralDTO session_data;
        TblAssesment tbl_assesment = new TblAssesment();
        DropBoxMiscModel _dropbox;
        YoutubeMix _youtube;
        public ClassContentModel(LMS_DBContext _db, IMapper _mapper, IWebHostEnvironment env, IConfiguration config, IHttpContextAccessor http, INotifications notifications)
        {

            db = _db;
            mapper = _mapper;
            Env = env;
            this.config = config;
            this.http = http;
            this.notifications = notifications;
            session_data = this.http.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
            _dropbox = new DropBoxMiscModel(config);
            _youtube = new YoutubeMix(config);

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
                var session_name = await db.TblClassSessions.Where(x => x.SessionId == dto.SessionId).FirstOrDefaultAsync();
                await db.SaveChangesAsync();
                general.type = "success";
                general.message = "Url Added";
                await notifications.Send_GroupNotification(Convert.ToInt32(dto.ClassId), 2, "new reference Link has been added in " + session_name.SessionName);

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
                // await _youtube.GetAccessToken();
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
                    int primary_key = 0;

                    if (dto.AssesmentId != 0)
                    {
                        var chk = await db.TblAssesments.Where(x => x.AssesmentId == dto.AssesmentId).FirstOrDefaultAsync();
                        mapper.Map(dto, chk);
                        await db.SaveChangesAsync();
                        primary_key = chk.AssesmentId;
                        general.message = "Assesment Updated";
                    }
                    else
                    {
                        var class_info = await db.TblClasses.Where(x => x.ClassId == dto.ClassId).Include(x => x.Course).FirstOrDefaultAsync();
                        var file_path = "/Assesments_Submission/" + class_info.Course.ShortName + " " + class_info.ClassId + "/" + dto.AssesmentName;
                        dto.SubmissionFolder = await _dropbox.CreateFolder(file_path);
                        dto.FolderPath = file_path;
                        mapper.Map(dto, tbl_assesment);
                        await db.TblAssesments.AddAsync(tbl_assesment);
                        await db.SaveChangesAsync();
                        primary_key = tbl_assesment.AssesmentId;
                        general.message = "Assesment Uploaded";
                    }
                    if (dto.Attachments != null)
                    {
                        foreach (var item in dto.Attachments)
                        {

                            var data = await _dropbox.UploadFile(item, "/Assesment_Attachment");
                            TblAssesmetnAttachment tbl = new TblAssesmetnAttachment();
                            tbl.AssesmentId = primary_key;
                            tbl.DisplayName = data.DisplayName;
                            tbl.Path = data.Path;
                            tbl.Link = data.Link;
                            await db.TblAssesmetnAttachments.AddAsync(tbl);
                            await db.SaveChangesAsync();
                        }
                    }
                    await transaction.CommitAsync();
                    general.type = "success";
                    await notifications.Send_GroupNotification(Convert.ToInt32(dto.ClassId), 1, dto.AssesmentName + " has been assigned.");

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

        public async Task<bool> DeleteAssesmentAttachment(int fileId)
        {
            var chk = await db.TblAssesmetnAttachments.Where(x => x.FileId == fileId).FirstOrDefaultAsync();
            if (chk != null)
            {
                Thread th = new Thread(() => _dropbox.DeleteFile(chk.Path).GetAwaiter());
                th.Start();
                db.TblAssesmetnAttachments.Remove(chk);
            }
            await db.SaveChangesAsync();
            return true;
        }
        public async Task<List<AssesmentDTO>> GetAssesment(int _sessionId, int _classId)
        {
            try
            {
                List<AssesmentDTO> _list = new List<AssesmentDTO>();
                List<TblAssesment> tbl_list = new List<TblAssesment>();
                var current_date = DateTime.Now;
                if (session_data.Role.RoleId == 3)
                {
                    tbl_list = await db.TblAssesments.Where(x => x.ClassId == _classId && x.SessionId == _sessionId && x.Start <= current_date).ToListAsync();
                }
                else
                {
                    tbl_list = await db.TblAssesments.Where(x => x.ClassId == _classId && x.SessionId == _sessionId).ToListAsync();
                }
                mapper.Map(tbl_list, _list);
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
                var files = db.TblAssesmetnAttachments.Where(x => x.AssesmentId == _id).ToList();
                if (files.Count != 0)
                {
                    foreach (var item in files)
                    {
                        Thread th = new Thread(() => _dropbox.DeleteFile(item.Path).GetAwaiter());
                        th.Start();
                        // Misc.DeleteFile(Env, item.Path);
                    }
                }
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
                mapper.Map(attachments, general.AssesmentAttachmentList = new List<AssesmetnAttachmentDTO>());
                mapper.Map(assesment_details, general.Assesment = new AssesmentDTO());
                general.Assesment.StartString = assesment_details.Start.Value.ToString("dddd, dd MMMM yyyy, hh:mm tt");
                general.Assesment.EndString = assesment_details.End.Value.ToString("dddd, dd MMMM yyyy, hh:mm tt");
                general.Assesment.UnixTime = new DateTimeOffset(assesment_details.End.Value).ToUnixTimeSeconds();
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
            //it will show the list of uploaded assesment in faculty view
            List<GeneralDTO> _list = new List<GeneralDTO>();
            try
            {
                var class_students = await db.TblStudentCourseRegistrations.Where(x => x.ClassId == class_id).Include(x => x.User).ToListAsync();
                foreach (var item in class_students)
                {
                    GeneralDTO dto = new GeneralDTO();
                    var _assesment = await db.TblAssesments.Where(x => x.AssesmentId == assesment_id).FirstOrDefaultAsync();
                    var profile = await db.TblProfiles.Where(x => x.ProfileId == item.User.ProfileId).FirstOrDefaultAsync();
                    var submitted_assesment = await db.TblAssesmentSubmissions.Where(x => x.UserId == item.UserId && x.AssesmentId == assesment_id).FirstOrDefaultAsync();
                    var marks = await db.TblMarks.Where(x => x.ClassId == class_id && x.UserId == item.UserId && x.AssesmentId == assesment_id).FirstOrDefaultAsync();
                    mapper.Map(profile, dto.Profile = new ProfileDTO());
                    mapper.Map(item.User, dto.User = new UserDTO());
                    mapper.Map(submitted_assesment, dto.AssesmentSubmission = new AssesmentSubmissionDTO());
                    mapper.Map(marks, dto.Marks = new MarksDTO());
                    if (submitted_assesment != null)
                    {
                        if (_assesment.End < submitted_assesment.SubmissionTime)
                        {
                            dto.AssesmentSubmission.LateSubmit = true;
                        }
                    }

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
                var chkAlreadyFile = await db.TblAssesmentSubmissions.Where(x => x.UserId == session_data.User.UserId && x.AssesmentId == dto.AssesmentId).FirstOrDefaultAsync();
                if (chkAlreadyFile != null)
                {
                    db.TblAssesmentSubmissions.Remove(chkAlreadyFile);
                    await db.SaveChangesAsync();
                }
                dto.UserId = session_data.User.UserId;
                var assesment_info = await db.TblAssesments.Where(x => x.AssesmentId == dto.AssesmentId).Include(x => x.Class.Course).FirstOrDefaultAsync();
                dto.DisplayName = session_data.User.UserName + "-" + session_data.Profile.Name + "-" + assesment_info.AssesmentName + "-" + assesment_info.ClassId + Path.GetExtension(dto.Attachment.FileName);
                dto.SubmissionTime = DateTime.Now;
                var data = await _dropbox.UploadFile(dto.Attachment, assesment_info.FolderPath, dto.DisplayName);
                dto.FilePath = data.Path;
                dto.Link = data.Link;
                dto.DisplayName = data.DisplayName;
                mapper.Map(dto, tbl);
                await db.TblAssesmentSubmissions.AddAsync(tbl);
                await db.SaveChangesAsync();

                general.Icon = "success";
                general.Text = "Assesment Submitted";

                {
                    //notfication
                    var course_info = await db.TblClasses.Where(x => x.ClassId == assesment_info.ClassId).Include(x => x.Course).FirstOrDefaultAsync();
                    var faculty_info = await db.TblFacultyCourseRegistrations.Where(x => x.ClassId == assesment_info.ClassId).FirstOrDefaultAsync();
                    await notifications.SendSingleNotification(Convert.ToInt32(faculty_info.UserId), course_info.Course.ShortName + " " + assesment_info.ClassId, 1, dto.UserId + " Submitted " + assesment_info.AssesmentName, Convert.ToInt32(assesment_info.ClassId));
                    await notifications.SendSingleNotification(Convert.ToInt32(dto.UserId), course_info.Course.ShortName + " " + assesment_info.ClassId, 1, "Your " + assesment_info.AssesmentName + " has been Submitted ", Convert.ToInt32(assesment_info.ClassId));
                }

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
                //student ko already  uploaded assesment show krega
                var assesment_info = await db.TblAssesments.Where(x => x.AssesmentId == assesment_id).FirstOrDefaultAsync();
                var data = await db.TblAssesmentSubmissions.Where(x => x.AssesmentId == assesment_id && x.UserId == session_data.User.UserId).FirstOrDefaultAsync();
                mapper.Map(data, general.AssesmentSubmission = new AssesmentSubmissionDTO());
                // TimeSpan t = assesment_info.End.Value.Subtract(data.SubmissionTime.Value);
                // general.AssesmentSubmission.TimeRemarks = t.Duration().ToString();
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
        public async Task<GeneralDTO> UploadVideos(VideosDTO _videos)
        {
            try
            {
                List<TblVideo> tbl_list = new List<TblVideo>();
                foreach (var video in _videos.Attachment)
                {
                    var video_id = await _youtube.GetVideoLink(video);
                    if (video_id != null)
                    {
                        TblVideo dto = new TblVideo();
                        dto.ClassId = _videos.ClassId;
                        dto.SessionId = _videos.SessionId;
                        dto.YtubeVideoId = video_id;
                        tbl_list.Add(dto);
                        general.type = "success";
                        general.message = "Videos Uploaded";
                    }
                    else
                    {
                        general.type = "error";
                        general.message = "Uploading Failed!";
                        break;
                    }
                }
                var session_name = await db.TblClassSessions.Where(x => x.SessionId == _videos.SessionId).FirstOrDefaultAsync();

                await db.TblVideos.AddRangeAsync(tbl_list);
                await db.SaveChangesAsync();
                await notifications.Send_GroupNotification(Convert.ToInt32(_videos.ClassId), 2, "New Lecture video(s) has been uploaded in " + session_name.SessionName);

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
        public async Task<List<VideosDTO>> GetVideos(int sessionId, int classId)
        {
            try
            {
                List<VideosDTO> _list = new List<VideosDTO>();
                var data = await db.TblVideos.Where(x => x.ClassId == classId && x.SessionId == sessionId).ToListAsync();
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

        public async Task<bool> DeleteVideo(int _videoId)
        {
            try
            {
                var chk = await db.TblVideos.Where(x => x.VideoId == _videoId).FirstOrDefaultAsync();
                if (chk != null)
                {
                    db.TblVideos.Remove(chk);
                    await db.SaveChangesAsync();
                }
                return true;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                return false;
            }
        }

        public static readonly List<string> VideoExtensions = new List<string> { ".MP4", ".MOV", ".WMV", ".AVI", ".AVCHD", "MKV", " WEBM", "MPEG-2" };

        public async Task<GeneralDTO> UploadDocs(DocDTO dto)
        {
            try
            {
                List<TblDoc> tbl_list = new List<TblDoc>();
                foreach (var file in dto.Attachments)
                {
                    if (!VideoExtensions.Contains(Path.GetExtension(file.FileName)))
                    {
                        var class_info = await db.TblClasses.Where(x => x.ClassId == dto.ClassId).Include(x => x.Course).FirstOrDefaultAsync();
                        var session_info = await db.TblClassSessions.Where(x => x.SessionId == dto.SessionId).FirstOrDefaultAsync();
                        var data = await _dropbox.UploadFile(file, "/Lectures/" + class_info.Course.ShortName + " " + class_info.ClassId + "/" + session_info.SessionName);
                        if (data != null)
                        {
                            TblDoc obj = new TblDoc();
                            obj.ClassId = dto.ClassId;
                            obj.SessionId = dto.SessionId;
                            obj.DisplayName = data.DisplayName;
                            obj.Path = data.Path;
                            obj.Link = data.Link;
                            tbl_list.Add(obj);
                            general.type = "success";
                            general.message = "Files Uploaded";
                        }
                        else
                        {
                            general.type = "error";
                            general.message = "Uploading Failed!";
                            break;
                        }
                    }
                }
                var session_name = await db.TblClassSessions.Where(x => x.SessionId == dto.SessionId).FirstOrDefaultAsync();

                await db.TblDocs.AddRangeAsync(tbl_list);
                await db.SaveChangesAsync();
                await notifications.Send_GroupNotification(Convert.ToInt32(dto.ClassId), 2, "New Lecture File(s) has been uploaded in " + session_name.SessionName);
                return general;

            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.type = "error";
                general.message = "Server Error!";
                return general;
            }
        }

        public async Task<List<DocDTO>> GetDocFiles(int class_id, int sessionId)
        {
            try
            {
                List<DocDTO> _list = new List<DocDTO>();
                var data = await db.TblDocs.Where(x => x.ClassId == class_id && x.SessionId == sessionId).ToListAsync();
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

        public async Task<bool> DeleteDocFile(int doc_id)
        {
            try
            {
                var chk = await db.TblDocs.Where(x => x.DocId == doc_id).FirstOrDefaultAsync();
                if (chk != null)
                {
                    db.TblDocs.Remove(chk);
                    Thread th = new Thread(() => _dropbox.DeleteFile(chk.Path).GetAwaiter());
                    th.Start();
                }
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                return false;
            }
        }

    }
}
