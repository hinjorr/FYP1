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
                if (data != null)
                {
                    var user = await db.TblUsers.Where(x => x.ProfileId == data.ProfileId).FirstOrDefaultAsync();
                    var mapped = mapper.Map(data, dto);
                    mapped.User.RoleId = user.RoleId;
                    return mapped;
                }
                else
                {
                    return null;
                }

            }
            catch (System.Exception)
            {

                throw;
            }

        }
    }
}