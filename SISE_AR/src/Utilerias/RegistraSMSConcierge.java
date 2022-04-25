/*
 * RegistraPago.java
 *
 * Created on 9 de junio de 2005, 05:22 PM
 */
package Utilerias;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/*
 *
 * @author  sotelom
 * @version
 */
public class RegistraSMSConcierge extends HttpServlet {

    /* Initializes the servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

    }

    /* Destroys the servlet.
     */
    public void destroy() {
    }

    /* Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String StrclAsistencia = "0";
        String StrNadultos = "0";
        String StrFechaD = "0";
        String StrHotel = "0";
        String StrReservacion = "0";
        String StrCodigo = "0";
        String StrTelefono = "0";
        String StrclUsrApp = "0";


        out.println("<html>");
        out.println("<head>");
        out.println("<title>Registra Pago</title>");
        out.println("</head>");
        out.println("<body>");

        String StrSql = "";

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrclUsrApp = sessionH.getAttribute("clUsrApp").toString();
        } else {
            out.println("<p class='class='cssTitDet'>No se ha iniciado sesión, favor de consultarlo con su administrador</p>");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }

        if (sessionH.getAttribute("clAsistencia") != null) {
            StrclAsistencia = sessionH.getAttribute("clAsistencia").toString();
        }

        if (request.getParameter("Nadultos") != null) {
            StrNadultos = request.getParameter("Nadultos").toString();
        }

        if (request.getParameter("FechaD") != null) {
            StrFechaD = request.getParameter("FechaD").toString();
        }

        if (request.getParameter("Hotel") != null) {
            StrHotel = request.getParameter("Hotel").toString();
        }
        
        if (request.getParameter("Reservacion") != null) {
            StrReservacion = request.getParameter("Reservacion").toString();
        }
                
        if (request.getParameter("Codigo") != null) {
            StrCodigo = request.getParameter("Codigo").toString();
        }                

        if (request.getParameter("Telefono") != null) {
            StrTelefono = request.getParameter("Telefono").toString();
        }
        
        
        StrSql = "st_CSEnviaSMSRestaurante " + StrclAsistencia + "," + StrNadultos + ",'" + StrFechaD + "','" + StrHotel + "','" + StrReservacion+ "'," + StrCodigo + "," + StrTelefono+ "," + StrclUsrApp;

        System.out.println("Envio SMS Concierge: " + StrSql);
        
        UtileriasBDF.ejecutaSQLNP(StrSql);

        out.println("</body>");
        out.println("</html>");
        out.println("<script>window.close();</script>");
        out.close();
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

    /* Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
}
