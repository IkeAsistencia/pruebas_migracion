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
import com.ike.concierge.to.Conciergeequipaje;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaEquipaje extends HttpServlet {
    
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
        Conciergeequipaje conciergeequipaje = new Conciergeequipaje();
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
        
        conciergeequipaje.setVuelo(request.getParameter("Vuelo").toString().trim());
        conciergeequipaje.setMaletas(request.getParameter("Maletas").toString().trim());
        conciergeequipaje.setCiudadO(request.getParameter("CiudadO").toString().trim());
        conciergeequipaje.setCiudadD(request.getParameter("CiudadD").toString().trim());
        conciergeequipaje.setAptoO(request.getParameter("AptoO").toString().trim());        
        conciergeequipaje.setAptoD(request.getParameter("AptoD").toString().trim());
        conciergeequipaje.setFechaS(request.getParameter("FechaS").toString().trim());
        conciergeequipaje.setFechaA(request.getParameter("FechaA").toString().trim());
        conciergeequipaje.setConexion(request.getParameter("Conexion").toString().trim());
        conciergeequipaje.setReclamo(request.getParameter("Reclamo").toString().trim());
        conciergeequipaje.setHotel(request.getParameter("Hotel").toString().trim());
        conciergeequipaje.setFechaI(request.getParameter("FechaI").toString().trim());                
        conciergeequipaje.setReservacion(request.getParameter("Reservacion").toString().trim());
        conciergeequipaje.setFechaO(request.getParameter("FechaO").toString().trim());                
        conciergeequipaje.setFechrecupera(request.getParameter("Fechrecupera").toString().trim());
        conciergeequipaje.setFechentrega(request.getParameter("Fechentrega").toString().trim());
        conciergeequipaje.setDireccionE(request.getParameter("DireccionE").toString().trim());        
        conciergeequipaje.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergeequipaje.setEstatus(request.getParameter("clEstatus").toString().trim());
        
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
                
                strSQL.append("st_CSAltaEquipaje '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergeequipaje.getVuelo()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getMaletas()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getCiudadO()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getCiudadD()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getAptoO()).append("'");                
                strSQL.append(",'").append(conciergeequipaje.getAptoD()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getFechaS()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getFechaA()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getConexion()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getReclamo()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getHotel()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getFechaI()).append("'");  
                strSQL.append(",'").append(conciergeequipaje.getReservacion()).append("'");                                
                strSQL.append(",'").append(conciergeequipaje.getFechaO()).append("'");                  
                strSQL.append(",'").append(conciergeequipaje.getFechrecupera()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getFechentrega()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getDireccionE()).append("'");                
                strSQL.append(",'").append(conciergeequipaje.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getEstatus()).append("'");
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
                strSQL.append("st_CSUpdateEquipaje '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergeequipaje.getVuelo()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getMaletas()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getCiudadO()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getCiudadD()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getAptoO()).append("'");                
                strSQL.append(",'").append(conciergeequipaje.getAptoD()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getFechaS()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getFechaA()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getConexion()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getReclamo()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getHotel()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getFechaI()).append("'");  
                strSQL.append(",'").append(conciergeequipaje.getReservacion()).append("'");                                
                strSQL.append(",'").append(conciergeequipaje.getFechaO()).append("'");                  
                strSQL.append(",'").append(conciergeequipaje.getFechrecupera()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getFechentrega()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getDireccionE()).append("'");                
                strSQL.append(",'").append(conciergeequipaje.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeequipaje.getEstatus()).append("'");
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
                    conciergeequipaje=null;
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