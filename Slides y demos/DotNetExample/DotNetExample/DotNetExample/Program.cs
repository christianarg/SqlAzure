using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using C = System.Data.SqlClient;
using System.Configuration;

namespace DotNetExample
{
    class Program
    {
        static void Main(string[] args)
        {

            #region "Retry-Policy"
            //ClsRetryLogic oClsRetry = new ClsRetryLogic();
            //C.SqlConnection sqlConnection = new C.SqlConnection();
            //oClsRetry.HazUnaConexionConReintentos(ConfigurationManager.ConnectionStrings["BadConnection"].ToString(), sqlConnection);
            #endregion

            #region "Connection Pooling"
            //ClsConnectionPooling oClsPool = new ClsConnectionPooling();
            //oClsPool.Inicia(9000, bPooling: true, bInstanciaCadaVez: false); //with Pooling
            //oClsPool.Inicia(9000, bPooling: false, bInstanciaCadaVez: false); //without Pooling
            //oClsPool.Inicia(9000, bPooling: true, bInstanciaCadaVez: true); //Multiple connections, pool error. 
            #endregion

            #region "How much time take my query and my connection"
            //ClsConnection oConnection = new ClsConnection();
            //oConnection.Inicia(2000);
            #endregion

            #region "Data Masking"
            //ClsDataMasking oClsDM = new ClsDataMasking();
            //oClsDM.Inicia();
            #endregion

            #region "AAD"
            //ClsAAD oClsAAD = new ClsAAD();
            //oClsAAD.Inicia(200);
            #endregion

            #region "Language"
            //ClsSetLanguage oClsSetLanguage = new ClsSetLanguage();
            //oClsSetLanguage.Inicia("Spanish");
            //oClsSetLanguage.Inicia("Italian");
            //oClsSetLanguage.Inicia("us_english");
            #endregion

            #region "Transaction"
            ClsTransaction oClsTransaction = new ClsTransaction();
            oClsTransaction.Inicia(true);
            oClsTransaction.Inicia(false);
            #endregion

            #region "Timeout"
            //ClsTimeout oClsTimeout = new ClsTimeout();
            //oClsTimeout.Inicia();

            #endregion
        }

    }

}
