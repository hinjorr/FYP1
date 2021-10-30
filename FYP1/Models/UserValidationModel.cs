using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using Microsoft.EntityFrameworkCore;

namespace FYP1.Models
{

    public class UserValidationModel : IUserValidation
    {

        private readonly LMS_DBContext db;
        private readonly IMapper mapper;

        public UserValidationModel(IMapper _mapper, LMS_DBContext _db)
        {
            mapper = _mapper;
            db = _db;

        }
        public async Task<ProfileDTO> CheckNIC(ProfileDTO dto)
        {
            try
            {
                var data = await db.TblProfiles.Where(x => x.Nic == dto.Nic).FirstOrDefaultAsync();
                var mapped = mapper.Map(data, dto);
                return mapped;
            }
            catch (System.Exception)
            {

                throw;
            }

        }
    }
}