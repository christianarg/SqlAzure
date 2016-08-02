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
    class ClsAAD

    {
        public void Inicia(int nRows)
        {
            try
            {

                string connectionString = GetConnectionString();

                using (SqlConnection awConnection = new SqlConnection(connectionString))
                {
                    Stopwatch stopWatch = new Stopwatch();
                    stopWatch.Start();


                    awConnection.StatisticsEnabled = true;

                    string productSQL = "SELECT top " + nRows.ToString() + "* FROM ValoresEjemplo";
                    SqlDataAdapter productAdapter = new SqlDataAdapter(productSQL, awConnection);

                    DataSet awDataSet = new DataSet();

                    awConnection.Open();

                    productAdapter.Fill(awDataSet, "ValoresEjemplo");

                    IDictionary currentStatistics = awConnection.RetrieveStatistics();

                    Console.WriteLine("Total Counters: " + currentStatistics.Count.ToString());
                    Console.WriteLine();


                    long bytesReceived = (long)currentStatistics["BytesReceived"];
                    long bytesSent = (long)currentStatistics["BytesSent"];
                    long selectCount = (long)currentStatistics["SelectCount"];
                    long selectRows = (long)currentStatistics["SelectRows"];
                    long ExecutionTime = (long)currentStatistics["ExecutionTime"];
                    long ConnectionTime = (long)currentStatistics["ConnectionTime"];

                    Console.WriteLine("BytesReceived: " + bytesReceived.ToString());
                    Console.WriteLine("BytesSent: " + bytesSent.ToString());
                    Console.WriteLine("SelectCount: " + selectCount.ToString());
                    Console.WriteLine("SelectRows: " + selectRows.ToString());
                    Console.WriteLine("ExecutionTime: " + ExecutionTime.ToString());
                    Console.WriteLine("ConnectionTime: " + ConnectionTime.ToString());

                    //Necesito un segundo en simulación de hacer una operativa interna.
                    Thread.Sleep(5000);
                    //
                    stopWatch.Stop();
                    // Get the elapsed time as a TimeSpan value.
                    TimeSpan ts = stopWatch.Elapsed;

                    // Format and display the TimeSpan value.
                    string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
                        ts.Hours, ts.Minutes, ts.Seconds,
                        ts.Milliseconds / 10);


                    Console.WriteLine("RunTime " + elapsedTime);
                    Console.WriteLine();
                    Console.WriteLine();
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
            return ConfigurationManager.ConnectionStrings["AADConnection"].ToString();
        }
    }
}





