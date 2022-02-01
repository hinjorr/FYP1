using System.Collections.Generic;

namespace FYP1.DTOs
{
    public class GeneralDTO
    {

        public string Text { get; set; }
        public string Icon { get; set; }
        public string ReturnUrl { get; set; }
        public int TotalSessions { get; set; }

        public MessageDTO Message { get; set; }
        public ParentMenuDTO ParentMenu { get; set; }
        public ProfileDTO Profile { get; set; }
        public UserDTO User { get; set; }
        public RoleDTO Role { get; set; }
        public StudentDTO Student { get; set; }
        public ProgramDTO Program { get; set; }
        public SemesterDTO Semester { get; set; }
        public ClassSessionDTO ClassSession { get; set; }
        public ClassDTO Classes { get; set; }
        public UrlDTO Url { get; set; }
        public DayDTO Day { get; set; }
        public TimeDTO Time { get; set; }
        public CourseDTO Course { get; set; }
        public MarksDTO Marks { get; set; }
        public AttendenceDTO Attendence { get; set; }
        public MenuDTO Menu { get; set; }
        public RoleMenuDTO RoleMenu { get; set; }

        public StudentCourseRegistrationDTO StudentCourseRegistration { get; set; }
        public FacultyCourseRegistrationDTO FacultyCourseRegistration { get; set; }



    }
}