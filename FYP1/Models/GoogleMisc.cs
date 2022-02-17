using Google.Apis.Auth.OAuth2;
using Google.Apis.Download;
using Google.Apis.Drive.v3;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using Microsoft.AspNetCore.Hosting;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;

namespace FYP1.Models
{
    public static class GoogleMisc
    {
        public static string[] Scopes = { Google.Apis.Drive.v3.DriveService.Scope.Drive };

        public static DriveService GetService(IWebHostEnvironment Env)
        {
            UserCredential credential;
            var CSPath = Path.Combine(Env.WebRootPath, "client_secret.json");

            using (var stream = new FileStream(CSPath, FileMode.Open, FileAccess.Read))
            {
                String FilePath = Path.Combine(Env.WebRootPath, "DriveServiceCredentials.json");

                credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                    GoogleClientSecrets.FromStream(stream).Secrets,
                    Scopes,
                    "user",
                    CancellationToken.None,
                    new FileDataStore(FilePath, true)).Result;
            }

            //create Drive API service.    
            DriveService service = new DriveService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "GoogleDriveRestAPI-v3",
            });
            return service;
        }

        public static string CreateFolder(string FolderName, IWebHostEnvironment Env)
        {
            DriveService service = GetService(Env);
            var FileMetaData = new Google.Apis.Drive.v3.Data.File();
            FileMetaData.Name = FolderName;
            FileMetaData.MimeType = "application/vnd.google-apps.folder";

            FilesResource.CreateRequest request;

            request = service.Files.Create(FileMetaData);
            request.Fields = "id";
            var file = request.Execute();
            return file.Id;
        }
    }
}
