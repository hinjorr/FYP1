using System;
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
    public class ClassContentModel : IClassContent
    {
        private readonly LMS_DBContext db;
        private readonly IMapper mapper;
        GeneralDTO general = new GeneralDTO();

        public ClassContentModel(LMS_DBContext _db, IMapper _mapper)
        {
            db = _db;
            mapper = _mapper;
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
                general.Icon = "success";
                return general;
            }
            catch (System.Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                return general;
            }
        }

        public async Task<List<GeneralDTO>> GetUrls(int _sessionId, int _classId)
        {
            List<GeneralDTO> _list = new List<GeneralDTO>();
            try
            {
                var data = await db.TblUrls.Where(x => x.ClassId == _classId && x.SessionId == _sessionId).ToListAsync();
                if (data.Count != 0)
                {
                    foreach (var item in data)
                    {
                        GeneralDTO dto = new GeneralDTO();
                        mapper.Map(item, dto.Url = new UrlDTO());
                        _list.Add(dto);
                    }
                }

                return _list;

            }
            catch (System.Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                _list.Add(general);
                return _list;

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
            catch (System.Exception)
            {
                // TODO
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
            catch (System.Exception)
            {
                // TODO
            }
            return dto;

        }
    }
}