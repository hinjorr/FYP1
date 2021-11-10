using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;

namespace FYP1.DTOs
{
    public class AutoMapperProfile:Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<UserDTO,TblUser>();
            CreateMap<AdminDTO,TblAdmin>();

            CreateMap<StudentDTO,TblStudent>();
            CreateMap<FacultyDTO,TblFaculty>();

            CreateMap<ProfileDTO,TblProfile>();
            CreateMap<TblProfile,ProfileDTO>();
            
            CreateMap<ClassDTO,TblClass>();
            CreateMap<CourseDTO,TblCourse>();
            CreateMap<CourseEligiblityDTO, TblCourseeligiblity>();
            CreateMap<DayDTO,TblDay>();
            CreateMap<FacultyCourseRegistrationDTO,TblFacultycourseregistration>();
            CreateMap<ProgramSyllabusDTO,TblProgramsyllabus>();
            CreateMap<RoleDTO,TblRole>();
            CreateMap<SemesterDTO,TblSemester>();
            CreateMap<StudentCourseRegistrationDTO,TblStudentcourseregistration>();
            CreateMap<TimeDTO,TblTime>();
            CreateMap<ClassDTO,TblClass>();
            CreateMap<ProgramDTO,TblProgram>();

        }
    }
}