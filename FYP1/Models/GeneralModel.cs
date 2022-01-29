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
    public class GeneralModel : IGeneral
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;

        public GeneralModel(LMS_DBContext _db, IMapper _mapper)
        {
            db = _db;
            mapper = _mapper;
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

        public async Task<int> ToTalUsers()
        {
            var data = await db.TblUsers.Where(x => x.IsActive == Convert.ToUInt16(true)).CountAsync();
            return data;
        }
        public async Task<int> ToTalStudents()
        {
            var data = await db.TblUsers.Where(x => x.IsActive == Convert.ToUInt16(true) && x.RoleId == 3).CountAsync();
            return data;
        }
        public async Task<int> ToTalFaculty()
        {
            var data = await db.TblUsers.Where(x => x.IsActive == Convert.ToUInt16(true) && x.RoleId == 2).CountAsync();
            return data;
        }
        public async Task<int> ToTalAdmins()
        {
            var data = await db.TblUsers.Where(x => x.IsActive == Convert.ToUInt16(true) && x.RoleId == 1).CountAsync();
            return data;
        }
        public async Task<int> ToTalPrograms()
        {
            var data = await db.TblPrograms.Where(x => x.IsActive == Convert.ToUInt16(true)).CountAsync();
            return data;
        }
        public async Task<int> ToTalCourses()
        {
            var data = await db.TblCourses.Where(x => x.IsActive == Convert.ToUInt16(true)).CountAsync();
            return data;
        }
        public async Task<int> ToTalActiveClasses()
        {
            var data = await db.TblClasses.Where(x => x.IsActive == Convert.ToUInt16(true)).CountAsync();
            return data;
        }
        
        public async Task<List<GeneralDTO>> GetStudents()
        {
            try
            {
                List<GeneralDTO> dto = new List<GeneralDTO>();
                var data = await db.TblStudents.Include(x => x.User).ToListAsync();
                foreach (var item in data)
                {
                    var profile = await db.TblProfiles.Where(x => x.ProfileId == item.User.ProfileId).FirstOrDefaultAsync();
                    var a = new GeneralDTO();
                    a.Student = mapper.Map(item, new StudentDTO());
                    a.User = mapper.Map(item.User, new UserDTO());
                    a.Profile = mapper.Map(profile, new ProfileDTO());
                    dto.Add(a);
                }
                return dto;
            }
            catch (System.Exception )
            {
                return null;
            }
        }


    }
}