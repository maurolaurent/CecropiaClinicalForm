//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Country
    {
        public Country()
        {
            this.Patient = new HashSet<Patient>();
        }
    
        public System.Guid Id { get; set; }
        public string Name { get; set; }
        public string Acron { get; set; }
    
        public virtual ICollection<Patient> Patient { get; set; }
    }
}
