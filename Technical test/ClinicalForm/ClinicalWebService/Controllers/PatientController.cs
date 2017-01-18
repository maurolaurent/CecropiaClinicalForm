using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using ClinicalLib;
using ClinicalLib.Models;
using Newtonsoft.Json;
using System.Threading.Tasks;
using ClinicalLib.Rules;

namespace ClinicalWebService.Controllers
{
    public class PatientController : ApiController
    {
        // GET: api/BloodType
        public async Task<AjaxResp> Get()
        {            
            return await DoGetPatients();
        }

        public async Task<AjaxResp> DoGetPatients()
        {
           return await Task.Run(() => GetPatients());
          
        }

        private AjaxResp GetPatients() {

            PatientCRUD crud = new PatientCRUD();

            List<Patient> patients = PatientCRUD.SelectPatient();
            return new AjaxResp { totalCount = patients.Count, items = patients };
        }




        // GET: api/Patient
      
        // GET: api/Patient/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Patient
        [System.Web.Http.HttpPost]
        public HttpResponseMessage Post(Patient value)
        {
            return Request.CreateResponse(HttpStatusCode.Gone);

        }

      /*  [System.Web.Http.HttpPut]
        public HttpResponseMessage Put(string value)
        {
            return Request.CreateResponse(HttpStatusCode.Gone);

        }*/

        // DELETE: api/Patient/5
        public void Delete(int id)
        {
        }
    }
}
