using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using MySql.Data.MySqlClient;
using System.Web.Script.Serialization;

namespace Health_Bridge
{
    /// <summary>
    /// Summary description for DoctorService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class DoctorService : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public void GetAllDoctors()
        {
            List<Doctors> doctorsList = new List<Doctors>();
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string selectQuery = "select * from health_bridge_doctors";
                MySqlCommand cmd = new MySqlCommand(selectQuery, con);
                
                con.Open();
                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Doctors doctor = new Doctors();

                    doctor.HospitalId = Convert.ToInt32(rdr["HospitalId"]);
                    doctor.HospitalName = rdr["HospitalName"].ToString();
                    doctor.DoctorName = rdr["DoctorName"].ToString();
                    doctor.Specialization = rdr["Specialization"].ToString();
                    doctor.HospitalLocation = rdr["HospitalLocation"].ToString();
                    doctor.HospitalAddress = rdr["HospitalAddress"].ToString();
                    doctor.Rating = Convert.ToInt32(rdr["Rating"]);
                    doctor.ConsultancyFee = Convert.ToInt32(rdr["ConsultancyFee"]);
                    doctor.Image = rdr["Image"].ToString();

                    doctorsList.Add(doctor);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(doctorsList));
           
        }
    }
}
