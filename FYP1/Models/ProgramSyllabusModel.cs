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
    public class ProgramSyllabusModel : IProgramSyllabus
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        TblProgramSyllabus syllabus = new TblProgramSyllabus();

        public ProgramSyllabusModel(LMS_DBContext db, IMapper mapper)
        {
            this.db = db;
            this.mapper = mapper;
        }
        public async Task<bool> AddSyllabus(ProgramSyllabusDTO dto)
        {
            try
            {
                mapper.Map(dto, syllabus);
                var data = await db.TblProgramSyllabi.AddAsync(syllabus);
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception)
            {
                return false;
                throw;
            }
        }

        public async Task<int?> GetCrHr(CourseDTO dto)
        {
            var data = await db.TblCourses.Where(x => x.CourseId == dto.CourseId).FirstOrDefaultAsync();
            int? CrHr = data.CrHr;
            return CrHr;
        }
    }
}