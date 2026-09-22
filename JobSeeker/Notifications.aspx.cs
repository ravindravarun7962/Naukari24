using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal.JobSeeker
{
    public partial class Notifications : Page
    {
        private int UserId
        {
            get
            {
                int userId;

                if (!int.TryParse(
                    Convert.ToString(Session["UserId"]),
                    out userId))
                {
                    return 0;
                }

                return userId;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserId"] == null)
            {
                RedirectToLogin();
                return;
            }

            if (!string.Equals(Convert.ToString(Session["UserRole"]),"JobSeeker",StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (UserId <= 0)
                {
                    RedirectToLogin();
                    return;
                }

                LoadNotifications();
            }


        }
       
        private void LoadNotifications()
        {
            string query = @"SELECT NotificationId,UserId,Title,Message,NotificationType,IsRead,CreatedAt FROM Notifications WHERE UserId = @UserId ORDER BY CreatedAt DESC";
            DataTable dt = Utility._GetDataTable24(query,new SqlParameter("@UserId", SqlDbType.Int)
                {
                    Value = UserId
            }
            );

            if (dt.Rows.Count > 0)
            {
                rptNotifications.DataSource = dt;
                rptNotifications.DataBind();
                pnlNotifications.Visible = true;
                pnlEmpty.Visible = false;

                int unreadCount = 0;

                foreach (DataRow row in dt.Rows)
                {
                    if (!GetIsRead(row["IsRead"]))
                    {
                        unreadCount++;
                    }
                }

                lblNotificationCount.Text = unreadCount + " unread notification" + (unreadCount == 1 ? "" : "s");
            }
            else
            {
                rptNotifications.DataSource = null;
                rptNotifications.DataBind();
                pnlNotifications.Visible = false;
                pnlEmpty.Visible = true;
                lblNotificationCount.Text = "0 notifications";
            }
        }

        protected void btnMarkRead_Command(object sender,CommandEventArgs e)
        {
            int notificationId;

            if (!int.TryParse(Convert.ToString(e.CommandArgument),out notificationId))
            {
                return;
            }

            string query = @"UPDATE Notifications SET IsRead = 1 WHERE NotificationId = @NotificationId AND UserId = @UserId";
            Utility.ExecuteQuery24(query,new SqlParameter("@NotificationId",SqlDbType.Int)
                {
                    Value = notificationId
                },
                new SqlParameter("@UserId",SqlDbType.Int)
                {
                    Value = UserId
                }
            );

            LoadNotifications();
        }

        protected void btnMarkAllRead_Click(object sender,EventArgs e)
        {
            string query = @"UPDATE Notifications SET IsRead = 1 WHERE UserId = @UserId AND IsRead = 0";
            Utility.ExecuteQuery24(query,new SqlParameter("@UserId",SqlDbType.Int)
                {
                    Value = UserId
            }
            );

            LoadNotifications();
        }

        public bool GetIsRead(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return false;
            }

            bool result;

            if (bool.TryParse(Convert.ToString(value),out result))
            {
                return result;
            }

            int intValue;

            if (int.TryParse(Convert.ToString(value),out intValue))
            {
                return intValue == 1;
            }

            return false;
        }

        public string GetNotificationClass(object isRead)
        {
            if (GetIsRead(isRead))
            {
                return "notification-item";
            }

            return "notification-item unread";
        }

        public string GetNotificationIconClass(object notificationType)
        {
            string type = Convert.ToString(notificationType);

            switch (type.ToLowerInvariant())
            {
                case "job":
                    return "notification-icon job";

                case "application":
                    return "notification-icon application";

                case "interview":
                    return "notification-icon interview";

                case "message":
                    return "notification-icon message";

                default:
                    return "notification-icon system";
            }
        }

        public string GetNotificationIcon(object notificationType)
        {
            string type = Convert.ToString(notificationType);

            switch (type.ToLowerInvariant())
            {
                case "job":
                    return "bi bi-briefcase";

                case "application":
                    return "bi bi-file-earmark-check";

                case "interview":
                    return "bi bi-calendar-event";

                case "message":
                    return "bi bi-chat-dots";

                default:
                    return "bi bi-bell";
            }
        }

        public string GetRelativeTime(object date)
        {
            if (date == null || date == DBNull.Value)
            {
                return "";
            }

            DateTime createdAt;

            if (!DateTime.TryParse(Convert.ToString(date),out createdAt))
            {
                return Convert.ToString(date);
            }

            TimeSpan difference = DateTime.Now - createdAt;

            if (difference.TotalSeconds < 60)
            {
                return "Just now";
            }

            if (difference.TotalMinutes < 60)
            {
                int minutes = (int)difference.TotalMinutes;
                return minutes + " minute" + (minutes == 1 ? "" : "s") + " ago";
            }

            if (difference.TotalHours < 24)
            {
                int hours = (int)difference.TotalHours;
                return hours + " hour" + (hours == 1 ? "" : "s") + " ago";
            }

            if (difference.TotalDays < 7)
            {
                int days = (int)difference.TotalDays;
                return days + " day" + (days == 1 ? "" : "s") + " ago";
            }

            return createdAt.ToString("dd MMM yyyy hh:mm tt");
        }

        private void RedirectToLogin()
        {
            Response.Redirect("~/Login.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.RawUrl));
        }

    }
}