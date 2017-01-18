using ClinicalLib;
using ClinicalLib.Models;
using ClinicalLib.Rules;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace ClinicalWebService.Controllers
{
    public class BloodTypesController : ApiController
    {


        public async Task<List<View_BloodTypes>> Get()
        {
            return await DoGetBloodTypes();
        }

        public async Task<List<View_BloodTypes>> DoGetBloodTypes()
        {
            return await Task.Run(() => GetBloodTypes());

        }

        private List<View_BloodTypes> GetBloodTypes()
        {

            List<BloodType> bloodTypes = PatientCRUD.GetBloodTypes();

            List<View_BloodTypes> blodtyps = (from bt in bloodTypes
                                              select new View_BloodTypes
                                              {
                                                  Id = bt.Id.ToString(),
                                                  Antigen = bt.Antigen,
                                                  RHFactor = bt.RHFactor

                                              }).ToList();

            return blodtyps;
        }
    }
}
