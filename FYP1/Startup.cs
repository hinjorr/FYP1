using System;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Models;
using FYP1.Repository;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Hosting;

namespace FYP1
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddDbContext<LMS_DBContext>(x => x.UseMySql(Configuration.GetConnectionString("Default"), ServerVersion.Parse("5.7.36-mysql")));
            services.AddAutoMapper(typeof(AutoMapperProfile));
            services.AddControllersWithViews();
           // services.AddDistributedMemoryCache();
            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(1);//You can set Time   
            });
            services.AddMvc();
            services.TryAddSingleton<IHttpContextAccessor, HttpContextAccessor>();
            services.AddScoped<IAuthentication, AuthenticationModel>();
            services.AddScoped<IClasses, ClassesModel>();
            services.AddScoped<IProgramSyllabus, ProgramSyllabusModel>();
            services.AddScoped<ICourse, CourseModel>();
            services.AddScoped<ISemester, SemesterModel>();
            services.AddScoped<IUser, UserModel>();
            services.AddScoped<IUserValidation, UserValidationModel>();
            services.AddScoped<IPrograms, ProgramsModel>();
            services.AddScoped<IGeneral, GeneralModel>();


        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseSession();
            app.UseRouting();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Authentication}/{action=Login}");
            });
        }
    }
}
