using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FYP1.DTOs
{
    public class YoutubeSnippet
    {
        public string title { get; set; }
        public string description { get; set; }
        public int categoryId { get; set; }
    }
    public class YoutubeStatus
    {
        public string privacyStatus { get; set; }
        public bool embeddable { get; set; }
        public string license { get; set; }
    }
    public class YoutubeDTO
    {
        public YoutubeSnippet snippet { get; set; }
        public YoutubeStatus status { get; set; }

    }

    public static class TokenConfig
    {
        public static string access_token { get; set; }
        public static DateTime expiry_date { get; set; }
    }
}