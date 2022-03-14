using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Dropbox.Api;
using Dropbox.Api.Files;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;

namespace FYP1.Models
{
    public class DropBoxMiscModel
    {
        private readonly IConfiguration config;

        public DropBoxMiscModel(IConfiguration _config)
        {
            config = _config;
        }

        private DropboxClient GetToken(IConfiguration _config)
        {
            var dropbox = new DropboxClient(_config["DropBox:AccessToken"]);
            return dropbox;
        }

        private async Task CreateFolder(string Folder)
        {
            try
            {
                DropboxClient token = GetToken(config);
                var folders = await token.Files.ListFolderAsync(string.Empty);
                var chk = folders.Entries.Where(x => x.IsFolder == true && x.Name == Folder).ToList();
                if (chk.Count == 0)
                {
                    var folderArg = new CreateFolderArg("/" + Folder);
                    var chk_ = await token.Files.CreateFolderV2Async(folderArg);
                }

            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                throw;
            }
        }
        public async Task<AssesmetnAttachmentDTO> UploadFile(IFormFile file, string Folder, string _Filename = "")
        {
            try
            {
                // await _youtube.GetVideoLink(file);
                AssesmetnAttachmentDTO dto = new AssesmetnAttachmentDTO();
                await CreateFolder(Folder);
                DropboxClient token = GetToken(config);
                var bytes = default(byte[]);
                using (var reader = new StreamReader(file.OpenReadStream()))
                {
                    using (var memstream = new MemoryStream())
                    {
                        await reader.BaseStream.CopyToAsync(memstream);
                        bytes = memstream.ToArray();
                    }
                }
                using (var memoryStream = new MemoryStream(bytes))
                {
                    string filename = "";
                    if (_Filename == "")
                    {
                        filename = Path.GetFileNameWithoutExtension(file.FileName) + "-" + Misc.RandomNumber(1, 856325) + Path.GetExtension(file.FileName);
                    }
                    else
                    {
                        filename = _Filename;
                    }
                    FileMetadata data = await token.Files.UploadAsync("/" + Folder + "/" + filename, WriteMode.Overwrite.Instance, body: memoryStream);
                    dto.DisplayName = data.Name;
                    dto.Path = data.PathDisplay;
                    var chk = await token.Sharing.ListSharedLinksAsync((data.PathDisplay));
                    if (chk.Links.Count != 0)
                    {
                        var url = chk.Links.First();
                        dto.Link = url.Url;
                    }
                    else
                    {
                        var result = await token.Sharing.CreateSharedLinkWithSettingsAsync(data.PathDisplay);
                        dto.Link = result.Url;
                    }

                }

                return dto;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                throw;
            }

        }

        public async Task DeleteFile(string Path)
        {
            try
            {
                DropboxClient token = GetToken(config);
                var dltArg = new DeleteArg(Path);
                await token.Files.DeleteV2Async(dltArg);
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
            }
        }
    }
}