using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.EntityFrameworkCore;

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
        public UserModel(IMapper _mapper, LMS_DBContext _db)
        {
            mapper = _mapper;
            db = _db;
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
                    if (profilechk != null)
                    {
                        dto.ProfileId = profilechk.ProfileId;
                        user = await AddUser(dto);
                        // condition whether the user is Student/ Faculty/Admin
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
                    else
                    {
                        mapper.Map(dto, profile);
                        await AddProfile();
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
                    return false;
                }
            }
        }
        async Task<TblProfile> AddProfile()
        {
            //entring data in TblProfile
            profile.ProfileDate = datenow.ToString("dd/MM/yyyy");
            await db.TblProfiles.AddAsync(profile);
            await db.SaveChangesAsync();
            return profile;
        }
        async Task<TblUser> AddUser(ProfileDTO dto)
        {
            //entring data in TblUser
            mapper.Map(dto.User, user);
            user.RoleId = dto.User.RoleId;
            user.IsActive=Convert.ToUInt32(true);
            user.UserDate = datenow.ToString("dd/MM/yyyy");
            user.Password = RandomNumber(93456, 193123) + profile.ProfileId.ToString();
            user.ProfileId = profile.ProfileId;
            user.UserName = RandomNumber(121, 9131) + user.ProfileId.ToString();
            await db.TblUsers.AddAsync(user);
            await db.SaveChangesAsync();
            return user;
        }
        async Task<TblAdmin> AddAdmin(int id)
        {
            //entring data in TblAdmin
            admin.UserId = id;
            await db.TblAdmins.AddAsync(admin);
            await db.SaveChangesAsync();
            return admin;
        }
        async Task<ProfileDTO> AddStudent(ProfileDTO dto)
        {
            //enting data in TblStudent
            student.UserId = user.UserId;
            student.ProgramId = dto.Student.ProgramId;
            await db.TblStudents.AddAsync(student);
            await db.SaveChangesAsync();
            return dto;
        }
        async Task<TblFaculty> AddFaculty(int id)
        {
            //entring data in TblFaculty
            faculty.UserId = user.UserId;
            await db.TblFaculties.AddAsync(faculty);
            await db.SaveChangesAsync();
            return faculty;
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

                throw;
            }
        }

        public async Task<List<ProfileDTO>> GetUsers()
        {
            var data = await db.TblUsers.Include(x => x.Profile).Select(x => new ProfileDTO
            {
                Nic = x.Profile.Nic,
                Name = x.Profile.Name + " " + x.Profile.FatherName,
                Email = x.Profile.Email,
                User = new UserDTO()
                {
                    UserName = x.UserName,
                    UserDate = x.UserDate,
                    IsActive = Convert.ToBoolean(x.IsActive),
                    Role = new RoleDTO()
                    {
                        RoleName = x.Role.RoleName
                    }
                },
            }).ToListAsync();
            return data;
        }

    }
}