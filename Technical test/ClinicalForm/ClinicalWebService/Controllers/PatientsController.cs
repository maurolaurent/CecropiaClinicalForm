using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ClinicalLib;
using ClinicalLib.Models;
using System.Net.Http;
using System.Net;
using ClinicalLib.Rules;

namespace ClinicalWebService.Controllers
{
    public class PatientsController : Controller
    {

      
        [System.Web.Http.HttpPost]
        public ActionResult Post(Patient values)
        {
            PatientCRUD.AddPatient(values);

            return new HttpStatusCodeResult(200);

        }

       
        [System.Web.Http.HttpDelete]
        public ActionResult Delete(int key)
        {
            PatientCRUD.DeletePatient(key);

            return new HttpStatusCodeResult(200);

        }

    }
}
