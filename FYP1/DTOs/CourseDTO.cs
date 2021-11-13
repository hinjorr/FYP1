namespace FYP1.DTOs
{
    public class CourseDTO
    {
        public int CourseId { get; set; }
        public string FullName { get; set; }
        public string ShortName { get; set; }
        public int? CrHr { get; set; }
        public bool IsActive { get; set; }
        public ClassDTO Classes { get; set; }

    }
}