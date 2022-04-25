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
import com.ike.concierge.to.Conciergegolf;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaGolf extends HttpServlet {
    
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
        Conciergegolf conciergegolf = new Conciergegolf();
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
        conciergegolf.setJugadores(request.getParameter("Jugadores").toString().trim());
        conciergegolf.setFecha(request.getParameter("Fecha").toString().trim());
        conciergegolf.setGreen(request.getParameter("Green").toString().trim());
        conciergegolf.setEquipo(request.getParameter("Equipo").toString().trim());
        conciergegolf.setDiestros(request.getParameter("Diestros").toString().trim());
        conciergegolf.setZurdos(request.getParameter("Zurdos").toString().trim());
        conciergegolf.setOtrosC(request.getParameter("OtrosC").toString().trim());
        conciergegolf.setCargoT(request.getParameter("CargoT").toString().trim());
        conciergegolf.setHotel(request.getParameter("Hotel").toString().trim());
        conciergegolf.setFechaI(request.getParameter("FechaI").toString().trim());
        conciergegolf.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergegolf.setFechaO(request.getParameter("FechaO").toString().trim());
        conciergegolf.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergegolf.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergegolf.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergegolf.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergegolf.setExpira2(request.getParameter("Expira").toString().trim());
        conciergegolf.setSecC(request.getParameter("SecC").toString().trim());
        conciergegolf.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergegolf.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergegolf.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergegolf.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergegolf.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergegolf.setEstatus(request.getParameter("clEstatus").toString().trim());
        
        
        
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
                
                strSQL.append("st_CSAltaGolf '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergegolf.getJugadores()).append("'");
                strSQL.append(",'").append(conciergegolf.getFecha()).append("'");
                strSQL.append(",'").append(conciergegolf.getGreen()).append("'");
                strSQL.append(",'").append(conciergegolf.getEquipo()).append("'");
                strSQL.append(",'").append(conciergegolf.getDiestros()).append("'");
                strSQL.append(",'").append(conciergegolf.getZurdos()).append("'");
                strSQL.append(",'").append(conciergegolf.getOtrosC()).append("'");
                strSQL.append(",'").append(conciergegolf.getCargoT()).append("'");
                strSQL.append(",'").append(conciergegolf.getHotel()).append("'");
                strSQL.append(",'").append(conciergegolf.getFechaI()).append("'");
                strSQL.append(",'").append(conciergegolf.getReservacion()).append("'");
                strSQL.append(",'").append(conciergegolf.getFechaO()).append("'");
                strSQL.append(",'").append(conciergegolf.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergegolf.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergegolf.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergegolf.getNumeroTC()).append("','");
                strSQL.append(conciergegolf.getExpira2()).append("'");
                strSQL.append(",'").append(conciergegolf.getSecC()).append("'");
                strSQL.append(",'").append(conciergegolf.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergegolf.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergegolf.getPCancel()).append("'");
                strSQL.append(",'").append(conciergegolf.getNuInf()).append("'");
                strSQL.append(",'").append(conciergegolf.getComentarios()).append("'");
                strSQL.append(",'").append(conciergegolf.getEstatus()).append("'");
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
                strSQL.append("st_CSUpdateGolf '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergegolf.getJugadores()).append("'");
                strSQL.append(",'").append(conciergegolf.getFecha()).append("'");
                strSQL.append(",'").append(conciergegolf.getGreen()).append("'");
                strSQL.append(",'").append(conciergegolf.getEquipo()).append("'");
                strSQL.append(",'").append(conciergegolf.getDiestros()).append("'");
                strSQL.append(",'").append(conciergegolf.getZurdos()).append("'");
                strSQL.append(",'").append(conciergegolf.getOtrosC()).append("'");
                strSQL.append(",'").append(conciergegolf.getCargoT()).append("'");
                strSQL.append(",'").append(conciergegolf.getHotel()).append("'");
                strSQL.append(",'").append(conciergegolf.getFechaI()).append("'");
                strSQL.append(",'").append(conciergegolf.getReservacion()).append("'");
                strSQL.append(",'").append(conciergegolf.getFechaO()).append("'");
                strSQL.append(",'").append(conciergegolf.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergegolf.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergegolf.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergegolf.getNumeroTC()).append("','");
                strSQL.append(conciergegolf.getExpira2()).append("'");
                strSQL.append(",'").append(conciergegolf.getSecC()).append("'");
                strSQL.append(",'").append(conciergegolf.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergegolf.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergegolf.getPCancel()).append("'");
                strSQL.append(",'").append(conciergegolf.getNuInf()).append("'");
                strSQL.append(",'").append(conciergegolf.getComentarios()).append("'");
                strSQL.append(",'").append(conciergegolf.getEstatus()).append("'");
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
                    conciergegolf=null;
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