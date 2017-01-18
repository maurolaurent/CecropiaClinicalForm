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
        public List<View_Patient> items { get; set; }
    }

    public class AjaxResp_BloodTypes
    {

        public AjaxResp_BloodTypes() { }

        public int totalCount { get; set; }
        public List<BloodType> items { get; set; }
    }
}
