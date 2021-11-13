using System.Collections.Generic;
using System;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace FYP1.Models
{
    public class CourseModel : ICourse
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        TblCourse course = new TblCourse();

        public CourseModel(LMS_DBContext db, IMapper mapper)
        {
            this.db = db;
            this.mapper = mapper;
        }
        public async Task<bool> AddNewCourse(CourseDTO dto)
        {
            try
            {
                mapper.Map(dto, course);
                course.ShortName.ToUpper();
                course.IsActive = Convert.ToUInt32(true);
                var data = await db.TblCourses.AddAsync(course);
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception)
            {
                return false;
            }

        }
        public async Task<bool> UpdateDetails(CourseDTO dto)
        {
            try
            {
                var data = await db.TblCourses.Where(x => x.CourseId == dto.CourseId).FirstOrDefaultAsync();
                data.FullName = dto.FullName;
                data.ShortName = dto.ShortName;
                data.CrHr = dto.CrHr;
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception)
            {

                throw;
            }

        }
        public async Task<List<CourseDTO>> GetCourses()
        {
            var courses = await db.TblCourses.Select(x => new CourseDTO
            {
                CourseId = x.CourseId,
                FullName = x.FullName,
                ShortName = x.ShortName,
                CrHr = x.CrHr,
                IsActive = Convert.ToBoolean(x.IsActive),
            }).ToListAsync();
            return courses;
        }

        public async Task<CourseDTO> GetCoursebyID(int id)
        {
            CourseDTO dto = new CourseDTO();
            var course = await db.TblCourses.FindAsync(id);
            mapper.Map(course, dto);
            return dto;
        }
    }
}