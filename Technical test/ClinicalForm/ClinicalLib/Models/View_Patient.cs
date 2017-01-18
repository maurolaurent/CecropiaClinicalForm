using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicalLib.Models
{
    public class View_Patient
    {
        public int id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string DateOfBirth { get; set; }
        public string Diseases { get; set; }
        public string Phone { get; set; }
        public string BloodType { get; set; }
        public string Country { get; set; }
    }

    public class View_BloodTypes
    {
        public string Id { get; set; }
        public string Antigen { get; set; }
        public string RHFactor { get; set; }
    }


    public class View_Countries
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Acron { get; set; }
    }
}
