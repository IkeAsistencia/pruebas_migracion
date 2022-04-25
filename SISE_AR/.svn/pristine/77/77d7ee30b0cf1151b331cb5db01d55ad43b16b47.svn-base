/*
 * EjecutaAltaContrato.java
 *
 * Created on 4 de Mayo de 2005, 04:27 PM
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
 * cabrerar
 * @version
 */
public class EjecutaAltaContrato extends HttpServlet {

    /*
     * Initializes
     * the
     * servlet.
     */
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
        String StrclContrato = "0";
        String StrclCuenta = "0";
        String StrFechaIni = "";
        String StrFechaFin = "";
        String StrContratoInterno = "";
        String StrPrefijoContrato = "";
        String StrIncisoAutomatico = "0";
        String StrContratoEspecial = "";
        String StrActivo = "1";
        String StrFechaAlta = "";
        String StrFechaBaja = "";
        String StrContratuCalculo = "";
        String StrContratoInternoI = "";
        String StrPrefijoContratoI = "";
        String StrCer = "000";

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Prueba de Servicio Seguridad</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("Action") == null) {
            out.println("Problema con la definición de la acción a realizar, por favor vuelva a intentarlo");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }

        if (request.getParameter("clContrato") != null) {
            StrclContrato = request.getParameter("clContrato");
        }

        if (request.getParameter("clCuenta") != null) {
            StrclCuenta = request.getParameter("clCuenta");
        } else {
            out.println("No se informó la cuenta, consulte a su administrador");
            out.close();
            return;
        }

        if (request.getParameter("FechaIni") != null) {
            StrFechaIni = request.getParameter("FechaIni");
        } else {
            out.println("Falta informar fecha de inicio de vigencia");
            out.close();
            return;
        }

        if (request.getParameter("FechaFin") != null) {
            StrFechaFin = request.getParameter("FechaFin");
        } else {
            out.println("Falta informar fecha de fin de vigencia");
            out.close();
            return;
        }
        StrIncisoAutomatico = request.getParameter("IncisoAutomatico");

        if (StrIncisoAutomatico.equalsIgnoreCase("1")) {
            StrContratoEspecial = "0";

        } else {
            if (request.getParameter("ContratoEspecial") != null) {

                StrContratoEspecial = request.getParameter("ContratoEspecial");
            } else {
                out.println("Falta informar Contrato Especial");

                out.close();
                return;
            }

        }
        if (request.getParameter("Activo") != null) {
            StrActivo = request.getParameter("Activo");
        }
        StrPrefijoContratoI = request.getParameter("PrefijoContrato");
        StrContratoInternoI = request.getParameter("ContratoInterno");
        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) {
                ResultSet rs = UtileriasBDF.rsSQLNP("Select E.PrefijoContrato, coalesce(max(ContratoInterno),1) + 1 ContratoInterno from cCuenta C inner join cEmpresaSEA E on (E.clEmpresaSEA = C.clEmpresaSEA) left join ContratoxCuenta CxC on (E.PrefijoContrato = CxC.PrefijoContrato) where C.clCuenta = " + StrclCuenta + " group by E.PrefijoContrato ");
                if (rs.next()) {
                    StrPrefijoContrato = rs.getString("PrefijoContrato");
                    StrContratoInterno = rs.getString("ContratoInterno");
                } else {
                    out.println("Problemas al obtener el número de contrato, consulte a su administrador");
                    out.close();
                    return;
                }
                if (StrIncisoAutomatico.equalsIgnoreCase("1")) {
                    StrContratoEspecial = StrPrefijoContrato + StrContratoInterno + StrCer;
                } else {
                    StrContratoEspecial = StrContratoEspecial;
                }

                String StrSentence = "Insert into ContratoxCuenta (clCuenta, FechaIni, FechaFin, ";
                StrSentence = StrSentence + "ContratoInterno,IncisoAutomatico, PrefijoContrato, ";
                StrSentence = StrSentence + "ContratoEspecial, FechaAlta)";
                StrSentence = StrSentence + " values (" + StrclCuenta + ",'" + StrFechaIni + "','";
                StrSentence = StrSentence + StrFechaFin + "'," + StrContratoInterno + "," + StrIncisoAutomatico + ",'" + StrPrefijoContrato;
                StrSentence = StrSentence + "','" + StrContratoEspecial + "',getdate())";
                ResultSet rsLlave = UtileriasBDF.rsSQLNP(StrSentence + " Select @@Identity Llave ");
                if (rsLlave.next()) {
                    strUrlBack = strUrlBack + "clContrato=" + rsLlave.getString("Llave");
                }
                out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");

            }

            if (Integer.parseInt(request.getParameter("Action")) == 2) {

                if (StrIncisoAutomatico.equalsIgnoreCase("1")) {
                    StrContratoEspecial = StrPrefijoContratoI + StrContratoInternoI + StrCer;
                } else {
                    StrContratoEspecial = StrContratoEspecial;
                }

                if (StrActivo.compareToIgnoreCase("0") == 0) {
                    StrFechaBaja = ",FechaBaja=getdate()";
                } else {
                    StrFechaBaja = ",FechaBaja=Null";
                }
                String StrSentence = "UPDATE ContratoxCuenta SET FechaIni='" + StrFechaIni + "',FechaFin='" + StrFechaFin
                        + "',Activo=" + StrActivo + ",IncisoAutomatico=" + StrIncisoAutomatico + ",ContratoEspecial='" + StrContratoEspecial + "'" + StrFechaBaja
                        + " WHERE clContrato=" + StrclContrato;
                UtileriasBDF.ejecutaSQLNP(StrSentence);
                strUrlBack = strUrlBack + "clContrato=" + StrclContrato;
                out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 3) {
            }
            out.println("</body>");
            out.println("</html>");

        } catch (Exception e) {
            out.close();
            e.printStackTrace();
        }
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
    public String getServletInfo() {
        return "Short description";
    }
}
