/*
 * CSAltaRentayate.java
 *
 * Created on 27 de Febrero de 2007, 13:09 PM
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
import com.ike.concierge.to.Conciergerentayate;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaYate extends HttpServlet {
    
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
        Conciergerentayate conciergerentayate = new Conciergerentayate();
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
        conciergerentayate.setEmbarcacion(request.getParameter("Embarcacion").toString().trim());
        conciergerentayate.setPasajeros(request.getParameter("Pasajeros").toString().trim());
        conciergerentayate.setUbicacion(request.getParameter("Ubicacion").toString().trim());
        conciergerentayate.setCamarotes(request.getParameter("Camarotes").toString().trim());
        conciergerentayate.setCiudad(request.getParameter("Ciudad").toString().trim());
        conciergerentayate.setEstado(request.getParameter("Estado").toString().trim());
        conciergerentayate.setPais(request.getParameter("Pais").toString().trim());
        conciergerentayate.setFechaS(request.getParameter("FechaS").toString().trim());
        conciergerentayate.setFechaR(request.getParameter("FechaR").toString().trim());
        conciergerentayate.setCostoH(request.getParameter("CostoH").toString().trim());
        conciergerentayate.setHorasP(request.getParameter("HorasP").toString().trim());
        conciergerentayate.setCargoT(request.getParameter("CargoT").toString().trim());
        conciergerentayate.setHotel(request.getParameter("Hotel").toString().trim());
        conciergerentayate.setFechaI(request.getParameter("FechaI").toString().trim());
        conciergerentayate.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergerentayate.setFechaO(request.getParameter("FechaO").toString().trim());
        conciergerentayate.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergerentayate.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergerentayate.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergerentayate.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergerentayate.setExpira2(request.getParameter("Expira").toString().trim());
        conciergerentayate.setSecC(request.getParameter("SecC").toString().trim());
        conciergerentayate.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergerentayate.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergerentayate.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergerentayate.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergerentayate.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergerentayate.setEstatus(request.getParameter("clEstatus").toString().trim());
        
        
        
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
                
                strSQL.append("st_CSAltaYate '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergerentayate.getEmbarcacion()).append("'");
                strSQL.append(",'").append(conciergerentayate.getPasajeros()).append("'");
                strSQL.append(",'").append(conciergerentayate.getUbicacion()).append("'");
                strSQL.append(",'").append(conciergerentayate.getCamarotes()).append("'");
                strSQL.append(",'").append(conciergerentayate.getCiudad()).append("'");
                strSQL.append(",'").append(conciergerentayate.getEstado()).append("'");
                strSQL.append(",'").append(conciergerentayate.getPais()).append("'");
                strSQL.append(",'").append(conciergerentayate.getFechaS()).append("'");
                strSQL.append(",'").append(conciergerentayate.getFechaR()).append("'");
                strSQL.append(",'").append(conciergerentayate.getCostoH()).append("'");
                strSQL.append(",'").append(conciergerentayate.getHorasP()).append("'");
                strSQL.append(",'").append(conciergerentayate.getCargoT()).append("'");
                strSQL.append(",'").append(conciergerentayate.getHotel()).append("'");
                strSQL.append(",'").append(conciergerentayate.getFechaI()).append("'");
                strSQL.append(",'").append(conciergerentayate.getReservacion()).append("'");
                strSQL.append(",'").append(conciergerentayate.getFechaO()).append("'");
                strSQL.append(",'").append(conciergerentayate.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergerentayate.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergerentayate.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergerentayate.getNumeroTC()).append("','");
                strSQL.append(conciergerentayate.getExpira2()).append("'");
                strSQL.append(",'").append(conciergerentayate.getSecC()).append("'");
                strSQL.append(",'").append(conciergerentayate.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergerentayate.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergerentayate.getPCancel()).append("'");
                strSQL.append(",'").append(conciergerentayate.getNuInf()).append("'");
                strSQL.append(",'").append(conciergerentayate.getComentarios()).append("'");
                strSQL.append(",'").append(conciergerentayate.getEstatus()).append("'");
                System.out.println(strSQL.toString());
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                strSQL.delete(0,strSQL.length());
                if (rsEx.next()) {
                    clAsistencia=rsEx.getString("clAsistencia");
                }
                if (!clAsistencia.equalsIgnoreCase("0")){
                    if(request.getParameter("URLBACK")!=null){
                        strUrlBack = request.getParameter("URLBACK");
                        //strUrlBack=strUrlBack + "&clAsistencia=0";
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
                strSQL.append("st_CSUpdateRentaYate '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergerentayate.getEmbarcacion()).append("'");
                strSQL.append(",'").append(conciergerentayate.getPasajeros()).append("'");
                strSQL.append(",'").append(conciergerentayate.getUbicacion()).append("'");
                strSQL.append(",'").append(conciergerentayate.getCamarotes()).append("'");
                strSQL.append(",'").append(conciergerentayate.getCiudad()).append("'");
                strSQL.append(",'").append(conciergerentayate.getEstado()).append("'");
                strSQL.append(",'").append(conciergerentayate.getPais()).append("'");
                strSQL.append(",'").append(conciergerentayate.getFechaS()).append("'");
                strSQL.append(",'").append(conciergerentayate.getFechaR()).append("'");
                strSQL.append(",'").append(conciergerentayate.getCostoH()).append("'");
                strSQL.append(",'").append(conciergerentayate.getHorasP()).append("'");
                strSQL.append(",'").append(conciergerentayate.getCargoT()).append("'");
                strSQL.append(",'").append(conciergerentayate.getHotel()).append("'");
                strSQL.append(",'").append(conciergerentayate.getFechaI()).append("'");
                strSQL.append(",'").append(conciergerentayate.getReservacion()).append("'");
                strSQL.append(",'").append(conciergerentayate.getFechaO()).append("'");
                strSQL.append(",'").append(conciergerentayate.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergerentayate.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergerentayate.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergerentayate.getNumeroTC()).append("','");
                strSQL.append(conciergerentayate.getExpira2()).append("'");
                strSQL.append(",'").append(conciergerentayate.getSecC()).append("'");
                strSQL.append(",'").append(conciergerentayate.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergerentayate.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergerentayate.getPCancel()).append("'");
                strSQL.append(",'").append(conciergerentayate.getNuInf()).append("'");
                strSQL.append(",'").append(conciergerentayate.getComentarios()).append("'");
                strSQL.append(",'").append(conciergerentayate.getEstatus()).append("'");
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
                    conciergerentayate=null;
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