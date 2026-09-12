using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace Success24_Job_Portal
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);

        }
        // =========================================================
        // REGISTER ROUTES
        // =========================================================

        private static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute(
                "JobDetailsClean",
                "{city}/{company}/Jobs/{position}",
                "~/JobDetails.aspx"
            );

            routes.MapPageRoute(
                "JobSeekerJobSearch",
                "{city}/Jobseeker/Looking-for-{keyword}",
                "~/Jobs.aspx"
            );
        }


        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}