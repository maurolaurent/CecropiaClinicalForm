﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ClinicalLib
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    using System.Data.SqlClient;
    
    public partial class ClinicalFormEntities : DbContext
    {
        public ClinicalFormEntities()
            : base("name=ClinicalFormEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Patient> Patient { get; set; }
    
        public virtual ObjectResult<GetAllPatients_Result> GetAllPatients()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetAllPatients_Result>("GetAllPatients");
        }

        /*public Patient SelectAllPatients()
        {
           /* var date = new SqlParameter("@date", _msg.MDate);
            var subject = new SqlParameter("@subject", _msg.MSubject);
            var body = new SqlParameter("@body", _msg.MBody);
            var fid = new SqlParameter("@fid", _msg.FID);
            this.Database.ExecuteSqlCommand("exec messageinsert @Date , @Subject , @Body , @Fid", date,subject,body,fid);

            this.Database.ExecuteSqlCommand("exec messageinsert");

        }*/
    }
}