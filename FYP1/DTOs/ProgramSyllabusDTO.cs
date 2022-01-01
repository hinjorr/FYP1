namespace FYP1.DTOs
{
    public class ProgramSyllabusDTO:GeneralDTO
    {
        public int SyllabusId { get; set; }
        public int? ProgramId { get; set; }
        public int? CourseId { get; set; }
        public int? RqdCourseId { get; set; }
        public int? RequiredCrHr { get; set; }

        public CourseDTO Courses { get; set; }
        public CourseDTO RqdCourse { get; set; }
        // public  ProgramDTO Program { get; set; }
        // public  CourseDTO RqdCourse { get; set; }
    }
}