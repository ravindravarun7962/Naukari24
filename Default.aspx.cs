using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Success24_Job_Portal
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtKeyword.Text.Trim();
            string location = txtLocation.Text.Trim();

            string url = "~/Jobs.aspx?keyword=" +
                         Server.UrlEncode(keyword) +
                         "&location=" +
                         Server.UrlEncode(location);

            Response.Redirect(url);
        }
    }
}