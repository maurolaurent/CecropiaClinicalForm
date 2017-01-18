using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicalLib.Rules
{   
    public class PatientCRUD
    {
        public static List<Patient> SelectPatient()
        {
            try
            {

                ClinicalFormEntities db = new ClinicalFormEntities();

                var pats = from n in db.Patient
                           select n;

                return pats.ToList();


            }
            catch (Exception)
            {

                throw;
            }
        }

        public static void AddPatient(Patient patient) {
            try
            {                
                ClinicalFormEntities db = new ClinicalFormEntities();

                var lastId = db.Patient.FirstOrDefault().id + 1;

                patient.id = lastId;

                db.Patient.Add(patient);
                db.SaveChanges();
            }
            catch (Exception)
            {
                
                throw;
            }
        }


        public static void DeletePatient(int id)
        {
            try
            {
                ClinicalFormEntities db = new ClinicalFormEntities();

                Patient pat = (Patient)db.Patient.Where(x => x.id == id);

                db.Patient.Remove(pat);
                db.SaveChanges();
            }
            catch (Exception)
            {

                throw;
            }

        }
    }
}
