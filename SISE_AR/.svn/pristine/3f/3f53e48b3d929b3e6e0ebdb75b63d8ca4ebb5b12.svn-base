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
import com.ike.concierge.to.Conciergebar;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaBar extends HttpServlet {
    
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
        Conciergebar conciergebar = new Conciergebar();
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
        conciergebar.setAdultos(request.getParameter("Adultos").toString().trim());
        conciergebar.setDamas(request.getParameter("Damas").toString().trim());
        conciergebar.setCaballeros(request.getParameter("Caballeros").toString().trim());
        conciergebar.setFechaD(request.getParameter("FechaD").toString().trim());
        conciergebar.setFechaC(request.getParameter("FechaC").toString().trim());
        conciergebar.setOcasion(request.getParameter("Ocasion").toString().trim());
        conciergebar.setCover(request.getParameter("Cover").toString().trim());
        conciergebar.setHotel(request.getParameter("Hotel").toString().trim());
        conciergebar.setFechaI(request.getParameter("FechaI").toString().trim());
        conciergebar.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergebar.setFechaO(request.getParameter("FechaO").toString().trim());
        conciergebar.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergebar.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergebar.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergebar.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergebar.setExpira2(request.getParameter("Expira").toString().trim());
        conciergebar.setSecC(request.getParameter("SecC").toString().trim());
        conciergebar.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergebar.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergebar.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergebar.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergebar.setTolerancia(request.getParameter("Tolerancia").toString().trim());
        conciergebar.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergebar.setEstatus(request.getParameter("clEstatus").toString().trim());
        
        
        
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
                
                strSQL.append("st_CSAltaBar '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergebar.getAdultos()).append("'");
                strSQL.append(",'").append(conciergebar.getDamas()).append("'");
                strSQL.append(",'").append(conciergebar.getCaballeros()).append("'");
                strSQL.append(",'").append(conciergebar.getFechaD()).append("'");
                strSQL.append(",'").append(conciergebar.getFechaC()).append("'");
                strSQL.append(",'").append(conciergebar.getOcasion()).append("'");
                strSQL.append(",'").append(conciergebar.getCover()).append("'");
                strSQL.append(",'").append(conciergebar.getHotel()).append("'");
                strSQL.append(",'").append(conciergebar.getFechaI()).append("'");
                strSQL.append(",'").append(conciergebar.getReservacion()).append("'");
                strSQL.append(",'").append(conciergebar.getFechaO()).append("'");
                strSQL.append(",'").append(conciergebar.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergebar.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergebar.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergebar.getNumeroTC()).append("','");
                strSQL.append(conciergebar.getExpira2()).append("'");
                strSQL.append(",'").append(conciergebar.getSecC()).append("'");
                strSQL.append(",'").append(conciergebar.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergebar.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergebar.getPCancel()).append("'");
                strSQL.append(",'").append(conciergebar.getNuInf()).append("'");
                strSQL.append(",'").append(conciergebar.getTolerancia()).append("'");
                strSQL.append(",'").append(conciergebar.getComentarios()).append("'");
                strSQL.append(",'").append(conciergebar.getEstatus()).append("'");
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
                strSQL.append("st_CSUpdateBar '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergebar.getAdultos()).append("'");
                strSQL.append(",'").append(conciergebar.getDamas()).append("'");
                strSQL.append(",'").append(conciergebar.getCaballeros()).append("'");
                strSQL.append(",'").append(conciergebar.getFechaD()).append("'");
                strSQL.append(",'").append(conciergebar.getFechaD()).append("'");
                strSQL.append(",'").append(conciergebar.getOcasion()).append("'");
                strSQL.append(",'").append(conciergebar.getCover()).append("'");
                strSQL.append(",'").append(conciergebar.getHotel()).append("'");
                strSQL.append(",'").append(conciergebar.getFechaI()).append("'");
                strSQL.append(",'").append(conciergebar.getReservacion()).append("'");
                strSQL.append(",'").append(conciergebar.getFechaO()).append("'");
                strSQL.append(",'").append(conciergebar.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergebar.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergebar.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergebar.getNumeroTC()).append("','");
                strSQL.append(conciergebar.getExpira2()).append("'");
                strSQL.append(",'").append(conciergebar.getSecC()).append("'");
                strSQL.append(",'").append(conciergebar.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergebar.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergebar.getPCancel()).append("'");
                strSQL.append(",'").append(conciergebar.getNuInf()).append("'");
                strSQL.append(",'").append(conciergebar.getTolerancia()).append("'");
                strSQL.append(",'").append(conciergebar.getComentarios()).append("'");
                strSQL.append(",'").append(conciergebar.getEstatus()).append("'");
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
                    conciergebar=null;
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