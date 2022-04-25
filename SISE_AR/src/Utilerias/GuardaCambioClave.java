/*
 * GuardaCambioClave.java
 *
 * Created on 21 de septiembre de 2006, 04:27 PM
 */
package Utilerias;

import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import java.io.IOException;
import java.io.PrintWriter;

/*
 *
 * @author
 * pereac
 * @version
 */
public class GuardaCambioClave extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //  HttpSession sessionH = request.getSession(false);

        String StrclExpediente = "0";
        String StrClave = "0";
        String StrclUsrApp = "0";
        String strclTipoClave = "0";

        ResultSet rsEx = null;
        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Cambio de claves</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente").toString();
        }

        if (request.getParameter("clUsrApp") != null) {
            StrclUsrApp = request.getParameter("clUsrApp").toString();
        }

        if (request.getParameter("Clave") != null) {
            StrClave = request.getParameter("Clave");
        }

        if (request.getParameter("clTipoClave") != null) {
            strclTipoClave = request.getParameter("clTipoClave").toString();
        }

        try {

            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            //UtileriasBDF.ejecutaSQLNP("st_CambiaClave  " + StrclUsrApp + "," + StrclExpediente + ",'" + StrClave.trim() + "'");
            UtileriasBDF.ejecutaSQLNP("st_CambiaClaveExpediente  " + StrclExpediente + ",'" + StrClave.trim() + "'," + StrclUsrApp);
            strUrlBack = strUrlBack + "&clExpediente=" + StrclExpediente + "&clTipoClave=" + strclTipoClave;
            out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");

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
        return "Realiza el cambio de una clave";
    }
}
