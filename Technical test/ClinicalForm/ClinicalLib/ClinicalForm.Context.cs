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
    
        public virtual DbSet<BloodType> BloodType { get; set; }
        public virtual DbSet<Country> Country { get; set; }
        public virtual DbSet<Patient> Patient { get; set; }
        public virtual DbSet<Audit> Audit { get; set; }
    
        public virtual ObjectResult<GetAllPatients_Result> GetAllPatients()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetAllPatients_Result>("GetAllPatients");
        }
    }
}
