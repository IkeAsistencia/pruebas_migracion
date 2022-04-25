package Seguridad;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;
import java.io.PrintWriter;
import java.io.IOException;
import Utilerias.GeneraRpt;
import Utilerias.EnviaCorreo;
import Utilerias.EnviaCorreoPDF;
import Utilerias.EnviaSMS;
import Utilerias.ProcesoConcierge;

public class StartStopServices extends HttpServlet {

    private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String StrAction = "3"; ///nada en caso contrario
        String StrIDProcess = "0"; //ninguno
        PrintWriter out = response.getWriter();

        if (request.getParameter("Action") != null) {
            StrAction = request.getParameter("Action").toString();
        }
        if (request.getParameter("IDProcess") != null) {
            StrIDProcess = request.getParameter("IDProcess").toString();
        }
        //System.out.print(StrIDProcess);

        /*Iniciar o detener el servicio de reportes -- 1 */
        if (StrIDProcess.compareToIgnoreCase("1") == 0) {
            // Genera Reportes
            if (StrAction.compareToIgnoreCase("1") == 0) {
                System.out.println(" --------------------------------------- SE INICIA ENVIO DE REPORTES ARG --------------------------------------- ");
                GeneraRpt.Start();
            }
            if (StrAction.compareToIgnoreCase("0") == 0) {
                System.out.println(" --------------------------------------- SE DETIENE ENVIO DE REPORTES ARG --------------------------------------- ");
                GeneraRpt.Stop();
            }
        }

        
        /*if (StrIDProcess.compareToIgnoreCase("2") == 0) {
            if (StrAction.compareToIgnoreCase("1") == 0) {
                UtileriasBDF.StartLog();
            }
            if (StrAction.compareToIgnoreCase("0") == 0) {
                UtileriasBDF.StopLog();
            }
        }*/

        // Reload Paginas
       /* if (StrIDProcess.compareToIgnoreCase("3") == 0) {
         if (StrAction.compareToIgnoreCase("1") == 0) {
         UtlHash.LoadPagina.reLoad();
         }
         }*/

        /*Iniciar o detener el servicio de correos -- 4 */
        if (StrIDProcess.compareToIgnoreCase("4") == 0) {
            if (StrAction.compareToIgnoreCase("1") == 0) {
                EnviaCorreo.Start();
            }
            if (StrAction.compareToIgnoreCase("0") == 0) {
                EnviaCorreo.Stop();
            }
        }
        
        /*Iniciar o detener el servicio de correos PDF -- 5 */
        if (StrIDProcess.compareToIgnoreCase("5") == 0) {
            if (StrAction.compareToIgnoreCase("1") == 0) {
                EnviaCorreoPDF.Start();
            }
            if (StrAction.compareToIgnoreCase("0") == 0) {
                EnviaCorreoPDF.Stop();
            }
        }

        /*Iniciar o detener el servicio de SMS -- 6 */
        if (StrIDProcess.compareToIgnoreCase("6") == 0) {
            if (StrAction.compareToIgnoreCase("1") == 0) {
                EnviaSMS.StartSMS();
            }
            if (StrAction.compareToIgnoreCase("0") == 0) {
                EnviaSMS.StopSMS();
            }
        }
        
        /*CONCIERGE TARJETAS*/
        if(StrIDProcess.compareToIgnoreCase("7")==0) {
            
            if (StrAction.compareToIgnoreCase("1")==0){                
                ProcesoConcierge.Start();     }
            if (StrAction.compareToIgnoreCase("0")==0){
                ProcesoConcierge.Stop();      }
            }  

        out.print("<HTML><body><script>location.href='../Seguridad/ProcesosAutMgr.jsp';window.close()</script></body></html>");
    }

    /* Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /* Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
