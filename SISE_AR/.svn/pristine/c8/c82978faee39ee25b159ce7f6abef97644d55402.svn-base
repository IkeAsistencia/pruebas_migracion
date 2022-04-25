/*
 * GuardaCambioCuenta.java
 *
 * Created on 11 de Julio de 2006, 13:19 PM
 */
package Utilerias;

import java.sql.ResultSet;
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
 * @author rodrigus
 * @version
 */
public class GuardaCambioCuenta extends HttpServlet {

    private static Correo Cor = new Correo();

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void destroy() {
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);

        String StrclExpediente = "0";
        String StrclCuenta = "0";
        String StrclUsrApp = "0";

        ResultSet rsEx = null;
        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Cambio de cuentas</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente").toString();
        }

        if (request.getParameter("clUsrApp") != null) {
            StrclUsrApp = request.getParameter("clUsrApp").toString();
        }

        if (request.getParameter("clCuenta") != null) {
            StrclCuenta = request.getParameter("clCuenta");
        }


        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) {
                UtileriasBDF.ejecutaSQLNP("sp_CambiaCuenta  " + StrclUsrApp + "," + StrclExpediente + "," + StrclCuenta);
                strUrlBack = strUrlBack + "&clExpediente=" + StrclExpediente;
                out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
            }

        } catch (Exception e) {
            out.close();
            e.printStackTrace();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }

            out.println("</body>");
            out.println("</html>");

            out.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public String getServletInfo() {
        return "Short description";
    }
}
