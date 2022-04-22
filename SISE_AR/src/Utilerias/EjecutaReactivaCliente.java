/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilerias;

/*
 *
 * @author
 * fcerqueda
 */
import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class EjecutaReactivaCliente extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void destroy() {
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sessionH = request.getSession(false);

        String StrUsrApp = "0";
        String StrFolioVTR = "0";
        String StrclAfiliado = "0";
        String StrclAfilTMK = "0";
        String StrNomAfil = "";
        String StrClave = "0";
        String StrMotReactiva = "";
        String StrGpoCuenta = "";
        String StrClCuenta = "0";
        String StrPrefijoSISE = "";
        String StrPrefijoTMK = "";
        String StrtipoCanc = "0";
        String StrUrlBack = "";
        String StrClReactivacion = "0";

        ResultSet rs = null;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Retenciones</title>");
        out.println("</head>");
        out.println("<body>");

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }

        if (request.getParameter("FolioVTR") != null) {
            StrFolioVTR = request.getParameter("FolioVTR");
        }

        if (request.getParameter("clAfiliado") != null) {
            StrclAfiliado = request.getParameter("clAfiliado");
        }

        if (request.getParameter("clAfilTMK") != null) {
            StrclAfilTMK = request.getParameter("clAfilTMK");
        }

        if (request.getParameter("nomAfil") != null) {
            StrNomAfil = request.getParameter("nomAfil");
        }

        if (request.getParameter("Clave") != null) {
            StrClave = request.getParameter("Clave");
        }

        if (request.getParameter("MotReactiva") != null) {
            StrMotReactiva = request.getParameter("MotReactiva");
        }

        if (request.getParameter("gpoCuenta") != null) {
            StrGpoCuenta = request.getParameter("gpoCuenta");
        }

        if (request.getParameter("ClCuenta") != null) {
            StrClCuenta = request.getParameter("ClCuenta");
        }

        if (request.getParameter("prefijoSISE") != null) {
            StrPrefijoSISE = request.getParameter("prefijoSISE");
        }

        if (request.getParameter("prefijoTMK") != null) {
            StrPrefijoTMK = request.getParameter("prefijoTMK");
        }

        if (request.getParameter("tipoCanc") != null) {
            StrtipoCanc = request.getParameter("tipoCanc");
        }

        try {
            if (request.getParameter("URLBACK") != null) {
                StrUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) {
                rs = UtileriasBDF.rsSQLNP("st_ReactivaCliente '" + StrUsrApp + "','"
                        + StrFolioVTR + "','"
                        + StrclAfiliado + "','"
                        + StrclAfilTMK + "','"
                        + StrNomAfil + "','"
                        + StrClave + "','"
                        + StrMotReactiva + "','"
                        + StrGpoCuenta + "','"
                        + StrClCuenta + "','"
                        + StrPrefijoSISE + "','"
                        + StrPrefijoTMK + "','"
                        + StrtipoCanc + "'");
                if (rs.next()) {
                    StrClReactivacion = rs.getString("codReactivacion");
                }

                if (!StrClReactivacion.equalsIgnoreCase("0")) {
                    StrUrlBack = StrUrlBack + "&clReactivacion=" + StrClReactivacion;
                    out.println("<script>window.opener.fnValidaResponse(1,'" + StrUrlBack + "')</script>");
                } else {
                    out.println("Problemas al Generar el Movimiento Favor de Comunicarse con su Administrador");
                    out.close();
                }
            }

        } catch (Exception e) {
            out.close();
            e.printStackTrace();
        } finally {

            StrUsrApp = null;
            StrFolioVTR = null;
            StrclAfiliado = null;
            StrclAfilTMK = null;
            StrNomAfil = null;
            StrClave = null;
            StrMotReactiva = null;
            StrClCuenta = null;
            StrPrefijoSISE = null;
            StrPrefijoTMK = null;
            StrtipoCanc = null;
            StrUrlBack = null;
            StrClReactivacion = null;

            try {
                if (rs != null) {
                    rs.close();
                    ;
                    rs = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }

        out.println("</body>");
        out.println("</html>");

        out.close();
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
