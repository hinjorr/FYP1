using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace FYP1.DTOs
{
    public class AssesmentSubmissionDTO
    {

        public int SubmissionId { get; set; }
        public int? UserId { get; set; }
        public int? AssesmentId { get; set; }
        public string FilePath { get; set; }
        public string DisplayName { get; set; }
        public string Link { get; set; }
        public DateTime? SubmissionTime { get; set; }
        public string TimeRemarks { get; set; }
        public bool LateSubmit { get; set; }
        

        [JsonIgnore]
        public IFormFile Attachment { get; set; }

    }
}