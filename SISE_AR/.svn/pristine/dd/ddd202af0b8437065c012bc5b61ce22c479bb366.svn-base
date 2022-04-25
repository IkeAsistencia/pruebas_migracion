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
import com.ike.concierge.to.Conciergeauto;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaAuto extends HttpServlet {
    
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
        Conciergeauto conciergeauto = new Conciergeauto();
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
        conciergeauto.setVehiculo(request.getParameter("Vehiculo").toString().trim());
        conciergeauto.setPasajeros(request.getParameter("Pasajeros").toString().trim());
        conciergeauto.setCiudad(request.getParameter("Ciudad").toString().trim());
        conciergeauto.setEstado(request.getParameter("Estado").toString().trim());
        conciergeauto.setPais(request.getParameter("Pais").toString().trim());
        conciergeauto.setFechaE(request.getParameter("FechaE").toString().trim());
        conciergeauto.setLugarEn(request.getParameter("LugarEn").toString().trim());
        conciergeauto.setFechaD(request.getParameter("FechaD").toString().trim());
        conciergeauto.setLugarDev(request.getParameter("LugarDev").toString().trim());
        conciergeauto.setCostoH(request.getParameter("CostoH").toString().trim());
        conciergeauto.setHorasC(request.getParameter("HorasC").toString().trim());
        conciergeauto.setCargoT(request.getParameter("CargoT").toString().trim());
        conciergeauto.setAdicionales(request.getParameter("Adicionales").toString().trim());
        conciergeauto.setSolAdic(request.getParameter("SolAdic").toString().trim());
        conciergeauto.setHotel(request.getParameter("Hotel").toString().trim());
        conciergeauto.setFechaI(request.getParameter("FechaI").toString().trim());
        conciergeauto.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergeauto.setFechaO(request.getParameter("FechaO").toString().trim());
        conciergeauto.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergeauto.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergeauto.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergeauto.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergeauto.setExpira2(request.getParameter("Expira").toString().trim());
        conciergeauto.setSecC(request.getParameter("SecC").toString().trim());
        conciergeauto.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergeauto.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergeauto.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergeauto.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergeauto.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergeauto.setEstatus(request.getParameter("clEstatus").toString().trim());
        
        
        
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
                
                strSQL.append("st_CSAltaAuto '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergeauto.getVehiculo()).append("'");
                strSQL.append(",'").append(conciergeauto.getPasajeros()).append("'");
                strSQL.append(",'").append(conciergeauto.getCiudad()).append("'");
                strSQL.append(",'").append(conciergeauto.getEstado()).append("'");
                strSQL.append(",'").append(conciergeauto.getPais()).append("'");
                strSQL.append(",'").append(conciergeauto.getFechaE()).append("'");
                strSQL.append(",'").append(conciergeauto.getLugarEn()).append("'");
                strSQL.append(",'").append(conciergeauto.getFechaD()).append("'");
                strSQL.append(",'").append(conciergeauto.getLugarDev()).append("'");
                strSQL.append(",'").append(conciergeauto.getCostoH()).append("'");
                strSQL.append(",'").append(conciergeauto.getHorasC()).append("'");
                strSQL.append(",'").append(conciergeauto.getCargoT()).append("'");
                strSQL.append(",'").append(conciergeauto.getAdicionales()).append("'");
                strSQL.append(",'").append(conciergeauto.getSolAdic()).append("'");
                strSQL.append(",'").append(conciergeauto.getHotel()).append("'");
                strSQL.append(",'").append(conciergeauto.getFechaI()).append("'");
                strSQL.append(",'").append(conciergeauto.getReservacion()).append("'");
                strSQL.append(",'").append(conciergeauto.getFechaO()).append("'");
                strSQL.append(",'").append(conciergeauto.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergeauto.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeauto.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeauto.getNumeroTC()).append("','");
                strSQL.append(conciergeauto.getExpira2()).append("'");
                strSQL.append(",'").append(conciergeauto.getSecC()).append("'");
                strSQL.append(",'").append(conciergeauto.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeauto.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergeauto.getPCancel()).append("'");
                strSQL.append(",'").append(conciergeauto.getNuInf()).append("'");
                strSQL.append(",'").append(conciergeauto.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeauto.getEstatus()).append("'");
                
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
                strSQL.append("st_CSUpdateAuto '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergeauto.getVehiculo()).append("'");
                strSQL.append(",'").append(conciergeauto.getPasajeros()).append("'");
                strSQL.append(",'").append(conciergeauto.getCiudad()).append("'");
                strSQL.append(",'").append(conciergeauto.getEstado()).append("'");
                strSQL.append(",'").append(conciergeauto.getPais()).append("'");
                strSQL.append(",'").append(conciergeauto.getFechaE()).append("'");
                strSQL.append(",'").append(conciergeauto.getLugarEn()).append("'");
                strSQL.append(",'").append(conciergeauto.getFechaD()).append("'");
                strSQL.append(",'").append(conciergeauto.getLugarDev()).append("'");
                strSQL.append(",'").append(conciergeauto.getCostoH()).append("'");
                strSQL.append(",'").append(conciergeauto.getHorasC()).append("'");
                strSQL.append(",'").append(conciergeauto.getCargoT()).append("'");
                strSQL.append(",'").append(conciergeauto.getAdicionales()).append("'");
                strSQL.append(",'").append(conciergeauto.getSolAdic()).append("'");
                strSQL.append(",'").append(conciergeauto.getHotel()).append("'");
                strSQL.append(",'").append(conciergeauto.getFechaI()).append("'");
                strSQL.append(",'").append(conciergeauto.getReservacion()).append("'");
                strSQL.append(",'").append(conciergeauto.getFechaO()).append("'");
                strSQL.append(",'").append(conciergeauto.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergeauto.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeauto.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeauto.getNumeroTC()).append("','");
                strSQL.append(conciergeauto.getExpira2()).append("'");
                strSQL.append(",'").append(conciergeauto.getSecC()).append("'");
                strSQL.append(",'").append(conciergeauto.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeauto.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergeauto.getPCancel()).append("'");
                strSQL.append(",'").append(conciergeauto.getNuInf()).append("'");
                strSQL.append(",'").append(conciergeauto.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeauto.getEstatus()).append("'");
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
                    conciergeauto=null;
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