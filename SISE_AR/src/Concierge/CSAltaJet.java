/*
 * CSAltaJet.java
 *
 * Created on 26 de Febrero de 2007, 13:09 PM
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
import com.ike.concierge.to.Conciergerentajet;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaJet extends HttpServlet {
    
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
        Conciergerentajet conciergerentajet = new Conciergerentajet();
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
        conciergerentajet.setAeronave(request.getParameter("Aeronave").toString().trim());
        conciergerentajet.setPasajeros(request.getParameter("Pasajeros").toString().trim());
        conciergerentajet.setOrigen(request.getParameter("Origen").toString().trim());
        conciergerentajet.setDestino(request.getParameter("Destino").toString().trim());
        conciergerentajet.setFechaS(request.getParameter("FechaS").toString().trim());
        conciergerentajet.setCostoH(request.getParameter("CostoH").toString().trim());
        conciergerentajet.setHorasP(request.getParameter("HorasP").toString().trim());
        conciergerentajet.setCargoT(request.getParameter("CargoT").toString().trim());
        conciergerentajet.setHotel(request.getParameter("Hotel").toString().trim());
        conciergerentajet.setFechaI(request.getParameter("FechaI").toString().trim());
        conciergerentajet.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergerentajet.setFechaO(request.getParameter("FechaO").toString().trim());
        conciergerentajet.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergerentajet.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergerentajet.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergerentajet.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergerentajet.setExpira2(request.getParameter("Expira").toString().trim());
        conciergerentajet.setSecC(request.getParameter("SecC").toString().trim());
        conciergerentajet.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergerentajet.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergerentajet.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergerentajet.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergerentajet.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergerentajet.setEstatus(request.getParameter("clEstatus").toString().trim());
        
        
        
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
                
                strSQL.append("st_CSAltaRentaJet '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergerentajet.getAeronave()).append("'");
                strSQL.append(",'").append(conciergerentajet.getPasajeros()).append("'");
                strSQL.append(",'").append(conciergerentajet.getOrigen()).append("'");
                strSQL.append(",'").append(conciergerentajet.getDestino()).append("'");
                strSQL.append(",'").append(conciergerentajet.getFechaS()).append("'");
                strSQL.append(",'").append(conciergerentajet.getCostoH()).append("'");
                strSQL.append(",'").append(conciergerentajet.getHorasP()).append("'");
                strSQL.append(",'").append(conciergerentajet.getCargoT()).append("'");
                strSQL.append(",'").append(conciergerentajet.getHotel()).append("'");
                strSQL.append(",'").append(conciergerentajet.getFechaI()).append("'");
                strSQL.append(",'").append(conciergerentajet.getReservacion()).append("'");
                strSQL.append(",'").append(conciergerentajet.getFechaO()).append("'");
                strSQL.append(",'").append(conciergerentajet.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergerentajet.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergerentajet.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergerentajet.getNumeroTC()).append("','");
                strSQL.append(conciergerentajet.getExpira2()).append("'");
                strSQL.append(",'").append(conciergerentajet.getSecC()).append("'");
                strSQL.append(",'").append(conciergerentajet.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergerentajet.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergerentajet.getPCancel()).append("'");
                strSQL.append(",'").append(conciergerentajet.getNuInf()).append("'");
                strSQL.append(",'").append(conciergerentajet.getComentarios()).append("'");
                strSQL.append(",'").append(conciergerentajet.getEstatus()).append("'");
                
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
                strSQL.append("st_CSUpdaterentajet '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergerentajet.getAeronave()).append("'");
                strSQL.append(",'").append(conciergerentajet.getPasajeros()).append("'");
                strSQL.append(",'").append(conciergerentajet.getOrigen()).append("'");
                strSQL.append(",'").append(conciergerentajet.getDestino()).append("'");
                strSQL.append(",'").append(conciergerentajet.getFechaS()).append("'");
                strSQL.append(",'").append(conciergerentajet.getCostoH()).append("'");
                strSQL.append(",'").append(conciergerentajet.getHorasP()).append("'");
                strSQL.append(",'").append(conciergerentajet.getCargoT()).append("'");
                strSQL.append(",'").append(conciergerentajet.getHotel()).append("'");
                strSQL.append(",'").append(conciergerentajet.getFechaI()).append("'");
                strSQL.append(",'").append(conciergerentajet.getReservacion()).append("'");
                strSQL.append(",'").append(conciergerentajet.getFechaO()).append("'");
                strSQL.append(",'").append(conciergerentajet.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergerentajet.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergerentajet.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergerentajet.getNumeroTC()).append("','");
                strSQL.append(conciergerentajet.getExpira2()).append("'");
                strSQL.append(",'").append(conciergerentajet.getSecC()).append("'");
                strSQL.append(",'").append(conciergerentajet.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergerentajet.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergerentajet.getPCancel()).append("'");
                strSQL.append(",'").append(conciergerentajet.getNuInf()).append("'");
                strSQL.append(",'").append(conciergerentajet.getComentarios()).append("'");
                strSQL.append(",'").append(conciergerentajet.getEstatus()).append("'");
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
                    conciergerentajet=null;
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