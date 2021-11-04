using System;
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
                mapper.Map(dto, semester);
                semester.StartDate = nowdt.ToString("dd/MM/yyyy");
                semester.IsActive = Convert.ToUInt32(true);
                await db.TblSemesters.AddAsync(semester);
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
    }
}