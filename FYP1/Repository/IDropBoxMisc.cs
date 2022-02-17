using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;
using Microsoft.AspNetCore.Http;

namespace FYP1.Repository
{
    public interface IDropBoxMisc
    {
        Task<AssesmetnAttachmentDTO> UploadFile(IFormFile file, string Folder, string _Filename = "");
       Task DeleteFile(string Path);
    }
}