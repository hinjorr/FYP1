namespace FYP1.DTOs
{
    public class GeneralDTO
    {
        public bool ResponseBool { get; set; }
        public string ResponceMsg { get; set; }

        public ProfileDTO Profile { get; set; }
        public UserDTO User { get; set; }
        public RoleDTO Role { get; set; }
        public StudentDTO Student { get; set; }
        public ProgramDTO Program { get; set; }
        public SemesterDTO Semester { get; set; }
        public ClassSessionDTO ClassSession { get; set; }



    }
}