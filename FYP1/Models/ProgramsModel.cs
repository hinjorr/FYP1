using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;

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
            using (var transaction = await db.Database.BeginTransactionAsync())
            {
                try
                {
                    mapper.Map(dto, program);
                    program.ProgramShortName.ToUpper();
                    await db.TblPrograms.AddAsync(program);
                    await db.SaveChangesAsync();
                    await transaction.CommitAsync();
                    return true;
                }
                catch (System.Exception)
                {

                    return false;
                }


            }
        }
    
       
    }
}