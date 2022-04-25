/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilerias;

import java.sql.ResultSet;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 *
 * @author rurbina
 */
public class CambioSubservicio extends HttpServlet {

    /* 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String StrclExpediente = "0";
        String StrclUsrApp = "0";
        String StrclSubservicioNuevo = "0";

        ResultSet rs = null;
        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Cambio de Subservicio</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente").toString();
        }

        if (request.getParameter("clUsrApp") != null) {
            StrclUsrApp = request.getParameter("clUsrApp").toString();
        }

        if (request.getParameter("clSubservicioNuevo") != null) {
            StrclSubservicioNuevo = request.getParameter("clSubservicioNuevo").toString();
        }


        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }
            System.out.println("st_CambiaSubservicio " + StrclExpediente + "," + StrclSubservicioNuevo + "," + StrclUsrApp);
            UtileriasBDF.ejecutaSQLNP("st_CambiaSubservicio " + StrclExpediente + "," + StrclSubservicioNuevo + "," + StrclUsrApp);
            strUrlBack = strUrlBack + "clExpediente=" + StrclExpediente;
            out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");

        } catch (Exception e) {
            out.close();
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
            out.println("</body>");
            out.println("</html>");
            out.close();

            StrclExpediente = null;
            StrclUsrApp = null;
            StrclSubservicioNuevo = null;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /* 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /* 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /* 
     * Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
