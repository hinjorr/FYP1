using System.Diagnostics;
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
using Microsoft.AspNetCore.Mvc;


namespace FYP1.Models
{
    public class UserModel : IUser
    {
        private readonly IMapper mapper;
        private readonly LMS_DBContext db;
        private static readonly Random _random = new Random();
        DateTime datenow = DateTime.Now;
        GeneralDTO general = new GeneralDTO();
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
        public async Task<GeneralDTO> RegisterUser(GeneralDTO dto)
        {
            using (var transaction = await db.Database.BeginTransactionAsync())
            {
                try
                {
                    var profilechk = await db.TblProfiles.Where(x => x.Nic == dto.Profile.Nic).FirstOrDefaultAsync();
                    //create another user for the same profile
                    if (profilechk != null)
                    {
                        dto.Profile.ProfileId = profilechk.ProfileId;
                        int user_id = await AddUser(dto.Role.RoleId, dto.Profile.ProfileId);
                        // condition whether the user is Student/Faculty/Admin
                        if (dto.Role.RoleId == 1)
                        {
                            await AddAdmin(user_id);
                        }
                        else if (dto.Role.RoleId == 2)
                        {
                            await AddFaculty(user_id);
                        }
                        else if (dto.Student.ProgramId != 0 && dto.Role.RoleId == 3)
                        {
                            await AddStudent(user_id, dto.Student.ProgramId);
                        }

                    }
                    //create new user for the new profile
                    else
                    {
                        TblProfile tblProfile = new TblProfile();
                        mapper.Map(dto.Profile, tblProfile);
                        string ImagePath = UploadFile(dto.Profile);

                        dto.Profile.Picture = ImagePath;
                        int profile_id = await AddProfile(dto.Profile);
                        dto.Profile.ProfileId = profile_id;

                        int user_id = await AddUser(dto.Role.RoleId, profile_id);
                        // condition whether the user is Student/Faculty/Admin
                        if (dto.Role.RoleId == 1)
                        {
                            await AddAdmin(user_id);
                        }
                        else if (dto.Role.RoleId == 2)
                        {
                            await AddFaculty(user_id);
                        }
                        else if (dto.Student.ProgramId != 0 && dto.Role.RoleId == 3)
                        {
                            await AddStudent(user_id, dto.Student.ProgramId);
                        }

                    }
                    await transaction.CommitAsync();
                    general.Text = "User Registered";
                    general.Icon = "success";
                    return general;
                }
                catch (System.Exception)
                {
                    general.Text = "Server Error";
                    general.Icon = "error";
                    return general;

                }
            }
        }
        async Task<int> AddProfile(ProfileDTO dto)
        {
            try
            {
                //entring data in TblProfile
                TblProfile tblProfile = new TblProfile();
                mapper.Map(dto, tblProfile);
                tblProfile.ProfileDate = datenow.ToString("dd/MM/yyyy");
                await db.TblProfiles.AddAsync(tblProfile);
                await db.SaveChangesAsync();
                return tblProfile.ProfileId;
            }
            catch (System.Exception)
            {
                throw new Exception("Task Failed");
            }

        }
        async Task<int> AddUser(int RoleID, int ProfileID)
        {
            try
            {
                //entring data in TblUser
                TblUser tblUser = new TblUser();
                tblUser.RoleId = RoleID;
                tblUser.IsActive = Convert.ToUInt32(true);
                tblUser.UserDate = datenow.ToString("dd/MM/yyyy");
                tblUser.Password = RandomNumber(93456, 193123) + ProfileID.ToString();
                tblUser.ProfileId = ProfileID;
                tblUser.UserName = RandomNumber(121, 9131) + ProfileID.ToString();
                await db.TblUsers.AddAsync(tblUser);
                await db.SaveChangesAsync();
                return tblUser.UserId;
            }
            catch (System.Exception)
            {

                throw new Exception("Task Failed");
            }

        }
        async Task<bool> AddAdmin(int UserID)
        {
            try
            {
                //entring data in TblAdmin
                TblAdmin tblAdmin = new TblAdmin();
                tblAdmin.UserId = UserID;
                await db.TblAdmins.AddAsync(tblAdmin);
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception)
            {
                throw new Exception("Task Failed");
            }
        }
        async Task<bool> AddStudent(int UserID, int ProgramID)
        {
            try
            {
                //enting data in TblStudent
                TblStudent tblStudent = new TblStudent();
                tblStudent.UserId = UserID;
                tblStudent.ProgramId = ProgramID;
                await db.TblStudents.AddAsync(tblStudent);
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception)
            {
                throw new Exception("Task Failed");
            }
        }
        async Task<bool> AddFaculty(int User_ID)
        {
            try
            {
                //entring data in TblFaculty
                TblFaculty tblFaculty = new TblFaculty();
                tblFaculty.UserId = User_ID;
                await db.TblFaculties.AddAsync(tblFaculty);
                await db.SaveChangesAsync();
                return true;
            }
            catch (System.Exception)
            {

                throw new Exception("Task Failed");
            }

        }
        public async Task<GeneralDTO> Role_NIC_Check(GeneralDTO dto)
        {
            try
            {
                var profile = await db.TblProfiles.Where(x => x.Nic == dto.Profile.Nic).FirstOrDefaultAsync();
                if (profile != null)
                {
                    var user = await db.TblUsers.Where(x => x.ProfileId == profile.ProfileId && x.RoleId == dto.Role.RoleId).FirstOrDefaultAsync();
                    if (user != null)
                    {
                        general.Text = "This User already registered with this Role";
                        general.Icon = "error";
                    }
                }
                return general;
            }
            catch (System.Exception)
            {

                general.Text = "Server Error";
                general.Icon = "error";
                return general;
            }
        }

        public async Task<GeneralDTO> DeleteUser(string username)
        {
            try
            {
                var data = await db.TblUsers.Where(x => x.UserName == username).FirstOrDefaultAsync();
                if (data.IsActive == 1)
                {
                    data.IsActive = Convert.ToUInt32(false);
                    general.Text = "User Deactivated";
                    general.Icon = "success";
                }
                else if (data.IsActive == 0)
                {
                    data.IsActive = Convert.ToUInt32(true);
                    general.Text = "User Activated";
                    general.Icon = "success";
                }
                await db.SaveChangesAsync();
                return general;
            }
            catch (System.Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                return general;
            }

        }

        //will return all active/non-active users from db
        public async Task<List<GeneralDTO>> GetUsers()
        {
            List<GeneralDTO> _list = new List<GeneralDTO>();
            try
            {
                //user profile role 
                var data = await db.TblUsers.Include(x => x.Role).Include(x => x.Profile).ToListAsync();
                foreach (var item in data)
                {
                    item.Password = "";
                    GeneralDTO dto = new GeneralDTO();
                    mapper.Map(item.Profile, dto.Profile = new ProfileDTO());
                    mapper.Map(item.Role, dto.Role = new RoleDTO());
                    mapper.Map(item, dto.User = new UserDTO());
                    _list.Add(dto);
                }
                return _list;

            }
            catch (System.Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                _list.Add(general);
                return _list;
            }

        }


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
                return null;
            }


        }

        public async Task<GeneralDTO> GetProfile(string username)
        {
            try
            {
                GeneralDTO dto = new GeneralDTO();
                var GetProfile = await db.TblUsers.Where(x => x.UserName == username).Include(x => x.Profile).Include(x => x.Role).FirstOrDefaultAsync();
                if (GetProfile != null)
                {
                    mapper.Map(GetProfile.Profile, dto.Profile = new ProfileDTO());
                    mapper.Map(GetProfile, dto.User = new UserDTO());
                    mapper.Map(GetProfile.Role, dto.Role = new RoleDTO());

                }
                return dto;
            }
            catch (System.Exception)
            {
                general.Text = "Server Error";
                general.Icon = "error";
                return general;
            }

        }
    }
}