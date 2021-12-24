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

            services.AddScoped<IAuthentication, AuthenticationModel>();
            services.AddScoped<IClasses, ClassesModel>();
            services.AddScoped<IProgramSyllabus, ProgramSyllabusModel>();
            services.AddScoped<ICourse, CourseModel>();
            services.AddScoped<ISemester, SemesterModel>();
            services.AddScoped<IUser, UserModel>();
            services.AddScoped<IUserValidation, UserValidationModel>();
            services.AddScoped<IPrograms, ProgramsModel>();
            services.AddScoped<IGeneral, GeneralModel>();
            services.AddDbContext<LMS_DBContext>(x => x.UseMySql(Configuration.GetConnectionString("Default"), ServerVersion.Parse("5.7.36-mysql")));
            services.AddAutoMapper(typeof(AutoMapperProfile));
            services.AddControllersWithViews();
            services.AddSession(x => x.IdleTimeout = TimeSpan.FromMinutes(10));

            services.TryAddSingleton<IHttpContextAccessor, HttpContextAccessor>();
            // services.AddControllers(config =>
            // {
            //     config.Filters.Add(new ExceptionFilter());
            // });
            services.AddSwaggerGen();


        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "My Test1 Api v1");
            });
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseSession();

            app.UseCookiePolicy();
            app.UseAuthentication();

            app.UseRouting();

            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Authentication}/{action=Login}");
            });
        }
    }
}
