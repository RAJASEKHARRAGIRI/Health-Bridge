using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;

namespace Health_Bridge
{
    /// <summary>
    /// Summary description for UploadImages
    /// </summary>
    public class UploadImages : IHttpHandler
    {

        MySqlConnection connection;
        MySqlCommand command;

        string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        string insert_item;
        object result_insert;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");

            HttpFileCollection files = context.Request.Files;
            for (int i = 0; i < files.Count; i++)
            {
                HttpPostedFile file = files[i];
                using (connection = new MySqlConnection(connString))
                {
                    connection.Open();
                    using (Stream fs = file.InputStream)
                    {
                        using (BinaryReader br = new BinaryReader(fs))
                        {
                            byte[] bytes = br.ReadBytes((Int32)fs.Length);
                            insert_item = "insert into images(image,contentType,fileName) values(@image,@type,@name)";
                            using (command = new MySqlCommand(insert_item, connection))
                            {
                                command.Parameters.AddWithValue("@image", bytes);
                                command.Parameters.AddWithValue("@type", file.ContentType);
                                command.Parameters.AddWithValue("@name", file.FileName);
                                result_insert = command.ExecuteNonQuery();

                            }
                        }
                    }

                }

            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}