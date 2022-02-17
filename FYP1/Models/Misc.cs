using System;
using System.IO;
using System.Net.Mail;
using System.Text;
using FYP1.dbModels;
using FYP1.DTOs;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;

namespace FYP1.Models
{
    public static class Misc
    {
        private static readonly Random _random = new Random();

        public static int RandomNumber(int min, int max)
        {
            return _random.Next(min, max);

        }

        public static bool NewUserEmail(string profile_name, string username, string password, string user_email, IWebHostEnvironment Env, IConfiguration config)
        {
            string FolderUpload = Path.Combine(Env.WebRootPath, "Email");
            string FilePath = Path.Combine(FolderUpload, "newUser.html");
            StreamReader str = new StreamReader(FilePath);
            string body = str.ReadToEnd();
            str.Close();
            body = body.Replace("[profile_name]", profile_name);
            body = body.Replace("[username]", username);
            body = body.Replace("[password]", password);
            SendEmail(user_email, "Gramiq | User Credentials Information", body, config);
            return true;
        }
        public static bool ForgetPasswordEmail(string username, string code, string user_email, IWebHostEnvironment Env, IConfiguration config)
        {
            string FolderUpload = Path.Combine(Env.WebRootPath, "Email");
            string FilePath = Path.Combine(FolderUpload, "password-reset.html");
            StreamReader str = new StreamReader(FilePath);
            string body = str.ReadToEnd();
            str.Close();
            body = body.Replace("[username]", username);
            body = body.Replace("[code]", code);
            SendEmail(user_email, "Gramiq | Password Reset Link", body, config);
            return true;
        }
        public static void SendExceptionEmail(Exception ex, IConfiguration config)
        {

            SendEmail("masoodarif1313@gmail.com", "Exception in Gramiq", ex.ToString(), config);
        }

        public static bool SendEmail(string user_email, string subject, string body, IConfiguration config)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient(config["Email:Host"]);
                mail.From = new MailAddress(config["Email:From"], config["Email:DisplayName"]);
                mail.To.Add(user_email);
                mail.Subject = subject;
                mail.IsBodyHtml = true;
                mail.Body = body;
                SmtpServer.Port = Convert.ToInt16(config["Email:Port"]);
                SmtpServer.Credentials = new System.Net.NetworkCredential(config["Email:From"], config["Email:Password"]);
                SmtpServer.EnableSsl = true;
                SmtpServer.Send(mail);
                return true;
            }
            catch (Exception)
            {
                return false;
                throw;
            }
        }
        public static void DeleteFile(IWebHostEnvironment Env, string path)
        {
            string Folder = Path.Combine(Env.WebRootPath + path);
            FileInfo filepath = new FileInfo(Folder);
            if (filepath.Exists)
            {
                filepath.Delete();
            }
        }
        public static string UploadFile(IFormFile File, IWebHostEnvironment Env, string Filename = "")
        {
            try
            {
                // string FilePath = null;
                // string Extension = Path.GetExtension(File.FileName);
                // string FolderUpload = Path.Combine(Env.WebRootPath, "Upload");
                // if (!Directory.Exists(FolderUpload))
                // {
                //     Directory.CreateDirectory(FolderUpload);
                // }
                // if (Filename != "")
                // {
                //     FilePath = Path.Combine(FolderUpload, Filename + Extension);
                // }
                // else
                // {
                //     FilePath = Path.Combine(FolderUpload, File.FileName);
                //     Filename = Path.GetFileNameWithoutExtension(File.FileName);
                // }
                // FileInfo path = new FileInfo(FilePath);
                // if (path.Exists)
                // {
                //     path.Delete();
                // }

                // using (var filestream = new FileStream(FilePath, FileMode.Create))
                // {
                //     File.CopyTo(filestream);
                // }


                // return "/Upload" + "/" + Filename + Extension;
                return "";
            }
            catch (System.Exception)
            {
                return null;
            }
        }

        public static long CreateUnixTime(DateTime _date)
        {
            long i = new DateTimeOffset(_date).ToUnixTimeSeconds();
            return i;
        }
        public static string DecodeUnixTime(int _date)
        {
            DateTime dateTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
            string s = dateTime.AddSeconds(_date).ToLocalTime().ToString();
            return s;
        }
    }
}