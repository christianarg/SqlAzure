using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using D = System.Data;
using C = System.Data.SqlClient;
using X = System.Text;
using H = System.Threading;

namespace DotNetExample
{
    class ClsRetryLogic
    {

        public bool HazUnaConexionConReintentos(string clsConexion, C.SqlConnection sqlConnection, bool bInstanciaCadaVez=false)
        {
            int retryIntervalSeconds = 10;
            bool returnBool = false;

            for (int tries = 1; tries <= 5; tries++)
            {
                try
                {
                    Console.WriteLine("Intento Nr.: " + tries.ToString());
                    Console.WriteLine();

                    if (tries > 1)
                    {
                        Console.WriteLine("Tiempo de Espera: " + retryIntervalSeconds.ToString() + " segundos");
                        Console.WriteLine();
                        H.Thread.Sleep(1000 * retryIntervalSeconds);
                        retryIntervalSeconds = Convert.ToInt32(retryIntervalSeconds * 1.5);

                        C.SqlConnection.ClearAllPools();
                    }
                    if (bInstanciaCadaVez)
                    {
                         sqlConnection = new C.SqlConnection();
                    }
                    sqlConnection.ConnectionString = clsConexion;
                    sqlConnection.Open();

                    // Sólo para conexiones que se reconectan. sqlConnection.Execute().  De forma automática tenemos 2 nuevas propiedades en la cadena de conexión.
                    // ConnectRetryCount(Default is 0.Range is 0 through 255.)
                    // ConnectRetryInterval(Default is 1 second.Range is 1 through 60.)
                    // Connection Timeout   (Default is 15 seconds.Range is 0 through 2147483647)

                    //Specifically, your chosen values should make the following equality true:
                    //Connection Timeout = ConnectRetryCount * ConnectionRetryInterval

                    //For example, if the count = 3, and interval = 10 seconds, a timeout of only 29 seconds would not quite give the system enough time for its 3rd and final retry at connecting: 29 < 3 * 10.
                    
                    returnBool = true;
                    break;
                }
                catch (C.SqlException sqlExc)
                {
                    if (sqlExc.Number == 4060 || sqlExc.Number == 40197 || sqlExc.Number == 40501 || sqlExc.Number == 40613 || sqlExc.Number == 49918 ||
                        sqlExc.Number == 49919 || sqlExc.Number == 49920 || sqlExc.Number==18456)
                    //18456 for demo. Login Failed.
                    // 4060  Cannot open database "%.*ls" requested by the login. The login failed
                    // 10928 "The %s limit for the database is %d and has been reached. See http://go.microsoft.com/fwlink/?LinkId=267637 for assistance.")
                    // 17830 SRV_LOGIN_TIMERS
                    // 40197 The service has encountered an error processing your request
                    // 40501 The service is currently busy. Retry the request after 10 seconds. Incident ID: %ls. Code: %d.
                    // 40613 Database unavailable
                    // 40615 Blocked by firewall
                    // 49918 Cannot process request. Not enough resources to process request
                    // 49919 Cannot process create or update request. Too many create or update operations in progress for subscription "%ld
                    // 49920 Cannot process request. Too many operations in progress for subscription "%ld
                    // 18456 Login Error, for testing, pretend network error is transient.
                    // See more: https://azure.microsoft.com/en-us/documentation/articles/sql-database-develop-error-messages/ 
                    {
                        Console.WriteLine("Error de connectividad: " + sqlExc.Number.ToString() + '-' + sqlExc.Message );
                        Console.WriteLine();
                        C.SqlConnection.ClearAllPools(); 
                                            
                        continue;
                    }
                    else
                    //{ throw sqlExc; }
                    {
                        Console.WriteLine("Error de connectividad fuera de intentos: " + sqlExc.Number.ToString() + '-' + sqlExc.Message);
                        Console.WriteLine();
                        C.SqlConnection.ClearAllPools();
                    }
                }
            }
            return returnBool;
        }
    }
}

    





