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
    public class MarksModel : IMarks
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        TblMark tbl = new TblMark();
        GeneralDTO generel = new GeneralDTO();
        public MarksModel(LMS_DBContext _db, IMapper _mapper)
        {
            db = _db;
            mapper = _mapper;
        }

        public async Task<GeneralDTO> UploadMarks(List<MarksDTO> dto)
        {
            try
            {
                foreach (var item in dto)
                {
                    var getuser = await db.TblUsers.Where(x => x.UserName == item.UserName).FirstOrDefaultAsync();
                    item.UserId = getuser.UserId;
                    mapper.Map(item, tbl);
                    await db.TblMarks.AddAsync(tbl);
                    await db.SaveChangesAsync();
                }
                generel.Text = "Marks Uploaded";
                generel.Icon = "success";
                return generel;
            }
            catch (System.Exception)
            {
                generel.Text = "Server Error";
                generel.Icon = "error";
                return generel;
                throw;
            }
        }

        // public async Task<List<GeneralDTO>> GetTestResults(MarksDTO dto)
        // {
        //     List<GeneralDTO> studentlist = new List<GeneralDTO>();
        //     try
        //     {
        //         var data = await db.TblMarks.Where(x => x.ClassId == dto.ClassId && x.AssesmentId == dto.AssesmentId).ToListAsync();
        //         if (data != null)
        //         {
        //             foreach (var item in data)
        //             {
        //                 GeneralDTO dTo = new GeneralDTO();
        //                 var userDetails = await db.TblUsers.Where(x => x.UserId == item.UserId).Include(x => x.Profile).FirstOrDefaultAsync();
        //                 mapper.Map(item, dTo.Marks = new MarksDTO());
        //                 mapper.Map(userDetails.Profile, dTo.Profile = new ProfileDTO());
        //                 mapper.Map(userDetails, dTo.User = new UserDTO());
        //                 studentlist.Add(dTo);
        //             }
        //         }
        //         else
        //         {

        //         }
        //     }
        //     catch (System.Exception)
        //     {

        //         throw;
        //     }

        // }

        public async Task<List<MarksDTO>> GetResults(MarksDTO dto)
        {
            try
            {
                List<MarksDTO> classlist = new List<MarksDTO>();
                var data = await db.TblMarks.Where(x => x.ClassId == dto.ClassId && x.UserName == dto.UserName).ToListAsync();
                if (data.Count != 0)
                {
                    mapper.Map(data, classlist);
                    return classlist;
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