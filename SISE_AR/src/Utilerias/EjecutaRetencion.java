/*
 * EjecutaLlamAltaAfil.java
 *
 * Created on 7 de Febrero de 2006, 05:02 PM
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
 * perezern
 * @version
 */
public class EjecutaRetencion extends HttpServlet {

    /*
     * Initializes
     * the
     * servlet.
     */
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

    }

    /*
     * Destroys
     * the
     * servlet.
     */
    @Override
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
        //cAfiliado
        //String StrUsrApp = "0";
        String StrUsrAppS = "0";
        String StrclCuenta = "0";
        String StrclAfiliado = "0";
        String StrNombre = "";
        String StrClave = "";
        String StrPersonaReporta = "";
        String StrTelPersonaReporta = "";
        String StrRFC = "";
        String StrclMotivoCancela = "";
        String StrclEstatus = "0";
        String StrObservaciones = "";
        String StrclRetencTmk = "0";//Variable de Regreso
        String strUrlBack = "";
        String StrclAfilTMK = "";
        String StrBeneficiario = "";        //me
        String StrChkBoxCompleta = "";//me
        String StrCanalVenta = "";
        String StrDNI = "";
        String StrDireccion = "";
        String StrCalle = "";
        String StrNcalle = "";
        String StrNPiso = "";
        String StrNdepto = "";
        String StrCp = "";
        String StrCambioDom = "";
        String StrTelCasa = "";
        String StrTelOfi = "";
        String Strcorreo = "";
        String StrClEntFed = "";
        String StrCodEnt = "";
        String StrCodMD = "";
        String StrHR1 = "";
        String StrHR2 = "";
        String StrPR1 = "";
        String StrPR2 = "";
        String StrPR3 = "";
        String StrPE1 = "";
        String StrPE2 = "";

        ResultSet rsEx = null;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Retenciones</title>");
        out.println("</head>");
        out.println("<body>");

//        if (sessionH.getAttribute("clUsrApp") != null) {
//            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
//        }
        if (request.getParameter("clUsrAppS") != null) {
            StrUsrAppS = request.getParameter("clUsrAppS");
        }
        if (request.getParameter("clCuenta") != null) {
            StrclCuenta = request.getParameter("clCuenta");
        }

        if (request.getParameter("Nombre") != null) {
            StrNombre = request.getParameter("Nombre");
        }

        if (request.getParameter("Clave") != null) {
            StrClave = request.getParameter("Clave");

        }
        if (request.getParameter("PersonaReporta") != null) {
            StrPersonaReporta = request.getParameter("PersonaReporta");
        }

        if (request.getParameter("TelPersonaReporta") != null) {
            StrTelPersonaReporta = request.getParameter("TelPersonaReporta");

        }
        if (request.getParameter("RFC") != null) {
            StrRFC = request.getParameter("RFC");

        }
        if (request.getParameter("clMotivoCancela") != null) {
            StrclMotivoCancela = request.getParameter("clMotivoCancela");

        }
        if (request.getParameter("clEstatus") != null) {
            StrclEstatus = request.getParameter("clEstatus");
        }

        if (request.getParameter("clAfiliado") != null) {
            StrclAfiliado = request.getParameter("clAfiliado");
        }
        if (request.getParameter("Observaciones") != null) {
            StrObservaciones = request.getParameter("Observaciones");
        }

        if (request.getParameter("clAfilTMK") != null) {
            StrclAfilTMK = request.getParameter("clAfilTMK");
        }

        if (request.getParameter("derechoHab") != null) {                     //me
            StrBeneficiario = request.getParameter("derechoHab");
        }

        if (request.getParameter("ChkBoxCompleta") != null) {
            StrChkBoxCompleta = request.getParameter("ChkBoxCompleta");
        }

        if (request.getParameter("CanalVenta") != null) {
            StrCanalVenta = request.getParameter("CanalVenta");
        }

        if (request.getParameter("DNI") != null) {
            StrDNI = request.getParameter("DNI");
        }

        if (request.getParameter("direccion") != null) {
            StrDireccion = request.getParameter("direccion");
        }

        if (request.getParameter("calle") != null) {
            StrCalle = request.getParameter("calle");
        }

        if (request.getParameter("ncalle") != null) {
            StrNcalle = request.getParameter("ncalle");
        }

        if (request.getParameter("nPiso") != null) {
            StrNPiso = request.getParameter("nPiso");
        }

        if (request.getParameter("ndepto") != null) {
            StrNdepto = request.getParameter("ndepto");
        }

        if (request.getParameter("cp") != null) {
            StrCp = request.getParameter("cp");
        }

        if (request.getParameter("ChkBoxCambioDom") != null) {
            StrCambioDom = request.getParameter("ChkBoxCambioDom");
        }

        if (request.getParameter("TelCasa") != null) {
            StrTelCasa = request.getParameter("TelCasa");
        }

        if (request.getParameter("TelOfi") != null) {
            StrTelOfi = request.getParameter("TelOfi");
        }

        if (request.getParameter("correo") != null) {
            Strcorreo = request.getParameter("correo");
        }

        if (request.getParameter("ClEntFed") != null) {
            StrClEntFed = request.getParameter("ClEntFed");
        }

        if (request.getParameter("CodEnt") != null) {
            StrCodEnt = request.getParameter("CodEnt");
        }

        if (request.getParameter("CodMD") != null) {
            StrCodMD = request.getParameter("CodMD");
        }

        if (request.getParameter("HR1") != null) {
            StrHR1 = request.getParameter("HR1");
        }
        
        if (request.getParameter("HR2") != null) {
            StrHR2 = request.getParameter("HR2");
        }
        
        if (request.getParameter("PR1") != null) {
            StrPR1 = request.getParameter("PR1");
        }

        if (request.getParameter("PR2") != null) {
            StrPR2 = request.getParameter("PR2");
        }
        
        if (request.getParameter("PR3") != null) {
            StrPR3 = request.getParameter("PR3");
        }
        
        if (request.getParameter("PE1") != null) {
            StrPE1 = request.getParameter("PE1");
        }
        
        if (request.getParameter("PE2") != null) {
            StrPE2 = request.getParameter("PE2");
        }

        try {

            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");

            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) {

                rsEx = UtileriasBDF.rsSQLNP("sp_AddRetencion '" + StrUsrAppS + "','" + StrclCuenta + "','" + StrclAfiliado + "','"
                        + StrNombre + "','" + StrClave + "','" + StrPersonaReporta + "','"
                        + StrTelPersonaReporta + "','" + StrRFC + "','" + StrclMotivoCancela + "','"
                        + StrclEstatus + "','" + StrObservaciones + "','" + StrclAfilTMK + "','"
                        + StrBeneficiario + "','" + StrChkBoxCompleta + "','" + StrCanalVenta + "','"
                        + StrDNI + "','" + StrDireccion + "','" + StrCalle + "','"
                        + StrNcalle + "','" + StrNPiso + "','" + StrNdepto + "','"
                        + StrCp + "','" + StrCambioDom + "','" + StrTelCasa + "','"
                        + StrTelOfi + "','" + Strcorreo + "','" + StrClEntFed + "','"
                        + StrCodEnt + "','" + StrCodMD + "'," + StrHR1 + "," + StrHR2 + "," + StrPR1 + "," + StrPR2 + ","
                        + StrPR3 + "," + StrPE1 + "," + StrPE2);

                if (rsEx.next()) {
                    StrclRetencTmk = rsEx.getString("clRetencTmk");
                }

                if (!StrclRetencTmk.equalsIgnoreCase("0")) {
                    strUrlBack = strUrlBack + "&clRetencTmk=" + StrclRetencTmk;
                    out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                } else {
                    out.println("Problemas al Generar el Movimiento Favor de Comunicarse con su Administrador");
                    out.close();
                }
            }

        } catch (Exception e) {
            out.close();

        } finally {

            //StrUsrApp = null;
            StrUsrAppS = null;
            StrclCuenta = null;
            StrclAfiliado = null;
            StrNombre = null;
            StrClave = null;
            StrPersonaReporta = null;
            StrTelPersonaReporta = null;
            StrRFC = null;
            StrclMotivoCancela = null;
            StrclEstatus = null;
            StrObservaciones = null;
            StrclRetencTmk = null;//Variable de Regreso
            strUrlBack = null;
            StrBeneficiario = null;     //me
            StrChkBoxCompleta = null;
            StrCanalVenta = null;

            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;
                }
            } catch (Exception ee) {
            }
        }
        out.println("</body>");
        out.println("</html>");

        out.close();
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
     * @param
     * response
     * servlet
     * response
     */
    @Override
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
     * @param
     * response
     * servlet
     * response
     */
    @Override
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
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
