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

        public async Task<string> CreateFolder(string _Path)
        {
            try
            {
                string link = string.Empty;
                DropboxClient token = GetToken(config);
                // SearchV2Arg arg = new SearchV2Arg(_Path);
                // var chk = await token.Files.SearchV2Async(arg);
                // if (chk.Matches.Count == 0)
                // {
                var folder_arg = new CreateFolderArg(_Path);
                var chk_folder = await token.Files.CreateFolderV2Async(folder_arg);
                // var chk_sharing = await token.Sharing.ListSharedLinksAsync((chk_folder.Metadata.PathDisplay));
                // if (chk_sharing.Links.Count != 0)
                // {
                //     var url = chk_sharing.Links.First();
                //     link = url.ToString();
                // }
                if (chk_folder.Metadata.SharingInfo == null)
                {
                    var result = await token.Sharing.CreateSharedLinkWithSettingsAsync(chk_folder.Metadata.PathDisplay);
                    link = result.Url;
                }
                // }
                return link;
            }
            catch (System.Exception)
            {
                // Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                // thr.Start();
                return null;
            }
        }

        public async Task<AssesmetnAttachmentDTO> UploadFile(IFormFile file, string _Path, string _Filename = "")
        {
            try
            {
                // await _youtube.GetVideoLink(file);
                AssesmetnAttachmentDTO dto = new AssesmetnAttachmentDTO();
                await CreateFolder(_Path);
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
                    FileMetadata data = await token.Files.UploadAsync(_Path + "/" + filename, WriteMode.Overwrite.Instance, body: memoryStream);
                    dto.DisplayName = data.Name;
                    dto.Path = data.PathDisplay;

                    // var chk = await token.Sharing.ListSharedLinksAsync((data.PathDisplay)); 
                    // if (chk.Links.Count != 0)
                    // {
                    //     var url = chk.Links.First();
                    //     dto.Link = url.Url;
                    // }
                    if (data.SharingInfo == null)
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