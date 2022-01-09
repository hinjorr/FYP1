using System.Collections.Generic;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface ICourse
    {
        Task<bool> AddNewCourse(CourseDTO dto);
        Task<List<CourseDTO>> GetCourses();
        Task<CourseDTO> GetCoursebyID(int id);
        Task<bool> UpdateDetails(CourseDTO dto);
        Task<bool> DeleteCourse(int id);
    }
}