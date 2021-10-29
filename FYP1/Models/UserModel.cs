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
    public class UserModel : IUser
    {
        private readonly IMapper mapper;
        private readonly LMS_DBContext db;
        TblProfile profile = new TblProfile();
        public UserModel(IMapper _mapper, LMS_DBContext _db)
        {
            mapper = _mapper;
            db = _db;
        }

        public async Task<bool> AddNewUser(ProfileDTO dto)
        {
            try
            {
                mapper.Map(dto, profile);
                profile.IsActive = 1;
                await db.TblProfiles.AddAsync(profile);
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