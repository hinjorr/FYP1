using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.EntityFrameworkCore;

namespace FYP1.Models
{

    public class RegisterCoursesModel : IRegisterCourses
    {
        private readonly IMapper mapper;
        private readonly LMS_DBContext db;
        GeneralDTO general = new GeneralDTO();
        TblStudentCourseRegistration tbl = new TblStudentCourseRegistration();
        TblFacultyCourseRegistration tblfaculty = new TblFacultyCourseRegistration();
        public RegisterCoursesModel(IMapper _mapper, LMS_DBContext _db)
        {
            mapper = _mapper;
            db = _db;
        }



        //Student Registration Process
        public async Task<GeneralDTO> ResgisterStudent(StudentCourseRegistrationDTO dto)
        {
            try
            {
                var class_data = await db.TblClasses.Where(x => x.ClassId == dto.ClassId).FirstOrDefaultAsync();
                var alreadyRegisteredClass = await CheckRegisteredClass(dto.ClassId, dto.Username);
                var chkclash = await CheckClash(dto.ClassId, dto.Username);
                if (alreadyRegisteredClass == true)
                {
                    general.Text = "Course Already Registered!";
                    general.Icon = "error";
                    return general;
                }
                else if (class_data.ClassStrength == class_data.EnrolledStd)
                {
                    general.Text = "Class Id full!";
                    general.Icon = "error";
                    return general;
                }
                else if (chkclash == true)
                {
                    general.Text = "Day and Time Clash occured with another Class";
                    general.Icon = "error";
                    return general;
                }
                else
                {
                    var data = await db.TblUsers.Where(x => x.UserName == dto.Username).FirstOrDefaultAsync();
                    dto.UserId = data.UserId;
                    mapper.Map(dto, tbl);
                    tbl.IsActive = Convert.ToUInt16(true);
                    await db.TblStudentCourseRegistrations.AddAsync(tbl);
                    class_data.EnrolledStd = class_data.EnrolledStd + 1;
                    await db.SaveChangesAsync();
                    general.Text = "Course Registered!";
                    general.Icon = "success";
                    return general;
                }


            }
            catch (Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                return general;
            }
        }

        public async Task<List<GeneralDTO>> GetRegisteredCourses(string username)
        {
            List<GeneralDTO> students = new List<GeneralDTO>();
            try
            {
                var data = await db.TblStudentCourseRegistrations.Where(x => x.Username == username).ToListAsync();
                if (data != null)
                {
                    foreach (var item in data)
                    {
                        GeneralDTO classdto = new GeneralDTO();
                        var course = await db.TblClasses.Where(x => x.ClassId == item.ClassId).Include(x => x.Course).Include(x => x.Time).Include(x => x.Day).FirstOrDefaultAsync();
                        mapper.Map(item, classdto.StudentCourseRegistration = new StudentCourseRegistrationDTO());
                        mapper.Map(course.Course, classdto.Course = new CourseDTO());
                        mapper.Map(course.Day, classdto.Day = new DayDTO());
                        mapper.Map(course.Time, classdto.Time = new TimeDTO());
                        students.Add(classdto);
                    }
                    return students;
                }
                else
                {
                    return null;
                }
            }
            catch (System.Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                students.Add(general);
                return students;
            }

        }
        public async Task<List<GeneralDTO>> GetClassesByCourse(int id)
        {
            var ClassesList = new List<GeneralDTO>();
            var classes = await db.TblClasses.Where(x => x.CourseId == id && x.IsActive == Convert.ToUInt16(true)).Include(x => x.Course).Include(x => x.Time).Include(x => x.Day).ToListAsync();

            foreach (var item in classes)
            {
                var dto = new GeneralDTO();
                dto.Classes = mapper.Map(item, dto.Classes);
                dto.Course = mapper.Map(item.Course, dto.Course);
                dto.Time = mapper.Map(item.Time, dto.Time);
                dto.Day = mapper.Map(item.Day, dto.Day);
                ClassesList.Add(dto);
            }
            return ClassesList;
        }

        public async Task<GeneralDTO> DropCourse(StudentCourseRegistrationDTO dto)
        {
            try
            {
                var class_data = await db.TblClasses.Where(x => x.ClassId == dto.ClassId).FirstOrDefaultAsync();
                var data = await db.TblStudentCourseRegistrations.Where(x => x.ClassId == dto.ClassId && x.Username == dto.Username).FirstOrDefaultAsync();
                if (data != null)
                {
                    db.TblStudentCourseRegistrations.Remove(data);
                    class_data.EnrolledStd = class_data.EnrolledStd - 1;
                    await db.SaveChangesAsync();
                    general.Text = "Course Dropped!";
                    general.Icon = "success";
                    return general;
                }
                else
                {
                    general.Text = "Something went wrong!";
                    general.Icon = "error";
                    return general;
                }
            }
            catch (System.Exception)
            {   
                general.Text = "Server Error!";
                general.Icon = "error";
                return general;
                throw;
            }

        }
        async Task<bool> CheckRegisteredClass(int ClassId, string Username)
        {
            try
            {
                var data = await db.TblClasses.Where(x => x.ClassId == ClassId && x.IsActive == Convert.ToUInt16(true)).FirstOrDefaultAsync();
                var chkcourse = await db.TblStudentCourseRegistrations.Where(x => x.Username == Username).Include(x => x.Class).ToListAsync();

                foreach (var item in chkcourse)
                {
                    if (data.CourseId == item.Class.CourseId)
                    {
                        return true;
                    }

                }
                return false;
            }
            catch (System.Exception)
            {

                throw;
            }

        }

        async Task<bool> CheckClash(int ClassId, string Username)
        {
            var CurentClass = await db.TblClasses.Where(x => x.ClassId == ClassId).FirstOrDefaultAsync();
            var GetOtherClasses = await db.TblStudentCourseRegistrations.Where(x => x.Username == Username).Include(x => x.Class).ToListAsync();
            foreach (var item in GetOtherClasses)
            {
                if (CurentClass.DayId == item.Class.DayId && CurentClass.TimeId == item.Class.TimeId)
                {
                    return true;
                }

            }
            return false;
        }


        //Faculty Registration Process

        public async Task<GeneralDTO> ResgisterFaculty(FacultyCourseRegistrationDTO dto)
        {
            try
            {
                var classid = Convert.ToInt16(dto.ClassId);

                if (await CheckFacultyRegisteredClass(classid, dto.Username))
                {
                    general.Text = "Class Already Registered!";
                    general.Icon = "error";
                    return general;
                }
                else if (await RegisteredbyAnotherFaculty(classid))
                {
                    general.Text = "Class Already Registered by another Faculty!";
                    general.Icon = "error";
                    return general;
                }


                else if (await CheckFacultyClash(classid, dto.Username))
                {
                    general.Text = "Day and Time Clash occured with another Class";
                    general.Icon = "error";
                    return general;
                }
                else
                {
                    var data = await db.TblUsers.Where(x => x.UserName == dto.Username).FirstOrDefaultAsync();
                    dto.UserId = data.UserId;
                    mapper.Map(dto, tblfaculty);
                    tblfaculty.IsActive = Convert.ToUInt16(true);
                    await db.TblFacultyCourseRegistrations.AddAsync(tblfaculty);
                    await db.SaveChangesAsync();
                    general.Text = "Course Registered!";
                    general.Icon = "success";
                    return general;
                }

            }
            catch (Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                return general;
            }
        }

        public async Task<List<GeneralDTO>> GetFacultyRegisteredCourses(string username)
        {
            List<GeneralDTO> faculty = new List<GeneralDTO>();
            try
            {
                var data = await db.TblFacultyCourseRegistrations.Where(x => x.Username == username).ToListAsync();
                if (data != null)
                {
                    foreach (var item in data)
                    {
                        GeneralDTO classdto = new GeneralDTO();
                        var course = await db.TblClasses.Where(x => x.ClassId == item.ClassId).Include(x => x.Course).Include(x => x.Time).Include(x => x.Day).FirstOrDefaultAsync();
                        mapper.Map(item, classdto.FacultyCourseRegistration = new FacultyCourseRegistrationDTO());
                        mapper.Map(course.Course, classdto.Course = new CourseDTO());
                        mapper.Map(course.Day, classdto.Day = new DayDTO());
                        mapper.Map(course.Time, classdto.Time = new TimeDTO());
                        faculty.Add(classdto);
                    }
                    return faculty;
                }
                else
                {
                    return null;
                }
            }
            catch (System.Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                faculty.Add(general);
                return faculty;
            }

        }
        async Task<bool> CheckFacultyRegisteredClass(int ClassId, string Username)
        {
            try
            {
                var chkcourse = await db.TblFacultyCourseRegistrations.Where(x => x.ClassId == ClassId && x.Username == Username).FirstOrDefaultAsync();
                if (chkcourse != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (System.Exception)
            {

                throw;
            }

        }

        async Task<bool> CheckFacultyClash(int ClassId, string Username)
        {
            var CurentClass = await db.TblClasses.Where(x => x.ClassId == ClassId).FirstOrDefaultAsync();
            var GetOtherClasses = await db.TblFacultyCourseRegistrations.Where(x => x.Username == Username).Include(x => x.Class).ToListAsync();
            foreach (var item in GetOtherClasses)
            {
                if (CurentClass.DayId == item.Class.DayId && CurentClass.TimeId == item.Class.TimeId)
                {
                    return true;
                }

            }
            return false;
        }

        async Task<bool> RegisteredbyAnotherFaculty(int classid)
        {
            var data = await db.TblFacultyCourseRegistrations.Where(x => x.ClassId == classid).FirstOrDefaultAsync();
            if (data != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public async Task<GeneralDTO> DropFacultyCourse(FacultyCourseRegistrationDTO dto)
        {
            try
            {
                var data = await db.TblFacultyCourseRegistrations.Where(x => x.ClassId == dto.ClassId && x.Username == dto.Username).FirstOrDefaultAsync();
                if (data != null)
                {
                    db.TblFacultyCourseRegistrations.Remove(data);
                    await db.SaveChangesAsync();
                    general.Text = "Course Dropped!";
                    general.Icon = "success";
                    return general;
                }
                else
                {
                    general.Text = "Something went wrong!";
                    general.Icon = "error";
                    return general;
                }
            }
            catch (System.Exception)
            {
                general.Text = "Server Error!";
                general.Icon = "error";
                return general;
                throw;
            }

        }
    }
}