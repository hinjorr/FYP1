using System;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;

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


    }
}