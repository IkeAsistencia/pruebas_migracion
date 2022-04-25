/*
 * EjecutaGuardaEncuestaSL.java
 *
 * Created on 12 de Junio de 2006, 12:09 PM
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
 * @author
 * zamoraed
 * @version
 */
public class EjecutaGuardaEncuestaSL extends HttpServlet {

    /*
     * Initializes
     * the
     * servlet.
     */
    private static Correo Cor = new Correo();

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    /*
     * Destroys
     * the
     * servlet.
     */
    public void destroy() {
    }

    /*
     * Processes
     * requests
     * for
     * both
     * HTTP
     * <code>GET</code>
     * and
     * <code>POST</code>
     * methods.
     *
     * @param
     * request
     * servlet
     * request
     * @param
     * response
     * servlet
     * response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);

        String StrclExpediente = "0";
        String StrLada = "0";
        String Strtelefono = "0";
        String StrclIndicador = "0";
        String StrclTipoContactante = "0";
        String StrNombreContactante = "";
        String StrEsConductor = "";
        String StrObservaciones = "";
        String StrclUsrApp = "0";
        String StrExtension = "";
        String StrFechaProgramada = "";
        String Strresp1 = "0";
        String Strresp2 = "0";
        String Strresp3 = "0";
        String Strresp4 = "0";
        String Strresp5 = "0";
        String Strresp6 = "0";
        String StrNotas = "";

        ResultSet rsEx = null;

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Encuesta</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente").toString();
        }

        if (request.getParameter("clUsrApp") != null) {
            StrclUsrApp = request.getParameter("clUsrApp").toString();
        }

        if (request.getParameter("Extension") != null) {
            StrExtension = request.getParameter("Extension");
        }

        if (request.getParameter("clTipoContactante") != null) {

            StrclTipoContactante = request.getParameter("clTipoContactante");
        }

        if (request.getParameter("NombreContactante") != null) {
            StrNombreContactante = request.getParameter("NombreContactante");
        }

        if (request.getParameter("EsConductor") != null) {
            StrEsConductor = request.getParameter("EsConductor");
        }

        if (request.getParameter("Lada") != null) {
            StrLada = request.getParameter("Lada");
        }

        if (request.getParameter("Telefono") != null) {
            Strtelefono = request.getParameter("Telefono");
        }

        if (request.getParameter("clIndicador") != null) {
            StrclIndicador = request.getParameter("clIndicador");
        }

        if (request.getParameter("Observaciones") != null) {
            StrObservaciones = request.getParameter("Observaciones");
        }

        if (request.getParameter("Extension") != null) {
            StrExtension = request.getParameter("Extension");
        }


        if (request.getParameter("FechaProgramada") != null) {
            StrFechaProgramada = request.getParameter("FechaProgramada");
        }

        if (request.getParameter("resp1") != null) {
            Strresp1 = request.getParameter("resp1");
        }

        if (request.getParameter("resp2") != null) {
            Strresp2 = request.getParameter("resp2");
        }

        if (request.getParameter("resp3") != null) {
            Strresp3 = request.getParameter("resp3");
        }


        if (request.getParameter("resp4") != null) {
            Strresp4 = request.getParameter("resp4");
        }

        if (request.getParameter("resp5") != null) {
            Strresp5 = request.getParameter("resp5");
        }

        if (request.getParameter("resp6") != null) {
            Strresp6 = request.getParameter("resp6");
        }

        if (request.getParameter("Notas") != null) {
            StrNotas = request.getParameter("Notas");
        }

        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) {
                System.out.println("sp_SLGuardaLlamadaEncuesta  " + StrclExpediente + "," + StrclUsrApp + ",'" + StrExtension + "','" + StrclTipoContactante + "','" + StrNombreContactante + "','" + StrEsConductor + "','" + StrclIndicador + "','" + StrObservaciones + "','" + StrFechaProgramada + "','" + Strresp1 + "','" + Strresp2 + "','" + Strresp3 + "','" + Strresp4 + "','" + Strresp5 + "','" + Strresp6 + "','" + StrNotas + "','" + StrLada + "','" + Strtelefono + "'");
                UtileriasBDF.ejecutaSQLNP("sp_SLGuardaLlamadaEncuesta  " + StrclExpediente + "," + StrclUsrApp + ",'" + StrExtension + "','" + StrclTipoContactante + "','" + StrNombreContactante + "','" + StrEsConductor + "','" + StrclIndicador + "','" + StrObservaciones + "','" + StrFechaProgramada + "','" + Strresp1 + "','" + Strresp2 + "','" + Strresp3 + "','" + Strresp4 + "','" + Strresp5 + "','" + Strresp6 + "','" + StrNotas + "','" + StrLada + "','" + Strtelefono + "'");
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

    /*
     * Handles
     * the
     * HTTP
     * <code>GET</code>
     * method.
     *
     * @param
     * request
     * servlet
     * request
     *
     * @param
     * response
     * servlet
     * response
     *
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);

    }

    /*
     * Handles
     * the
     * HTTP
     * <code>POST</code>
     * method.
     *
     * @param
     * request
     * servlet
     * request
     *
     * @param
     * response
     * servlet
     * response
     *
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);

    }

    /*
     * Returns
     * a
     * short
     * description
     * of
     * the
     * servlet.
     *
     */
    public String getServletInfo() {

        return "Short description";

    }
}
