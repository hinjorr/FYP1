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
        GeneralDTO general = new GeneralDTO();
        public ProgramSyllabusModel(LMS_DBContext db, IMapper mapper)
        {
            this.db = db;
            this.mapper = mapper;
        }
        public async Task<GeneralDTO> AddSyllabus(List<ProgramSyllabusDTO> dto)
        {

            try
            {

                var Program_Id = dto.ElementAt(0);
                var chk = await db.TblProgramSyllabi.Where(x => x.ProgramId == Program_Id.ProgramId).ToListAsync();
                db.TblProgramSyllabi.RemoveRange(chk);
                foreach (var item in dto)
                {
                    mapper.Map(item, syllabus);
                    var data = await db.TblProgramSyllabi.AddAsync(syllabus);
                    await db.SaveChangesAsync();

                }
                general.Text = "Syllbus Created!";
                general.Icon = "success";
                return general;
            }
            catch (System.Exception)
            {
                general.Text = "Server Error!";
                general.Icon = "error";
                return general;
                throw;
            }
        }

        public async Task<int> GetCrHr(CourseDTO dto)
        {
            var data = await db.TblCourses.Where(x => x.CourseId == dto.CourseId).FirstOrDefaultAsync();
            int CrHr = Convert.ToInt32(data.CrHr);
            return CrHr;
        }
        public async Task<List<ProgramSyllabusDTO>> GetProgramSyllabus(int id)
        {
            try
            {
                var Syllabus = await db.TblProgramSyllabi.Where(x => x.ProgramId == id).Select(x => new ProgramSyllabusDTO
                {
                    SyllabusId = x.SyllabusId,
                    ProgramId = x.ProgramId,
                    CourseId = x.CourseId,
                    RqdCourseId = x.RqdCourseId,
                    RequiredCrHr = x.RequiredCrHr,

                }).ToListAsync();
                if (Syllabus.Count() != 0)
                {
                    return Syllabus;

                }
                else
                {
                    return null;

                }
            }
            catch (System.Exception ex)
            {
                return null;
            }

        }
    }
}