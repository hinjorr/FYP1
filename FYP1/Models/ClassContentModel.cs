using System.Threading;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace FYP1.Models
{
    public class ClassContentModel : IClassContent
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        private readonly IWebHostEnvironment Env;
        private readonly IConfiguration config;
        GeneralDTO general = new GeneralDTO();
        TblAssesment tbl_assesment = new TblAssesment();
        public ClassContentModel(LMS_DBContext _db, IMapper _mapper, IWebHostEnvironment env, IConfiguration config)
        {
            db = _db;
            mapper = _mapper;
            Env = env;
            this.config = config;
        }

        public async Task<GeneralDTO> AddUrl(UrlDTO dto)
        {
            try
            {
                if (dto.UrlId == 0)
                {
                    TblUrl tbl = new TblUrl();
                    mapper.Map(dto, tbl);
                    await db.TblUrls.AddAsync(tbl);
                }
                else
                {
                    var update = await db.TblUrls.Where(x => x.UrlId == dto.UrlId).FirstOrDefaultAsync();
                    update.Link = dto.Link;
                    update.DisplayName = dto.DisplayName;
                }
                await db.SaveChangesAsync();
                general.type = "success";
                general.message = "Url Added";
                return general;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.type = "error";
                general.message = "Server Error";
                return general;
            }
        }

        public async Task<List<UrlDTO>> GetUrls(int _sessionId, int _classId)
        {
            try
            {
                List<UrlDTO> _list = new List<UrlDTO>();
                var data = await db.TblUrls.Where(x => x.ClassId == _classId && x.SessionId == _sessionId).ToListAsync();
                mapper.Map(data, _list);
                return _list;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                return null;

            }
        }

        public void DeleteUrl(int _id)
        {
            try
            {
                var data = db.TblUrls.Where(x => x.UrlId == _id).FirstOrDefault();
                db.TblUrls.Remove(data);
                db.SaveChanges();
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
            }
        }

        public async Task<UrlDTO> GetSingleUrl(int _id)
        {
            UrlDTO dto = new UrlDTO();
            try
            {
                var data = await db.TblUrls.Where(x => x.UrlId == _id).FirstOrDefaultAsync();
                mapper.Map(data, dto);
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                // TODO
            }
            return dto;

        }

        public async Task<GeneralDTO> UploadAssesment(AssesmentDTO dto)
        {
            using (var transaction = await db.Database.BeginTransactionAsync())
            {
                try
                {
                    mapper.Map(dto, tbl_assesment);
                    await db.TblAssesments.AddAsync(tbl_assesment);
                    // await db.SaveChangesAsync();
                    if (dto.Attachments != null)
                    {
                        foreach (var item in dto.Attachments)
                        {
                            TblAssesmetnAttachment tbl = new TblAssesmetnAttachment();
                            tbl.AssesmentId = tbl_assesment.AssesmentId;
                            tbl.Path = Misc.UploadFile(item, Env);
                            await db.TblAssesmetnAttachments.AddAsync(tbl);
                        }
                        await db.SaveChangesAsync();
                    }
                    await transaction.CommitAsync();
                    general.type = "success";
                    general.message = "Assesment Uploaded";
                    return general;
                }
                catch (System.Exception ex)
                {
                    Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                    thr.Start();
                    general.type = "error";
                    general.message = "Server Error";
                    return general;
                }
            }
        }

        public async Task<List<AssesmentDTO>> GetAssesment(int _sessionId, int _classId)
        {
            try
            {
                List<AssesmentDTO> _list = new List<AssesmentDTO>();
                var data = await db.TblAssesments.Where(x => x.ClassId == _classId && x.SessionId == _sessionId).ToListAsync();
                mapper.Map(data, _list);
                return _list;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                return null;
            }
        }
        public void DeleteAssesment(int _id)
        {
            try
            {
                var data = db.TblAssesments.Where(x => x.AssesmentId == _id).FirstOrDefault();
                db.TblAssesments.Remove(data);
                db.SaveChanges();
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                // TODO
            }
        }

    }
}