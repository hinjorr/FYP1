using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface ISemester
    {
        Task<bool> StartSemester(SemesterDTO dto);
        Task<bool> EndSemester(SemesterDTO dto);
        Task<bool> AddClassSession(List<ClassSessionDTO> dto);
        Task<TblSemester> GetCurrentSemester();
        Task<List<ClassSessionDTO>> GetAllSessions();
    }
}