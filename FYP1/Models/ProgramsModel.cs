using System.Runtime.Serialization;
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
    public class ProgramsModel : IPrograms
    {
        private readonly IMapper mapper;
        private readonly LMS_DBContext db;
        TblProgram program = new TblProgram();
        public ProgramsModel(IMapper _mapper, LMS_DBContext _db)
        {
            mapper = _mapper;
            db = _db;
        }
        public async Task<bool> AddProgram(ProgramDTO dto)
        {
            try
            {
                mapper.Map(dto, program);
                program.ProgramShortName.ToUpper();
                await db.TblPrograms.AddAsync(program);
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception)
            {

                return false;
            }
        }

        public async Task<List<ProgramDTO>> GetPrograms()
        {
            List<ProgramDTO> _list = new List<ProgramDTO>();
            try
            {
                var data = await db.TblPrograms.ToListAsync();
                foreach (var item in data)
                {
                    ProgramDTO dto = new ProgramDTO();
                    int total_courses = await db.TblProgramSyllabi.Where(x => x.ProgramId == item.ProgramId).CountAsync();
                    int total_classes = await db.TblClasses.Where(x => x.ProgramId == item.ProgramId && x.IsActive == Convert.ToUInt16(true)).CountAsync();
                    int total_students = await db.TblStudents.Where(x => x.ProgramId == item.ProgramId).CountAsync();
                    mapper.Map(item, dto);
                    dto.Enrolled_Classes = total_classes;
                    dto.Enrolled_Courses = total_courses;
                    dto.Enrolled_Students = total_students;
                    _list.Add(dto);
                }
                return _list;
            }
            catch (System.Exception)
            {

                throw;
            }
        }

    }
}