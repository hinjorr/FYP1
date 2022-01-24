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
        public async Task<GeneralDTO> CheckNIC(GeneralDTO dto)
        {
            try
            {
                var data = await db.TblProfiles.Where(x => x.Nic == dto.Profile.Nic).FirstOrDefaultAsync();

                if (data != null)
                {
                    mapper.Map(data, dto.Profile = new ProfileDTO());
                    var user = await db.TblUsers.Where(x => x.ProfileId == data.ProfileId).Include(z => z.Role).FirstOrDefaultAsync();
                    mapper.Map(user.Role, dto.Role = new RoleDTO());
                    // mapped.Role = new RoleDTO
                    // {
                    //     RoleId = user.Role.RoleId,
                    //     RoleName = user.Role.RoleName
                    // };
                     return dto;
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