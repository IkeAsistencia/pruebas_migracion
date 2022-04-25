/*
 * EjecutaLlamAltaAfil.java
 *
 * Created on 11 de Mayo de 2006, 05:02 PM
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
 * @author zamoraed
 * @version
 */
public class EjecutaVentaAcumulador extends HttpServlet {

    private static Correo Cor = new Correo();

    public void init(ServletConfig config) throws ServletException {
        super.init(config);

    }

    public void destroy() {
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        //cAfiliado
        String StrUsrApp = "0";

        //VARIABLES DECLARADAS SEGUN LOS CAMPOS QUE LA PÁGINA VENTAACUMULADOR.JSP CAPTURA

        String StrclExpediente = "0";
        String StrReportaVenta = "0";
        String StrUsuarioAcepta = "0";
        String StrclFormaPago = "0";
        String StrclBanco = "0";
        String StrTarjetaNumero = "";
        String StrVencimiento = "";
        String StrCodigoSeguridad = "";
        String StrMonto = "0";
        String StrAutorizacion = "";
        String StrFactura = "";
        String StrFax = "";
        String StrCodigoMarca = "";
        String StrClaveAmis = "";
        String StrModelo = "0";
        String StrColor = "";
        String StrPlacas = "";
        String StrUsuarioRZ = "";
        String StrRFC = "";
        String StrCodEnt = "0";
        String StrCodMD = "";
        String StrColonia = "";
        String StrCalleNum = "";
        String StrCP = "0";

        ResultSet rsEx = null;
        ResultSet rsSx = null;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Venta de Acumulador</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("clUsrAppVenta") != null) {
            StrUsrApp = request.getParameter("clUsrAppVenta").toString();
        }

        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente");
        }

        if (request.getParameter("ReportaVenta") != null) {
            StrReportaVenta = request.getParameter("ReportaVenta");
        }

        if (request.getParameter("UsuarioAcepta") != null) {
            StrUsuarioAcepta = request.getParameter("UsuarioAcepta");
        }

        if (request.getParameter("clFormaPago") != null) {
            StrclFormaPago = request.getParameter("clFormaPago");
        }

        if (request.getParameter("clBanco") != null) {
            StrclBanco = request.getParameter("clBanco");
        }
        if (request.getParameter("TarjetaNumero") != null) {
            StrTarjetaNumero = request.getParameter("TarjetaNumero");
        }
        if (request.getParameter("Vencimiento") != null) {
            StrVencimiento = request.getParameter("Vencimiento");
        }

        if (request.getParameter("CodigoSeguridad") != null) {
            StrCodigoSeguridad = request.getParameter("CodigoSeguridad");
        }

        if (request.getParameter("Monto") != null) {
            StrMonto = request.getParameter("Monto");
        }

        if (request.getParameter("Autorizacion") != null) {
            StrAutorizacion = request.getParameter("Autorizacion");
        }

        if (request.getParameter("Factura") != null) {
            StrFactura = request.getParameter("Factura");
        }

        if (request.getParameter("Fax") != null) {
            StrFax = request.getParameter("Fax");
        }

        if (request.getParameter("CodigoMarca") != null) {
            StrCodigoMarca = request.getParameter("CodigoMarca");
        }

        if (request.getParameter("ClaveAMIS") != null) {
            StrClaveAmis = request.getParameter("ClaveAMIS");
        }

        if (request.getParameter("Modelo") != null) {
            StrModelo = request.getParameter("Modelo");
        }

        if (request.getParameter("Color") != null) {
            StrColor = request.getParameter("Color");
        }
        if (request.getParameter("Placas") != null) {
            StrPlacas = request.getParameter("Placas");
        }

        if (request.getParameter("UsuarioRZ") != null) {
            StrUsuarioRZ = request.getParameter("UsuarioRZ");
        }

        if (request.getParameter("RFC") != null) {
            StrRFC = request.getParameter("RFC");
        }

        if (request.getParameter("CodEnt") != null) {
            StrCodEnt = request.getParameter("CodEnt");
        }
        if (request.getParameter("CodMD") != null) {
            StrCodMD = request.getParameter("CodMD");
        }

        if (request.getParameter("CalleNum") != null) {
            StrCalleNum = request.getParameter("CalleNum");

        }
        if (request.getParameter("CP") != null) {
            StrCP = request.getParameter("CP");
        }

        if (request.getParameter("Colonia") != null) {
            StrColonia = request.getParameter("Colonia");
        }

        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");

            }
            if (Integer.parseInt(request.getParameter("Action")) == 1) {
                ResultSet rsAcumul = UtileriasBDF.rsSQLNP("Select clAcumulador,NumSerie from AcumuladorxExpediente where clexpediente=" + StrclExpediente);
                if (rsAcumul.next()) {
                    do {
//                    System.out.println("sp_GuardaVentaAcumulador  '" + StrclExpediente + "','" + StrReportaVenta + "','" + StrUsuarioAcepta + "','" + StrclFormaPago + "','" + StrclBanco + "','" + StrTarjetaNumero + "','" + StrVencimiento + "','" + StrCodigoSeguridad + "','" + StrMonto + "','" + StrAutorizacion + "','" + StrFactura + "','" + StrFax + "','"+ StrCodigoMarca + "','" + StrClaveAmis + "','" + StrModelo + "','" + StrColor + "','" + StrPlacas + "','" + StrUsuarioRZ + "','" + StrRFC + "','" + StrCodEnt + "','" + StrCodMD + "','" + StrColonia + "','" + StrCalleNum + "','" + StrCP + "'");
                        rsEx = UtileriasBDF.rsSQLNP("sp_GuardaVentaAcumulador  '" + StrclExpediente + "','" + StrReportaVenta + "','" + StrUsuarioAcepta + "','" + StrclFormaPago + "','" + StrclBanco + "','" + StrTarjetaNumero + "','" + StrVencimiento + "','" + StrCodigoSeguridad + "','" + StrMonto + "','" + StrAutorizacion + "','" + StrFactura + "','" + StrFax + "','" + StrCodigoMarca + "','" + StrClaveAmis + "','" + StrModelo + "','" + StrColor + "','" + StrPlacas + "','" + StrUsuarioRZ + "','" + StrRFC + "','" + StrCodEnt + "','" + StrCodMD + "','" + StrColonia + "','" + StrCalleNum + "','" + StrCP + "','" + rsAcumul.getString("clAcumulador").toString() + "','" + rsAcumul.getString("NumSerie").toString() + "'");
                        if (rsEx.next()) {
                            String StrVentaOK = rsEx.getString("VentaOK");
                            if (StrVentaOK.equalsIgnoreCase("0")) {
                                out.println("Error durante la Ejecución de la Transacción. Los datos se hab enviado por E-Mail para su revisión.");
                                out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                            } else {
                                strUrlBack = strUrlBack + "&clExpediente=" + StrclExpediente + "&clUsrApp=" + StrUsrApp;
                                out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                            }
                        }
                    } while (rsAcumul.next());

                } else {
                    UtileriasBDF.ejecutaSQLNP("sp_GuardaNoVentaAcumulador  '" + StrclExpediente + "'");
                    strUrlBack = strUrlBack + "&clExpediente=" + StrclExpediente;
                    out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                }

                rsAcumul.close();
                rsAcumul = null;
            }
            if (Integer.parseInt(request.getParameter("Action")) == 2) {

                UtileriasBDF.ejecutaSQLNP("update AsistVentaAcumulador set  Factura=" + StrFactura + ", Fax='" + StrFax + "', CodigoMarca='" + StrCodigoMarca + "',ClaveAmis='" + StrClaveAmis + "',Modelo=" + StrModelo + ",Color='" + StrColor + "',Placas='" + StrPlacas + "',UsuarioRZ='" + StrUsuarioRZ + "',RFC='" + StrRFC + "',CodEnt='" + StrCodEnt + "',CodMD='" + StrCodMD + "',Colonia='" + StrColonia + "',CalleNum='" + StrCalleNum + "',CP='" + StrCP + "' where clExpediente = " + StrclExpediente);
                strUrlBack = strUrlBack + "&clExpediente=" + StrclExpediente + "&clUsrApp=" + StrUsrApp;
                out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
            }
        } catch (Exception e) {
            out.println("<script>");
            out.println("alert(\"Error al insertar, Favor verifique los datos e intentelo nuevamente\");");
            out.println("</script>");
            out.println("<script>window.opener.fnValidaError()</script>");
            out.close();
            e.printStackTrace();
//            this.destroy();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;

                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }

            try {
                if (rsSx != null) {
                    rsSx.close();
                    rsSx = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
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
