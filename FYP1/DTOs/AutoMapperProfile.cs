using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;

namespace FYP1.DTOs
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<UserDTO, TblUser>();
            CreateMap<TblUser, UserDTO>();
            CreateMap<AdminDTO, TblAdmin>();

            CreateMap<StudentDTO, TblStudent>();
            CreateMap<TblStudent, StudentDTO>();

            CreateMap<FacultyDTO, TblFaculty>();
            CreateMap<TblFaculty, FacultyDTO>();

            CreateMap<ProfileDTO, TblProfile>();
            CreateMap<TblProfile, ProfileDTO>();

            CreateMap<ClassDTO, TblClass>();
            CreateMap<TblClass, ClassDTO>();

            CreateMap<CourseDTO, TblCourse>();
            CreateMap<TblCourse, CourseDTO>();


            CreateMap<CourseEligiblityDTO, TblCourseEligiblity>();

            CreateMap<DayDTO, TblDay>();
            CreateMap<TblDay, DayDTO>();


            CreateMap<FacultyCourseRegistrationDTO, TblFacultyCourseRegistration>();
            CreateMap<TblFacultyCourseRegistration, FacultyCourseRegistrationDTO>();

            CreateMap<ProgramSyllabusDTO, TblProgramSyllabus>();


            CreateMap<RoleDTO, TblRole>();
            CreateMap<TblRole, RoleDTO>();

            CreateMap<SemesterDTO, TblSemester>();
            CreateMap<ClassSessionDTO, TblClassSession>();


            CreateMap<StudentCourseRegistrationDTO, TblStudentCourseRegistration>();
            CreateMap<TblStudentCourseRegistration, StudentCourseRegistrationDTO>();

            CreateMap<TimeDTO, TblTime>();
            CreateMap<TblTime, TimeDTO>();

            CreateMap<ClassDTO, TblClass>();
            CreateMap<ProgramDTO, TblProgram>();

        }
    }
}