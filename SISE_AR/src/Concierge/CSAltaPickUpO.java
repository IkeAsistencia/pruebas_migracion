/*
 * CSAltaLocalidadesB.java
 *
 * Created on 22 de Febrero de 2007, 13:09 PM
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
import com.ike.concierge.to.Conciergepicko;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaPickUpO extends HttpServlet {
    
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
        Conciergepicko conciergepicko = new Conciergepicko();
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
        
        conciergepicko.setNadultos(request.getParameter("Nadultos").toString().trim());
        conciergepicko.setNinos(request.getParameter("Ninos").toString().trim());
        conciergepicko.setEdades(request.getParameter("Edades").toString().trim());
        conciergepicko.setVehiculo(request.getParameter("Vehiculo").toString().trim());
        conciergepicko.setEquipaje(request.getParameter("Equipaje").toString().trim());
        conciergepicko.setVuelo(request.getParameter("Vuelo").toString().trim());
        conciergepicko.setFecha(request.getParameter("Fecha").toString().trim());        
        conciergepicko.setFechaA(request.getParameter("FechaA").toString().trim());        
        conciergepicko.setOrigen(request.getParameter("Origen").toString().trim());
        conciergepicko.setCiudadA(request.getParameter("CiudadA").toString().trim());
        conciergepicko.setAeropuerto(request.getParameter("Aeropuerto").toString().trim());
        conciergepicko.setEncuentro(request.getParameter("Encuentro").toString().trim());
        conciergepicko.setCargoT(request.getParameter("CargoT").toString().trim());                
        conciergepicko.setAdicionales(request.getParameter("Adicionales").toString().trim());
        conciergepicko.setServAds(request.getParameter("ServAds").toString().trim());
        conciergepicko.setDestino(request.getParameter("Destino").toString().trim());        
        conciergepicko.setHotel(request.getParameter("Hotel").toString().trim());
        conciergepicko.setFechaI(request.getParameter("FechaI").toString().trim());                
        conciergepicko.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergepicko.setFechaO(request.getParameter("FechaO").toString().trim());                
        conciergepicko.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergepicko.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergepicko.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergepicko.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergepicko.setExpira2(request.getParameter("Expira").toString().trim());
        conciergepicko.setSecC(request.getParameter("SecC").toString().trim());
        conciergepicko.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergepicko.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergepicko.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergepicko.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergepicko.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergepicko.setEstatus(request.getParameter("clEstatus").toString().trim());
        
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
                
                strSQL.append("st_CSAltaPickUpO '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergepicko.getNadultos()).append("'");
                strSQL.append(",'").append(conciergepicko.getNinos()).append("'");
                strSQL.append(",'").append(conciergepicko.getEdades()).append("'");
                strSQL.append(",'").append(conciergepicko.getVehiculo()).append("'");
                strSQL.append(",'").append(conciergepicko.getEquipaje()).append("'");                
                strSQL.append(",'").append(conciergepicko.getVuelo()).append("'");
                strSQL.append(",'").append(conciergepicko.getFecha()).append("'");
                strSQL.append(",'").append(conciergepicko.getFechaA()).append("'");
                strSQL.append(",'").append(conciergepicko.getOrigen()).append("'");
                strSQL.append(",'").append(conciergepicko.getCiudadA()).append("'");
                strSQL.append(",'").append(conciergepicko.getAeropuerto()).append("'");
                strSQL.append(",'").append(conciergepicko.getEncuentro()).append("'");                
                strSQL.append(",'").append(conciergepicko.getCargoT()).append("'");                                
                strSQL.append(",'").append(conciergepicko.getAdicionales()).append("'");
                strSQL.append(",'").append(conciergepicko.getServAds()).append("'");
                strSQL.append(",'").append(conciergepicko.getDestino()).append("'");
                strSQL.append(",'").append(conciergepicko.getHotel()).append("'");
                strSQL.append(",'").append(conciergepicko.getFechaI()).append("'");  
                strSQL.append(",'").append(conciergepicko.getReservacion()).append("'");                                
                strSQL.append(",'").append(conciergepicko.getFechaO()).append("'");                  
                strSQL.append(",'").append(conciergepicko.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergepicko.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergepicko.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergepicko.getNumeroTC()).append("','");
                strSQL.append(conciergepicko.getExpira2()).append("'");
                strSQL.append(",'").append(conciergepicko.getSecC()).append("'");
                strSQL.append(",'").append(conciergepicko.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergepicko.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergepicko.getPCancel()).append("'");
                strSQL.append(",'").append(conciergepicko.getNuInf()).append("'");
                strSQL.append(",'").append(conciergepicko.getComentarios()).append("'");
                strSQL.append(",'").append(conciergepicko.getEstatus()).append("'");
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                System.out.println(strSQL);
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
                strSQL.append("st_CSUpdatePickUpO '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergepicko.getNadultos()).append("'");
                strSQL.append(",'").append(conciergepicko.getNinos()).append("'");
                strSQL.append(",'").append(conciergepicko.getEdades()).append("'");
                strSQL.append(",'").append(conciergepicko.getVehiculo()).append("'");
                strSQL.append(",'").append(conciergepicko.getEquipaje()).append("'");                
                strSQL.append(",'").append(conciergepicko.getVuelo()).append("'");
                strSQL.append(",'").append(conciergepicko.getFecha()).append("'");
                strSQL.append(",'").append(conciergepicko.getFechaA()).append("'");
                strSQL.append(",'").append(conciergepicko.getOrigen()).append("'");
                strSQL.append(",'").append(conciergepicko.getCiudadA()).append("'");
                strSQL.append(",'").append(conciergepicko.getAeropuerto()).append("'");
                strSQL.append(",'").append(conciergepicko.getEncuentro()).append("'");                
                strSQL.append(",'").append(conciergepicko.getCargoT()).append("'");                                
                strSQL.append(",'").append(conciergepicko.getAdicionales()).append("'");
                strSQL.append(",'").append(conciergepicko.getServAds()).append("'");
                strSQL.append(",'").append(conciergepicko.getDestino()).append("'");
                strSQL.append(",'").append(conciergepicko.getHotel()).append("'");
                strSQL.append(",'").append(conciergepicko.getFechaI()).append("'");  
                strSQL.append(",'").append(conciergepicko.getReservacion()).append("'");                                
                strSQL.append(",'").append(conciergepicko.getFechaO()).append("'");                  
                strSQL.append(",'").append(conciergepicko.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergepicko.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergepicko.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergepicko.getNumeroTC()).append("','");
                strSQL.append(conciergepicko.getExpira2()).append("'");
                strSQL.append(",'").append(conciergepicko.getSecC()).append("'");
                strSQL.append(",'").append(conciergepicko.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergepicko.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergepicko.getPCancel()).append("'");
                strSQL.append(",'").append(conciergepicko.getNuInf()).append("'");
                strSQL.append(",'").append(conciergepicko.getComentarios()).append("'");
                strSQL.append(",'").append(conciergepicko.getEstatus()).append("'");
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
                    conciergepicko=null;
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