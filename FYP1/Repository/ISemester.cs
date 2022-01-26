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
        Task<GeneralDTO> StartSemester(SemesterDTO dto);
        Task<GeneralDTO> EndSemester(SemesterDTO dto);
        Task<GeneralDTO> AddClassSession(List<ClassSessionDTO> dto);
        Task<TblSemester> GetCurrentSemester();
        Task<List<ClassSessionDTO>> GetAllSessions();
    }
}