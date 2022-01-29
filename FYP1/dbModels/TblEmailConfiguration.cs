using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblEmailConfiguration
    {
        public int Id { get; set; }
        public string From { get; set; }
        public string Host { get; set; }
        public string Password { get; set; }
        public int? Port { get; set; }
    }
}
