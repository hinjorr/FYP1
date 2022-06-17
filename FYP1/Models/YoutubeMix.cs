using System.Text;
using System;
using System.IO;
using System.Net.Http;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using System.Net.Http.Headers;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Http;
using FYP1.DTOs;

namespace FYP1.Models
{
    public class YoutubeMix
    {
        private readonly IConfiguration config;
        public YoutubeMix(IConfiguration config)
        {
            this.config = config;
        }

        HttpClient client = new HttpClient();
        public async Task GetAccessToken()
        {
            try
            {
                HttpContent content = new FormUrlEncodedContent(new[]{
                    new KeyValuePair<string,string>("client_id",config["Youtube:client_id"]),
                    new KeyValuePair<string,string>("client_secret",config["Youtube:client_secret"]),
                    new KeyValuePair<string,string>("grant_type","refresh_token"),
                    new KeyValuePair<string,string>("refresh_token",config["Youtube:refresh_token"])
                });

                content.Headers.ContentType = new MediaTypeHeaderValue("application/x-www-form-urlencoded");
                HttpResponseMessage resp = await client.PostAsync("https://oauth2.googleapis.com/token", content);
                var data = await resp.Content.ReadAsStringAsync();

                var json_converted = JObject.Parse(data);
                var access_token = json_converted["access_token"].ToString();
                TokenConfig.access_token = access_token;
                TokenConfig.expiry_date = DateTime.Now.AddMinutes(59);
            }
            catch (System.Exception)
            {
                // TODO
            }
        }
        public async Task<string> GetVideoLink(IFormFile video)
        {
            try
            {
                string _videoId = "";
                YoutubeDTO obj = new YoutubeDTO()
                {
                    snippet = new YoutubeSnippet()
                    {
                        title = Path.GetFileNameWithoutExtension(video.FileName),
                        categoryId = 27
                    },
                    status = new YoutubeStatus()
                    {
                        privacyStatus = "public",
                        embeddable = true,
                        license = "youtube"
                    }
                };

                HttpContent content = new StringContent(JsonConvert.SerializeObject(obj), Encoding.UTF8, "application/json");
                if (TokenConfig.expiry_date < DateTime.Now)
                {
                    await GetAccessToken();
                }
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", TokenConfig.access_token);
                client.DefaultRequestHeaders.Add("x-upload-content-type", "video/*");
                client.DefaultRequestHeaders.Add("X-Upload-Content-Length", video.Length.ToString());
                HttpResponseMessage resp = await client.PostAsync("https://www.googleapis.com/upload/youtube/v3/videos?uploadType=resumable&part=snippet,status", content);
                // HttpResponseMessage resp = await client.PostAsync("#", content);
                if (resp.IsSuccessStatusCode)
                {
                    var location = resp.Headers.Location;
                    _videoId = await UploadViaLink(location.ToString(), video, TokenConfig.access_token);
                    // await UploadVideo("https://www.googleapis.com/upload/youtube/v3/videos?uploadType=resumable&part=snippet,status&upload_id=ADPycdsIr6FtdbZJs-dD3CinxBZrvtpILBg5fsntVLy9GFAPRISJosJZgNf6WHCQMlGQ1kiWgiDi-I-N7VmL-CsQBV8OdI7N6g", video, TokenConfig.access_token);
                }
                return _videoId;
            }
            catch (System.Exception)
            {
                return null;
            }
        }
        public async Task<string> UploadViaLink(string Link, IFormFile video, string token)
        {
            try
            {
                var data = default(byte[]);
                using (var memoryStream = new MemoryStream())
                {
                    await video.CopyToAsync(memoryStream);
                    data = memoryStream.ToArray();
                }
                HttpContent content = new ByteArrayContent(data);
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                content.Headers.Add("Content-Type", "video/*");
                content.Headers.Add("Content-Length", video.Length.ToString());
                HttpResponseMessage resp = await client.PutAsync(Link, content);
                var resp_data = await resp.Content.ReadAsStringAsync();
                var json_converted = JObject.Parse(resp_data);
                var video_id = json_converted["id"].ToString();
                return video_id;
            }
            catch (System.Exception)
            {
                return null;
                // TODO
            }
        }
        public async Task<string> CreatePlaylist(string playlist_name, string _description = "")
        {
            try
            {
                YoutubeDTO obj = new YoutubeDTO()
                {
                    snippet = new YoutubeSnippet()
                    {
                        title = playlist_name,
                        description = _description
                    },
                    status = new YoutubeStatus()
                    {
                        privacyStatus = "public",
                    }
                };
                HttpContent content = new StringContent(JsonConvert.SerializeObject(obj), Encoding.UTF8, "application/json");
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", TokenConfig.access_token);
                HttpResponseMessage resp = await client.PostAsync("https://www.googleapis.com/youtube/v3/playlists?part=snippet,status", content);
                var data = await resp.Content.ReadAsStringAsync();
                var json_converted = JObject.Parse(data);
                var playlist_id = json_converted["id"].ToString();
                return playlist_id;
            }
            catch (System.Exception)
            {
                return null;
            }
        }

        // public async Task UploadVideos(List<IFormFile> _videos)
        // {
        //     try
        //     {
        //         foreach (var item in _videos)
        //         {
        //             await GetVideoLink(item);
        //         }
        //     }
        //     catch (System.Exception ex)
        //     {
        //         // TODO
        //     }
        // }

    }
}