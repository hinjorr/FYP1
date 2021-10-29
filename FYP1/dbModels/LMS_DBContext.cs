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

        public virtual DbSet<TblClass> TblClasses { get; set; }
        public virtual DbSet<TblCourse> TblCourses { get; set; }
        public virtual DbSet<TblCourseEligiblity> TblCourseEligiblities { get; set; }
        public virtual DbSet<TblDay> TblDays { get; set; }
        public virtual DbSet<TblFaculty> TblFaculties { get; set; }
        public virtual DbSet<TblFacultyCourseRegistration> TblFacultyCourseRegistrations { get; set; }
        public virtual DbSet<TblProfile> TblProfiles { get; set; }
        public virtual DbSet<TblProgram> TblPrograms { get; set; }
        public virtual DbSet<TblProgramSyllabus> TblProgramSyllabi { get; set; }
        public virtual DbSet<TblRole> TblRoles { get; set; }
        public virtual DbSet<TblSemester> TblSemesters { get; set; }
        public virtual DbSet<TblStudent> TblStudents { get; set; }
        public virtual DbSet<TblStudentCourseRegistration> TblStudentCourseRegistrations { get; set; }
        public virtual DbSet<TblTime> TblTimes { get; set; }
        public virtual DbSet<TblUser> TblUsers { get; set; }

//         protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
//         {
//             if (!optionsBuilder.IsConfigured)
//             {
// #warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
//                 optionsBuilder.UseMySql("server=localhost;port=3306;user=root;password=masood1050;database=LMS", Microsoft.EntityFrameworkCore.ServerVersion.Parse("5.7.36-mysql"));
//             }
//         }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasCharSet("latin1");

            modelBuilder.Entity<TblClass>(entity =>
            {
                entity.HasKey(e => e.ClassId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Classes");

                entity.HasIndex(e => e.ClassDay, "Class_Day");

                entity.HasIndex(e => e.ClassTime, "Class_Time");

                entity.HasIndex(e => e.CourseId, "Course_Id");

                entity.HasIndex(e => e.SemesterId, "Semester_Id");

                entity.Property(e => e.ClassId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Class_Id");

                entity.Property(e => e.ClassDay)
                    .HasColumnType("int(11)")
                    .HasColumnName("Class_Day");

                entity.Property(e => e.ClassStrength).HasColumnType("int(11)");

                entity.Property(e => e.ClassTime)
                    .HasColumnType("int(11)")
                    .HasColumnName("Class_Time");

                entity.Property(e => e.CourseId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Course_Id");

                entity.Property(e => e.SemesterId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Semester_Id");

                entity.HasOne(d => d.ClassDayNavigation)
                    .WithMany(p => p.TblClasses)
                    .HasForeignKey(d => d.ClassDay)
                    .HasConstraintName("Tbl_Classes_ibfk_1");

                entity.HasOne(d => d.ClassTimeNavigation)
                    .WithMany(p => p.TblClasses)
                    .HasForeignKey(d => d.ClassTime)
                    .HasConstraintName("Tbl_Classes_ibfk_2");

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.TblClasses)
                    .HasForeignKey(d => d.CourseId)
                    .HasConstraintName("Tbl_Classes_ibfk_3");

                entity.HasOne(d => d.Semester)
                    .WithMany(p => p.TblClasses)
                    .HasForeignKey(d => d.SemesterId)
                    .HasConstraintName("Tbl_Classes_ibfk_4");
            });

            modelBuilder.Entity<TblCourse>(entity =>
            {
                entity.HasKey(e => e.CourseId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Courses");

                entity.Property(e => e.CourseId)
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever()
                    .HasColumnName("CourseID");

                entity.Property(e => e.CourseName).HasMaxLength(50);

                entity.Property(e => e.CourseShortName).HasMaxLength(50);

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");
            });

            modelBuilder.Entity<TblCourseEligiblity>(entity =>
            {
                entity.HasKey(e => e.ElgibiltyId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_CourseEligiblity");

                entity.HasIndex(e => e.ClassId, "Class_Id");

                entity.HasIndex(e => e.ProgramId, "Program_Id");

                entity.HasIndex(e => e.RqdCourseId, "RqdCourse_Id");

                entity.Property(e => e.ElgibiltyId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Elgibilty_ID");

                entity.Property(e => e.ClassId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Class_Id");

                entity.Property(e => e.ProgramId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Program_Id");

                entity.Property(e => e.RqdCourseId)
                    .HasColumnType("int(11)")
                    .HasColumnName("RqdCourse_Id");

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.TblCourseEligiblities)
                    .HasForeignKey(d => d.ClassId)
                    .HasConstraintName("Tbl_CourseEligiblity_ibfk_1");

                entity.HasOne(d => d.Program)
                    .WithMany(p => p.TblCourseEligiblities)
                    .HasForeignKey(d => d.ProgramId)
                    .HasConstraintName("Tbl_CourseEligiblity_ibfk_2");

                entity.HasOne(d => d.RqdCourse)
                    .WithMany(p => p.TblCourseEligiblities)
                    .HasForeignKey(d => d.RqdCourseId)
                    .HasConstraintName("Tbl_CourseEligiblity_ibfk_3");
            });

            modelBuilder.Entity<TblDay>(entity =>
            {
                entity.HasKey(e => e.DayId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Days");

                entity.Property(e => e.DayId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Day_Id");

                entity.Property(e => e.DayName).HasMaxLength(50);
            });

            modelBuilder.Entity<TblFaculty>(entity =>
            {
                entity.HasKey(e => e.FacultyId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Faculty");

                entity.HasIndex(e => e.UserId, "UserID");

                entity.Property(e => e.FacultyId).HasColumnType("int(11)");

                entity.Property(e => e.UserId)
                    .HasColumnType("int(11)")
                    .HasColumnName("UserID");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.TblFaculties)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("Tbl_Faculty_ibfk_1");
            });

            modelBuilder.Entity<TblFacultyCourseRegistration>(entity =>
            {
                entity.HasKey(e => e.FcrId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_FacultyCourseRegistration");

                entity.HasIndex(e => e.ClassId, "Class_ID");

                entity.HasIndex(e => e.FacultyId, "Faculty_ID");

                entity.Property(e => e.FcrId)
                    .HasColumnType("int(11)")
                    .HasColumnName("FCR_ID");

                entity.Property(e => e.ClassId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Class_ID");

                entity.Property(e => e.FacultyId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Faculty_ID");

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.TblFacultyCourseRegistrations)
                    .HasForeignKey(d => d.ClassId)
                    .HasConstraintName("Tbl_FacultyCourseRegistration_ibfk_2");

                entity.HasOne(d => d.Faculty)
                    .WithMany(p => p.TblFacultyCourseRegistrations)
                    .HasForeignKey(d => d.FacultyId)
                    .HasConstraintName("Tbl_FacultyCourseRegistration_ibfk_1");
            });

            modelBuilder.Entity<TblProfile>(entity =>
            {
                entity.HasKey(e => e.ProfileId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Profile");

                entity.Property(e => e.ProfileId)
                    .HasColumnType("int(11)")
                    .HasColumnName("ProfileID");

                entity.Property(e => e.Address).HasMaxLength(100);

                entity.Property(e => e.City).HasMaxLength(50);

                entity.Property(e => e.Country).HasMaxLength(50);

                entity.Property(e => e.DoB).HasMaxLength(50);

                entity.Property(e => e.Email).HasMaxLength(50);

                entity.Property(e => e.FatherName).HasMaxLength(50);

                entity.Property(e => e.Gender).HasMaxLength(50);

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.Name).HasMaxLength(50);

                entity.Property(e => e.Nic)
                    .HasMaxLength(50)
                    .HasColumnName("NIC");

                entity.Property(e => e.PhoneNumber).HasMaxLength(50);

                entity.Property(e => e.Picture).HasMaxLength(1000);
            });

            modelBuilder.Entity<TblProgram>(entity =>
            {
                entity.HasKey(e => e.ProgramId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Programs");

                entity.Property(e => e.ProgramId)
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever()
                    .HasColumnName("ProgramID");

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.ProgramName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<TblProgramSyllabus>(entity =>
            {
                entity.HasKey(e => e.SyllabusId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_ProgramSyllabus");

                entity.HasIndex(e => e.CourseId, "Course_Id");

                entity.HasIndex(e => e.ProgramId, "Program_Id");

                entity.HasIndex(e => e.RqdCourseId, "RqdCourse_Id");

                entity.Property(e => e.SyllabusId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Syllabus_Id");

                entity.Property(e => e.CourseId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Course_Id");

                entity.Property(e => e.ProgramId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Program_Id");

                entity.Property(e => e.RqdCourseId)
                    .HasColumnType("int(11)")
                    .HasColumnName("RqdCourse_Id");

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.TblProgramSyllabusCourses)
                    .HasForeignKey(d => d.CourseId)
                    .HasConstraintName("Tbl_ProgramSyllabus_ibfk_2");

                entity.HasOne(d => d.Program)
                    .WithMany(p => p.TblProgramSyllabi)
                    .HasForeignKey(d => d.ProgramId)
                    .HasConstraintName("Tbl_ProgramSyllabus_ibfk_1");

                entity.HasOne(d => d.RqdCourse)
                    .WithMany(p => p.TblProgramSyllabusRqdCourses)
                    .HasForeignKey(d => d.RqdCourseId)
                    .HasConstraintName("Tbl_ProgramSyllabus_ibfk_3");
            });

            modelBuilder.Entity<TblRole>(entity =>
            {
                entity.HasKey(e => e.RoleId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Roles");

                entity.Property(e => e.RoleId)
                    .HasColumnType("int(11)")
                    .HasColumnName("RoleID");

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.RoleName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<TblSemester>(entity =>
            {
                entity.HasKey(e => e.SemesterId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Semester");

                entity.Property(e => e.SemesterId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Semester_Id");

                entity.Property(e => e.SemesterName).HasMaxLength(50);
            });

            modelBuilder.Entity<TblStudent>(entity =>
            {
                entity.HasKey(e => e.StudentId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Student");

                entity.HasIndex(e => e.ProgramId, "ProgramID");

                entity.HasIndex(e => e.UserId, "UserID");

                entity.Property(e => e.StudentId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Student_Id");

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.ProgramId)
                    .HasColumnType("int(11)")
                    .HasColumnName("ProgramID");

                entity.Property(e => e.UserId)
                    .HasColumnType("int(11)")
                    .HasColumnName("UserID");

                entity.HasOne(d => d.Program)
                    .WithMany(p => p.TblStudents)
                    .HasForeignKey(d => d.ProgramId)
                    .OnDelete(DeleteBehavior.SetNull)
                    .HasConstraintName("Tbl_Student_ibfk_1");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.TblStudents)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.SetNull)
                    .HasConstraintName("Tbl_Student_ibfk_2");
            });

            modelBuilder.Entity<TblStudentCourseRegistration>(entity =>
            {
                entity.HasKey(e => e.ScrId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_StudentCourseRegistration");

                entity.HasIndex(e => e.ElgibiltyId, "Elgibilty_ID");

                entity.HasIndex(e => e.StudentId, "Student_ID");

                entity.Property(e => e.ScrId)
                    .HasColumnType("int(11)")
                    .HasColumnName("SCR_Id");

                entity.Property(e => e.ElgibiltyId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Elgibilty_ID");

                entity.Property(e => e.StudentId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Student_ID");

                entity.HasOne(d => d.Elgibilty)
                    .WithMany(p => p.TblStudentCourseRegistrations)
                    .HasForeignKey(d => d.ElgibiltyId)
                    .HasConstraintName("Tbl_StudentCourseRegistration_ibfk_2");

                entity.HasOne(d => d.Student)
                    .WithMany(p => p.TblStudentCourseRegistrations)
                    .HasForeignKey(d => d.StudentId)
                    .HasConstraintName("Tbl_StudentCourseRegistration_ibfk_1");
            });

            modelBuilder.Entity<TblTime>(entity =>
            {
                entity.HasKey(e => e.TimeId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_Time");

                entity.Property(e => e.TimeId)
                    .HasColumnType("int(11)")
                    .HasColumnName("Time_Id");

                entity.Property(e => e.TimeName).HasMaxLength(50);
            });

            modelBuilder.Entity<TblUser>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("PRIMARY");

                entity.ToTable("Tbl_User");

                entity.HasIndex(e => e.ProfileId, "ProfileID");

                entity.HasIndex(e => e.RoleId, "RoleID");

                entity.Property(e => e.UserId)
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever()
                    .HasColumnName("UserID");

                entity.Property(e => e.IsActive).HasColumnType("bit(1)");

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.ProfileId)
                    .HasColumnType("int(11)")
                    .HasColumnName("ProfileID");

                entity.Property(e => e.RoleId)
                    .HasColumnType("int(11)")
                    .HasColumnName("RoleID");

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Profile)
                    .WithMany(p => p.TblUsers)
                    .HasForeignKey(d => d.ProfileId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Tbl_User_ibfk_2");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.TblUsers)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Tbl_User_ibfk_3");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
