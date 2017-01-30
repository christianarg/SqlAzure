using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Threading;
using System.Configuration;
using System.Transactions;

namespace DotNetExample
{
    class ClsTransaction 

    {
        public void Inicia(Boolean bOk)
        {
            try
            {

                string connectionStringDb1 = GetConnectionStringDb1();
                string connectionStringDb2 = GetConnectionStringDb2();


                    using (var scope = new TransactionScope())
                    {
                        using (SqlConnection awConnectionDb1 = new SqlConnection(connectionStringDb1))
                        {
                            awConnectionDb1.Open();
                            SqlCommand cmd1 = awConnectionDb1.CreateCommand();
                            cmd1.CommandText = string.Format("insert into T1 values(3)");
                            cmd1.ExecuteNonQuery();
                        }
                        using (SqlConnection awConnectionDb2 = new SqlConnection(connectionStringDb2))
                        {
                            awConnectionDb2.Open();
                            var cmd2 = awConnectionDb2.CreateCommand();
                        if(bOk == true)
                            cmd2.CommandText = string.Format("insert into T2 values(4)");
                        else
                            cmd2.CommandText = string.Format("insert into TNotExist values(2)");
                        cmd2.ExecuteNonQuery();
                        }
                        scope.Complete();

                        Console.WriteLine("Click to close");
                    Console.ReadLine();

                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Ups!!" + e.Message);
            }

        }
        private static string GetConnectionStringDb1()
        {
            return ConfigurationManager.ConnectionStrings["DB1T"].ToString();
        }
        private static string GetConnectionStringDb2()
        {
            return ConfigurationManager.ConnectionStrings["DB2T"].ToString();
        }
    }
}






