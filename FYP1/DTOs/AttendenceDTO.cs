using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class AttendenceDTO
    {
        public int Id { get; set; }
        public int? ClassId { get; set; }

        public int? UserId { get; set; }
        public string UserName { get; set; }
        public int? SessionId { get; set; }
        public ulong? _1st { get; set; }
        public ulong? _2nd { get; set; }

        public int? TotalMarkedSesion { get; set; }
        public int? TotalPresent { get; set; }
        public int? TotalAbsent { get; set; }
    }
}