using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IClasses
    {
        Task<GeneralDTO> AddNewClass(ClassDTO dto);
        Task<List<GeneralDTO>> ViewAllClass();
        Task<List<CourseDTO>> ViewAllActiveCourses();
        Task<List<GeneralDTO>> GetClassesByCourse(int id);

        Task<List<GeneralDTO>> ViewClassesbyId(string username);
        Task<List<GeneralDTO>> ViewStudentbyClass(int cid);
        Task<bool> DeleteClass(int id);

        Task<GeneralDTO> ClassInformation(int cid);
        Task<List<ClassSessionDTO>> GetSessionsforClass(int Cid);

    }
}