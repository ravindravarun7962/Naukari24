using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSendMessage_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string subject = txtSubject.Text.Trim();
            string message = txtMessage.Text.Trim();

            try
            {
                // =========================================
                // YOUR EMAIL CONFIGURATION
                // =========================================

                string fromEmail = "varunravindra2143@gmail.com";
                string appPassword = "ujxtwxwhzhvtgkro";

                string toEmail = "varunravindra2143@gmail.com";


                // =========================================
                // EMAIL BODY
                // =========================================

                string emailBody = @"
                    <html>
                    <body style='font-family: Arial, sans-serif;'>

                        <h2>New Contact Form Message</h2>

                        <table cellpadding='8' cellspacing='0'
                               style='border-collapse: collapse;'>

                            <tr>
                                <td><strong>Name</strong></td>
                                <td>" + Server.HtmlEncode(name) + @"</td>
                            </tr>

                            <tr>
                                <td><strong>Email</strong></td>
                                <td>" + Server.HtmlEncode(email) + @"</td>
                            </tr>

                            <tr>
                                <td><strong>Mobile</strong></td>
                                <td>" + Server.HtmlEncode(mobile) + @"</td>
                            </tr>

                            <tr>
                                <td><strong>Subject</strong></td>
                                <td>" + Server.HtmlEncode(subject) + @"</td>
                            </tr>

                            <tr>
                                <td><strong>Message</strong></td>
                                <td>" + Server.HtmlEncode(message)
                                .Replace("\r\n", "<br/>")
                                .Replace("\n", "<br/>") + @"</td>
                            </tr>

                        </table>

                    </body>
                    </html>
                ";


                // =========================================
                // CREATE MAIL
                // =========================================

                MailMessage mail = new MailMessage();

                mail.From = new MailAddress(
                    fromEmail,
                    "Naukari24 Job Portal"
                );

                mail.To.Add(toEmail);

                // User's email for Reply
                if (!string.IsNullOrWhiteSpace(email))
                {
                    mail.ReplyToList.Add(
                        new MailAddress(email, name)
                    );
                }

                mail.Subject =
                    "Contact Form: " + subject;

                mail.Body = emailBody;

                mail.IsBodyHtml = true;


                // =========================================
                // SMTP
                // =========================================

                SmtpClient smtp = new SmtpClient(
                    "smtp.gmail.com",
                    587
                );

                smtp.EnableSsl = true;

                smtp.Credentials =
                    new NetworkCredential(
                        fromEmail,
                        appPassword
                    );


                // =========================================
                // SEND EMAIL
                // =========================================

                smtp.Send(mail);


                // =========================================
                // SUCCESS MESSAGE
                // =========================================

                lblMessage.Text =
                    "Thank you for contacting us. " +
                    "Your message has been sent successfully.";

                lblMessage.Visible = true;

                lblMessage.Style["background"] = "#ecfdf5";
                lblMessage.Style["color"] = "#047857";
                lblMessage.Style["padding"] = "11px 13px";
                lblMessage.Style["border-radius"] = "7px";
                lblMessage.Style["display"] = "block";
                lblMessage.Style["margin-bottom"] = "18px";


                // Clear form

                txtName.Text = "";
                txtEmail.Text = "";
                txtMobile.Text = "";
                txtSubject.Text = "";
                txtMessage.Text = "";
            }
            catch (Exception ex)
            {
                lblMessage.Text =
                    "Unable to send your message right now. " +
                    "Please try again later.";

                lblMessage.Visible = true;

                lblMessage.Style["background"] = "#fef2f2";
                lblMessage.Style["color"] = "#b91c1c";
                lblMessage.Style["padding"] = "11px 13px";
                lblMessage.Style["border-radius"] = "7px";
                lblMessage.Style["display"] = "block";
                lblMessage.Style["margin-bottom"] = "18px";

                // For development only
                System.Diagnostics.Debug.WriteLine(
                    ex.ToString()
                );
            }

        }

    }
}
