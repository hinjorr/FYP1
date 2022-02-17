using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dropbox.Api;
using Dropbox.Api.Files;
using FYP1.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;

namespace FYP1.Models
{
    public class DropBoxMiscModel : IDropBoxMisc
    {
        private readonly IConfiguration config;

        public DropBoxMiscModel(IConfiguration _config)
        {
            config = _config;
        }

        public static DropboxClient GetToken(IConfiguration _config)
        {
            var dropbox = new DropboxClient(_config["DropBox:AccessToken"]);
            return dropbox;
        }

        public async Task<string> UploadFile(IFormFile file)
        {
            try
            {
                DropboxClient token = GetToken(config);
                FileMetadata data;
                var bytes = default(byte[]);
                using (var reader = new StreamReader(file.OpenReadStream()))
                {
                    using (var memstream = new MemoryStream())
                    {
                        reader.BaseStream.CopyTo(memstream);
                        bytes = memstream.ToArray();
                    }
                }
                using (var memoryStream = new MemoryStream(bytes))
                {
                    data = await token.Files.UploadAsync("/" + file.FileName, WriteMode.Overwrite.Instance, body: memoryStream);
                }
                return data.Id;
            }
            catch (System.Exception ex)
            {
                // TODO
                throw;
            }

        }
    }
}