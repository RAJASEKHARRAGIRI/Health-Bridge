using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Health_Bridge
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(Session["customerMail"]);
            if (Session.Contents.Count == 0 && Session["customerMail"] == null)
            {
                Response.Redirect("index.aspx");
            }
            else {
                welcomeUsername.Text = "Welcome!! "+ Session["customerName"];
            }
        }

        
        protected void logoutCustomer(object sender, EventArgs e)
        {
            // Session.Clear();
            Session.Abandon();
            Response.Redirect("index.aspx");
            
        }
    }
}