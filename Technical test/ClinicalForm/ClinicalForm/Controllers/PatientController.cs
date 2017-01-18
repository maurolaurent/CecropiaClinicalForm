using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using ClinicalLib;

namespace ClinicalForm.Controllers
{
    public class PatientController : ApiController
    {

        #region Blood Types

        // GET api/getBloodTypes
        public IEnumerable<BloodType> getBloodTypes()
        {
            return new BloodType[] { };
        }

        #endregion

        // GET api/patient
        public IEnumerable<Patient> Get()
        {
            return new Patient[] { };
        }

        // GET api/patient/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/patient
        public void Post([FromBody]string value)
        {
        }

        // PUT api/patient/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/patient/5
        public void Delete(int id)
        {
        }
    }
}
