using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Helpers__Filters;
using FYP1.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace FYP1.Models
{
    public class MarksModel : IMarks
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        private readonly IConfiguration config;
        private readonly IHttpContextAccessor http;
        TblMark tbl = new TblMark();
        GeneralDTO generel = new GeneralDTO();
        GeneralDTO session_data;
        public MarksModel(LMS_DBContext _db, IMapper _mapper, IConfiguration config, IHttpContextAccessor _http)
        {
            db = _db;
            mapper = _mapper;
            this.config = config;
            http = _http;
            session_data = http.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
        }

        public async Task<GeneralDTO> UploadMarks(List<MarksDTO> dto)
        {
            try
            {
                var obj = dto.ElementAt(0);
                var chk = await db.TblMarks.Where(x => x.AssesmentId == obj.AssesmentId).ToListAsync();
                if (chk.Count != 0)
                {
                    db.TblMarks.RemoveRange(chk);
                }
                List<TblMark> tbl_list = new List<TblMark>();
                mapper.Map(dto, tbl_list);
                await db.TblMarks.AddRangeAsync(tbl_list);
                await db.SaveChangesAsync();
                generel.Text = "Marks Uploaded";
                generel.Icon = "success";
                return generel;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                generel.Text = "Server Error";
                generel.Icon = "error";
                return generel;
            }
        }

        public async Task<List<GeneralDTO>> GetTestResults(MarksDTO dto)
        {
            //for faculty
            List<GeneralDTO> studentlist = new List<GeneralDTO>();
            try
            {

                var students = await db.TblStudentCourseRegistrations.Where(x => x.ClassId == dto.ClassId).ToListAsync();
                foreach (var item in students)
                {
                    GeneralDTO dTo = new GeneralDTO();
                    var userDetails = await db.TblUsers.Where(x => x.UserId == item.UserId).Include(x => x.Profile).FirstOrDefaultAsync();
                    var marks = await db.TblMarks.Where(x => x.AssesmentId == dto.AssesmentId && x.UserId == item.UserId).FirstOrDefaultAsync();
                    mapper.Map(marks, dTo.Marks = new MarksDTO());
                    mapper.Map(userDetails.Profile, dTo.Profile = new ProfileDTO());
                    mapper.Map(userDetails, dTo.User = new UserDTO());
                    studentlist.Add(dTo);
                }
                return studentlist;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                generel.Text = "Server Error";
                generel.Icon = "error";
                studentlist.Add(generel);
                return studentlist;
            }
        }

        public async Task<List<MarksDTO>> GetResults(MarksDTO dto)
        {
            try
            {
                //single student result
                var data = await db.TblMarks.Where(x => x.ClassId == dto.ClassId && x.UserId == session_data.User.UserId).Include(x => x.Assesment)
                .Select(x => new MarksDTO
                {
                    ClassId = x.ClassId,
                    AssesmentName = x.Assesment.AssesmentName,
                    TotalMarks = x.TotalMarks,
                    ObtainedMakrs = x.ObtainedMakrs
                }).ToListAsync();
                return data;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                throw;
            }

        }

        public async Task<List<AssesmentDTO>> GetAssesmentsList(int classId)
        {
            try
            {
                var data = await db.TblAssesments.Where(x => x.ClassId == classId).Select(x => new AssesmentDTO
                {
                    AssesmentId = x.AssesmentId,
                    AssesmentName = x.AssesmentName
                }).ToListAsync();
                return data;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                throw;
            }
        }

    }
}