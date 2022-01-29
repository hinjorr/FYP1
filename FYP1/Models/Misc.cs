using System;
using System.IO;
using System.Net.Mail;
using FYP1.DTOs;
using Microsoft.AspNetCore.Hosting;

namespace FYP1.Models
{
    public static class Misc
    {
        private static readonly Random _random = new Random();

        public static int RandomNumber(int min, int max)
        {
            return _random.Next(min, max);

        }

        public static bool NewUserEmail(string profile_name, string username, string password, string user_email, IWebHostEnvironment Env)
        {
            string FolderUpload = Path.Combine(Env.WebRootPath, "Email");
            string FilePath = Path.Combine(FolderUpload, "newUser.html");
            StreamReader str = new StreamReader(FilePath);
            string body = str.ReadToEnd();
            str.Close();
            body = body.Replace("[profile_name]", profile_name);
            body = body.Replace("[username]", username);
            body = body.Replace("[password]", password);
            SendEmail(user_email, "Gramiq | User Credentials Information", body);
            return true;
        }
        public static bool ForgetPasswordEmail(string username, string code, string user_email, IWebHostEnvironment Env)
        {
            string FolderUpload = Path.Combine(Env.WebRootPath, "Email");
            string FilePath = Path.Combine(FolderUpload, "password-reset.html");
            StreamReader str = new StreamReader(FilePath);
            string body = str.ReadToEnd();
            str.Close();
            body = body.Replace("[username]", username);
            body = body.Replace("[code]", code);
            SendEmail(user_email, "Gramiq | Password Reset Link", body);
            return true;
        }
        public static bool SendEmail(string user_email, string subject, string body)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");
                mail.From = new MailAddress("gramiq.hinjorr@gmail.com", "Gramiq");
                mail.To.Add(user_email);
                mail.Subject = subject;
                mail.IsBodyHtml = true;
                mail.Body = body;
                SmtpServer.Port = 587;
                SmtpServer.Credentials = new System.Net.NetworkCredential("gramiq.hinjorr@gmail.com", "masood1050");
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

        public static string UploadFile(ProfileDTO dto, IWebHostEnvironment Env)
        {
            try
            {
                string FilePath = null;
                string Extension = Path.GetExtension(dto.ProfileImage.FileName);
                if (dto.ProfileImage != null)
                {
                    string FolderUpload = Path.Combine(Env.WebRootPath, "Upload");
                    if (!Directory.Exists(FolderUpload))
                    {
                        Directory.CreateDirectory(FolderUpload);
                    }
                    FilePath = Path.Combine(FolderUpload, dto.Nic + Extension);

                    using (var filestream = new FileStream(FilePath, FileMode.Create))
                    {
                        dto.ProfileImage.CopyTo(filestream);
                    }
                }
                return "/Upload" + "/" + dto.Nic + Extension;

            }
            catch (System.Exception)
            {
                return null;
            }


        }
    }
}