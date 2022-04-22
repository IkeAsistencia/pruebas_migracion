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
import com.ike.concierge.to.ConciergeLocalidades;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaLocalidadesB extends HttpServlet {
    
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
        ConciergeLocalidades conciergeLocalidades = new ConciergeLocalidades();
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
        
        conciergeLocalidades.setNadultos(request.getParameter("Nadultos").toString().trim());
        conciergeLocalidades.setNinos(request.getParameter("Ninos").toString().trim());
        conciergeLocalidades.setEdades(request.getParameter("Edades").toString().trim());
        conciergeLocalidades.setEvento(request.getParameter("Evento").toString().trim());
        conciergeLocalidades.setFechaE(request.getParameter("FechaE").toString().trim());        
        conciergeLocalidades.setTeatro(request.getParameter("Teatro").toString().trim());
        conciergeLocalidades.setDireccion(request.getParameter("Direccion").toString().trim());
        conciergeLocalidades.setSeccion(request.getParameter("Seccion").toString().trim());
        conciergeLocalidades.setFila(request.getParameter("Fila").toString().trim());
        conciergeLocalidades.setHotel(request.getParameter("Hotel").toString().trim());
        conciergeLocalidades.setFechaI(request.getParameter("FechaI").toString().trim());                
        conciergeLocalidades.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergeLocalidades.setFechaO(request.getParameter("FechaO").toString().trim());                
        conciergeLocalidades.setFace(request.getParameter("Face").toString().trim());
        conciergeLocalidades.setSale(request.getParameter("Sale").toString().trim());
        conciergeLocalidades.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergeLocalidades.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergeLocalidades.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergeLocalidades.setCargoT(request.getParameter("CargoT").toString().trim());        
        conciergeLocalidades.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergeLocalidades.setExpira2(request.getParameter("Expira").toString().trim());
        conciergeLocalidades.setSecC(request.getParameter("SecC").toString().trim());
        conciergeLocalidades.setMetodo(request.getParameter("Metodo").toString().trim());
        conciergeLocalidades.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergeLocalidades.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergeLocalidades.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergeLocalidades.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergeLocalidades.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergeLocalidades.setEstatus(request.getParameter("clEstatus").toString().trim());
        
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
                
                strSQL.append("st_CSAltaLocalidades '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNadultos()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNinos()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getEdades()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getEvento()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getFechaE()).append("'");                
                strSQL.append(",'").append(conciergeLocalidades.getTeatro()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getDireccion()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getSeccion()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getFila()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getHotel()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getFechaI()).append("'");  
                strSQL.append(",'").append(conciergeLocalidades.getReservacion()).append("'");                                
                strSQL.append(",'").append(conciergeLocalidades.getFechaO()).append("'");                  
                strSQL.append(",'").append(conciergeLocalidades.getFace()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getSale()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getCargoT()).append("'");                
                strSQL.append(",'").append(conciergeLocalidades.getNumeroTC()).append("','");
                strSQL.append(conciergeLocalidades.getExpira2()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getSecC()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getMetodo()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getPCancel()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNuInf()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getEstatus()).append("'");
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
                strSQL.append("st_CSUpdateLocalidades '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNadultos()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNinos()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getEdades()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getEvento()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getFechaE()).append("'");                
                strSQL.append(",'").append(conciergeLocalidades.getTeatro()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getDireccion()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getSeccion()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getFila()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getHotel()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getFechaI()).append("'");  
                strSQL.append(",'").append(conciergeLocalidades.getReservacion()).append("'");                                
                strSQL.append(",'").append(conciergeLocalidades.getFechaO()).append("'");                  
                strSQL.append(",'").append(conciergeLocalidades.getFace()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getSale()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getCargoT()).append("'");                
                strSQL.append(",'").append(conciergeLocalidades.getNumeroTC()).append("','");
                strSQL.append(conciergeLocalidades.getExpira2()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getSecC()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getMetodo()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getPCancel()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getNuInf()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeLocalidades.getEstatus()).append("'");
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
                    conciergeLocalidades=null;
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