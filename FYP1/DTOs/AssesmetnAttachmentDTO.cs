using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class AssesmetnAttachmentDTO
    {
        public int FileId { get; set; }
        public int? AssesmentId { get; set; }
        public string DisplayName { get; set; }
        public string PathId { get; set; }

    }
}