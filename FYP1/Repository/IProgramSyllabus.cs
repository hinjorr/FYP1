using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IProgramSyllabus
    {
        Task<bool> AddSyllabus(ProgramSyllabusDTO dto);
        Task<int?> GetCrHr(CourseDTO dto);
    }
}