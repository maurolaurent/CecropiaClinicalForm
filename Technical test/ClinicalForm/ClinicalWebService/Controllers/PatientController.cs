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
       
        public async Task<AjaxResp> Get()
        {            
            return await DoGetPatients();
        }

        public async Task<AjaxResp> DoGetPatients()
        {
           return await Task.Run(() => GetPatients());
          
        }

        private AjaxResp GetPatients() {

            List<Patient> patients = PatientCRUD.SelectPatient();

            //Due to Guid not being serializable...
            List<View_Patient> vpatients = (from pp in patients
                              select new View_Patient
                              {
                                  id = pp.id,
                                  FirstName = pp.FirstName,
                                  LastName = pp.LastName,
                                  DateOfBirth = pp.DateOfBirth,
                                  Country = pp.Country.Id.ToString(),
                                  Phone = pp.Phone,
                                  Diseases = pp.Diseases,
                                  BloodType = pp.BloodType.Id.ToString()
                              }).ToList();

            return new AjaxResp { totalCount = patients.Count, items = vpatients };
        }


    }
}
