using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System;
using MySql.Data.MySqlClient;
using System.Web.Services;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;

namespace Health_Bridge
{
    public partial class MultipleUploads : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var storageItem = Request.Form["images"];
            Response.Write(storageItem);
        }

       /* [WebMethod, ScriptMethod]
        public static void MultiUpload(string customermail)
        { 
            
            Customer customer = new Customer();
            if (HttpContext.Current != null)
            {
                Page page = (Page)HttpContext.Current.Handler;
                FileUpload file = (FileUpload)page.FindControl("FileUpload1");
                foreach (HttpPostedFile postedFile in file.PostedFiles)
                {
                    string filename = Path.GetFileName(postedFile.FileName);
                    customer.uploadFlag = filename;
                }
           }

           
            
          // return customer;
        }*/

       


        protected void Upload(object sender, EventArgs e)
        {
            var storageItem = Request.Form["images"];
            Response.Write(storageItem);
            /*MySqlConnection sqlcon = new MySqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            foreach (HttpPostedFile postedFile in FileUpload1.PostedFiles)
            {
                string filename = Path.GetFileName(postedFile.FileName);
                try
                {
                    sqlcon.Open();
                    string contentType = postedFile.ContentType;
                    using (Stream fs = postedFile.InputStream)
                    {
                        using (BinaryReader br = new BinaryReader(fs))
                        {
                            byte[] bytes = br.ReadBytes((Int32)fs.Length);

                            //parameters blob, file type, filename
                            MySqlCommand cmd = new MySqlCommand("insert into images(image,contentType, fileName) values( @Content, @ContentType,@FileName)", sqlcon);
                            cmd.Parameters.AddWithValue("@FileName", filename);
                            cmd.Parameters.AddWithValue("@ContentType", contentType);
                            cmd.Parameters.AddWithValue("@Content", bytes);
                            cmd.ExecuteNonQuery();
                            cmd.Dispose();
                            Response.Write("Successfull !!!!");
                        }
                    }
                }
                catch (MySqlException ex)
                {
                    if (ex.Number == 1062)
                        Response.Write("Id already Exist");
                    else
                        Response.Write(" Problem to Insert Record" + ex.Message);
                }
                finally
                {
                    sqlcon.Close();
                }
            }
            Response.Redirect(Request.Url.AbsoluteUri);*/
        }
       
    }
}