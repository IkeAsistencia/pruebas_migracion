/*
 * CSAltaTour.java
 *
 * Created on 09 de Marzo de 2007, 10:05 PM
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
import com.ike.concierge.to.Conciergetransp;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaTransportacion extends HttpServlet {
    
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
        Conciergetransp conciergetransp = new Conciergetransp();
        PrintWriter out = response.getWriter();
        
        //cAfiliado
        String StrUsrApp = "0";
        String clConcierge="";
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
        conciergetransp.setNadultos(request.getParameter("Nadultos").toString().trim());
        conciergetransp.setNinos(request.getParameter("Ninos").toString().trim());
        conciergetransp.setEdades(request.getParameter("Edades").toString().trim());
        conciergetransp.setVehiculo(request.getParameter("Vehiculo").toString().trim());        
        conciergetransp.setEquipaje(request.getParameter("Equipaje").toString().trim());
        conciergetransp.setFechaC(request.getParameter("FechaC").toString().trim());
        conciergetransp.setOrigen(request.getParameter("Origen").toString().trim());
        conciergetransp.setDestino(request.getParameter("Destino").toString().trim());
        conciergetransp.setCostoH(request.getParameter("CostoH").toString().trim());
        conciergetransp.setHorasC(request.getParameter("HorasC").toString().trim());
        conciergetransp.setOtrosC(request.getParameter("OtrosC").toString().trim());
        conciergetransp.setEncuentro(request.getParameter("Encuentro").toString().trim());        
        conciergetransp.setCargoT(request.getParameter("CargoT").toString().trim());
        conciergetransp.setHotel(request.getParameter("Hotel").toString().trim());
        conciergetransp.setFechaI(request.getParameter("FechaI").toString().trim());
        conciergetransp.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergetransp.setFechaO(request.getParameter("FechaO").toString().trim());
        conciergetransp.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergetransp.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergetransp.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergetransp.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergetransp.setExpira2(request.getParameter("Expira").toString().trim());
        conciergetransp.setSecC(request.getParameter("SecC").toString().trim());
        conciergetransp.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergetransp.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergetransp.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergetransp.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergetransp.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergetransp.setEstatus(request.getParameter("clEstatus").toString().trim());
        
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
                
                strSQL.append("st_CSAltaTransportacion '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergetransp.getNadultos()).append("'");
                strSQL.append(",'").append(conciergetransp.getNinos()).append("'");
                strSQL.append(",'").append(conciergetransp.getEdades()).append("'");
                strSQL.append(",'").append(conciergetransp.getVehiculo()).append("'");                
                strSQL.append(",'").append(conciergetransp.getEquipaje()).append("'");
                strSQL.append(",'").append(conciergetransp.getFechaC()).append("'");
                strSQL.append(",'").append(conciergetransp.getOrigen()).append("'");
                strSQL.append(",'").append(conciergetransp.getDestino()).append("'");
                strSQL.append(",'").append(conciergetransp.getCostoH()).append("'");
                strSQL.append(",'").append(conciergetransp.getHorasC()).append("'");
                strSQL.append(",'").append(conciergetransp.getOtrosC()).append("'");
                strSQL.append(",'").append(conciergetransp.getEncuentro()).append("'");                
                strSQL.append(",'").append(conciergetransp.getCargoT()).append("'");
                strSQL.append(",'").append(conciergetransp.getHotel()).append("'");
                strSQL.append(",'").append(conciergetransp.getFechaI()).append("'");
                strSQL.append(",'").append(conciergetransp.getReservacion()).append("'");
                strSQL.append(",'").append(conciergetransp.getFechaO()).append("'");
                strSQL.append(",'").append(conciergetransp.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergetransp.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergetransp.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergetransp.getNumeroTC()).append("','");
                strSQL.append(conciergetransp.getExpira2()).append("'");
                strSQL.append(",'").append(conciergetransp.getSecC()).append("'");
                strSQL.append(",'").append(conciergetransp.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergetransp.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergetransp.getPCancel()).append("'");
                strSQL.append(",'").append(conciergetransp.getNuInf()).append("'");
                strSQL.append(",'").append(conciergetransp.getComentarios()).append("'");
                strSQL.append(",'").append(conciergetransp.getEstatus()).append("'");
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
                strSQL.append("st_CSUpdateTransportacion '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergetransp.getNadultos()).append("'");
                strSQL.append(",'").append(conciergetransp.getNinos()).append("'");
                strSQL.append(",'").append(conciergetransp.getEdades()).append("'");
                strSQL.append(",'").append(conciergetransp.getVehiculo()).append("'");                
                strSQL.append(",'").append(conciergetransp.getEquipaje()).append("'");
                strSQL.append(",'").append(conciergetransp.getFechaC()).append("'");
                strSQL.append(",'").append(conciergetransp.getOrigen()).append("'");
                strSQL.append(",'").append(conciergetransp.getDestino()).append("'");
                strSQL.append(",'").append(conciergetransp.getCostoH()).append("'");
                strSQL.append(",'").append(conciergetransp.getHorasC()).append("'");
                strSQL.append(",'").append(conciergetransp.getOtrosC()).append("'");
                strSQL.append(",'").append(conciergetransp.getEncuentro()).append("'");                
                strSQL.append(",'").append(conciergetransp.getCargoT()).append("'");
                strSQL.append(",'").append(conciergetransp.getHotel()).append("'");
                strSQL.append(",'").append(conciergetransp.getFechaI()).append("'");
                strSQL.append(",'").append(conciergetransp.getReservacion()).append("'");
                strSQL.append(",'").append(conciergetransp.getFechaO()).append("'");
                strSQL.append(",'").append(conciergetransp.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergetransp.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergetransp.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergetransp.getNumeroTC()).append("','");
                strSQL.append(conciergetransp.getExpira2()).append("'");
                strSQL.append(",'").append(conciergetransp.getSecC()).append("'");
                strSQL.append(",'").append(conciergetransp.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergetransp.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergetransp.getPCancel()).append("'");
                strSQL.append(",'").append(conciergetransp.getNuInf()).append("'");
                strSQL.append(",'").append(conciergetransp.getComentarios()).append("'");
                strSQL.append(",'").append(conciergetransp.getEstatus()).append("'");
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
                    conciergetransp=null;
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