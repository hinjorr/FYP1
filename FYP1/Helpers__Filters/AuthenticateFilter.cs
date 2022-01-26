using System;
using System.Collections.Generic;
using FYP1.DTOs;
using Microsoft.AspNetCore.Http;
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


            filterContext.HttpContext.Session.SetString("ReturnUrl", filterContext.HttpContext.Request.Path.Value);

            if (data == null)
            {
                 var controller = (ControllerBase)filterContext.Controller;
                filterContext.Result = controller.RedirectToAction("Login", "Authentication");
            }
            else
            {
                bool chk = true;
                foreach (var i in permissions)
                {   
                    if (i.Menu.Controller == _controller && i.Menu.Action == _action)
                    {
                        base.OnActionExecuting(filterContext);
                        chk = false;
                        break;
                    }
                }
                if (chk)
                {
                    var controller = (ControllerBase)filterContext.Controller;
                    filterContext.Result = controller.RedirectToAction("Error404Page", "Authentication");
                }
            }
            // base.OnActionExecuting(filterContext);
        }
    }
}