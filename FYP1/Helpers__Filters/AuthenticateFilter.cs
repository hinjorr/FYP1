using System;
using System.Collections.Generic;
using FYP1.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.Mvc.Filters;

namespace FYP1.Helpers__Filters
{
    public class AuthenticateFilter : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var descriptor = filterContext.ActionDescriptor as ControllerActionDescriptor;
            var _controller = descriptor.ControllerName;
            var _action = descriptor.ActionName;
            var data = filterContext.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
            var permissions = filterContext.HttpContext.Session.GetObjectFromJson<List<GeneralDTO>>("Permissions");
            if (data == null)
            {
                var controller = (ControllerBase)filterContext.Controller;
                filterContext.Result = controller.RedirectToAction("Login", "Authentication");
            }
            else
            {
                foreach (var i in permissions)
                {
                    if (i.Menu.Controller == _controller && i.Menu.Action == _action)
                    {
                        foreach (var j in permissions)
                        {
                            if (i.Menu.MenuId == j.RoleMenu.MenuId && j.RoleMenu.RoleId == data.Role.RoleId && j.RoleMenu.Check == true)
                            {
                                base.OnActionExecuting(filterContext);
                                break;
                            }
                            else if (i.Menu.MenuId == j.RoleMenu.MenuId && j.RoleMenu.RoleId == data.Role.RoleId && j.RoleMenu.Check == false)
                            {
                                var controller = (ControllerBase)filterContext.Controller;
                                filterContext.Result = controller.RedirectToAction("Error404Page", "Authentication");
                                break;
                            }
                        }
                        break;
                    }

                }
            }
            // base.OnActionExecuting(filterContext);
        }
    }
}