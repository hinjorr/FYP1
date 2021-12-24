using FYP1.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Routing;

namespace FYP1.Helpers__Filters
{
    public class AuthorizedUserFilter : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var data = filterContext.HttpContext.Session.GetObjectFromJson<GeneralDTO>("UserDetails");
            
            if (data == null)
            {
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary
                {
                    {"Area", ""},
                    {"Controller", "Authentication"},
                    {"Action", "Login"}
                });

            }
            base.OnActionExecuting(filterContext);
        }

    }
}