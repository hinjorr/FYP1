using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class User
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public DateTime SignupDate { get; set; }
        public string ProfilePic { get; set; }
        public int NumPosts { get; set; }
        public int NumLikes { get; set; }
        public string UserClosed { get; set; }
        public string FriendArray { get; set; }
        public long? UserId { get; set; }
    }
}
