using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace FYP1.DTOs
{
    public class VideosDTO
    {
        public int VideoId { get; set; }
        public string YtubeVideoId { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }

        [JsonIgnore]
        public List<IFormFile> Attachment { get; set; }
    }
}