using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace FYP1.DTOs
{
    public class ClassContentDTO
    {
        public int ContentId { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }
        public string ContentName { get; set; }
        public string ContentLink { get; set; }
        public List<IFormFile> Attachments { get; set; }
    }
}