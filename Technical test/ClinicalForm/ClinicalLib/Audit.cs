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
    
    public partial class Audit
    {
        public System.DateTime EventTime { get; set; }
        public string Message { get; set; }
        public string StackTrace { get; set; }
        public string Ocurrence { get; set; }
        public int IsError { get; set; }
    }
}