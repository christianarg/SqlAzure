using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Collections;
using System.Data;
using C = System.Data.SqlClient;
using System.Diagnostics;
using System.Threading;
using System.Configuration;

namespace DotNetExample
{
    class ClsConnectionPooling
    {
        private static string GetConnectionString(bool bPooling)
        {
            return ConfigurationManager.ConnectionStrings["OkConnection"].ToString() + (bPooling ? "yes" : "no");
        }

        public void Inicia(int nRows, bool bPooling, bool bInstanciaCadaVez=false)
        {
            try
            {
                Stopwatch stopWatch = new Stopwatch();
                stopWatch.Start();

                for (int tries = 1; tries <= nRows; tries++)
                {
                    Console.WriteLine("Intento Nr.: " + tries.ToString());
                    Console.WriteLine();
                    ClsRetryLogic oClsRetry = new ClsRetryLogic();
                    C.SqlConnection con = new C.SqlConnection();
                    oClsRetry.HazUnaConexionConReintentos(GetConnectionString(bPooling), con, bInstanciaCadaVez);
                    con.Close();
               }
                stopWatch.Stop();
                // Obtenemos el tiempo pasado
                TimeSpan ts = stopWatch.Elapsed;

                // Formateamos y mostramos.
                string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
                    ts.Hours, ts.Minutes, ts.Seconds,
                    ts.Milliseconds / 10);
                Console.WriteLine("Tipo de Objeto:{0}. Tiempo:{1}",bPooling?"Pooling":"Sin Pooling", elapsedTime);
                Console.ReadLine();
            }
            catch (Exception e)
            {
                Console.WriteLine("Ups!! " + e.Message);
                Console.ReadLine();
            }

        }
    }
}
