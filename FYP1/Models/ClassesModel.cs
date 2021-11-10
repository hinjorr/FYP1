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
                var data = await db.TblClasses.AddAsync(Class);
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception)
            {

                return false;
            }

        }
    }
}