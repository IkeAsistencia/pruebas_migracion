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
import com.ike.concierge.to.Conciergelocaltaquilla;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaLocalidadesT extends HttpServlet {
    
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
        Conciergelocaltaquilla conciergelocaltaquilla = new Conciergelocaltaquilla();
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
        
        conciergelocaltaquilla.setNadultos(request.getParameter("Nadultos").toString().trim());
        conciergelocaltaquilla.setNinos(request.getParameter("Ninos").toString().trim());
        conciergelocaltaquilla.setEdades(request.getParameter("Edades").toString().trim());
        conciergelocaltaquilla.setEvento(request.getParameter("Evento").toString().trim());
        conciergelocaltaquilla.setFechaE(request.getParameter("FechaE").toString().trim());        
        conciergelocaltaquilla.setTeatro(request.getParameter("Teatro").toString().trim());
        conciergelocaltaquilla.setDireccion(request.getParameter("Direccion").toString().trim());
        conciergelocaltaquilla.setSeccion(request.getParameter("Seccion").toString().trim());
        conciergelocaltaquilla.setFila(request.getParameter("Fila").toString().trim());
        conciergelocaltaquilla.setHotel(request.getParameter("Hotel").toString().trim());
        conciergelocaltaquilla.setFechaI(request.getParameter("FechaI").toString().trim());                
        conciergelocaltaquilla.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergelocaltaquilla.setFechaO(request.getParameter("FechaO").toString().trim());                
        conciergelocaltaquilla.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergelocaltaquilla.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergelocaltaquilla.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergelocaltaquilla.setCargoT(request.getParameter("CargoT").toString().trim());        
        conciergelocaltaquilla.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergelocaltaquilla.setExpira2(request.getParameter("Expira").toString().trim());
        conciergelocaltaquilla.setSecC(request.getParameter("SecC").toString().trim());
        conciergelocaltaquilla.setMetodo(request.getParameter("Metodo").toString().trim());
        conciergelocaltaquilla.setAutoriza(request.getParameter("Autoriza").toString().trim());        
        conciergelocaltaquilla.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergelocaltaquilla.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergelocaltaquilla.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergelocaltaquilla.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergelocaltaquilla.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergelocaltaquilla.setEstatus(request.getParameter("clEstatus").toString().trim());
        
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
                
                strSQL.append("st_CSAltaLocalidadesTaquilla '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNadultos()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNinos()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getEdades()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getEvento()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getFechaE()).append("'");                
                strSQL.append(",'").append(conciergelocaltaquilla.getTeatro()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getDireccion()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getSeccion()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getFila()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getHotel()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getFechaI()).append("'");  
                strSQL.append(",'").append(conciergelocaltaquilla.getReservacion()).append("'");                                
                strSQL.append(",'").append(conciergelocaltaquilla.getFechaO()).append("'");                  
                strSQL.append(",'").append(conciergelocaltaquilla.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getCargoT()).append("'");                
                strSQL.append(",'").append(conciergelocaltaquilla.getNumeroTC()).append("','");
                strSQL.append(conciergelocaltaquilla.getExpira2()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getSecC()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getMetodo()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getAutoriza()).append("'");                
                strSQL.append(",'").append(conciergelocaltaquilla.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getPCancel()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNuInf()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getComentarios()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getEstatus()).append("'");
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
                strSQL.append("st_CSUpdateLocalidadesTaquilla '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNadultos()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNinos()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getEdades()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getEvento()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getFechaE()).append("'");                
                strSQL.append(",'").append(conciergelocaltaquilla.getTeatro()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getDireccion()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getSeccion()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getFila()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getHotel()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getFechaI()).append("'");  
                strSQL.append(",'").append(conciergelocaltaquilla.getReservacion()).append("'");                                
                strSQL.append(",'").append(conciergelocaltaquilla.getFechaO()).append("'");                  
                strSQL.append(",'").append(conciergelocaltaquilla.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getCargoT()).append("'");                
                strSQL.append(",'").append(conciergelocaltaquilla.getNumeroTC()).append("','");
                strSQL.append(conciergelocaltaquilla.getExpira2()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getSecC()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getMetodo()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getAutoriza()).append("'");                
                strSQL.append(",'").append(conciergelocaltaquilla.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getPCancel()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getNuInf()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getComentarios()).append("'");
                strSQL.append(",'").append(conciergelocaltaquilla.getEstatus()).append("'");
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
                    conciergelocaltaquilla=null;
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