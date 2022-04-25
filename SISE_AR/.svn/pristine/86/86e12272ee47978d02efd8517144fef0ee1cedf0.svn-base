/*
 * ValidaUsuario.java
 *
 * Created on 20 de enero de 2005, 04:31 PM
 */
package Seguridad;

import java.sql.ResultSet;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import Utilerias.UtileriasBDF;
import javax.servlet.http.HttpSession;
import java.sql.Connection;

/*
 *
 * @author  lopgui
 * @version
 */
public class ValidaUsuario extends HttpServlet {

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

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        Connection con = null;
        con = UtileriasBDF.getConnection();

        HttpSession sessionH = request.getSession(false);

        /* TODO output your page here */
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("Entro al Servlet");

        out.println("</body>");
        out.println("</html>");

        if (sessionH.getAttribute("Cambio") != null) {
            ResultSet rs = UtileriasBDF.rsSQLNP("sp_EncriptDesEncriptPassword '" + request.getParameter("Usuario") + "'");
            try {
                rs.next();
                out.println("<script>location.href('Seguridad.Login?Usr=" + request.getParameter("Usuario") + "&Pass=" + rs.getString("password") + "')</script>");
                rs.close();
            } catch (Exception e) {
                e.getMessage();
            } finally {
                try {
                    con.close();
                } catch (Exception ee) {
                    ee.printStackTrace();
                }
            }
        }

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
