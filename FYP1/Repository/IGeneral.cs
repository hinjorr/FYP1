using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IGeneral
    {
        Task<List<RoleDTO>> GetRole();
        Task<List<ProgramDTO>> GetPrograms();
        Task<List<DayDTO>> GetDays();
        Task<List<TimeDTO>> GetTime();
        Task<List<CourseDTO>> GetCourses();
        Task<List<CourseDTO>> GetCoursesFullName();
        Task<List<ProgramSyllabusDTO>> GetCoursesbyPrograms(int id);
        Task<int> ToTalUsers();
        Task<int> ToTalStudents();
        Task<int> ToTalFaculty();
        Task<int> ToTalAdmins();
        Task<int> ToTalPrograms();
        Task<int> ToTalCourses();
        Task<int> ToTalActiveClasses();
        Task<List<GeneralDTO>> GetStudents();
        Task<List<GeneralDTO>> GetFaculty();

    }
}