using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicalLib.Rules
{
    public class AuditCRUD
    {

        public static Audit CreateAuditMesssage(bool IsException, string Message, string Ocurrence, string StackTrace) {

            Audit au = new Audit();

            au.EventTime = DateTime.Now;
            au.IsError = IsException ? 1 : 0;
            au.Message = Message;
            au.Ocurrence = Ocurrence;
            au.StackTrace = String.IsNullOrEmpty(StackTrace) ? "This is a message log" : StackTrace ;

            return au;
        
        }

        public static void InsertAuditMessage(Audit audit) {

            using (var ctx = new ClinicalFormEntities())
            {

                ctx.Database.ExecuteSqlCommand("InsertAuditLog @EventTime, @Message, @StackTrace, @Ocurrence, @IsError ",
                    new SqlParameter("EventTime", audit.EventTime),
                    new SqlParameter("Message", audit.Message),
                    new SqlParameter("StackTrace", audit.StackTrace),
                    new SqlParameter("Ocurrence", audit.Ocurrence),
                    new SqlParameter("IsError", audit.IsError)
    
                    );

            }

        }



        public static void CreateAuditMesssageAndInsertMessage(bool IsException, string Message, string Ocurrence, string StackTrace = null)
        {
            Audit au = CreateAuditMesssage(IsException, Message, Ocurrence, StackTrace);
            InsertAuditMessage(au);
        }
    }
}
