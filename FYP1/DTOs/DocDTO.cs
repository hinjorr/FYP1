using System.Net.Mail;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace FYP1.DTOs
{
    public class DocDTO
    {
        public int DocId { get; set; }
        public string DisplayName { get; set; }
        public string Path { get; set; }
        public string Link { get; set; }
        public int? SessionId { get; set; }
        public int? ClassId { get; set; }

        public List<IFormFile> Attachments { get; set; }
    }
}