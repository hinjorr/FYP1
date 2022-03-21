using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface INotifications
    {
        Task Send_GroupNotification(int class_id, int notification_type, string message);
        Task<List<GeneralDTO>> ReceiveNotifications();
        Task MarkAsReadNotifications();
        Task SendSingleNotification(int _To, string _From, int _Type, string _Message, int? _ClassId);
    }
}