using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Health_Bridge
{
    public partial class index : System.Web.UI.Page
    {
        public enum MessageType { success, error, info, warning };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["customerMail"] != null)
            {
                Response.Redirect("HomePage.aspx");
            }
        }
        
       
        protected void btnLogin(object sender, EventArgs e) {
            ShowMessage(User.Identity.Name.ToString(), MessageType.success);
        }

        protected void btnregister_OnClick(object sender, EventArgs e)
        {
            //    Response.Write("helppppppppppppppp");
            ShowMessage("Hai Boss", MessageType.success);
            
        }

        protected void email_TextChanged(object sender, EventArgs e)
        {
            //Response.Write("Textttttttttttttttt");
            //ShowMessage("Hai Text", MessageType.success);
        }


        //Showing alerts 
        protected void ShowMessage(string Message, MessageType type)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
        }
    }
}