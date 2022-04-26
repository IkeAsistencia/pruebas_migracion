/*
 * CSAltaBoletoCine.java
 *
 * Created on 21 de Febrero de 2007, 13:09 PM
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
import com.ike.concierge.to.ConciergeBoletosCine;

/*
 *
 * @author  zamoraed
 * @version
 */
public class CSAltaBoletoCine extends HttpServlet {

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
        ConciergeBoletosCine conciergeboletoscine = new ConciergeBoletosCine();
        PrintWriter out = response.getWriter();

        String StrUsrApp = "0";
        String clConcierge = "0";
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

        conciergeboletoscine.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergeboletoscine.setNumAdultos(request.getParameter("NumAdultos").toString().trim());
        conciergeboletoscine.setNumNinos(request.getParameter("Ninos").toString().trim());
        conciergeboletoscine.setEdades(request.getParameter("Edades").toString().trim());
        conciergeboletoscine.setPelicula(request.getParameter("Pelicula").toString().trim());
        conciergeboletoscine.setFechaIni(request.getParameter("FechaIni").toString().trim());
        conciergeboletoscine.setdsComplejo(request.getParameter("dsComplejo").toString().trim());
        conciergeboletoscine.setdsSala(request.getParameter("dsSala").toString().trim());
        conciergeboletoscine.setclReservaCompra(request.getParameter("clReservaCompra").toString().trim());
        conciergeboletoscine.setCargo(request.getParameter("Cargo").toString().trim());
        conciergeboletoscine.setclTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergeboletoscine.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergeboletoscine.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergeboletoscine.setNumTarjeta(request.getParameter("NumeroTC").toString().trim());
        conciergeboletoscine.setExpiraTarjeta(request.getParameter("Expira").toString().trim());
        conciergeboletoscine.setClaveTarjeta(request.getParameter("SecC").toString().trim());
        conciergeboletoscine.setCalleNum(request.getParameter("CalleNum").toString().trim());
        conciergeboletoscine.setCP(request.getParameter("CP").toString().trim());
        conciergeboletoscine.setColonia(request.getParameter("Colonia").toString().trim());
        conciergeboletoscine.setCodEnt(request.getParameter("CodEnt").toString().trim());
        conciergeboletoscine.setCodMD(request.getParameter("CodMD").toString().trim());
        conciergeboletoscine.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergeboletoscine.setNumConfimacion(request.getParameter("NumConfimacion").toString().trim());
        conciergeboletoscine.setCancelacion(request.getParameter("Cancelacion").toString().trim());
        conciergeboletoscine.setNUInfoK(request.getParameter("NUInfoK").toString().trim());
        conciergeboletoscine.setclEstatus(request.getParameter("clEstatus").toString().trim());

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

                strSQL.append("st_CSAltaBoletoCine '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNumAdultos()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNumNinos()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getEdades()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getPelicula()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getFechaIni()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getdsComplejo()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getdsSala()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getclReservaCompra()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getclTipoPago()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCargo()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNumTarjeta()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getExpiraTarjeta()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getClaveTarjeta()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCalleNum()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCP()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getColonia()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getclCiudad()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCodEnt()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCodMD()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNumConfimacion()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCancelacion()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNUInfoK()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getclEstatus()).append("'");
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
                strSQL.append("st_CSUpdateBoletoCine '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNumAdultos()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNumNinos()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getEdades()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getPelicula()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getFechaIni()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getdsComplejo()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getdsSala()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getclReservaCompra()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getclTipoPago()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCargo()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNumTarjeta()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getExpiraTarjeta()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getClaveTarjeta()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCalleNum()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCP()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getColonia()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCodEnt()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCodMD()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNumConfimacion()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getCancelacion()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getNUInfoK()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeboletoscine.getclEstatus()).append("'");

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
                    conciergeboletoscine = null;
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
