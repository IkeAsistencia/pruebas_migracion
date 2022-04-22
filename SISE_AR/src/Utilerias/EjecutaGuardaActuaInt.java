/*
 * EjecutaGuardaActuaInt.java
 *
 * Created on 25 de Septiembre de 2006, 16:10 PM
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
 * rodrigus
 * @version
 */
public class EjecutaGuardaActuaInt extends HttpServlet {

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);

        String strSise = "0";
        String strclExpediente = "0";
        String strFechaActualizacion = "";
        String strclAsistencia = "0";
        String strAvPrevia = "";
        String strclProveedor = "0";
        String strclEtapaProcedimiento = "0";
        String strFechaIntervencion = "";
        String strclObjetivoLegal = "0";
        String strclEstatusRecupDanos = "0";
        String strObjetivoResultado = "";
        String strFechaTentativa = "";
        String strFechaTramite = "";
        String strQueHice = "";
        String strParaQueHice = "";
        String strResultadoObtuve = "";
        String strSucederaDespues = "";
        String strclEstatusUnidad = "";
        String strFechaDetencion = "";
        String strFechaAcredProp = "";
        String strFechaOficioLibera = "";
        String strMontoAvaluo = "0";
        String strFechaLibera = "";
        String strFechaPresQuerella = "";
        String strMotivoNoLiberacion = "";
        String strEmail = "";
        String strNombreAtendio = "";
        String strFechaLlamada = "";
        String strObservaciones = "";
        String strTelefonoLlamada = "";
        String strclTipoPersAten = "0";
        String strclProveedorLlamada = "0";

        String strclCulpaDicta = "0";
        ResultSet rsEx = null;

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Encuesta</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("Sise") != null) {
            strSise = request.getParameter("Sise").toString();
        }

        if (request.getParameter("clExpediente") != null) {
            strclExpediente = request.getParameter("clExpediente").toString();
        }

        if (request.getParameter("FechaActualizacion") != null) {
            strFechaActualizacion = request.getParameter("FechaActualizacion").toString();
        }

        if (request.getParameter("clAsistencia") != null) {
            strclAsistencia = request.getParameter("clAsistencia").toString();
        }

        if (request.getParameter("AvPrevia") != null) {
            strAvPrevia = request.getParameter("AvPrevia").toString();
        }

        if (request.getParameter("clProveedor") != null) {
            strclProveedor = request.getParameter("clProveedor").toString();
        }

        if (request.getParameter("clEtapaProcedimiento") != null) {
            strclEtapaProcedimiento = request.getParameter("clEtapaProcedimiento").toString();
        }

        if (request.getParameter("FechaIntervencion") != null) {
            strFechaIntervencion = request.getParameter("FechaIntervencion").toString();
        }

        if (request.getParameter("clObjetivoLegal") != null) {
            strclObjetivoLegal = request.getParameter("clObjetivoLegal").toString();
        }

        if (request.getParameter("clEstatusRecupDanos") != null) {
            strclObjetivoLegal = request.getParameter("clEstatusRecupDanos").toString();
        }

        if (request.getParameter("ObjetivoResultado") != null) {
            strObjetivoResultado = request.getParameter("ObjetivoResultado").toString();
        }

        if (request.getParameter("FechaTramite") != null) {
            strFechaTramite = request.getParameter("FechaTramite").toString();
        }

        if (request.getParameter("QueHice") != null) {
            strQueHice = request.getParameter("QueHice").toString();
        }

        if (request.getParameter("ParaQueHice") != null) {
            strParaQueHice = request.getParameter("ParaQueHice").toString();
        }

        if (request.getParameter("ResultadoObtuve") != null) {
            strResultadoObtuve = request.getParameter("ResultadoObtuve").toString();
        }

        if (request.getParameter("SucederaDespues") != null) {
            strSucederaDespues = request.getParameter("SucederaDespues").toString();
        }

        if (request.getParameter("clEstatusUnidad") != null) {
            strclEstatusUnidad = request.getParameter("clEstatusUnidad").toString();
        }

        if (request.getParameter("FechaDetencion") != null) {
            strFechaDetencion = request.getParameter("FechaDetencion").toString();
        }

        if (request.getParameter("FechaAcredProp") != null) {
            strFechaAcredProp = request.getParameter("FechaAcredProp").toString();
        }

        if (request.getParameter("FechaOficioLibera") != null) {
            strFechaOficioLibera = request.getParameter("FechaOficioLibera").toString();
        }

        if (request.getParameter("MontoAvaluo") != null) {
            strMontoAvaluo = request.getParameter("MontoAvaluo").toString();
        }

        if (request.getParameter("FechaLibera") != null) {
            strFechaLibera = request.getParameter("FechaLibera").toString();
        }

        if (request.getParameter("FechaPresQuerella") != null) {
            strFechaPresQuerella = request.getParameter("FechaPresQuerella").toString();
        }

        if (request.getParameter("MotivoNoLiberacion") != null) {
            strMotivoNoLiberacion = request.getParameter("MotivoNoLiberacion").toString();
        }

        if (request.getParameter("Correo") != null) {
            strEmail = request.getParameter("Correo").toString();
        }

        if (request.getParameter("NombreAtendio") != null) {
            strNombreAtendio = request.getParameter("NombreAtendio").toString();
        }

        if (request.getParameter("FechaLlamada") != null) {
            strFechaLlamada = request.getParameter("FechaLlamada").toString();
        }

        if (request.getParameter("Observaciones") != null) {
            strObservaciones = request.getParameter("Observaciones").toString();
        }

        if (request.getParameter("TelefonoLlamada") != null) {
            strTelefonoLlamada = request.getParameter("TelefonoLlamada").toString();
        }

        if (request.getParameter("clTipoPersAten") != null) {
            strclTipoPersAten = request.getParameter("clTipoPersAten").toString();
        }

        if (request.getParameter("clProveedorLlamada") != null) {
            strclProveedorLlamada = request.getParameter("clProveedorLlamada").toString();
        }

        if (request.getParameter("clCulpaDicta") != null) {
            strclCulpaDicta = request.getParameter("clCulpaDicta").toString();
        }

        if (request.getParameter("FechaTentativa") != null) {
            strFechaTentativa = request.getParameter("FechaTentativa").toString();
        }

        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }


            if (Integer.parseInt(request.getParameter("Action")) == 1) {
                ResultSet rsGuarda = UtileriasBDF.rsSQLNP("st_GuardaIntervencionSEAIKE '" + strSise + "','" + strclExpediente + "','" + strclAsistencia + "','" + strFechaActualizacion + "','" + strAvPrevia + "','" + strclProveedor + "','" + strclEtapaProcedimiento + "','" + strFechaIntervencion + "','" + strclObjetivoLegal + "','" + strclEstatusRecupDanos + "','" + strObjetivoResultado + "','" + strFechaTramite + "','" + strQueHice + "','" + strParaQueHice + "','" + strResultadoObtuve + "','" + strSucederaDespues + "','" + strclEstatusUnidad + "','" + strFechaDetencion + "','" + strFechaAcredProp + "','" + strFechaOficioLibera + "','" + strMontoAvaluo + "','" + strFechaLibera + "','" + strFechaPresQuerella + "','" + strMotivoNoLiberacion + "','" + strEmail + "','" + strNombreAtendio + "','" + strFechaLlamada + "','" + strObservaciones + "','" + strTelefonoLlamada + "','" + strclTipoPersAten + "','" + strclProveedorLlamada + "','" + strclCulpaDicta + "','" + strFechaTentativa + "'");
                System.out.println("st_GuardaIntervencionSEAIKE '" + strSise + "','" + strclExpediente + "','" + strclAsistencia + "','" + strFechaActualizacion + "','" + strAvPrevia + "','" + strclProveedor + "','" + strclEtapaProcedimiento + "','" + strFechaIntervencion + "','" + strclObjetivoLegal + "','" + strclEstatusRecupDanos + "','" + strObjetivoResultado + "','" + strFechaTramite + "','" + strQueHice + "','" + strParaQueHice + "','" + strResultadoObtuve + "','" + strSucederaDespues + "','" + strclEstatusUnidad + "','" + strFechaDetencion + "','" + strFechaAcredProp + "','" + strFechaOficioLibera + "','" + strMontoAvaluo + "','" + strFechaLibera + "','" + strFechaPresQuerella + "','" + strMotivoNoLiberacion + "','" + strEmail + "','" + strNombreAtendio + "','" + strFechaLlamada + "','" + strObservaciones + "','" + strTelefonoLlamada + "','" + strclTipoPersAten + "','" + strclProveedorLlamada + "','" + strclCulpaDicta + "','" + strFechaTentativa + "'");
                if (rsGuarda.next()) {
                    if (rsGuarda.getString("Error").equalsIgnoreCase("0")) {
                        out.println("<script>");
                        out.println("alert(\"La Intervencion se insgreso correctamente\");");
                        out.println("</script>");
                        out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                    } else {
                        out.println("<script>");
                        out.println("alert(\"01: Error al Insertar la Intervencion\");");
                        out.println("</script>");
                        out.println("<script>window.opener.fnValidaError()</script>");
                    }
                }

            }
        } catch (Exception e) {
            out.println("<script>");
            out.println("alert(\"02: Error al Insertar la Intervencion\");");
            out.println("</script>");
            out.println("<script>window.opener.fnValidaError()</script>");
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
