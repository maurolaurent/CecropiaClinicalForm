using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicalLib.Models
{
    public class AjaxResp
    {

        public AjaxResp() { }

        public int totalCount { get; set; }
        public List<Patient> items { get; set; }
    }
}
