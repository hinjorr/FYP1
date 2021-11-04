using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface ICourse
    {
        Task<bool> AddNewCourse(CourseDTO dto);
    }
}