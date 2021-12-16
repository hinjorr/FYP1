using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Hosting;
using System.IO;

namespace FYP1.Models
{
    public class UserModel : IUser
    {
        private readonly IMapper mapper;
        private readonly LMS_DBContext db;
        private static readonly Random _random = new Random();
        DateTime datenow = DateTime.Now;
        TblProfile profile = new TblProfile();
        TblFaculty faculty = new TblFaculty();
        TblStudent student = new TblStudent();
        TblAdmin admin = new TblAdmin();
        TblUser user = new TblUser();

        public IWebHostEnvironment Env { get; }

        public UserModel(IMapper _mapper, LMS_DBContext _db, IWebHostEnvironment env)
        {
            mapper = _mapper;
            db = _db;
            Env = env;
        }

        //generating random number for username/passowrd
        public static int RandomNumber(int min, int max)
        {
            return _random.Next(min, max);
        }
        public async Task<bool> AddNewUser(ProfileDTO dto)
        {
            using (var transaction = await db.Database.BeginTransactionAsync())
            {
                try
                {
                    var profilechk = await db.TblProfiles.Where(x => x.Nic == dto.Nic).FirstOrDefaultAsync();
                    //create another user for the same profile
                    if (profilechk != null)
                    {
                        dto.ProfileId = profilechk.ProfileId;
                        user = await AddUser(dto);
                        // condition whether the user is Student/Faculty/Admin
                        if (user.RoleId == 1)
                        {
                            await AddAdmin(user.UserId);
                        }
                        else if (user.RoleId == 2)
                        {
                            await AddFaculty(user.UserId);
                        }
                        else if (dto.Student.ProgramId != 0 && user.RoleId == 3)
                        {
                            await AddStudent(dto);
                        }
                        else
                        {
                            return false;
                        }
                    }
                    //create new user for the new profile
                    else
                    {
                        mapper.Map(dto, profile);
                        string ImagePath = UploadFile(dto);

                        profile.Picture = ImagePath;
                        await AddProfile();
                        dto.ProfileId = profile.ProfileId;

                        await AddUser(dto);
                        //condition whether the user is Student/ Faculty/Admin
                        if (dto.User.RoleId == 1)
                        {
                            await AddAdmin(user.UserId);
                        }
                        else if (dto.User.RoleId == 2)
                        {
                            await AddFaculty(user.UserId);
                        }

                        else if (dto.Student.ProgramId != null && dto.User.RoleId == 3)
                        {
                            await AddStudent(dto);
                        }
                        else
                        {
                            return false;
                        }

                    }


                    await transaction.CommitAsync();
                    return true;
                }
                catch (System.Exception)
                {
                    throw new Exception("Task Failed");
                }
            }
        }
        //entring data in TblProfile

        async Task<TblProfile> AddProfile()
        {
            try

            {

                profile.ProfileDate = datenow.ToString("dd/MM/yyyy");

                await db.TblProfiles.AddAsync(profile);
                await db.SaveChangesAsync();

                return profile;
            }
            catch (System.Exception)
            {

                throw new Exception("Task Failed");
            }

        }
        async Task<TblUser> AddUser(ProfileDTO dto)
        {
            try
            {
                //entring data in TblUser
                mapper.Map(dto.User, user);
                user.RoleId = dto.User.RoleId;
                user.IsActive = Convert.ToUInt32(true);
                user.UserDate = datenow.ToString("dd/MM/yyyy");
                user.Password = RandomNumber(93456, 193123) + profile.ProfileId.ToString();
                user.ProfileId = dto.ProfileId;
                user.UserName = RandomNumber(121, 9131) + user.ProfileId.ToString();
                await db.TblUsers.AddAsync(user);
                await db.SaveChangesAsync();
                return user;
            }
            catch (System.Exception)
            {

                throw new Exception("Task Failed");
            }

        }
        async Task<TblAdmin> AddAdmin(int id)
        {
            try
            {
                //entring data in TblAdmin
                admin.UserId = id;
                await db.TblAdmins.AddAsync(admin);
                await db.SaveChangesAsync();
                return admin;
            }
            catch (System.Exception)
            {

                throw new Exception("Task Failed");
            }

        }
        async Task<ProfileDTO> AddStudent(ProfileDTO dto)
        {
            try
            {
                //enting data in TblStudent
                student.UserId = user.UserId;
                student.ProgramId = dto.Student.ProgramId;
                await db.TblStudents.AddAsync(student);
                await db.SaveChangesAsync();
                return dto;
            }
            catch (System.Exception)
            {

                throw new Exception("Task Failed");
            }

        }
        async Task<TblFaculty> AddFaculty(int id)
        {
            try
            {
                //entring data in TblFaculty
                faculty.UserId = user.UserId;
                await db.TblFaculties.AddAsync(faculty);
                await db.SaveChangesAsync();
                return faculty;
            }
            catch (System.Exception)
            {

                throw new Exception("Task Failed");
            }

        }
        public async Task<string> Role_NIC_Check(ProfileDTO dto)
        {
            try
            {
                var profile = await db.TblProfiles.Where(x => x.Nic == dto.Nic).FirstOrDefaultAsync();
                if (profile != null)
                {
                    var user = await db.TblUsers.Where(x => x.ProfileId == profile.ProfileId && x.RoleId == dto.User.RoleId).FirstOrDefaultAsync();
                    if (user != null)
                    {
                        return "This User already registered with this Role";
                    }
                }
                return null;
            }
            catch (System.Exception)
            {

                throw new Exception("Role_NIC_Check! Task Failed");
            }
        }

        public async Task<bool> DeleteUser(string username)
        {
            try
            {
                var data = await db.TblUsers.Where(x => x.UserName == username).FirstOrDefaultAsync();
                if (data.IsActive == 1)
                {
                    data.IsActive = Convert.ToUInt32(false);
                    await db.SaveChangesAsync();
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (System.Exception)
            {
                throw new Exception("Task Failed in DeleteUser");
            }

        }

        //will return all active users from db
        public async Task<List<ProfileDTO>> GetUsers()
        {

            var data = await db.TblUsers.Select(x => new ProfileDTO
            {
                Nic = x.Profile.Nic,
                Name = x.Profile.Name + " " + x.Profile.FatherName,
                Email = x.Profile.Email,
                Picture = x.Profile.Picture,
                User = new UserDTO()
                {
                    UserName = x.UserName,
                    UserDate = x.UserDate,
                    IsActive = Convert.ToBoolean(x.IsActive),
                    Role = new RoleDTO()
                    {
                        RoleId = x.Role.RoleId,
                        RoleName = x.Role.RoleName
                    }
                },
            }).ToListAsync();
            return data;
        }

        // public async Task<bool> UpdateUserProfile(ProfileDTO dto)
        // {
        //     var chk = await db.TblProfiles.Where(x => x.ProfileId == dto.ProfileId).FirstOrDefaultAsync();
        //     chk.Name=dto.Name;
        //     chk.FatherName=dto.FatherName;
        //     chk.Gender=dto.Gender;
        //     chk.PhoneNumber=dto.PhoneNumber;
        //     if (dto.ProfileImage!=null)
        //     {
        //         var Image=UploadFile(dto);
        //         chk.Picture=Image;
        //     }
        //     chk.Email=dto.Email;
        //     chk.Address=dto.Address;
        //     chk.City=dto.City;
        //     chk.Country=dto.Country;
        //     chk.DoB=dto.DoB;

        // }
        //SaveImage in Folder
        private string UploadFile(ProfileDTO dto)
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

                throw new Exception("UploadFile Task Failed!");
            }


        }

    }
}