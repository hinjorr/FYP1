using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IClassContent
    {
        Task<GeneralDTO> AddUrl(UrlDTO dto);
        Task<List<GeneralDTO>> GetUrls(int _sessionId, int _classId);
        void DeleteUrl(int _id);
        Task<UrlDTO> GetSingleUrl(int _id);
    }
}