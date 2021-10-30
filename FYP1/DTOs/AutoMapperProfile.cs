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
            CreateMap<StudentDTO,TblStudent>();
            CreateMap<FacultyDTO,TblFaculty>();

            CreateMap<ProfileDTO,TblProfile>();
            CreateMap<TblProfile,ProfileDTO>();
            
            CreateMap<ClassDTO,TblClass>();
            CreateMap<CourseDTO,TblCourse>();
            CreateMap<CourseEligiblityDTO,TblCourseEligiblity>();
            CreateMap<DayDTO,TblDay>();
            CreateMap<FacultyCourseRegistrationDTO,TblFacultyCourseRegistration>();
            CreateMap<ProgramSyllabusDTO,TblProgramSyllabus>();
            CreateMap<RoleDTO,TblRole>();
            CreateMap<SemesterDTO,TblSemester>();
            CreateMap<StudentCourseRegistrationDTO,TblStudentCourseRegistration>();
            CreateMap<TimeDTO,TblTime>();
            CreateMap<ClassDTO,TblClass>();
            CreateMap<ProgramDTO,TblProgram>();

        }
    }
}