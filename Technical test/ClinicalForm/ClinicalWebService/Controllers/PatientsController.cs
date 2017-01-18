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
        public ActionResult Post(View_Patient values)
        {
            try
            {
                //Audit log
                AuditCRUD.CreateAuditMesssageAndInsertMessage(false, "INITIATE NEW PATIENT INSERTION", "PatientsController");

                PatientCRUD.AddPatient(values);

                return new HttpStatusCodeResult(200);
            }
            catch (Exception ex)
            {
                AuditCRUD.CreateAuditMesssageAndInsertMessage(true, "ERROR ON NEW PATIENT INSERTION", "PatientsController", ex.StackTrace);
                return new HttpStatusCodeResult(500);
            }

        }

       
        [System.Web.Http.HttpDelete]
        public ActionResult Delete(int key)
        {
            try
            {
                 //Audit log
                AuditCRUD.CreateAuditMesssageAndInsertMessage(false, "INITIATE PATIENT DELETION", "PatientsController");

                PatientCRUD.DeletePatient(key);

                return new HttpStatusCodeResult(200);
            }
            catch (Exception ex)
            {
                AuditCRUD.CreateAuditMesssageAndInsertMessage(true, "ERROR ON PATIENT DELETION", "PatientsController", ex.StackTrace);
                return new HttpStatusCodeResult(500);
            }

            

        }

        [System.Web.Http.HttpPut]
        public ActionResult Update(int key, View_Patient patient)
        {
            try
            {
                //Audit log
                AuditCRUD.CreateAuditMesssageAndInsertMessage(false, "INITIATE PATIENT UPDATE", "PatientsController");

                PatientCRUD.UpdatePatient(key, patient);

                return new HttpStatusCodeResult(200);
            }
            catch (Exception ex)
            {
                AuditCRUD.CreateAuditMesssageAndInsertMessage(true, "ERROR ON PATIENT UPDATE", "PatientsController", ex.StackTrace);
                return new HttpStatusCodeResult(500);
            }

        }

    }
}
