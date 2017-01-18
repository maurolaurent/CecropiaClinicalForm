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
    public class CountriesController : ApiController
    {
        public async Task<List<View_Countries>> Get()
        {
            return await DoGetCountries();
        }

        public async Task<List<View_Countries>> DoGetCountries()
        {
            return await Task.Run(() => GetCountries());

        }

        private List<View_Countries> GetCountries()
        {

            List<Country> countries = PatientCRUD.GetCountries();

            List<View_Countries> ctrs = (from co in countries
                                         select new View_Countries
                                         {
                                             Id = co.Id.ToString(),
                                             Name = co.Name,
                                             Acron = co.Acron
                                         }).ToList();

            return ctrs;
        }

    }
}
