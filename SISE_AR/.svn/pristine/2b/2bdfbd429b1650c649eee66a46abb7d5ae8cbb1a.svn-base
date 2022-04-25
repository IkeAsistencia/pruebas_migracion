/*
 * CSAltaRentaCasaDepto.java
 *
 * Created on 27 de febrero de 2007, 12:43 PM
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
import com.ike.concierge.to.ConciergeRentaCasaDepto;

/*
 *
 * @author  zamoraed
 * @version
 */
public class CSAltaRentaCasaDepto extends HttpServlet {
    
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
        ConciergeRentaCasaDepto conciergerentacasadepto = new ConciergeRentaCasaDepto();
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
        conciergerentacasadepto.setclEstatus(request.getParameter("clEstatus"));        
        conciergerentacasadepto.setComentarios(request.getParameter("Comentarios"));
        conciergerentacasadepto.setNumAdultos(request.getParameter("NumAdultos"));
        conciergerentacasadepto.setNinos(request.getParameter("Ninos"));
        conciergerentacasadepto.setEdades(request.getParameter("Edades"));
        conciergerentacasadepto.setTipoInmueble(request.getParameter("TipoInmueble"));
        conciergerentacasadepto.setFechaI(request.getParameter("FechaI"));
        conciergerentacasadepto.setFecha0(request.getParameter("Fecha0"));
        conciergerentacasadepto.setServicios(request.getParameter("Servicios"));
        conciergerentacasadepto.setCiudad(request.getParameter("Ciudad"));
        conciergerentacasadepto.setEstado(request.getParameter("Estado"));
        conciergerentacasadepto.setPais(request.getParameter("Pais"));
        conciergerentacasadepto.setCostoxDia(request.getParameter("CostoxDia"));
        conciergerentacasadepto.setOtrosCargos(request.getParameter("OtrosCargos"));
        conciergerentacasadepto.setCargoTotal(request.getParameter("CargoTotal"));
        conciergerentacasadepto.setLEntregaLlaves(request.getParameter("LEntregaLlaves"));
        conciergerentacasadepto.setEntregaLlaves(request.getParameter("EntregaLlaves"));
        conciergerentacasadepto.setclFormaPago(request.getParameter("clTipoPago"));
        conciergerentacasadepto.setNomBanco(request.getParameter("NomBanco"));
        conciergerentacasadepto.setNombreTC(request.getParameter("NombreTC"));
        conciergerentacasadepto.setNumeroTC(request.getParameter("NumeroTC"));
        conciergerentacasadepto.setExpira(request.getParameter("Expira"));
        conciergerentacasadepto.setSecC(request.getParameter("SecC"));
        conciergerentacasadepto.setConfirmo(request.getParameter("Confirmo"));
        conciergerentacasadepto.setNumConfirmacion(request.getParameter("NumConfirmacion"));
        conciergerentacasadepto.setCancelacion(request.getParameter("Cancelacion"));
        conciergerentacasadepto.setNUInfo(request.getParameter("NUInfo"));

            
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
                
                strSQL.append("st_CSAltaRentaCasaDepto '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getComentarios()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNumAdultos()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNinos()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getEdades()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getTipoInmueble()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getFechaI()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getFecha0()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getServicios()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getCiudad()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getEstado()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getPais()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getCostoxDia()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getOtrosCargos()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getCargoTotal()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getLEntregaLlaves()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getEntregaLlaves()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getclFormaPago()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNumeroTC()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getExpira()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getSecC()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNumConfirmacion()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getCancelacion()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNUInfo()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getclEstatus()).append("'");
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
                strSQL.append("st_CSUpdateRentaCasaDepto '").append(clAsistenciaG).append("'"); 
                strSQL.append(",'").append(conciergerentacasadepto.getComentarios()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNumAdultos()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNinos()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getEdades()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getTipoInmueble()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getFechaI()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getFecha0()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getServicios()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getCiudad()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getEstado()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getPais()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getCostoxDia()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getOtrosCargos()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getCargoTotal()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getLEntregaLlaves()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getEntregaLlaves()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getclFormaPago()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNumeroTC()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getExpira()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getSecC()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNumConfirmacion()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getCancelacion()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getNUInfo()).append("'");
                strSQL.append(",'").append(conciergerentacasadepto.getclEstatus()).append("'");
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
                    conciergerentacasadepto=null;
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