/*
 * CSAltaAvionRoundTrip.java
 *
 * Created on 16 de marzo de 2007, 05:38 PM
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
import com.ike.concierge.to.ConciergeAvionRoundTrip;

/*
 *
 * @author  zamoraed
 * @version
 */
public class CSAltaAvionRoundTrip extends HttpServlet {
    
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
        ConciergeAvionRoundTrip conciergeavionroundtrip = new ConciergeAvionRoundTrip();
        PrintWriter out = response.getWriter();
              
        String StrUsrApp = "0";
        String clConcierge="0";
        String FechaApAsist="";
        String clAsistencia="0";
        String clAsistenciaG="0";
        ResultSet rsEx = null;
        if (sessionH.getAttribute("clUsrApp")==null){
            out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
            out.println("Problema al registrar el movimiento, debe iniciar session");
            out.println("</body>");
            out.println("</html>");
        }
        if (sessionH.getAttribute("clUsrApp")!=null){
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }
        conciergeavionroundtrip.setclEstatus(request.getParameter("clEstatus"));
        conciergeavionroundtrip.setclAvionRoundTrip(request.getParameter("clAvionRoundTrip"));
        conciergeavionroundtrip.setclAsistencia(request.getParameter("clAsistencia"));
        conciergeavionroundtrip.setComentarios(request.getParameter("Comentarios"));
        conciergeavionroundtrip.setNumAdultos(request.getParameter("NumAdultos"));
        conciergeavionroundtrip.setNumNinos(request.getParameter("NumNinos"));
        conciergeavionroundtrip.setEdades(request.getParameter("Edades"));
        conciergeavionroundtrip.setInfoVuelo(request.getParameter("InfoVuelo"));
        conciergeavionroundtrip.setclAvionRoundTrip(request.getParameter("clAvionRoundTrip"));
        conciergeavionroundtrip.setCargo(request.getParameter("Cargo"));
        conciergeavionroundtrip.setCdOrigen(request.getParameter("CdOrigen"));
        conciergeavionroundtrip.setCdDestino(request.getParameter("CdDestino"));
        conciergeavionroundtrip.setAptOrigen(request.getParameter("AptOrigen"));
        conciergeavionroundtrip.setAptDestino(request.getParameter("AptDestino"));
        conciergeavionroundtrip.setFechaSalida(request.getParameter("FechaSalida"));
        conciergeavionroundtrip.setFechaArribo(request.getParameter("FechaArribo"));
        conciergeavionroundtrip.setConexiones(request.getParameter("Conexiones"));
        conciergeavionroundtrip.setClase(request.getParameter("Clase"));
        conciergeavionroundtrip.setTiempoLimite(request.getParameter("TiempoLimite"));
        conciergeavionroundtrip.setclFormaPago(request.getParameter("clTipoPago"));
        conciergeavionroundtrip.setNomBanco(request.getParameter("NomBanco"));
        conciergeavionroundtrip.setNombreTC(request.getParameter("NombreTC"));
        conciergeavionroundtrip.setNumeroTC(request.getParameter("NumeroTC"));
        conciergeavionroundtrip.setExpira(request.getParameter("Expira"));
        conciergeavionroundtrip.setSecC(request.getParameter("SecC"));
        conciergeavionroundtrip.setConfirmo(request.getParameter("Confirmo"));
        conciergeavionroundtrip.setNumConfirmacion(request.getParameter("NumConfirmacion"));
        conciergeavionroundtrip.setCancelacion(request.getParameter("Cancelacion"));
        conciergeavionroundtrip.setNUInfo(request.getParameter("NUInfo"));
        conciergeavionroundtrip.setLugarPagar(request.getParameter("LugarPagar"));
        conciergeavionroundtrip.setCveReservacion(request.getParameter("CveReservacion"));
        conciergeavionroundtrip.setMetEntrega(request.getParameter("MetEntrega"));
            
        if(request.getParameter("clConcierge")!=null){
            clConcierge = request.getParameter("clConcierge").trim();
        }
        if(request.getParameter("FechaApAsist")!=null){
            FechaApAsist = request.getParameter("FechaApAsist").trim();
        }
                if(request.getParameter("clAsistencia")!=null){
            clAsistenciaG = request.getParameter("clAsistencia").trim();
        }
        response.setContentType("text/html");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>RegistraLlamadaConcierge</title>");
        out.println("</head>");
        out.println("<body>");
        try{
            StringBuffer strSQL = new StringBuffer();
            String strUrlBack="";
            if(request.getParameter("URLBACK")!=null) {
                strUrlBack = request.getParameter("URLBACK");
            }
            if (Integer.parseInt(request.getParameter("Action"))==1){
                
                strSQL.append("st_CSAltaAvionRoundTrip '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getclEstatus()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getclAsistencia()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNumAdultos()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNumNinos()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getEdades()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getInfoVuelo()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getCargo()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getCdOrigen()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getCdDestino()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getAptOrigen()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getAptDestino()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getFechaSalida()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getFechaArribo()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getConexiones()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getClase()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getTiempoLimite()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getclFormaPago()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNumeroTC()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getExpira()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getSecC()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNumConfirmacion()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getCancelacion()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNUInfo()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getLugarPagar()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getCveReservacion()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getMetEntrega()).append("'");

                System.out.println(strSQL.toString());
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                strSQL.delete(0,strSQL.length());
                if (rsEx.next()) {
                    clAsistencia=rsEx.getString("clAsistencia");
                }
                if (!clAsistencia.equalsIgnoreCase("0")){
                    if(request.getParameter("URLBACK")!=null){
                        strUrlBack = request.getParameter("URLBACK");
                        strUrlBack=strUrlBack + "&clAsistencia=" + clAsistencia ;
                        out.println("<script> window.opener.fnValidaResponse(1,'"+ strUrlBack  +"')</script>");
                    }
                }else {
                    out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
                    out.println("Problema al registrar el movimiento,Consulte a su Administrador");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }
            }
            if (Integer.parseInt(request.getParameter("Action"))==2){
                strSQL.append("st_CSUpdateAvionRoundTrip '").append(clAsistenciaG).append("'");               
                strSQL.append(",'").append(conciergeavionroundtrip.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNumAdultos()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNumNinos()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getEdades()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getInfoVuelo()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getclAvionRoundTrip()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getCargo()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getCdOrigen()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getCdDestino()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getAptOrigen()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getAptDestino()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getFechaSalida()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getFechaArribo()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getConexiones()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getClase()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getTiempoLimite()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getclFormaPago()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNumeroTC()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getExpira()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getSecC()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNumConfirmacion()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getCancelacion()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getNUInfo()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getLugarPagar()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getCveReservacion()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getMetEntrega()).append("'");
                strSQL.append(",'").append(conciergeavionroundtrip.getclEstatus()).append("'");

                System.out.println(strSQL.toString());
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                strSQL.delete(0,strSQL.length());
                    if (rsEx.next()) {
                    clAsistencia=rsEx.getString("clAsistencia");
                }
                if (!clAsistencia.equalsIgnoreCase("0")){
                    if(request.getParameter("URLBACK")!=null){
                        strUrlBack = request.getParameter("URLBACK");
                        strUrlBack=strUrlBack + "&clAsistencia=" + clAsistencia ;
                        out.println("<script> window.opener.fnValidaResponse(1,'"+ strUrlBack  +"')</script>");
                    }
                }else {
                    out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
                    out.println("Problema al Actualizar el Registro,Consulte a su Administrador");
                    out.println("</body>");
                    out.println("</html>");
                    out.close();
                    return;
                }
            }
            StrUsrApp = null;
            strSQL=null;
            clConcierge=null;
            FechaApAsist=null;
        } catch(Exception e){
            out.close();
            e.printStackTrace();
        } finally {
            try{
                if (rsEx!=null) {
                    rsEx.close();
                    rsEx=null;
                    conciergeavionroundtrip=null;
                }
            } catch(Exception ee) {
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