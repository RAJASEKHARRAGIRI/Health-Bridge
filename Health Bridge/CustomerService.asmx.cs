using MySql.Data.MySqlClient;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Health_Bridge
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class CustomerService : System.Web.Services.WebService
    {

        [WebMethod]
        public Customer CheckCutomerExist(string customermail)
        {
            Customer customer = new Customer();
            // int exist=0;
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string selectQuery = "select * from health_bridge_registrations where email=@mailid ";
                MySqlCommand cmd = new MySqlCommand(selectQuery, con);
                cmd.Parameters.AddWithValue("@mailid", customermail);

                con.Open();
                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (rdr["email"].ToString() == customermail)
                    {
                        customer.customerExist = true;
                        customer.statusFlag = rdr["status"].ToString();
                    }
                    else
                    {
                        customer.customerExist = false;
                    }
                }
            }
            return customer;

        }
        [WebMethod(EnableSession = true)]
        public Customer CheckLogin(string customermail, string Enteredpassword)
        {
            Customer customer = new Customer();
            // int exist=0;
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string selectQuery = "SELECT * FROM health_bridge_registrations WHERE email=@mailid AND password= @pswd AND status=@flag";
                MySqlCommand cmd = new MySqlCommand(selectQuery, con);
                cmd.Parameters.AddWithValue("@mailid", customermail);
                cmd.Parameters.AddWithValue("@pswd", Enteredpassword);
                cmd.Parameters.AddWithValue("@flag", "True");
                con.Open();
                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (rdr["email"].ToString() == customermail && rdr["password"].ToString() == Enteredpassword)
                    {
                        customer.validCustomer = "True";
                        customer.name = rdr["name"].ToString();
                        customer.statusFlag = rdr["status"].ToString();
                        Session["customerName"] = rdr["name"].ToString();
                        Session["customerMail"] = rdr["email"].ToString();

                    }
                    else
                    {
                        customer.validCustomer = "False";
                    }
                }
            }
            return customer;

        }




        [WebMethod]
        public Customer GetCustomer(string customermail)
        {
            Customer customer = new Customer();
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string selectQuery = "select * from health_bridge_registrations where email=@mailid ";
                MySqlCommand cmd = new MySqlCommand(selectQuery, con);
                cmd.Parameters.AddWithValue("@mailid", customermail);
                con.Open();
                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    customer.name = rdr["name"].ToString();
                    customer.location = rdr["location"].ToString();
                    customer.gender = rdr["gender"].ToString();
                    customer.email = rdr["email"].ToString();
                    customer.mobileno = Convert.ToDouble(rdr["mobileno"]);
                    customer.password = rdr["password"].ToString();
                }
            }

            return customer;
        }

        [WebMethod]
        public Customer Registrations(string fullname, string location, string gender, string customermail, double mobileno, string password)
        {
            Customer customer = new Customer();
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            try
            {
                using (MySqlConnection con = new MySqlConnection(cs))
                {
                    string selectQuery = "INSERT INTO health_bridge_registrations(name,location,gender,email,mobileno,password) VALUES(@name,@location,@gender,@email, @mobileno, @password)";
                    MySqlCommand cmd = new MySqlCommand(selectQuery, con);
                    cmd.Parameters.AddWithValue("@name", fullname);
                    cmd.Parameters.AddWithValue("@location", location);
                    cmd.Parameters.AddWithValue("@gender", gender);
                    cmd.Parameters.AddWithValue("@email", customermail);
                    cmd.Parameters.AddWithValue("@mobileno", mobileno);
                    cmd.Parameters.AddWithValue("@password", password);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    customer.registrationSuccessFlag = true;
                }
            }
            catch (MySqlException ex)
            {
                customer.registrationSuccessFlag = false;
            }

            return customer;
        }

        [WebMethod(EnableSession = true)]
        public Customer DeactiveAccount()
        {
            Customer customer = new Customer();
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            try
            {
                using (MySqlConnection con = new MySqlConnection(cs))
                {
                    string selectQuery = "UPDATE health_bridge_registrations SET status=@statusFalg WHERE email=@emailid";
                    MySqlCommand cmd = new MySqlCommand(selectQuery, con);
                    cmd.Parameters.AddWithValue("@statusFalg", "False");
                    cmd.Parameters.AddWithValue("@emailid", Session["customerMail"].ToString());
                    con.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    customer.statusFlag = "False";
                    Session.Abandon();
                }
            }
            catch (MySqlException ex)
            {
                customer.statusFlag = "True";
            }

            return customer;
        }

        [WebMethod]
        public Customer Upload(string fileList)
        {
            Customer customer = new Customer();
            var json = new JavaScriptSerializer().Serialize(fileList);
           

            customer.uploadFlag = fileList+"";


            return customer;
        }

    }
}
