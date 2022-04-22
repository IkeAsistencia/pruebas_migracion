/*
 * CSAltaHospedaje.java
 *
 * Created on 05 de Marzo de 2007, 16:42 PM
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
import com.ike.concierge.to.Conciergehospedaje;

/**
 *
 * @author perezern
 * @version
 */
public class CSAltaHospedaje extends HttpServlet {

    /**
     * Initializes the servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    /**
     * Destroys the servlet.
     */
    public void destroy() {
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        Conciergehospedaje HOSP = new Conciergehospedaje();
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
            out.println("Problema al registrar el movimiento, debe iniciar sesion");
            out.println("</body>");
            out.println("</html>");
        }

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }

        HOSP.setFechaE(request.getParameter("FechaE").toString().trim());
        HOSP.setFechaS(request.getParameter("FechaS").toString().trim());
        HOSP.setNombre(request.getParameter("Nombre").toString().trim());
        HOSP.setHotel(request.getParameter("Hotel").toString().trim());
        HOSP.setIncluye(request.getParameter("Incluye").toString().trim());
        HOSP.setHabitaciones(request.getParameter("Habitaciones").toString().trim());
        HOSP.setTipoHab(request.getParameter("TipoHab").toString().trim());
        HOSP.setCostoN(request.getParameter("CostoN").toString().trim());
        HOSP.setCargoT(request.getParameter("CargoT").toString().trim());
        HOSP.setAdicionales(request.getParameter("Adicionales").toString().trim());
        HOSP.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        HOSP.setNomBanco(request.getParameter("NomBanco").toString().trim());
        HOSP.setNombreTC(request.getParameter("NombreTC").toString().trim());
        HOSP.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        HOSP.setExpira2(request.getParameter("Expira").toString().trim());
        HOSP.setSecC(request.getParameter("SecC").toString().trim());
        HOSP.setConfirmo(request.getParameter("Confirmo").toString().trim());
        HOSP.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        HOSP.setPCancel(request.getParameter("PCancel").toString().trim());
        HOSP.setNuInf(request.getParameter("NuInf").toString().trim());
        HOSP.setComentarios(request.getParameter("Comentarios").toString().trim());
        HOSP.setEstatus(request.getParameter("clEstatus").toString().trim());
        //HOSP.setTipoCama(request.getParameter("TipoCama").toString().trim());
        //HOSP.setCategoriaHotel(request.getParameter("CategoriaHotel").toString().trim());

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

                strSQL.append("st_CSAltaHospedaje '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(HOSP.getFechaE()).append("'");
                strSQL.append(",'").append(HOSP.getFechaS()).append("'");
                strSQL.append(",'").append(HOSP.getNombre()).append("'");
                strSQL.append(",'").append(HOSP.getHotel()).append("'");
                strSQL.append(",'").append(HOSP.getIncluye()).append("'");
                //strSQL.append(",'").append(HOSP.getEdades()).append("'");
                strSQL.append(",'").append(HOSP.getHabitaciones()).append("'");
                strSQL.append(",'").append(HOSP.getTipoHab()).append("'");
                strSQL.append(",'").append(HOSP.getCostoN()).append("'");
                strSQL.append(",'").append(HOSP.getCargoT()).append("'");
                strSQL.append(",'").append(HOSP.getAdicionales()).append("'");
                strSQL.append(",'").append(HOSP.getClTipoPago()).append("'");
                strSQL.append(",'").append(HOSP.getNomBanco()).append("'");
                strSQL.append(",'").append(HOSP.getNombreTC()).append("'");
                strSQL.append(",'").append(HOSP.getNumeroTC()).append("','");
                strSQL.append(HOSP.getExpira2()).append("'");
                strSQL.append(",'").append(HOSP.getSecC()).append("'");
                strSQL.append(",'").append(HOSP.getConfirmo()).append("'");
                strSQL.append(",'").append(HOSP.getNConfirmo()).append("'");
                strSQL.append(",'").append(HOSP.getPCancel()).append("'");
                strSQL.append(",'").append(HOSP.getNuInf()).append("'");
                strSQL.append(",'").append(HOSP.getComentarios()).append("'");
                strSQL.append(",'").append(HOSP.getEstatus()).append("'");
                /*strSQL.append(",'").append(HOSP.getTipoCama()).append("'");
                strSQL.append(",'").append(HOSP.getCategoriaHotel()).append("'");*/

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
                strSQL.append("st_CSUpdateHospedaje '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(HOSP.getFechaE()).append("'");
                strSQL.append(",'").append(HOSP.getFechaS()).append("'");
                strSQL.append(",'").append(HOSP.getNombre()).append("'");
                strSQL.append(",'").append(HOSP.getHotel()).append("'");
                strSQL.append(",'").append(HOSP.getIncluye()).append("'");
                //strSQL.append(",'").append(HOSP.getEdades()).append("'");
                strSQL.append(",'").append(HOSP.getHabitaciones()).append("'");
                strSQL.append(",'").append(HOSP.getTipoHab()).append("'");
                strSQL.append(",'").append(HOSP.getCostoN()).append("'");
                strSQL.append(",'").append(HOSP.getCargoT()).append("'");
                strSQL.append(",'").append(HOSP.getAdicionales()).append("'");
                strSQL.append(",'").append(HOSP.getClTipoPago()).append("'");
                strSQL.append(",'").append(HOSP.getNomBanco()).append("'");
                strSQL.append(",'").append(HOSP.getNombreTC()).append("'");
                strSQL.append(",'").append(HOSP.getNumeroTC()).append("','");
                strSQL.append(HOSP.getExpira2()).append("'");
                strSQL.append(",'").append(HOSP.getSecC()).append("'");
                strSQL.append(",'").append(HOSP.getConfirmo()).append("'");
                strSQL.append(",'").append(HOSP.getNConfirmo()).append("'");
                strSQL.append(",'").append(HOSP.getPCancel()).append("'");
                strSQL.append(",'").append(HOSP.getNuInf()).append("'");
                strSQL.append(",'").append(HOSP.getComentarios()).append("'");
                strSQL.append(",'").append(HOSP.getEstatus()).append("'");
                /*strSQL.append(",'").append(HOSP.getTipoCama()).append("'");
                strSQL.append(",'").append(HOSP.getCategoriaHotel()).append("'");*/

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
                    HOSP = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        out.println("</body>");
        out.println("</html>");
        out.close();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
}
