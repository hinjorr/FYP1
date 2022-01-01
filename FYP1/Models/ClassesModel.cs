using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.EntityFrameworkCore;

namespace FYP1.Models
{
    public class ClassesModel : IClasses
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        GeneralDTO general = new GeneralDTO();
        TblClass Class = new TblClass();
        public ClassesModel(LMS_DBContext db, IMapper mapper)
        {
            this.db = db;
            this.mapper = mapper;
        }

        public async Task<bool> AddNewClass(ClassDTO dto)
        {
            try
            {
                mapper.Map(dto, Class);
                Class.IsActive = Convert.ToUInt32(true);
                var data = await db.TblClasses.AddAsync(Class);
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception)
            {

                return false;
            }

        }

        public async Task<List<GeneralDTO>> ViewClassesbyId(string username)
        {

            try
            {
                List<GeneralDTO> classlist = new List<GeneralDTO>();
                var chkRole = await db.TblUsers.Where(x => x.UserName == username).FirstOrDefaultAsync();
                if (chkRole.RoleId == 2)
                {
                    var facultyclasses = await db.TblFacultyCourseRegistrations.Where(x => x.Username == username).Include(x => x.Class).ToListAsync();
                    foreach (var item in facultyclasses)
                    {
                        GeneralDTO classdto = new GeneralDTO();
                        var course = await db.TblClasses.Where(x => x.ClassId == item.ClassId).Include(x => x.Course).Include(x => x.Time).Include(x => x.Day).FirstOrDefaultAsync();
                        classdto.Classes = new ClassDTO();
                        classdto.Classes.ClassId = Convert.ToInt16(item.ClassId);
                        mapper.Map(course.Course, classdto.Course = new CourseDTO());
                        mapper.Map(course.Day, classdto.Day = new DayDTO());
                        mapper.Map(course.Time, classdto.Time = new TimeDTO());
                        classlist.Add(classdto);
                    }

                }
                else if (chkRole.RoleId == 3)
                {
                    var studentclasses = await db.TblStudentCourseRegistrations.Where(x => x.Username == username).ToListAsync();
                    foreach (var item in studentclasses)
                    {
                        GeneralDTO classdto = new GeneralDTO();
                        var course = await db.TblClasses.Where(x => x.ClassId == item.ClassId).Include(x => x.Course).Include(x => x.Time).Include(x => x.Day).FirstOrDefaultAsync();
                        classdto.Classes = new ClassDTO();
                        classdto.Classes.ClassId = Convert.ToInt16(item.ClassId);
                        mapper.Map(course.Course, classdto.Course = new CourseDTO());
                        mapper.Map(course.Day, classdto.Day = new DayDTO());
                        mapper.Map(course.Time, classdto.Time = new TimeDTO());
                        classlist.Add(classdto);
                    }
                }

                return classlist;

            }
            catch (System.Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                throw;
            }

        }

        public async Task<List<GeneralDTO>> ViewStudentbyClass(int cid)
        {
            List<GeneralDTO> studentlist = new List<GeneralDTO>();
            try
            {
                var students = await db.TblStudentCourseRegistrations.Where(x => x.ClassId == cid).Include(x => x.User).ToListAsync();
                if (students.Count != 0)
                {
                    foreach (var item in students)
                    {
                        GeneralDTO dto = new GeneralDTO();
                        var getprofile = await db.TblProfiles.Where(x => x.ProfileId == item.User.ProfileId).FirstOrDefaultAsync();
                        mapper.Map(item.User, dto.User = new UserDTO());
                        mapper.Map(getprofile, dto.Profile = new ProfileDTO());
                        studentlist.Add(dto);
                    }
                }
                else
                {
                    general.Text = "No Student is Registered!";
                    general.Icon = "error";
                    studentlist.Add(general);

                }
                return studentlist;

            }
            catch (System.Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                studentlist.Add(general);
                throw;
            }

        }
        public async Task<List<ClassDTO>> ViewAllClass()
        {
            try
            {
                var classes = await db.TblClasses.Where(y => y.IsActive == Convert.ToUInt32(true)).Select(x => new ClassDTO
                {
                    ClassId = x.ClassId,
                    IsActive = x.IsActive,
                    ClassStrength = x.ClassStrength,
                    ClassImage = x.ClassImage,
                    Semester = new SemesterDTO
                    {
                        SemesterName = x.Semester.SemesterName
                    },
                    Program = new ProgramDTO
                    {
                        ProgramShortName = x.Program.ProgramShortName
                    },
                    Course = new CourseDTO
                    {
                        CourseId = Convert.ToInt32(x.CourseId),
                        ShortName = x.Course.FullName
                    },
                    Time = new TimeDTO
                    {
                        TimeName = x.Time.TimeName
                    },
                    Day = new DayDTO
                    {
                        DayName = x.Day.DayName
                    }

                }).ToListAsync();
                return classes;
            }
            catch (System.Exception)
            {

                throw;
            }

        }
        public async Task<List<CourseDTO>> ViewAllActiveCourses()
        {
            try
            {
                var courses = await (from x in db.TblClasses
                                     where x.IsActive == Convert.ToUInt16(true)
                                     select new CourseDTO
                                     {
                                         CourseId = Convert.ToInt32(x.CourseId),
                                         FullName = x.Course.FullName
                                     }).Distinct().ToListAsync();
                return courses;
            }
            catch (System.Exception)
            {

                throw;
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
        public async Task<ClassDTO> GetSingleClass(int Cid)
        {
            var GetClass = await db.TblClasses.Where(x => x.ClassId == Cid && x.IsActive == Convert.ToUInt32(true)).Select(x => new ClassDTO
            {
                ClassId = x.ClassId,
                Course = new CourseDTO()
                {
                    FullName = x.Course.FullName
                }
            }).FirstOrDefaultAsync();
            return GetClass;
        }

        // public async Task<List<ClassDTO>> ViewbyCoursesnPrograms(ClassDTO dto)
        // {
        //     var data = await db.TblClasses.Where(x => x.ProgramId == dto.ProgramId && x.CourseId == dto.CourseId && x.IsActive == Convert.ToUInt32(true)).Select(x => new ClassDTO
        //     {
        //         ClassId = x.ClassId,
        //         ClassStrength = x.ClassStrength,
        //         Semester = new SemesterDTO
        //         {
        //             SemesterName = x.Semester.SemesterName
        //         },
        //         Program = new ProgramDTO
        //         {
        //             ProgramShortName = x.Program.ProgramShortName
        //         },
        //         Course = new CourseDTO
        //         {
        //             ShortName = x.Course.ShortName
        //         },
        //         Time = new TimeDTO
        //         {
        //             TimeName = x.Time.TimeName
        //         },
        //         Day = new DayDTO
        //         {
        //             DayName = x.Day.DayName
        //         }

        //     }).ToListAsync();
        //     return data;
        // }


    }
}