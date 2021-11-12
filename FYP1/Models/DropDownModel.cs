using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.EntityFrameworkCore;

namespace FYP1.Models
{
    public class DropDownModel : IDropDown
    {
        private readonly LMS_DBContext db;

        public DropDownModel(LMS_DBContext _db)
        {
            db = _db;
        }

        public async Task<List<ProgramDTO>> GetPrograms()
        {
            var programs = await db.TblPrograms.Select(x => new ProgramDTO
            {
                ProgramId = x.ProgramId,
                ProgramShortName = x.ProgramShortName
            }).ToListAsync();
            return programs;
        }

        public async Task<List<RoleDTO>> GetRole()
        {
            var roles = await db.TblRoles.Select(x => new RoleDTO
            {
                RoleId = x.RoleId,
                RoleName = x.RoleName
            }).ToListAsync();
            return roles;
        }
        public async Task<List<DayDTO>> GetDays()
        {
            var days = await db.TblDays.Select(x => new DayDTO
            {
                DayId = x.DayId,
                DayName = x.DayName
            }).ToListAsync();
            return days;
        }
        public async Task<List<TimeDTO>> GetTime()
        {
            var time = await db.TblTimes.Select(x => new TimeDTO
            {
                TimeId = x.TimeId,
                TimeName = x.TimeName
            }).ToListAsync();
            return time;
        }

        public async Task<List<CourseDTO>> GetCourses()
        {
            var courses = await db.TblCourses.Where(y => y.IsActive == Convert.ToUInt32(true)).Select(x => new CourseDTO
            {
                CourseId = x.CourseId,
                ShortName = x.ShortName
            }).ToListAsync();
            return courses;
        }

        public async Task<List<CourseDTO>> GetCoursesFullName()
        {
            var courses = await db.TblCourses.Where(y => y.IsActive == Convert.ToUInt32(true)).Select(x => new CourseDTO
            {
                CourseId = x.CourseId,
                FullName = x.FullName,
            }).ToListAsync();
            return courses;
        }

        public async Task<List<ProgramSyllabusDTO>> GetCoursesbyPrograms(int id)
        {
            // var courses = await db.TblProgramSyllabi.Where(y=>y.ProgramId==id).Select(x => new ProgramSyllabusDTO
            // {
            //     CourseId=x.CourseId,
            //     Courses=new CourseDTO{
            //         FullName=x.Course.FullName
            //     }
            // }).ToListAsync();
            var courses = await (from x in db.TblProgramSyllabi
                                 where x.ProgramId == id
                                 select new ProgramSyllabusDTO
                                 {
                                     CourseId = x.CourseId,
                                     Courses = new CourseDTO
                                     {
                                         FullName = x.Course.FullName
                                     }
                                 }).Distinct().ToListAsync();
            return courses;
        }

     
    }
}