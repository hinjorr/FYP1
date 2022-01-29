using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace FYP1.dbModels
{
    public partial class LMS_DBContext : DbContext
    {
        public LMS_DBContext()
        {
        }

        public LMS_DBContext(DbContextOptions<LMS_DBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<TblAttendence> TblAttendences { get; set; }
        public virtual DbSet<TblClass> TblClasses { get; set; }
        public virtual DbSet<TblClassContent> TblClassContents { get; set; }
        public virtual DbSet<TblClassSession> TblClassSessions { get; set; }
        public virtual DbSet<TblCourse> TblCourses { get; set; }
        public virtual DbSet<TblCourseEligiblity> TblCourseEligiblities { get; set; }
        public virtual DbSet<TblDay> TblDays { get; set; }
        public virtual DbSet<TblEmailConfiguration> TblEmailConfigurations { get; set; }
        public virtual DbSet<TblFacultyCourseRegistration> TblFacultyCourseRegistrations { get; set; }
        public virtual DbSet<TblMark> TblMarks { get; set; }
        public virtual DbSet<TblMenu> TblMenus { get; set; }
        public virtual DbSet<TblParentMenu> TblParentMenus { get; set; }
        public virtual DbSet<TblProfile> TblProfiles { get; set; }
        public virtual DbSet<TblProgram> TblPrograms { get; set; }
        public virtual DbSet<TblProgramSyllabus> TblProgramSyllabi { get; set; }
        public virtual DbSet<TblRole> TblRoles { get; set; }
        public virtual DbSet<TblRoleMenu> TblRoleMenus { get; set; }
        public virtual DbSet<TblSemester> TblSemesters { get; set; }
        public virtual DbSet<TblStudent> TblStudents { get; set; }
        public virtual DbSet<TblStudentCourseRegistration> TblStudentCourseRegistrations { get; set; }
        public virtual DbSet<TblTime> TblTimes { get; set; }
        public virtual DbSet<TblUser> TblUsers { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseMySql("server=localhost;port=3306;user=root;password=masood1050;database=LMS", Microsoft.EntityFrameworkCore.ServerVersion.Parse("8.0.27-mysql"));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasCharSet("latin1");

            modelBuilder.Entity<TblAttendence>(entity =>
            {
                entity.ToTable("Tbl_Attendence");

                entity.HasIndex(e => e.UserId, "Tbl_Attendence_ibfk_1");

                entity.HasIndex(e => e.SessionId, "Tbl_Attendence_ibfk_2");

                entity.HasIndex(e => e.ClassId, "Tbl_Attendence_ibfk_3");

                entity.Property(e => e.ClassId).HasColumnName("Class_ID");

                entity.Property(e => e.SessionId).HasColumnName("Session_ID");

                entity.Property(e => e.UserId).HasColumnName("User_ID");

                entity.Property(e => e.UserName)
                    .HasMaxLength(50)
                    .HasColumnName("User_Name");

                entity.Property(e => e._1st)
                    .HasColumnType("bit(1)")
                    .HasColumnName("1st")
                    .HasDefaultValueSql("b'0'");

                entity.Property(e => e._2nd)
                    .HasColumnType("bit(1)")
                    .HasColumnName("2nd")
                    .HasDefaultValueSql("b'0'");

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.TblAttendences)
                    .HasForeignKey(d => d.ClassId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Attendence_ibfk_3");

                entity.HasOne(d => d.Session)
                    .WithMany(p => p.TblAttendences)
                    .HasForeignKey(d => d.SessionId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Attendence_ibfk_2");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.TblAttendences)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Attendence_ibfk_1");
            });

            modelBuilder.Entity<TblClass>(entity =>
            {
                entity.HasKey(e => e.ClassId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Classes");

                entity.HasIndex(e => e.SemesterId, "Tbl_Classes_ibfk_1");

                entity.HasIndex(e => e.CourseId, "Tbl_Classes_ibfk_4");

                entity.HasIndex(e => e.ProgramId, "Tbl_Classes_ibfk_5");

                entity.HasIndex(e => e.DayId, "Tbl_Classes_ibfk_6");

                entity.HasIndex(e => e.TimeId, "Tbl_Classes_ibfk_7");

                entity.Property(e => e.ClassId).HasColumnName("Class_Id");

                entity.Property(e => e.ClassImage)
                    .HasMaxLength(100)
                    .HasColumnName("Class_Image");

                entity.Property(e => e.CourseId).HasColumnName("Course_Id");

                entity.Property(e => e.DayId).HasColumnName("Day_Id");

                entity.Property(e => e.EnrolledStd)
                    .HasColumnName("Enrolled_Std")
                    .HasDefaultValueSql("'0'");

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.ProgramId).HasColumnName("Program_Id");

                entity.Property(e => e.SemesterId).HasColumnName("Semester_Id");

                entity.Property(e => e.TimeId).HasColumnName("Time_Id");

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.TblClasses)
                    .HasForeignKey(d => d.CourseId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Classes_ibfk_4");

                entity.HasOne(d => d.Day)
                    .WithMany(p => p.TblClasses)
                    .HasForeignKey(d => d.DayId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Classes_ibfk_6");

                entity.HasOne(d => d.Program)
                    .WithMany(p => p.TblClasses)
                    .HasForeignKey(d => d.ProgramId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Classes_ibfk_5");

                entity.HasOne(d => d.Semester)
                    .WithMany(p => p.TblClasses)
                    .HasForeignKey(d => d.SemesterId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Classes_ibfk_1");

                entity.HasOne(d => d.Time)
                    .WithMany(p => p.TblClasses)
                    .HasForeignKey(d => d.TimeId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Classes_ibfk_7");
            });

            modelBuilder.Entity<TblClassContent>(entity =>
            {
                entity.HasKey(e => e.ContentId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_ClassContent");

                entity.HasIndex(e => e.ClassId, "Tbl_ClassContent_ibfk_1");

                entity.HasIndex(e => e.SessionId, "Tbl_ClassContent_ibfk_2");

                entity.Property(e => e.ContentId).HasColumnName("Content_ID");

                entity.Property(e => e.ClassId).HasColumnName("Class_ID");

                entity.Property(e => e.ContentLink).HasMaxLength(200);

                entity.Property(e => e.ContentName).HasMaxLength(100);

                entity.Property(e => e.SessionId).HasColumnName("Session_ID");

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.TblClassContents)
                    .HasForeignKey(d => d.ClassId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_ClassContent_ibfk_1");

                entity.HasOne(d => d.Session)
                    .WithMany(p => p.TblClassContents)
                    .HasForeignKey(d => d.SessionId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_ClassContent_ibfk_2");
            });

            modelBuilder.Entity<TblClassSession>(entity =>
            {
                entity.HasKey(e => e.SessionId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_ClassSessions");

                entity.HasIndex(e => e.SemesterId, "Tbl_ClassSessions_ibfk_1");

                entity.Property(e => e.SessionId).HasColumnName("Session_ID");

                entity.Property(e => e.SemesterId).HasColumnName("Semester_ID");

                entity.Property(e => e.SessionName).HasMaxLength(100);

                entity.HasOne(d => d.Semester)
                    .WithMany(p => p.TblClassSessions)
                    .HasForeignKey(d => d.SemesterId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_ClassSessions_ibfk_1");
            });

            modelBuilder.Entity<TblCourse>(entity =>
            {
                entity.HasKey(e => e.CourseId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Courses");

                entity.Property(e => e.CourseId).HasColumnName("CourseID");

                entity.Property(e => e.FullName).HasMaxLength(100);

                entity.Property(e => e.IsActive)
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("b'1'");

                entity.Property(e => e.ShortName).HasMaxLength(50);
            });

            modelBuilder.Entity<TblCourseEligiblity>(entity =>
            {
                entity.HasKey(e => e.ElgibiltyId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_CourseEligiblity");

                entity.HasIndex(e => e.ClassId, "Class_Id");

                entity.HasIndex(e => e.ProgramId, "Program_Id");

                entity.HasIndex(e => e.RqdCourseId, "RqdCourse_Id");

                entity.Property(e => e.ElgibiltyId).HasColumnName("Elgibilty_ID");

                entity.Property(e => e.ClassId).HasColumnName("Class_Id");

                entity.Property(e => e.ProgramId).HasColumnName("Program_Id");

                entity.Property(e => e.RqdCourseId).HasColumnName("RqdCourse_Id");

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.TblCourseEligiblities)
                    .HasForeignKey(d => d.ClassId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_CourseEligiblity_ibfk_1");

                entity.HasOne(d => d.Program)
                    .WithMany(p => p.TblCourseEligiblities)
                    .HasForeignKey(d => d.ProgramId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_CourseEligiblity_ibfk_2");

                entity.HasOne(d => d.RqdCourse)
                    .WithMany(p => p.TblCourseEligiblities)
                    .HasForeignKey(d => d.RqdCourseId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_CourseEligiblity_ibfk_3");
            });

            modelBuilder.Entity<TblDay>(entity =>
            {
                entity.HasKey(e => e.DayId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Days");

                entity.Property(e => e.DayId).HasColumnName("Day_Id");

                entity.Property(e => e.DayName).HasMaxLength(50);
            });

            modelBuilder.Entity<TblEmailConfiguration>(entity =>
            {
                entity.ToTable("Tbl_EmailConfiguration");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.From).HasMaxLength(50);

                entity.Property(e => e.Host).HasMaxLength(50);

                entity.Property(e => e.Password).HasMaxLength(50);
            });

            modelBuilder.Entity<TblFacultyCourseRegistration>(entity =>
            {
                entity.HasKey(e => e.FcrId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_FacultyCourseRegistration");

                entity.HasIndex(e => e.SemesterId, "SemesterId");

                entity.HasIndex(e => e.UserId, "Tbl_FacultyCourseRegistration_ibfk_1");

                entity.HasIndex(e => e.ClassId, "Tbl_FacultyCourseRegistration_ibfk_2");

                entity.Property(e => e.FcrId).HasColumnName("FCR_ID");

                entity.Property(e => e.ClassId).HasColumnName("Class_ID");

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.Username).HasMaxLength(50);

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.TblFacultyCourseRegistrations)
                    .HasForeignKey(d => d.ClassId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_FacultyCourseRegistration_ibfk_2");

                entity.HasOne(d => d.Semester)
                    .WithMany(p => p.TblFacultyCourseRegistrations)
                    .HasForeignKey(d => d.SemesterId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_FacultyCourseRegistration_ibfk_3");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.TblFacultyCourseRegistrations)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_FacultyCourseRegistration_ibfk_1");
            });

            modelBuilder.Entity<TblMark>(entity =>
            {
                entity.HasKey(e => e.MarksId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Marks");

                entity.HasIndex(e => e.ClassId, "Tbl_Marks_ibfk_1");

                entity.HasIndex(e => e.UserId, "Tbl_Marks_ibfk_2");

                entity.Property(e => e.MarksId).HasColumnName("Marks_Id");

                entity.Property(e => e.AssementName)
                    .HasMaxLength(50)
                    .HasColumnName("Assement_Name");

                entity.Property(e => e.ClassId).HasColumnName("Class_Id");

                entity.Property(e => e.ObtainedMakrs)
                    .HasColumnName("Obtained_Makrs")
                    .HasDefaultValueSql("'0'");

                entity.Property(e => e.TotalMarks).HasColumnName("Total_Marks");

                entity.Property(e => e.UserId).HasColumnName("User_Id");

                entity.Property(e => e.UserName).HasMaxLength(50);

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.TblMarks)
                    .HasForeignKey(d => d.ClassId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Marks_ibfk_1");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.TblMarks)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Marks_ibfk_2");
            });

            modelBuilder.Entity<TblMenu>(entity =>
            {
                entity.HasKey(e => e.MenuId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Menu");

                entity.HasIndex(e => e.Parent, "Parent");

                entity.Property(e => e.MenuId).HasColumnName("Menu_ID");

                entity.Property(e => e.Action).HasMaxLength(50);

                entity.Property(e => e.Controller).HasMaxLength(50);

                entity.Property(e => e.DisplayLink).HasMaxLength(50);

                entity.Property(e => e.DisplayName).HasMaxLength(50);

                entity.Property(e => e.Icon).HasColumnType("text");

                entity.HasOne(d => d.ParentNavigation)
                    .WithMany(p => p.TblMenus)
                    .HasForeignKey(d => d.Parent)
                    .HasConstraintName("Tbl_Menu_ibfk_1");
            });

            modelBuilder.Entity<TblParentMenu>(entity =>
            {
                entity.HasKey(e => e.ParentId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_ParentMenu");

                entity.Property(e => e.ParentId).HasColumnName("ParentID");

                entity.Property(e => e.DisplayName).HasMaxLength(50);

                entity.Property(e => e.Icon).HasColumnType("text");
            });

            modelBuilder.Entity<TblProfile>(entity =>
            {
                entity.HasKey(e => e.ProfileId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Profile");

                entity.Property(e => e.ProfileId).HasColumnName("ProfileID");

                entity.Property(e => e.Address).HasMaxLength(100);

                entity.Property(e => e.City).HasMaxLength(50);

                entity.Property(e => e.Country).HasMaxLength(50);

                entity.Property(e => e.DoB).HasMaxLength(50);

                entity.Property(e => e.Email).HasMaxLength(50);

                entity.Property(e => e.FatherName).HasMaxLength(50);

                entity.Property(e => e.Gender).HasMaxLength(50);

                entity.Property(e => e.Name).HasMaxLength(50);

                entity.Property(e => e.Nic)
                    .HasMaxLength(50)
                    .HasColumnName("NIC");

                entity.Property(e => e.PhoneNumber).HasMaxLength(50);

                entity.Property(e => e.Picture).HasMaxLength(1000);

                entity.Property(e => e.ProfileDate)
                    .HasMaxLength(50)
                    .HasColumnName("Profile_Date");
            });

            modelBuilder.Entity<TblProgram>(entity =>
            {
                entity.HasKey(e => e.ProgramId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Programs");

                entity.Property(e => e.ProgramId).HasColumnName("ProgramID");

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.ProgramFullName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.ProgramShortName).HasMaxLength(50);
            });

            modelBuilder.Entity<TblProgramSyllabus>(entity =>
            {
                entity.HasKey(e => e.SyllabusId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_ProgramSyllabus");

                entity.HasIndex(e => e.ProgramId, "Tbl_ProgramSyllabus_ibfk_1");

                entity.HasIndex(e => e.CourseId, "Tbl_ProgramSyllabus_ibfk_2");

                entity.HasIndex(e => e.RqdCourseId, "Tbl_ProgramSyllabus_ibfk_3");

                entity.Property(e => e.SyllabusId).HasColumnName("Syllabus_Id");

                entity.Property(e => e.CourseId).HasColumnName("Course_Id");

                entity.Property(e => e.ProgramId).HasColumnName("Program_Id");

                entity.Property(e => e.RequiredCrHr)
                    .HasColumnName("Required_CrHr")
                    .HasDefaultValueSql("'0'");

                entity.Property(e => e.RqdCourseId)
                    .HasColumnName("RqdCourse_Id")
                    .HasDefaultValueSql("'0'");

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.TblProgramSyllabusCourses)
                    .HasForeignKey(d => d.CourseId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_ProgramSyllabus_ibfk_2");

                entity.HasOne(d => d.Program)
                    .WithMany(p => p.TblProgramSyllabi)
                    .HasForeignKey(d => d.ProgramId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_ProgramSyllabus_ibfk_1");

                entity.HasOne(d => d.RqdCourse)
                    .WithMany(p => p.TblProgramSyllabusRqdCourses)
                    .HasForeignKey(d => d.RqdCourseId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_ProgramSyllabus_ibfk_3");
            });

            modelBuilder.Entity<TblRole>(entity =>
            {
                entity.HasKey(e => e.RoleId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Roles");

                entity.Property(e => e.RoleId).HasColumnName("RoleID");

                entity.Property(e => e.RoleName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<TblRoleMenu>(entity =>
            {
                entity.ToTable("Tbl_RoleMenu");

                entity.HasIndex(e => e.MenuId, "Menu_ID");

                entity.HasIndex(e => e.RoleId, "Role_ID");

                entity.Property(e => e.Check)
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("b'0'");

                entity.Property(e => e.MenuId).HasColumnName("Menu_ID");

                entity.Property(e => e.RoleId).HasColumnName("Role_ID");

                entity.HasOne(d => d.Menu)
                    .WithMany(p => p.TblRoleMenus)
                    .HasForeignKey(d => d.MenuId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_RoleMenu_ibfk_1");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.TblRoleMenus)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_RoleMenu_ibfk_2");
            });

            modelBuilder.Entity<TblSemester>(entity =>
            {
                entity.HasKey(e => e.SemesterId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Semester");

                entity.Property(e => e.SemesterId).HasColumnName("Semester_Id");

                entity.Property(e => e.EndDate).HasMaxLength(50);

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.SemesterName).HasMaxLength(50);

                entity.Property(e => e.StartDate).HasMaxLength(50);
            });

            modelBuilder.Entity<TblStudent>(entity =>
            {
                entity.HasKey(e => e.StudentId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Student");

                entity.HasIndex(e => e.ProgramId, "ProgramID");

                entity.HasIndex(e => e.UserId, "UserID");

                entity.Property(e => e.StudentId).HasColumnName("Student_Id");

                entity.Property(e => e.ProgramId).HasColumnName("ProgramID");

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.HasOne(d => d.Program)
                    .WithMany(p => p.TblStudents)
                    .HasForeignKey(d => d.ProgramId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Student_ibfk_2");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.TblStudents)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_Student_ibfk_1");
            });

            modelBuilder.Entity<TblStudentCourseRegistration>(entity =>
            {
                entity.HasKey(e => e.ScrId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_StudentCourseRegistration");

                entity.HasIndex(e => e.SemesterId, "SemesterId");

                entity.HasIndex(e => e.UserId, "Tbl_StudentCourseRegistration_ibfk_2");

                entity.HasIndex(e => e.ClassId, "Tbl_StudentCourseRegistration_ibfk_3");

                entity.Property(e => e.ScrId).HasColumnName("SCR_Id");

                entity.Property(e => e.ClassId).HasColumnName("Class_ID");

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.UserId).HasColumnName("User_ID");

                entity.Property(e => e.Username).HasMaxLength(50);

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.TblStudentCourseRegistrations)
                    .HasForeignKey(d => d.ClassId)
                    .HasConstraintName("Tbl_StudentCourseRegistration_ibfk_3");

                entity.HasOne(d => d.Semester)
                    .WithMany(p => p.TblStudentCourseRegistrations)
                    .HasForeignKey(d => d.SemesterId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Tbl_StudentCourseRegistration_ibfk_4");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.TblStudentCourseRegistrations)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("Tbl_StudentCourseRegistration_ibfk_2");
            });

            modelBuilder.Entity<TblTime>(entity =>
            {
                entity.HasKey(e => e.TimeId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Time");

                entity.Property(e => e.TimeId).HasColumnName("Time_Id");

                entity.Property(e => e.TimeName).HasMaxLength(50);
            });

            modelBuilder.Entity<TblUser>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_User");

                entity.HasIndex(e => e.ProfileId, "ProfileID");

                entity.HasIndex(e => e.RoleId, "RoleID");

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.ProfileId).HasColumnName("ProfileID");

                entity.Property(e => e.RoleId).HasColumnName("RoleID");

                entity.Property(e => e.UserDate)
                    .HasMaxLength(50)
                    .HasColumnName("User_Date");

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Profile)
                    .WithMany(p => p.TblUsers)
                    .HasForeignKey(d => d.ProfileId)
                    .HasConstraintName("Tbl_User_ibfk_1");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.TblUsers)
                    .HasForeignKey(d => d.RoleId)
                    .HasConstraintName("Tbl_User_ibfk_2");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
