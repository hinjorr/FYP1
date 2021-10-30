using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.EntityFrameworkCore;

namespace FYP1.Models
{
    public class DropDownModel : IDropDown
    {
        private readonly LMS_DBContext db;

        public DropDownModel(LMS_DBContext _db)
        {
            db = _db;
        }

        public async Task<List<ProgramDTO>> GetPrograms()
        {
            var programs = await db.TblPrograms.Select(x => new ProgramDTO
            {
                ProgramId = x.ProgramId,
                ProgramShortName = x.ProgramShortName
            }).ToListAsync();
            return programs;
        }

        public async Task<List<RoleDTO>> GetRole()
        {
            var roles = await db.TblRoles.Select(x => new RoleDTO
            {
                RoleId = x.RoleId,
                RoleName = x.RoleName
            }).ToListAsync();
            return roles;
        }

        // public async Task<ProfileDTO> CheckData(string nic)
        // {
        //     var chk=db.TblProfiles.Where(x=>x.Nic==nic).FirstOrDefaultAsync();
        //     if (chk!=null)
        //     {
                
        //     }
                 
        // }
    }
}