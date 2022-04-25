package Utilerias;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
 *
 * @author rurbina
 */
public class AsignaCoberturaProv extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=iso-8859-1");
        PrintWriter out = response.getWriter();

        String StrclProveedor = "";
        String StrSelecciones = "";
        String StrclTipoCobertura = "";
        String strUrlBack = "";
        String StrAsignar = "0";
        String StrCodEnt = "";
        String StrclUsrApp = "0";
        String StrclPais = "";
        String StrSQL = "";

        HttpSession sessionH = request.getSession(false);
        StrclUsrApp = sessionH.getAttribute("clUsrApp").toString();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Asigna Cobertura x Proveedor</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("clProveedor") != null) {
            StrclProveedor = request.getParameter("clProveedor").toString();
        }
        if (request.getParameter("Selecciones") != null) {
            StrSelecciones = request.getParameter("Selecciones").toString();
        }
        if (request.getParameter("clTipoCobertura") != null) {
            StrclTipoCobertura = request.getParameter("clTipoCobertura").toString();
        }

        if (request.getParameter("CodEnt") != null) {
            StrCodEnt = request.getParameter("CodEnt").toString();
        }

        if (request.getParameter("clPais") != null) {
            StrclPais = request.getParameter("clPais").toString();
        }
        //System.out.println("Servlet Pais: " + StrclPais + ", CodEnt: " + StrCodEnt);


        try {
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            if (request.getParameter("boton") != null) {

                if (request.getParameter("boton").equalsIgnoreCase("1")) {
                    StrSQL = "st_AsignaCoberturaProv '" + StrclTipoCobertura + "','" + StrclProveedor + "','" + StrSelecciones + "','" + StrclUsrApp + "','" + StrclPais + "'";
                }
                if (request.getParameter("boton").equalsIgnoreCase("2")) {
                    StrSQL = "st_EliminaCoberturaProv '" + StrclTipoCobertura + "','" + StrclProveedor + "','" + StrSelecciones + "','" + StrclUsrApp + "','" + StrclPais + "'";
                }

                //System.out.println("StrSQL: " + StrSQL);
                UtileriasBDF.ejecutaSQLNP(StrSQL);
            }

            strUrlBack = strUrlBack + "clProveedor=" + StrclProveedor + "&clTipoCobertura=" + StrclTipoCobertura + "&CodEnt=" + StrCodEnt + "&StrAsignar=" + StrAsignar;
            //System.out.println("strUrlBack: " + strUrlBack);

            out.print("<script>location.href='" + strUrlBack + "'</script>");

        } catch (Exception e) {
            out.println("<script>");
            out.println("alert(\"Error al Guardar...\");");
            out.println("</script>");
            out.println("<script>window.opener.fnValidaError()</script>");
            out.close();
            e.printStackTrace();
        } finally {

            StrclProveedor = null;
            StrSelecciones = null;
            StrclTipoCobertura = null;
            strUrlBack = null;
            StrAsignar = null;
            StrCodEnt = null;
            StrclUsrApp = null;
            StrclPais = null;
            StrSQL = null;

            out.println("</body>");
            out.println("</html>");
            out.close();
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
