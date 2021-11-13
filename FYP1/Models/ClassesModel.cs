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

        public async Task<List<ClassDTO>> ViewAllClass()
        {
            try
            {
                var classes = await db.TblClasses.Where(y => y.IsActive == Convert.ToUInt32(true)).Select(x => new ClassDTO
                {
                    ClassId = x.ClassId,
                    ClassStrength = x.ClassStrength,
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