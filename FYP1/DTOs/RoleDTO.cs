namespace FYP1.DTOs
{
    public class RoleDTO:GeneralDTO
    {
          public int RoleId { get; set; }
        public string RoleName { get; set; }
        public ulong? IsActive { get; set; }
    }
}