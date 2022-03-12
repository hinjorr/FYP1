using System.Threading.Tasks;
using FYP1.Repository;
using Microsoft.AspNetCore.Mvc;

namespace FYP1.Controllers
{
    public class NotficationController : Controller
    {
        private readonly INotifications repo;

        public NotficationController(INotifications repo)
        {
            this.repo = repo;
        }
        public async Task<IActionResult> Send_GroupNotification(int class_id, int notification_type, string message)
        {
            await repo.Send_GroupNotification(class_id, notification_type, message);
            return Ok();
        }

        public async Task<IActionResult> ReceiveNotifications()
        {
            var data = await repo.ReceiveNotifications();
            return Ok(data);
        }
        public async Task<IActionResult> MarkAsReadNotifications()
        {
            await repo.MarkAsReadNotifications();
            return Ok();
        }
    }
}