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
    class ClsTimeout

    {
        public void Inicia()
        {
            try
            {

                string connectionStringDb = GetConnectionStringDb();
                    using (SqlConnection awConnectionDb = new SqlConnection(connectionStringDb))
                    {
                        awConnectionDb.Open();
                        SqlCommand cmd1 = awConnectionDb.CreateCommand();
                        cmd1.CommandTimeout = 5;
                        cmd1.CommandText = string.Format("usp_Timeout");
                        cmd1.ExecuteNonQuery();
                    }


                    Console.WriteLine("Click to close");
                    Console.ReadLine();
            }
            catch (Exception e)
            {
                Console.WriteLine("Ups!!" + e.Message);
                Console.ReadLine();
            }

        }
        private static string GetConnectionStringDb()
        {
            return ConfigurationManager.ConnectionStrings["ExtendedEvents"].ToString();
        }

    }
}






