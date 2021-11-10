using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IDropDown
    {
        Task<List<RoleDTO>> GetRole();
        Task<List<ProgramDTO>> GetPrograms();
        Task<List<DayDTO>> GetDays();
        Task<List<TimeDTO>> GetTime();
        Task<List<CourseDTO>> GetCourses();
        Task<List<CourseDTO>> GetCoursesFullName();
        Task<List<ProgramSyllabusDTO>>GetCoursesbyPrograms(int id);
    }
}