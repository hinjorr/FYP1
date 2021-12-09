using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.dbModels;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IClasses
    {
        Task<bool> AddNewClass(ClassDTO dto);
        Task<List<ClassDTO>> ViewAllClass();
        Task<ClassDTO> GetSingleClass(int Cid);

    }
}