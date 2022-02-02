using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using FYP1.dbModels;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace FYP1.Models
{
    public class RoleManagementModel : IRoleManagement
    {
        private LMS_DBContext db;
        private readonly IMapper mapper;
        private readonly IConfiguration config;
        TblRoleMenu TblRoleMenu = new TblRoleMenu();
        TblRole tbl_role = new TblRole();
        GeneralDTO general = new GeneralDTO();
        public RoleManagementModel(LMS_DBContext _db, IMapper _mapper, IConfiguration config)
        {
            db = _db;
            mapper = _mapper;
            this.config = config;
        }

        public async Task<GeneralDTO> CreateRole(RoleDTO dto)
        {
            try
            {
                if (dto.RoleId != 0)
                {
                    var get_role = await db.TblRoles.Where(x => x.RoleId == dto.RoleId).FirstOrDefaultAsync();
                    if (get_role != null)
                    {
                        get_role.RoleName = dto.RoleName;
                        general.Text = "Role Updated";
                    }
                }
                else
                {
                    mapper.Map(dto, tbl_role);
                    await db.TblRoles.AddAsync(tbl_role);
                    general.Text = "Role Created";
                }

                await db.SaveChangesAsync();
                general.Icon = "success";
                return general;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Icon = "error";
                general.Text = "Server Error";
                return general;
            }
        }

        public async Task<GeneralDTO> GetSingleRole(int id)
        {
            try
            {
                var role = await db.TblRoles.Where(x => x.RoleId == id).FirstOrDefaultAsync();
                if (role != null)
                {
                    mapper.Map(role, general.Role = new RoleDTO());
                }
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Icon = "error";
                general.Text = "Server Error";
            }
            return general;

        }

        public async Task<GeneralDTO> DeleteRole(int id)
        {
            try
            {
                //chk krega k is role pr already rigistered users h ya nh
                var chk_users = await db.TblUsers.Where(x => x.RoleId == id && x.IsActive == Convert.ToUInt16(true)).CountAsync();
                if (chk_users != 0)
                {
                    general.Icon = "error";
                    general.Text = "Role can't be deleted " + chk_users + " user(s) already registered with this role";
                }

                else
                {
                    var get_role = await db.TblRoles.Where(x => x.RoleId == id).FirstOrDefaultAsync();
                    if (get_role != null)
                    {
                        db.TblRoles.Remove(get_role);
                        await db.SaveChangesAsync();
                        general.Icon = "success";
                        general.Text = "Role Deleted";
                    }
                }
                return general;

            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Icon = "error";
                general.Text = "Server Error";
                return general;
            }
        }
        public async Task<List<GeneralDTO>> GetScreens(int Role_ID)
        {
            List<GeneralDTO> _list = new List<GeneralDTO>();
            try
            {
                if (Role_ID != 0)
                {
                    var db_list = await db.TblRoleMenus.Where(x => x.RoleId == Role_ID).Include(x => x.Menu).ToListAsync();
                    if (db_list.Count != 0)
                    {
                        foreach (var item in db_list)
                        {
                            GeneralDTO dto = new GeneralDTO();
                            mapper.Map(item, dto.RoleMenu = new RoleMenuDTO());
                            mapper.Map(item.Menu, dto.Menu = new MenuDTO());
                            _list.Add(dto);
                        }
                    }
                    else
                    {
                        var menus = await db.TblMenus.ToListAsync();
                        foreach (var item in menus)
                        {
                            GeneralDTO dto = new GeneralDTO();
                            mapper.Map(item, dto.Menu = new MenuDTO());
                            _list.Add(dto);
                        }
                    }
                }
                else
                {
                    var menus = await db.TblMenus.ToListAsync();
                    foreach (var item in menus)
                    {
                        GeneralDTO dto = new GeneralDTO();
                        mapper.Map(item, dto.Menu = new MenuDTO());
                        _list.Add(dto);
                    }
                }
                return _list;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Icon = "error";
                general.Text = "Server Error";
                _list.Add(general);
                return _list;
            }
        }


        public async Task<GeneralDTO> AssignPermission(List<RoleMenuDTO> dto)
        {
            try
            {
                var obj = dto.ElementAt(0);
                var chk = await db.TblRoleMenus.Where(x => x.RoleId == obj.RoleId).ToListAsync();
                if (chk.Count != 0)
                {
                    db.TblRoleMenus.RemoveRange(chk);
                }
                List<TblRoleMenu> tbl_list = new List<TblRoleMenu>();
                mapper.Map(dto, tbl_list);
                await db.TblRoleMenus.AddRangeAsync(tbl_list);
                await db.SaveChangesAsync();
                general.Icon = "success";
                general.Text = "Permissions Assigned!";
                return general;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                general.Icon = "error";
                general.Text = "Server Error!";
                return general;
            }
        }

        public async Task<bool> CheckPermission(string _controller, string _action, int Role_ID)
        {
            try
            {
                if (db == null)
                {
                    db = new LMS_DBContext();
                }
                var menu = await db.TblMenus.Where(x => x.Controller == _controller && x.Action == _action).FirstOrDefaultAsync();
                if (menu != null)
                {
                    var chk_permission = await db.TblRoleMenus.Where(x => x.MenuId == menu.MenuId && x.RoleId == Role_ID && x.Check == Convert.ToUInt16(true)).FirstOrDefaultAsync();
                    if (chk_permission != null)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                return false;
            }
            catch (System.Exception ex)
            {
                Thread thr = new Thread(() => Misc.SendExceptionEmail(ex, config));
                thr.Start();
                return false;
            }
        }
    }
}