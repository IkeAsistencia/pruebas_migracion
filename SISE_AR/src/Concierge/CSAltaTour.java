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
import com.ike.concierge.to.Conciergetour;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaTour extends HttpServlet {
    
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
        Conciergetour conciergetour = new Conciergetour();
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
        
        conciergetour.setNadultos(request.getParameter("Nadultos").toString().trim());
        conciergetour.setNinos(request.getParameter("Ninos").toString().trim());
        conciergetour.setEdades(request.getParameter("Edades").toString().trim());
        conciergetour.setTour(request.getParameter("Tour").toString().trim());
        conciergetour.setVehiculo(request.getParameter("Vehiculo").toString().trim());
        conciergetour.setCiudad(request.getParameter("Ciudad").toString().trim());
        conciergetour.setEstado(request.getParameter("Estado").toString().trim());
        conciergetour.setPais(request.getParameter("Pais").toString().trim());
        conciergetour.setFechaIn(request.getParameter("FechaIn").toString().trim());
        conciergetour.setFechaFi(request.getParameter("FechaFi").toString().trim());
        conciergetour.setCostoH(request.getParameter("CostoH").toString().trim());
        conciergetour.setHorasC(request.getParameter("HorasC").toString().trim());
        conciergetour.setCostoP(request.getParameter("CostoP").toString().trim());
        conciergetour.setOtrosC(request.getParameter("OtrosC").toString().trim());
        conciergetour.setCargoT(request.getParameter("CargoT").toString().trim());
        conciergetour.setEncuentro(request.getParameter("Encuentro").toString().trim());
        conciergetour.setHorario(request.getParameter("Horario").toString().trim());
        conciergetour.setHotel(request.getParameter("Hotel").toString().trim());
        conciergetour.setFechaI(request.getParameter("FechaI").toString().trim());
        conciergetour.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergetour.setFechaO(request.getParameter("FechaO").toString().trim());
        conciergetour.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergetour.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergetour.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergetour.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergetour.setExpira2(request.getParameter("Expira").toString().trim());
        conciergetour.setSecC(request.getParameter("SecC").toString().trim());
        conciergetour.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergetour.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergetour.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergetour.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergetour.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergetour.setEstatus(request.getParameter("clEstatus").toString().trim());
        
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
                
                strSQL.append("st_CSAltaTour '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergetour.getNadultos()).append("'");
                strSQL.append(",'").append(conciergetour.getNinos()).append("'");
                strSQL.append(",'").append(conciergetour.getEdades()).append("'");
                strSQL.append(",'").append(conciergetour.getTour()).append("'");
                strSQL.append(",'").append(conciergetour.getVehiculo()).append("'");
                strSQL.append(",'").append(conciergetour.getCiudad()).append("'");
                strSQL.append(",'").append(conciergetour.getEstado()).append("'");
                strSQL.append(",'").append(conciergetour.getPais()).append("'");
                strSQL.append(",'").append(conciergetour.getFechaIn()).append("'");
                strSQL.append(",'").append(conciergetour.getFechaFi()).append("'");
                strSQL.append(",'").append(conciergetour.getCostoH()).append("'");
                strSQL.append(",'").append(conciergetour.getHorasC()).append("'");
                strSQL.append(",'").append(conciergetour.getCostoP()).append("'");
                strSQL.append(",'").append(conciergetour.getOtrosC()).append("'");
                strSQL.append(",'").append(conciergetour.getCargoT()).append("'");
                strSQL.append(",'").append(conciergetour.getEncuentro()).append("'");
                strSQL.append(",'").append(conciergetour.getHorario()).append("'");
                strSQL.append(",'").append(conciergetour.getHotel()).append("'");
                strSQL.append(",'").append(conciergetour.getFechaI()).append("'");
                strSQL.append(",'").append(conciergetour.getReservacion()).append("'");
                strSQL.append(",'").append(conciergetour.getFechaO()).append("'");
                strSQL.append(",'").append(conciergetour.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergetour.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergetour.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergetour.getNumeroTC()).append("','");
                strSQL.append(conciergetour.getExpira2()).append("'");
                strSQL.append(",'").append(conciergetour.getSecC()).append("'");
                strSQL.append(",'").append(conciergetour.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergetour.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergetour.getPCancel()).append("'");
                strSQL.append(",'").append(conciergetour.getNuInf()).append("'");
                strSQL.append(",'").append(conciergetour.getComentarios()).append("'");
                strSQL.append(",'").append(conciergetour.getEstatus()).append("'");
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
                strSQL.append("st_CSUpdateTour '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergetour.getNadultos()).append("'");
                strSQL.append(",'").append(conciergetour.getNinos()).append("'");
                strSQL.append(",'").append(conciergetour.getEdades()).append("'");
                strSQL.append(",'").append(conciergetour.getTour()).append("'");
                strSQL.append(",'").append(conciergetour.getVehiculo()).append("'");
                strSQL.append(",'").append(conciergetour.getCiudad()).append("'");
                strSQL.append(",'").append(conciergetour.getEstado()).append("'");
                strSQL.append(",'").append(conciergetour.getPais()).append("'");
                strSQL.append(",'").append(conciergetour.getFechaIn()).append("'");
                strSQL.append(",'").append(conciergetour.getFechaFi()).append("'");
                strSQL.append(",'").append(conciergetour.getCostoH()).append("'");
                strSQL.append(",'").append(conciergetour.getHorasC()).append("'");
                strSQL.append(",'").append(conciergetour.getCostoP()).append("'");
                strSQL.append(",'").append(conciergetour.getOtrosC()).append("'");
                strSQL.append(",'").append(conciergetour.getCargoT()).append("'");
                strSQL.append(",'").append(conciergetour.getEncuentro()).append("'");
                strSQL.append(",'").append(conciergetour.getHorario()).append("'");
                strSQL.append(",'").append(conciergetour.getHotel()).append("'");
                strSQL.append(",'").append(conciergetour.getFechaI()).append("'");
                strSQL.append(",'").append(conciergetour.getReservacion()).append("'");
                strSQL.append(",'").append(conciergetour.getFechaO()).append("'");
                strSQL.append(",'").append(conciergetour.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergetour.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergetour.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergetour.getNumeroTC()).append("','");
                strSQL.append(conciergetour.getExpira2()).append("'");
                strSQL.append(",'").append(conciergetour.getSecC()).append("'");
                strSQL.append(",'").append(conciergetour.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergetour.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergetour.getPCancel()).append("'");
                strSQL.append(",'").append(conciergetour.getNuInf()).append("'");
                strSQL.append(",'").append(conciergetour.getComentarios()).append("'");
                strSQL.append(",'").append(conciergetour.getEstatus()).append("'");
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
                    conciergetour=null;
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