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
    class ClsDataMasking
    {
        public void Inicia()
        {
            try
            {
                                
                ClsRetryLogic oClsRetry = new ClsRetryLogic();
                SqlConnection sqlConnection = new SqlConnection();
                if (oClsRetry.HazUnaConexionConReintentos(ConfigurationManager.ConnectionStrings["DataMasking"].ToString(), sqlConnection))
                   {
                    SqlCommand oCmd = new SqlCommand();
                    oCmd.CommandText = "SELECT * FROM Contacto";
                    oCmd.Connection = sqlConnection;
                    SqlDataReader oReader = oCmd.ExecuteReader();
                    while( oReader.Read())
                        {
                        Console.WriteLine(oReader.GetName(0)+ ":" + oReader.GetSqlInt32(0).ToString()  );
                        Console.WriteLine(oReader.GetName(1) + ":" + oReader.GetSqlString(1));
                        Console.WriteLine(oReader.GetName(2) + ":" + oReader.GetSqlString(2));
                        Console.WriteLine(oReader.GetName(3) + ":" + oReader.GetSqlString(3));
                        Console.WriteLine(oReader.GetName(4) + ":" + oReader.GetSqlString(4));
                        Console.WriteLine();
                        Console.WriteLine("Pulsar para cerrar");
                        Console.ReadLine();
                    }
                    oReader.Close();
                    Console.WriteLine("Pulsar para mostrar ahora como protegemos a nivel de fila");

                    SqlCommand oCmdV = new SqlCommand();
                    oCmdV.CommandText = "SELECT * FROM Protegido";
                    oCmdV.Connection = sqlConnection;
                    SqlDataReader oReaderV = oCmdV.ExecuteReader();
                    while (oReaderV.Read())
                    {
                        Console.WriteLine(oReaderV.GetName(0) + ":" + oReaderV.GetSqlInt32(0).ToString());
                        Console.WriteLine(oReaderV.GetName(1) + ":" + oReaderV.GetSqlString(1));
                        Console.WriteLine(oReaderV.GetName(2) + ":" + oReaderV.GetSqlString(2));
                        Console.WriteLine(oReaderV.GetName(3) + ":" + oReaderV.GetSqlString(3));
                        Console.WriteLine(oReaderV.GetName(4) + ":" + oReaderV.GetSqlString(4));
                        Console.WriteLine();
                        Console.WriteLine("Pulsar para cerrar");
                        Console.ReadLine();
                    }
                    oReaderV.Close();
                    Console.WriteLine("Pulsar para cerrar");


                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Ups!!" + e.Message);
            }

        }
        private static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["DataMasking"].ToString();
        }
    }
}
