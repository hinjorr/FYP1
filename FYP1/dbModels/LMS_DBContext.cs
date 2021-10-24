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

        public virtual DbSet<TblCourse> TblCourses { get; set; }
        public virtual DbSet<TblProfile> TblProfiles { get; set; }
        public virtual DbSet<TblProgram> TblPrograms { get; set; }
        public virtual DbSet<TblRole> TblRoles { get; set; }
        public virtual DbSet<TblUser> TblUsers { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseMySql("server=localhost;port=3306;user=root;password=masood1050;database=LMS", Microsoft.EntityFrameworkCore.ServerVersion.Parse("5.7.35-mysql"));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasCharSet("latin1");

            modelBuilder.Entity<TblCourse>(entity =>
            {
                entity.HasKey(e => e.CourseId)
                    .HasName("PRIMARY");

                entity.Property(e => e.CourseId)
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever()
                    .HasColumnName("CourseID");

                entity.Property(e => e.CourseCrHr).HasColumnType("int(50)");

                entity.Property(e => e.CourseName).HasMaxLength(50);

                entity.Property(e => e.RequiredCrHr).HasColumnType("int(50)");
            });

            modelBuilder.Entity<TblProfile>(entity =>
            {
                entity.HasKey(e => e.ProfileId)
                    .HasName("PRIMARY");

                entity.ToTable("TblProfile");

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

                entity.Property(e => e.ProgramId)
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever()
                    .HasColumnName("ProgramID");

                entity.Property(e => e.ProgramName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<TblRole>(entity =>
            {
                entity.HasKey(e => e.RoleId)
                    .HasName("PRIMARY");

                entity.Property(e => e.RoleId)
                    .HasColumnType("int(11)")
                    .HasColumnName("RoleID");

                entity.Property(e => e.RoleName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<TblUser>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("PRIMARY");

                entity.ToTable("TblUser");

                entity.HasIndex(e => e.ProfileId, "ProfileID");

                entity.HasIndex(e => e.RoleId, "RoleID");

                entity.Property(e => e.UserId)
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever()
                    .HasColumnName("UserID");

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
                    .HasConstraintName("TblUser_ibfk_2");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.TblUsers)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("TblUser_ibfk_3");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
