using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IAttendence
    {
        Task<List<GeneralDTO>> GetAttendenceStudents(AttendenceDTO dto);
        Task<GeneralDTO> MarkAttendence(List<AttendenceDTO> dto);
        Task<List<GeneralDTO>> StudentAttendenceReport();
    }
}