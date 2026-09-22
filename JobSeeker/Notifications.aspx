<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="Success24_Job_Portal.JobSeeker.Notifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        .notification-header {
            margin-bottom: 25px;
        }

        .notification-header h2 {
            font-weight: 700;
            margin-bottom: 5px;
        }

        .notification-header p {
            color: #6c757d;
            margin-bottom: 0;
        }

        .notification-wrapper {
            background: #fff;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            overflow: hidden;
        }

        .notification-toolbar {
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .notification-count {
            color: #6c757d;
            font-size: 14px;
        }

        .notification-item {
            display: flex;
            align-items: flex-start;
            padding: 18px 20px;
            border-bottom: 1px solid #f0f0f0;
            text-decoration: none;
            color: inherit;
            transition: all 0.2s ease;
        }

        .notification-item:last-child {
            border-bottom: none;
        }

        .notification-item:hover {
            background: #f8f9fa;
        }

        .notification-item.unread {
            background: #f0f7ff;
        }

        .notification-icon {
            width: 46px;
            height: 46px;
            min-width: 46px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 19px;
        }

        .notification-icon.job {
            background: #e7f1ff;
            color: #0d6efd;
        }

        .notification-icon.application {
            background: #e8f7ee;
            color: #198754;
        }

        .notification-icon.interview {
            background: #fff3cd;
            color: #856404;
        }

        .notification-icon.message {
            background: #f0e7ff;
            color: #6f42c1;
        }

        .notification-icon.system {
            background: #e9ecef;
            color: #495057;
        }

        .notification-content {
            flex: 1;
            min-width: 0;
        }

        .notification-title {
            font-size: 15px;
            font-weight: 700;
            color: #212529;
            margin-bottom: 4px;
        }

        .notification-message {
            color: #6c757d;
            font-size: 14px;
            line-height: 1.5;
        }

        .notification-time {
            color: #8b949e;
            font-size: 12px;
            margin-top: 6px;
        }

        .unread-dot {
            width: 8px;
            height: 8px;
            background: #0d6efd;
            border-radius: 50%;
            margin-left: 12px;
            margin-top: 7px;
            flex-shrink: 0;
        }

        .mark-read-btn {
            border: none;
            background: transparent;
            color: #0d6efd;
            font-size: 12px;
            padding: 5px 8px;
            margin-top: 5px;
        }

        .mark-read-btn:hover {
            text-decoration: underline;
        }

        .empty-state {
            background: #fff;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            padding: 60px 20px;
            text-align: center;
        }

        .empty-state i {
            font-size: 55px;
            color: #adb5bd;
            margin-bottom: 15px;
        }

        .empty-state h4 {
            font-weight: 700;
            margin-bottom: 8px;
        }

        .empty-state p {
            color: #6c757d;
            margin-bottom: 0;
        }

        @media (max-width: 767px) {

            .notification-toolbar {
                padding: 12px 15px;
            }

            .notification-item {
                padding: 15px;
            }

            .notification-icon {
                width: 40px;
                height: 40px;
                min-width: 40px;
                font-size: 17px;
                margin-right: 12px;
            }

            .notification-title {
                font-size: 14px;
            }

            .notification-message {
                font-size: 13px;
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid py-4">

        <div class="notification-header">

            <h2>Notifications</h2>

            <p>
                Stay updated with your applications, interviews and jobs.
            </p>

        </div>

        <asp:Panel ID="pnlNotifications" runat="server">

            <div class="notification-wrapper">

                <div class="notification-toolbar">

                    <span class="notification-count">
                        <asp:Label
                            ID="lblNotificationCount"
                            runat="server">
                        </asp:Label>
                    </span>

                    <asp:LinkButton
                        ID="btnMarkAllRead"
                        runat="server"
                        CssClass="btn btn-sm btn-outline-primary"
                        OnClick="btnMarkAllRead_Click">

                        <i class="bi bi-check2-all me-1"></i>
                        Mark All as Read

                    </asp:LinkButton>

                </div>

                <asp:Repeater
                    ID="rptNotifications"
                    runat="server">

                    <ItemTemplate>

                        <div class='<%# GetNotificationClass(Eval("IsRead")) %>'>

                            <div class='<%# GetNotificationIconClass(Eval("NotificationType")) %>'>

                                <i class='<%# GetNotificationIcon(Eval("NotificationType")) %>'></i>

                            </div>

                            <div class="notification-content">

                                <div class="notification-title">
                                    <%# Eval("Title") %>
                                </div>

                                <div class="notification-message">
                                    <%# Eval("Message") %>
                                </div>

                                <div class="notification-time">

                                    <i class="bi bi-clock me-1"></i>

                                    <%# GetRelativeTime(Eval("CreatedAt")) %>

                                </div>

                                <asp:LinkButton
                                    ID="btnMarkRead"
                                    runat="server"
                                    CssClass="mark-read-btn"
                                    CommandArgument='<%# Eval("NotificationId") %>'
                                    OnCommand="btnMarkRead_Command"
                                    Visible='<%# !GetIsRead(Eval("IsRead")) %>'>

                                    <i class="bi bi-check2 me-1"></i>
                                    Mark as Read

                                </asp:LinkButton>

                            </div>

                            <asp:Panel
                                ID="pnlUnreadDot"
                                runat="server"
                                CssClass="unread-dot"
                                Visible='<%# !GetIsRead(Eval("IsRead")) %>'>
                            </asp:Panel>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </asp:Panel>

        <asp:Panel
            ID="pnlEmpty"
            runat="server"
            Visible="false">

            <div class="empty-state">

                <i class="bi bi-bell-slash"></i>

                <h4>No Notifications</h4>

                <p>
                    You don't have any notifications right now.
                </p>

            </div>

        </asp:Panel>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
