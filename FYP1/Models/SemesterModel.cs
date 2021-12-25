using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.EntityFrameworkCore;

namespace FYP1.Models
{
    public class SemesterModel : ISemester
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        public TblClassSession sessions = new TblClassSession();
        TblSemester semester = new TblSemester();
        DateTime nowdt = DateTime.Now;
        public SemesterModel(LMS_DBContext _db, IMapper mapper)
        {
            this.mapper = mapper;
            db = _db;

        }

        public async Task<bool> StartSemester(SemesterDTO dto)
        {
            try
            {
                TblSemester sem = new TblSemester()
                {
                    SemesterName = dto.SemesterName,
                    StartDate = nowdt.ToString("dd/MM/yyyy"),
                    IsActive = Convert.ToUInt32(true)
                };
                await db.TblSemesters.AddAsync(sem);
                await db.SaveChangesAsync();
                return true;

            }
            catch (System.Exception e)
            {
                throw e;
            }
        }

        public async Task<bool> EndSemester(SemesterDTO dto)
        {
            try
            {

                // mapper.Map(dto, semester);
                var data = await db.TblSemesters.Where(x => x.SemesterId == dto.SemesterId).FirstOrDefaultAsync();
                var endclassees = await db.TblClasses.Where(x => x.SemesterId == data.SemesterId).ToListAsync();
                endclassees.ForEach(x => x.IsActive = Convert.ToUInt32(false));
                data.EndDate = nowdt.ToString("dd/MM/yyyy");
                data.IsActive = Convert.ToUInt32(false);
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception e)
            {
                throw e;
            }
        }


        public async Task<TblSemester> GetCurrentSemester()
        {
            ulong IsActive = Convert.ToUInt64(true);
            var data = await db.TblSemesters.Where(x => x.IsActive == IsActive).FirstOrDefaultAsync();
            return data;
        }

        public async Task<bool> AddClassSession(List<ClassSessionDTO> dto)
        {
            try
            {
                foreach (var items in dto)
                {
                    var chkId = await db.TblClassSessions.Where(x => x.SemesterId == items.SemesterId).FirstOrDefaultAsync();
                    if (chkId != null)
                    {
                        db.TblClassSessions.Remove(chkId);
                        await db.SaveChangesAsync();
                    }
                }

                foreach (var item in dto)
                {
                    mapper.Map(item, sessions);
                    var data = await db.TblClassSessions.AddAsync(sessions);
                    await db.SaveChangesAsync();
                }
                return true;
            }
            catch (System.Exception)
            {
                return false;
                throw new Exception("Task Failed in AddClassSession");
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