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
import com.ike.concierge.to.Conciergepickr;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaPickUpR extends HttpServlet {
    
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
        Conciergepickr conciergepickr = new Conciergepickr();
        PrintWriter out = response.getWriter();
        
        //cAfiliado
        String StrUsrApp = "0";
        String clPickUpO="";
        String FechaApAsist="";
        String StrclAsistencia="";
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
        
        /* if (sessionH.getAttribute("clAsistencia")!=null){
            StrclAsistencia = sessionH.getAttribute("clAsistencia").toString();
        }*/
        
        conciergepickr.setNadultos(request.getParameter("Nadultos").toString().trim());
        conciergepickr.setNinos(request.getParameter("Ninos").toString().trim());
        conciergepickr.setEdades(request.getParameter("Edades").toString().trim());
        conciergepickr.setVehiculo(request.getParameter("Vehiculo").toString().trim());
        conciergepickr.setEquipaje(request.getParameter("Equipaje").toString().trim());
        conciergepickr.setVuelo(request.getParameter("Vuelo").toString().trim());
        conciergepickr.setFecha(request.getParameter("Fecha").toString().trim());        
        conciergepickr.setHoraS(request.getParameter("HoraS").toString().trim());        
        conciergepickr.setDestino(request.getParameter("Destino").toString().trim());        
        conciergepickr.setCiudadS(request.getParameter("CiudadS").toString().trim());
        conciergepickr.setAeropuerto(request.getParameter("Aeropuerto").toString().trim());
        conciergepickr.setEncuentro(request.getParameter("Encuentro").toString().trim());
        conciergepickr.setHorario(request.getParameter("Horario").toString().trim());
        conciergepickr.setAdicionales(request.getParameter("Adicionales").toString().trim());
        conciergepickr.setCargoT(request.getParameter("CargoT").toString().trim());            
        conciergepickr.setDestino2(request.getParameter("Destino2").toString().trim());        
        conciergepickr.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergepickr.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergepickr.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergepickr.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergepickr.setComentarios(request.getParameter("Comentarios").toString().trim());
        //conciergepickr.setClAsistencia(sessionH.getAttribute("clAsistencia").toString().trim());
        
        if(request.getParameter("clPickUpO")!=null){
            clPickUpO = request.getParameter("clPickUpO").trim();
        }
        if(request.getParameter("FechaApAsist")!=null){
            FechaApAsist = request.getParameter("FechaApAsist").trim();
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
                
                strSQL.append("st_CSAltaPickUpR '").append(clPickUpO).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergepickr.getNadultos()).append("'");
                strSQL.append(",'").append(conciergepickr.getNinos()).append("'");
                strSQL.append(",'").append(conciergepickr.getEdades()).append("'");
                strSQL.append(",'").append(conciergepickr.getVehiculo()).append("'");
                strSQL.append(",'").append(conciergepickr.getEquipaje()).append("'");                
                strSQL.append(",'").append(conciergepickr.getVuelo()).append("'");
                strSQL.append(",'").append(conciergepickr.getFecha()).append("'");
                strSQL.append(",'").append(conciergepickr.getHoraS()).append("'");
                strSQL.append(",'").append(conciergepickr.getDestino()).append("'");
                strSQL.append(",'").append(conciergepickr.getCiudadS()).append("'");
                strSQL.append(",'").append(conciergepickr.getAeropuerto()).append("'");
                strSQL.append(",'").append(conciergepickr.getEncuentro()).append("'");                
                strSQL.append(",'").append(conciergepickr.getHorario()).append("'");      
                strSQL.append(",'").append(conciergepickr.getAdicionales()).append("'");                
                strSQL.append(",'").append(conciergepickr.getCargoT()).append("'");                                
                strSQL.append(",'").append(conciergepickr.getDestino2()).append("'");                
                strSQL.append(",'").append(conciergepickr.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergepickr.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergepickr.getPCancel()).append("'");
                strSQL.append(",'").append(conciergepickr.getNuInf()).append("'");
                strSQL.append(",'").append(conciergepickr.getComentarios()).append("'");
                
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                System.out.println(strSQL);
                strSQL.delete(0,strSQL.length());
                if (rsEx.next()) {
                    clPickUpO=rsEx.getString("clPickUpO");
                }
                if (!clPickUpO.equalsIgnoreCase("0")){
                    if(request.getParameter("URLBACK")!=null){
                        strUrlBack = request.getParameter("URLBACK");
                        strUrlBack=strUrlBack + "&clPickUpO=" + clPickUpO ;
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
                strSQL.append("st_CSUpdatePickUpR '").append(clPickUpO).append("'");
                strSQL.append(",'").append(conciergepickr.getNadultos()).append("'");
                strSQL.append(",'").append(conciergepickr.getNinos()).append("'");
                strSQL.append(",'").append(conciergepickr.getEdades()).append("'");
                strSQL.append(",'").append(conciergepickr.getVehiculo()).append("'");
                strSQL.append(",'").append(conciergepickr.getEquipaje()).append("'");                
                strSQL.append(",'").append(conciergepickr.getVuelo()).append("'");
                strSQL.append(",'").append(conciergepickr.getFecha()).append("'");
                strSQL.append(",'").append(conciergepickr.getHoraS()).append("'");
                strSQL.append(",'").append(conciergepickr.getDestino()).append("'");
                strSQL.append(",'").append(conciergepickr.getCiudadS()).append("'");
                strSQL.append(",'").append(conciergepickr.getAeropuerto()).append("'");
                strSQL.append(",'").append(conciergepickr.getEncuentro()).append("'");  
                strSQL.append(",'").append(conciergepickr.getHorario()).append("'");      
                strSQL.append(",'").append(conciergepickr.getAdicionales()).append("'");                
                strSQL.append(",'").append(conciergepickr.getCargoT()).append("'");                                
                strSQL.append(",'").append(conciergepickr.getDestino2()).append("'");                
                strSQL.append(",'").append(conciergepickr.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergepickr.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergepickr.getPCancel()).append("'");
                strSQL.append(",'").append(conciergepickr.getNuInf()).append("'");
                strSQL.append(",'").append(conciergepickr.getComentarios()).append("'");
               // strSQL.append(",'").append(conciergepickr.getClAsistencia()).append("'");
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                System.out.println(strSQL);
                strSQL.delete(0,strSQL.length());
                if (rsEx.next()) {
                    clPickUpO=rsEx.getString("clPickUpO");
                }
                if (!clPickUpO.equalsIgnoreCase("0")){
                    if(request.getParameter("URLBACK")!=null){
                        strUrlBack = request.getParameter("URLBACK");
                        strUrlBack=strUrlBack + "&clPickUpO=" + clPickUpO ;
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
            clPickUpO=null;
            FechaApAsist=null;
        } catch(Exception e){
            out.close();
            e.printStackTrace();
        } finally {
            try{
                if (rsEx!=null) {
                    rsEx.close();
                    rsEx=null;
                    conciergepickr=null;
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