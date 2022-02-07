using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace FYP1.DTOs
{
    public class AssesmentDTO
    {

        public int AssesmentId { get; set; }
        public int? ClassId { get; set; }
        public int? SessionId { get; set; }
        public string AssesmentName { get; set; }
        public string Description { get; set; }
        public DateTime? Start { get; set; }
        public DateTime? End { get; set; }
        public string StartString { get; set; }
        public string EndString { get; set; }
        public long UnixTime { get; set; }
        public bool? LateSubmission { get; set; }

        [JsonIgnore]
        public List<IFormFile> Attachments { get; set; }
    }
}