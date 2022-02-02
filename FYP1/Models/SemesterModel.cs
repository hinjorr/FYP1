using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace FYP1.Models
{
    public class SemesterModel : ISemester
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        private readonly IConfiguration config;
        public TblClassSession sessions = new TblClassSession();
        TblSemester semester = new TblSemester();
        DateTime nowdt = DateTime.Now;
        GeneralDTO general = new GeneralDTO();
        public SemesterModel(LMS_DBContext _db, IMapper mapper,IConfiguration config)
        {
            this.mapper = mapper;
            this.config = config;
            db = _db;

        }

        public async Task<GeneralDTO> StartSemester(SemesterDTO dto)
        {
            try
            {
                TblSemester sem = new TblSemester()
                {
                    SemesterName = dto.SemesterName.ToUpper(),
                    StartDate = nowdt.ToString("dd/MM/yyyy"),
                    IsActive = Convert.ToUInt32(true)
                };
                await db.TblSemesters.AddAsync(sem);
                await db.SaveChangesAsync();
                general.Text = "Semester Created";
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

        public async Task<GeneralDTO> EndSemester(SemesterDTO dto)
        {
            try
            {
                // mapper.Map(dto, semester);
                var data = await db.TblSemesters.Where(x => x.SemesterId == dto.SemesterId).FirstOrDefaultAsync();
                var endclassees = await db.TblClasses.Where(x => x.SemesterId == data.SemesterId).ToListAsync();
                var end_stdClass = await db.TblStudentCourseRegistrations.Where(x => x.SemesterId == dto.SemesterId).ToListAsync();
                var end_fcltyClasses = await db.TblFacultyCourseRegistrations.Where(x => x.SemesterId == dto.SemesterId).ToListAsync();
                endclassees.ForEach(x => x.IsActive = Convert.ToUInt32(false));
                end_stdClass.ForEach(x => x.IsActive = Convert.ToUInt32(false));
                end_fcltyClasses.ForEach(x => x.IsActive = Convert.ToUInt32(false));
                data.EndDate = nowdt.ToString("dd/MM/yyyy");
                data.IsActive = Convert.ToUInt32(false);
                await db.SaveChangesAsync();
                general.Text = "Semester Ended";
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


        public async Task<TblSemester> GetCurrentSemester()
        {
            ulong IsActive = Convert.ToUInt64(true);
            var data = await db.TblSemesters.Where(x => x.IsActive == IsActive).FirstOrDefaultAsync();
            return data;
        }

        public async Task<GeneralDTO> AddClassSession(List<ClassSessionDTO> dto)
        {
            try
            {
                var semester_id = dto.ElementAt(0);
                if (semester_id != null)
                {
                    var chkId = await db.TblClassSessions.Where(x => x.SemesterId == semester_id.SemesterId).ToListAsync();
                    if (chkId != null)
                    {
                        db.TblClassSessions.RemoveRange(chkId);
                        await db.SaveChangesAsync();
                    }
                    foreach (var item in dto)
                    {
                        mapper.Map(item, sessions);
                        var data = await db.TblClassSessions.AddAsync(sessions);
                        await db.SaveChangesAsync();
                    }
                    general.Text = "Sessions Added";
                    general.Icon = "success";
                }
                else
                {
                    general.Text = "Register a new Semester First";
                    general.Icon = "error";
                }
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

        public async Task<List<ClassSessionDTO>> GetAllSessions()
        {
            var semester = await db.TblSemesters.Where(x => x.IsActive == Convert.ToUInt32(true)).FirstOrDefaultAsync();
            if (semester != null)
            {
                var sessions = await db.TblClassSessions.Where(x => x.SemesterId == semester.SemesterId).Include(x => x.Semester).Select(x => new ClassSessionDTO
                {
                    SessionId = x.SessionId,
                    SessionName = x.SessionName,
                    SemesterId = x.SemesterId,
                    SemesterName = x.Semester.SemesterName,
                }).ToListAsync();
                return sessions;

            }
            return null;
        }
    }
}