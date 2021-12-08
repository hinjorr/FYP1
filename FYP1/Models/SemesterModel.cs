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
                using (var transaction = await db.Database.BeginTransactionAsync())
                {
                    mapper.Map(dto, semester);
                    semester.StartDate = nowdt.ToString("dd/MM/yyyy");
                    semester.IsActive = Convert.ToUInt32(true);
                    await db.TblSemesters.AddAsync(semester);
                    dto.SemesterId = semester.SemesterId;
                    await db.SaveChangesAsync();
                    return true;
                }

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

                throw new Exception("Task Failed in AddClassSession");
            }
        }

        public async Task<List<ClassSessionDTO>> GetAllSessions()
        {
            var semester = await db.TblSemesters.Where(x => x.IsActive == Convert.ToUInt32(true)).FirstOrDefaultAsync();
            var sessions = await db.TblClassSessions.Where(x => x.SemesterId == semester.SemesterId).Select(x => new ClassSessionDTO
            {
                SessionId = x.SessionId,
                SessionName = x.SessionName,
                SemesterId=x.SemesterId
            }).ToListAsync();
            return sessions;
        }
    }
}