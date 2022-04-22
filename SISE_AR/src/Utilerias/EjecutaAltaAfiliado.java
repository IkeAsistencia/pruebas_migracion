/*
 * EjecutaAltaAfiliado.java
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
 * @version
 */
public class EjecutaAltaAfiliado extends HttpServlet {

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
        //cAfiliado

        String StrclAfiliado = "0";
        String StrclAfiliadoN = "0";
        String StrclContrato = "0";
        String StrclCuenta = "0";
        String StrNombre = "";
        String StrFechaIni = "";
        String StrFechaFin = "";
        String StrClave = "";
        String StrInciso = "";
        String StrAutomaticoVTR = "0";
        String StrFechaBaja = "";
        String StrActivo = "1";
        String StrclAutoAfiliadoN = "0";
        String StrColor = "";
        String StrPlacas = "";
        String StrSerie = "";
        String StrNoMotor = "";
        String StrModelo = "";
        String StrdescAuto = "";
        String StrCodigoMarca = "";
        String StrClaveAMIS = "";
        String StrCodEnt = "";
        String StrCodMD = "";
        String StrColonia = "";
        String StrCalle = "";
        String StrCP = "";
        String StrLicencia = "";
        String StrInciso2 = "0";

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
            return;
        }

        if (request.getParameter("clAfiliado") != null) {
            StrclAfiliado = request.getParameter("clAfiliado");
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


        if (request.getParameter("Nombre") != null) {
            StrNombre = request.getParameter("Nombre");
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

        if (request.getParameter("Clave") != null) {
            StrClave = request.getParameter("Clave");
        }
        if (request.getParameter("AutomaticoVTR") != null) {
            StrAutomaticoVTR = request.getParameter("AutomaticoVTR");
        }

        if (StrAutomaticoVTR.equalsIgnoreCase("1")) {
            StrInciso = "0";

        } else {
            if (request.getParameter("Inciso") != null) {
                StrInciso = request.getParameter("Inciso");
            } else {
                out.println("Falta informar Inciso");
                out.close();
                return;
            }
        }

        if (request.getParameter("Activo") != null) {
            StrActivo = request.getParameter("Activo");
        }

        if (request.getParameter("Color") != null) {
            StrColor = request.getParameter("Color");
        }

        if (request.getParameter("Placas") != null) {
            StrPlacas = request.getParameter("Placas");
        }

        if (request.getParameter("Serie") != null) {
            StrSerie = request.getParameter("Serie");
        }

        if (request.getParameter("NoMotor") != null) {
            StrNoMotor = request.getParameter("NoMotor");
        }

        if (request.getParameter("Modelo") != null) {
            StrModelo = request.getParameter("Modelo");
        }

        if (request.getParameter("descAuto") != null) {
            StrdescAuto = request.getParameter("descAuto");
        }

        if (request.getParameter("CodigoMarca") != null) {
            StrCodigoMarca = request.getParameter("CodigoMarca");
        }

        if (request.getParameter("ClaveAMIS") != null) {
            StrClaveAMIS = request.getParameter("ClaveAMIS");
        }

        if (request.getParameter("CodEnt") != null) {
            StrCodEnt = request.getParameter("CodEnt");
        }

        if (request.getParameter("CodMD") != null) {
            StrCodMD = request.getParameter("CodMD");
        }

        if (request.getParameter("Colonia") != null) {
            StrColonia = request.getParameter("Colonia");
        }

        if (request.getParameter("Calle") != null) {
            StrCalle = request.getParameter("Calle");
        }

        if (request.getParameter("CP") != null) {
            StrCP = request.getParameter("CP");
        }

        if (request.getParameter("Licencia") != null) {
            StrLicencia = request.getParameter("Licencia");
        }

        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) {
                String StrSentenceA = " sp_regresamaximoafiliado ";
                ResultSet rsclAfiliado = UtileriasBDF.rsSQLNP(StrSentenceA);
                if (rsclAfiliado.next()) {
                    StrclAfiliadoN = rsclAfiliado.getString("clAfiliado");
                }

                String StrSentenceB = " sp_RegresaMaximoAfilInfAdic ";
                ResultSet rsclAfiliadoInfo = UtileriasBDF.rsSQLNP(StrSentenceB);
                if (rsclAfiliadoInfo.next()) {
                    StrclAutoAfiliadoN = rsclAfiliadoInfo.getString("clAutoAfiliado");
                }

                ResultSet rs = UtileriasBDF.rsSQLNP("Select coalesce(max(Inciso),0) + 1  Inciso2 from cafiliado where clContrato =" + StrclContrato + "and clCuenta =" + StrclCuenta);
                if (rs.next()) {
                    StrInciso2 = rs.getString("Inciso2");

                } else {
                    out.println("Problemas al obtener el Maximo afiliado, consulte a su administrador");
                    out.close();
                    return;
                }

                if (StrAutomaticoVTR.equalsIgnoreCase("1")) {
                    StrInciso = StrInciso2;
                } else {
                    StrInciso = StrInciso;
                }

                String StrSentence = "Insert into cAfiliado (clAfiliado, clContrato, clCuenta, Nombre,";
                StrSentence = StrSentence + " FechaIni, FechaFin, Clave, Inciso,";
                StrSentence = StrSentence + " FechaAlta, Activo)";
                StrSentence = StrSentence + " values (" + StrclAfiliadoN + "," + StrclContrato + "," + StrclCuenta + ",'" + StrNombre + "','" + StrFechaIni + "','";
                StrSentence = StrSentence + StrFechaFin + "','" + StrClave + "'," + StrInciso;
                StrSentence = StrSentence + ",getdate()," + StrActivo + ")";
                UtileriasBDF.ejecutaSQLNP(StrSentence);

                String StrSentence2 = "Insert into AfiliadoInfoAdicional (clAutoAfiliado, clAfiliado, Color,";
                StrSentence2 = StrSentence2 + " Placas, Serie, NoMotor, Modelo,";
                StrSentence2 = StrSentence2 + " DescAuto, CodigoMarca, ClaveAMIS, CodENT, CodMD, Colonia, Calle, CP, Licencia)";
                StrSentence2 = StrSentence2 + " values (" + StrclAutoAfiliadoN + "," + StrclAfiliadoN + ",'" + StrColor + "','" + StrPlacas + "','";
                StrSentence2 = StrSentence2 + StrSerie + "','" + StrNoMotor + "','" + StrModelo;
                StrSentence2 = StrSentence2 + "','" + StrdescAuto + "','" + StrCodigoMarca + "','" + StrClaveAMIS + "','" + StrCodEnt + "','";
                StrSentence2 = StrSentence2 + StrCodMD + "','" + StrColonia + "','" + StrCalle + "','" + StrCP + "','" + StrLicencia + "')";
                UtileriasBDF.ejecutaSQLNP(StrSentence2);

//                    strUrlBack = strUrlBack + StrclAfiliadoN;
                strUrlBack = strUrlBack + "clAfiliado=" + StrclAfiliadoN;

                out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");

            }

            if (Integer.parseInt(request.getParameter("Action")) == 2) {

                if (StrActivo.compareToIgnoreCase("0") == 0) {
                    StrFechaBaja = "getdate()";
                } else {
                    StrFechaBaja = "null";
                }

                String StrSentence = "UPDATE cAfiliado SET Nombre='" + StrNombre + "',FechaIni='" + StrFechaIni + "',FechaFin='" + StrFechaFin
                        + "', Clave='" + StrClave + "', Inciso=" + StrInciso + ", FechaBaja=" + StrFechaBaja + ", Activo=" + StrActivo
                        + " WHERE clAfiliado=" + StrclAfiliado;
                UtileriasBDF.ejecutaSQLNP(StrSentence);

                String StrSentence2 = "UPDATE AfiliadoInfoAdicional SET Color='" + StrColor + "',Placas='" + StrPlacas + "',Serie='" + StrSerie
                        + "', NoMotor='" + StrNoMotor + "', Modelo='" + StrModelo + "', DescAuto='" + StrdescAuto + "', CodigoMarca='" + StrCodigoMarca
                        + "', ClaveAMIS='" + StrClaveAMIS + "', CodEnt='" + StrCodEnt + "', CodMD='" + StrCodMD + "', Colonia='" + StrColonia
                        + "', Calle='" + StrCalle + "', CP='" + StrCP
                        + "', Licencia='" + StrLicencia + "' WHERE clAfiliado=" + StrclAfiliado;
                UtileriasBDF.ejecutaSQLNP(StrSentence2);


                strUrlBack = strUrlBack + "clAfiliado=" + StrclAfiliado;
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