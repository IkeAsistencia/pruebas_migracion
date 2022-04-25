/*
 * RegistraEspectaculo.java
 *
 * Created on 15 de febrero de 2007, 12:06 PM
 */
package Concierge;

import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import Utilerias.UtileriasBDF;
import com.ike.concierge.to.Conciergeespectaculo;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaEspec extends HttpServlet {

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
        HttpSession sessionH = request.getSession(false);
        Conciergeespectaculo conciergeespectaculo = new Conciergeespectaculo();
        PrintWriter out = response.getWriter();

        //cAfiliado
        String StrUsrApp = "0";
        String clConcierge = "";
        String FechaApAsist = "";
        String clAsistencia = "0";
        String clAsistenciaG = "0";
        ResultSet rsEx = null;
        if (sessionH.getAttribute("clUsrApp") == null) {
            out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
            out.println("Problema al registrar el movimiento, debe iniciar session");
            out.println("</body>");
            out.println("</html>");
        }
        if (sessionH.getAttribute("clUsrApp") != null) {
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }

        conciergeespectaculo.setDescripcion(request.getParameter("Descripcion").toString().trim());
        conciergeespectaculo.setFechaEvento(request.getParameter("FechaEvento").toString().trim());
        conciergeespectaculo.setDireccion(request.getParameter("Direccion").toString().trim());
        conciergeespectaculo.setCiudad(request.getParameter("Ciudad").toString().trim());
        conciergeespectaculo.setEstado(request.getParameter("Estado").toString().trim());
        conciergeespectaculo.setPais(request.getParameter("Pais").toString().trim());
        conciergeespectaculo.setTelefono(request.getParameter("Telefono").toString().trim());
        conciergeespectaculo.setCelular(request.getParameter("Celular").toString().trim());
        conciergeespectaculo.setCostoH(request.getParameter("CostoH").toString().trim());
        conciergeespectaculo.setHorasC(request.getParameter("HorasC").toString().trim());
        conciergeespectaculo.setCargoT(request.getParameter("CargoT").toString().trim());
        conciergeespectaculo.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergeespectaculo.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergeespectaculo.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergeespectaculo.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergeespectaculo.setExpira(request.getParameter("Expira").toString().trim());
        conciergeespectaculo.setSecC(request.getParameter("SecC").toString().trim());
        conciergeespectaculo.setPagoO(request.getParameter("PagoO").toString().trim());
        conciergeespectaculo.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergeespectaculo.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergeespectaculo.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergeespectaculo.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergeespectaculo.setComentarios(request.getParameter("Observaciones").toString().trim());
        conciergeespectaculo.setEstatus(request.getParameter("clEstatus").toString().trim());

        if (request.getParameter("clConcierge") != null) {
            clConcierge = request.getParameter("clConcierge").trim();
        }
        if (request.getParameter("FechaApAsist") != null) {
            FechaApAsist = request.getParameter("FechaApAsist").trim();
        }
        if (request.getParameter("clAsistencia") != null) {
            clAsistenciaG = request.getParameter("clAsistencia").trim();
        }
        response.setContentType("text/html");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>RegistraLlamadaConcierge</title>");
        out.println("</head>");
        out.println("<body>");
        try {
            StringBuffer strSQL = new StringBuffer();
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }
            if (Integer.parseInt(request.getParameter("Action")) == 1) {

                strSQL.append("st_CSAltaEspectaculo '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getDescripcion()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getFechaEvento()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getDireccion()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getCiudad()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getEstado()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getPais()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getTelefono()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getCelular()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getCostoH()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getHorasC()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getCargoT()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getNumeroTC()).append("','").append(conciergeespectaculo.getExpira()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getSecC()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getPagoO()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getPCancel()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getNuInf()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getEstatus()).append("'");
                System.out.println(strSQL.toString());
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                strSQL.delete(0, strSQL.length());
                if (rsEx.next()) {
                    clAsistencia = rsEx.getString("clAsistencia");
                }
                if (!clAsistencia.equalsIgnoreCase("0")) {
                    if (request.getParameter("URLBACK") != null) {
                        strUrlBack = request.getParameter("URLBACK");
                        strUrlBack = strUrlBack + "&clAsistencia=" + clAsistencia;
                        out.println("<script> window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                    }
                } else {
                    out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
                    out.println("Problema al registrar el movimiento,Consulte a su Administrador");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }
            }
            if (Integer.parseInt(request.getParameter("Action")) == 2) {
                strSQL.append("st_CSUpdateEspectaculo '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getDescripcion()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getFechaEvento()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getDireccion()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getCiudad()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getEstado()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getPais()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getTelefono()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getCelular()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getCostoH()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getHorasC()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getCargoT()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getNumeroTC()).append("','").append(conciergeespectaculo.getExpira()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getSecC()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getPagoO()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getPCancel()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getNuInf()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeespectaculo.getEstatus()).append("'");
                System.out.println(strSQL.toString());
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                strSQL.delete(0, strSQL.length());
                if (rsEx.next()) {
                    clAsistencia = rsEx.getString("clAsistencia");
                }
                if (!clAsistencia.equalsIgnoreCase("0")) {
                    if (request.getParameter("URLBACK") != null) {
                        strUrlBack = request.getParameter("URLBACK");
                        strUrlBack = strUrlBack + "&clAsistencia=" + clAsistencia;
                        out.println("<script> window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                    }
                } else {
                    out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
                    out.println("Problema al Actualizar el Registro,Consulte a su Administrador");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }
            }
            StrUsrApp = null;
            strSQL = null;
            clConcierge = null;
            FechaApAsist = null;
        } catch (Exception e) {
            out.close();
            e.printStackTrace();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;
                    conciergeespectaculo = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        out.println("</body>");
        out.println("</html>");
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
