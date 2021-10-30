using System;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;

namespace FYP1.Models
{
    public class UserModel : IUser
    {
        private readonly IMapper mapper;
        private readonly LMS_DBContext db;
        private static readonly Random _random = new Random();

        TblProfile profile = new TblProfile();
        TblFaculty faculty = new TblFaculty();
        TblStudent student = new TblStudent();
        TblUser user = new TblUser();
        public UserModel(IMapper _mapper, LMS_DBContext _db)
        {
            mapper = _mapper;
            db = _db;
        }

        public async Task<bool> AddNewUser(ProfileDTO dto)
        {
            using (var transaction = await db.Database.BeginTransactionAsync())
            {
                try
                {
                    //entring data in TblProfile
                    mapper.Map(dto, profile);
                    await db.TblProfiles.AddAsync(profile);
                    await db.SaveChangesAsync();

                    //entring data in TblUser
                    mapper.Map(dto.User, user);
                    int random = RandomNumber(121, 9131);
                    user.ProfileId = profile.ProfileId;
                    user.UserName = random + user.ProfileId.ToString();
                    await db.TblUsers.AddAsync(user);
                    await db.SaveChangesAsync();

                    if (dto.Student.ProgramId != null && dto.User.RoleId == 3)
                    {
                        //enting data in TblStudent
                        mapper.Map(dto.Student, student);
                        student.UserId = user.UserId;
                        student.ProgramId = dto.Student.ProgramId;
                        await db.TblStudents.AddAsync(student);
                        await db.SaveChangesAsync();
                    }
                    else if (dto.User.RoleId == 2)
                    {
                        //entring data in TblFaculty
                        mapper.Map(dto.Faculty, faculty);
                        faculty.UserId = user.UserId;
                        await db.TblFaculties.AddAsync(faculty);
                        await db.SaveChangesAsync();
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
        public static int RandomNumber(int min, int max)
        {
            return _random.Next(min, max);
        }
      


    }
}