using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace FYP1.Repository
{
    public interface IDropBoxMisc
    {
        Task<string> UploadFile(IFormFile file);
    }
}