using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace FYP1.DTOs
{
    public class FilesDTO
    {
        public int FileId { get; set; }
        public string FilePath { get; set; }
        public string DisplayName { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }

        [JsonIgnore]
        public IFormFile Attachment { get; set; }
    }
}