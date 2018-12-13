using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Health_Bridge
{
    public class Doctors
    {
        public int HospitalId { get; set; }
        public string HospitalName { get; set; }
        public string DoctorName { get; set; }
        public string Specialization { get; set; }
        public string HospitalLocation { get; set; }
        public string HospitalAddress { get; set; }
        public int Rating { get; set; }
        public int ConsultancyFee { get; set; }
        public string Image { get; set; }
    }
}