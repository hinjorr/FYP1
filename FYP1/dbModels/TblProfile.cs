using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblProfile
    {
        public TblProfile()
        {
            TblUsers = new HashSet<TblUser>();
        }

        public int ProfileId { get; set; }
        public string Name { get; set; }
        public string FatherName { get; set; }
        public string Email { get; set; }
        public string Nic { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public string Picture { get; set; }
        public string DoB { get; set; }
        public string Gender { get; set; }
        public string PhoneNumber { get; set; }
        public ulong? IsActive { get; set; }

        public virtual ICollection<TblUser> TblUsers { get; set; }
    }
}
