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

namespace DotNetExample
{
    class ClsSetLanguage

    {
        public void Inicia(string sRows)
        {
            try
            {

                string connectionString = GetConnectionString() + sRows;

                using (SqlConnection awConnection = new SqlConnection(connectionString))
                {
                    string productSQL = "SELECT @@language;SELECT DATENAME(month, GetDate()) AS 'Month Name'";
                    SqlDataAdapter productAdapter = new SqlDataAdapter(productSQL, awConnection);

                    DataSet awDataSet = new DataSet();

                    awConnection.Open();

                    productAdapter.Fill(awDataSet, "ValoresEjemplo");

                    foreach (DataTable table in awDataSet.Tables)
                    {
                        foreach (DataRow row in table.Rows)
                        {
                            foreach (DataColumn column in table.Columns)
                            {
                                object item = row[column];
                                Console.WriteLine("item.: " + item.ToString());

                                // read column and item
                            }
                        }
                    }

                    
                    Console.WriteLine("Pulsar para cerrar");
                    Console.ReadLine();
                    awConnection.ResetStatistics();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Ups!!" + e.Message);
            }

        }
        private static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["SetLanguage"].ToString();
        }
    }
}





