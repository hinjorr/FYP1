using System.Collections.Generic;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IRegisterCourses
    {
        Task<GeneralDTO> ResgisterStudent(StudentCourseRegistrationDTO dto);
        Task<List<GeneralDTO>> GetRegisteredCourses(string username);
        Task<List<GeneralDTO>> GetClassesByCourse(int id);

        Task<GeneralDTO> DropCourse(StudentCourseRegistrationDTO dto);
        Task<GeneralDTO> ResgisterFaculty(FacultyCourseRegistrationDTO dto);
        Task<List<GeneralDTO>> GetFacultyRegisteredCourses(string username);

        Task<GeneralDTO> DropFacultyCourse(FacultyCourseRegistrationDTO dto);
    }
}