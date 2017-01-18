using ClinicalLib.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
            catch (Exception ex)
            {
                AuditCRUD.CreateAuditMesssageAndInsertMessage(true, "ERROR ON SELECTPATIENT", "PatientsController", ex.StackTrace);
                throw;
            }
        }

        public static void AddPatient(View_Patient pat) {
            try
            {

                using (var ctx = new ClinicalFormEntities())
                {
                 
                    //Get student name of string type
                    ctx.Database.ExecuteSqlCommand("op_InsertPatient @FirstName, @LastName, @DateOfBirth, @Country, @Diseases, @Phone, @BloodType ",
                        new SqlParameter("FirstName", pat.FirstName),
                        new SqlParameter("LastName", pat.LastName),
                        new SqlParameter("DateOfBirth", pat.DateOfBirth),
                        new SqlParameter("Country", pat.Country),
                        new SqlParameter("Diseases", pat.Diseases),
                        new SqlParameter("Phone", pat.Phone),
                        new SqlParameter("BloodType", pat.BloodType)
                        );

                    AuditCRUD.CreateAuditMesssageAndInsertMessage(false, "FINISHED NEW PATIENT INSERTION", "PatientsController");
                }
            }
            catch (Exception ex)
            {
                AuditCRUD.CreateAuditMesssageAndInsertMessage(true, "ERROR ON NEW PATIENT INSERTION", "PatientsController", ex.StackTrace);
                throw;
            }
        }


        public static void DeletePatient(int id)
        {
            try
            {
                using (var ctx = new ClinicalFormEntities())
                {                    
                    //Get student name of string type
                    ctx.Database.ExecuteSqlCommand("op_DeletePatient @id ", new SqlParameter("id", id));
                    AuditCRUD.CreateAuditMesssageAndInsertMessage(false, "FINISHED PATIENT DELETION", "PatientsController");
                }        
            }
            catch (Exception ex)
            {
                AuditCRUD.CreateAuditMesssageAndInsertMessage(true, "ERROR ON PATIENT DELETION", "PatientsController", ex.StackTrace);
                throw;
            }

        }

        public static void UpdatePatient(int key, View_Patient patient)
        {
            try
            {

                using (var ctx = new ClinicalFormEntities())
                {

                    View_Patient pat = (from p in ctx.Patient
                                        where p.id == key
                                        select new View_Patient { 
                                        
                                            id = p.id,
                                            BloodType = p.BloodType.Id.ToString(),
                                            Country = p.Country.Id.ToString(),
                                            DateOfBirth = p.DateOfBirth,
                                            Diseases = p.Diseases,
                                            FirstName = p.FirstName,
                                            LastName = p.LastName,
                                            Phone = p.Phone,
                                        }).FirstOrDefault();

                                      
                    //Manually mapping the patient, no time for fancy pants mapper
                    pat.FirstName = !String.IsNullOrEmpty(patient.FirstName) ? patient.FirstName : pat.FirstName;
                    pat.LastName = !String.IsNullOrEmpty(patient.LastName) ? patient.LastName : pat.LastName;
                    pat.DateOfBirth = !String.IsNullOrEmpty(patient.DateOfBirth) ? patient.DateOfBirth : pat.DateOfBirth;
                    pat.Diseases = !String.IsNullOrEmpty(patient.Diseases) ? patient.LastName : pat.Diseases;
                    pat.Phone = !String.IsNullOrEmpty(patient.Phone) ? patient.Phone : pat.Phone;
                    pat.Country = !String.IsNullOrEmpty(patient.Country) ? patient.Country : pat.Country;
                    pat.BloodType = !String.IsNullOrEmpty(patient.BloodType) ? patient.BloodType : pat.BloodType;
                 
                  

                    //Get student name of string type
                    ctx.Database.ExecuteSqlCommand("op_UpdatePatient @id, @FirstName, @LastName, @DateOfBirth, @Country, @Diseases, @Phone, @BloodType ",
                        new SqlParameter("id", key),
                        new SqlParameter("FirstName", pat.FirstName),
                        new SqlParameter("LastName", pat.LastName),
                        new SqlParameter("DateOfBirth", pat.DateOfBirth),
                        new SqlParameter("Country", pat.Country),
                        new SqlParameter("Diseases", pat.Diseases),
                        new SqlParameter("Phone", pat.Phone),
                        new SqlParameter("BloodType", pat.BloodType)
                        );

                    AuditCRUD.CreateAuditMesssageAndInsertMessage(false, "FINISHED PATIENT UPDATE", "PatientsController");

                }
            }
            catch (Exception ex)
            {
                AuditCRUD.CreateAuditMesssageAndInsertMessage(true, "ERROR ON PATIENT UPDATE", "PatientsController", ex.StackTrace);
                throw;
            }
        }

        public static List<BloodType> GetBloodTypes()
        {
            try
            {
                List<BloodType> bloodTypes = new List<BloodType>();

                using (var ctx = new ClinicalFormEntities())
                {                    
                    var btypes = ctx.BloodType.SqlQuery("exec op_GetBloodTypes").ToList<BloodType>();
                    bloodTypes = btypes;
                }

                return bloodTypes;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static List<Country> GetCountries()
        {
            try
            {
                List<Country> countries = new List<Country>();

                using (var ctx = new ClinicalFormEntities())
                {
                    var ctries = ctx.Country.SqlQuery("exec op_GetCountries").ToList<Country>();
                    countries = ctries;
                }

                return countries;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
