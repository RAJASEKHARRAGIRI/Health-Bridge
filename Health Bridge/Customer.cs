using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Health_Bridge
{
    public class Customer
    {
        public string name { get; set; }
        public string location { get; set; }
        public string gender { get; set; }
        public string email { get; set; }
        public double mobileno { get; set; }
        public string password { get; set; }

        public Boolean customerExist { get; set; }
        public string validCustomer { get; set; }
        public Boolean registrationSuccessFlag { get; set; }
        public string statusFlag { get; set; }
        public string uploadFlag { get; set; }
    }
}