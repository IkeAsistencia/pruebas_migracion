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
public class RegistraPago extends HttpServlet {

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
        String StrclExpediente = "0";
        String StrclProveedor = "0";
        String StrclUsrApp = "0";
        String strTipoPago = "0";
        String strTclCosto = "0";
        String strCostoNU ="0";
        String strclMedioPago="0";
        String strCostoCIA="0";

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

        if (sessionH.getAttribute("clExpediente") != null) {
            StrclExpediente = sessionH.getAttribute("clExpediente").toString();
        }

        if (request.getParameter("clProveedor") != null) {
            StrclProveedor = request.getParameter("clProveedor").toString();
        }

        if (request.getParameter("TipoPago") != null) {
            strTipoPago = request.getParameter("TipoPago").toString();
        }

        if (request.getParameter("clCosto") != null) {
            strTclCosto = request.getParameter("clCosto").toString();
        }
        
        if (request.getParameter("CostoNU") != null) {
            strCostoNU = request.getParameter("CostoNU").toString();
        }
        
        if (request.getParameter("clMedioPago") != null) {
            strclMedioPago = request.getParameter("clMedioPago").toString();
        }

        if (request.getParameter("CostoCIA") != null) {
            strCostoCIA = request.getParameter("CostoCIA").toString();
        }


        StrSql = "sp_RegistraPago " + StrclExpediente + "," + StrclProveedor + "," + StrclUsrApp + "," + strTipoPago + "," + strTclCosto + "," + strCostoNU + "," + strclMedioPago + "," + strCostoCIA;

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
