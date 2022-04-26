/*
 * CSAltaAvionOneWay.java
 *
 * Created on 13 de marzo de 2007, 12:43 PM
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
import com.ike.concierge.to.ConciergeAvionOneWay;

/*
 *
 * @author  zamoraed
 * @version
 */
public class CSAltaAvionOneWay extends HttpServlet {
    
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
        ConciergeAvionOneWay conciergeaviononeway = new ConciergeAvionOneWay();
        PrintWriter out = response.getWriter();
              
        String StrUsrApp = "0";
        String clConcierge="0";
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
        conciergeaviononeway.setclEstatus(request.getParameter("clEstatus"));
        conciergeaviononeway.setclAvionOneWay(request.getParameter("clAvionOneWay"));
        conciergeaviononeway.setclAsistencia(request.getParameter("clAsistencia"));
        conciergeaviononeway.setComentarios(request.getParameter("Comentarios"));

        conciergeaviononeway.setNoVuelo(request.getParameter("NoVuelo"));
        conciergeaviononeway.setClase(request.getParameter("Clase"));
        conciergeaviononeway.setOperadox(request.getParameter("Operadox"));
        conciergeaviononeway.setCdOrigen(request.getParameter("CdOrigen"));
        conciergeaviononeway.setCdDestino(request.getParameter("CdDestino"));
        conciergeaviononeway.setAptOrigen(request.getParameter("AptOrigen"));
        conciergeaviononeway.setAptDestino(request.getParameter("AptDestino"));
        conciergeaviononeway.setFechaSalida(request.getParameter("FechaSalida"));
        conciergeaviononeway.setFechaArribo(request.getParameter("FechaArribo"));
        conciergeaviononeway.setConexiones(request.getParameter("Conexiones"));
        conciergeaviononeway.setTiempoLimite(request.getParameter("TiempoLimite"));
        conciergeaviononeway.setCdOrigen1(request.getParameter("CdOrigen1"));
        conciergeaviononeway.setCdDestino1(request.getParameter("CdDestino1"));
        conciergeaviononeway.setAptOrigen1(request.getParameter("AptOrigen1"));
        conciergeaviononeway.setAptDestino1(request.getParameter("AptDestino1"));
        conciergeaviononeway.setFechaSalida1(request.getParameter("FechaSalida1"));
        conciergeaviononeway.setFechaArribo1(request.getParameter("FechaArribo1"));
        conciergeaviononeway.setConexiones1(request.getParameter("Conexiones1"));
        conciergeaviononeway.setTiempoLimite1(request.getParameter("TiempoLimite1"));
        conciergeaviononeway.setCdOrigen2(request.getParameter("CdOrigen2"));
        conciergeaviononeway.setCdDestino2(request.getParameter("CdDestino2"));
        conciergeaviononeway.setAptOrigen2(request.getParameter("AptOrigen2"));
        conciergeaviononeway.setAptDestino2(request.getParameter("AptDestino2"));
        conciergeaviononeway.setFechaSalida2(request.getParameter("FechaSalida2"));
        conciergeaviononeway.setFechaArribo2(request.getParameter("FechaArribo2"));
        conciergeaviononeway.setConexiones2(request.getParameter("Conexiones2"));
        conciergeaviononeway.setTiempoLimite2(request.getParameter("TiempoLimite2"));
        conciergeaviononeway.setCdOrigen3(request.getParameter("CdOrigen3"));
        conciergeaviononeway.setCdDestino3(request.getParameter("CdDestino3"));
        conciergeaviononeway.setAptOrigen3(request.getParameter("AptOrigen3"));
        conciergeaviononeway.setAptDestino3(request.getParameter("AptDestino3"));
        conciergeaviononeway.setFechaSalida3(request.getParameter("FechaSalida3"));
        conciergeaviononeway.setFechaArribo3(request.getParameter("FechaArribo3"));
        conciergeaviononeway.setConexiones3(request.getParameter("Conexiones3"));
        conciergeaviononeway.setTiempoLimite3(request.getParameter("TiempoLimite3"));
        conciergeaviononeway.setclTipoPago(request.getParameter("clTipoPago"));
        conciergeaviononeway.setNomBanco(request.getParameter("NomBanco"));
        conciergeaviononeway.setNombreTC(request.getParameter("NombreTC"));
        conciergeaviononeway.setNumeroTC(request.getParameter("NumeroTC"));
        conciergeaviononeway.setExpira(request.getParameter("Expira"));
        conciergeaviononeway.setSecC(request.getParameter("SecC"));
        conciergeaviononeway.setConfirmo(request.getParameter("Confirmo"));
        conciergeaviononeway.setNumConfirmacion(request.getParameter("NumConfirmacion"));
        conciergeaviononeway.setCancelacion(request.getParameter("Cancelacion"));
        conciergeaviononeway.setNUInfo(request.getParameter("NUInfo"));
        
            
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
                
                strSQL.append("st_CSAltaAvionOneWay '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getclEstatus()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getComentarios()).append("'");

                strSQL.append(",'").append(conciergeaviononeway.getNoVuelo()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getClase()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getOperadox()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdOrigen()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdDestino()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptOrigen()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptDestino()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaSalida()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaArribo()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getConexiones()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getTiempoLimite ()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdOrigen1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdDestino1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptOrigen1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptDestino1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaSalida1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaArribo1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getConexiones1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getTiempoLimite1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdOrigen2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdDestino2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptOrigen2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptDestino()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaSalida2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaArribo2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getConexiones2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getTiempoLimite2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdOrigen3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdDestino3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptOrigen3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptDestino3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaSalida3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaArribo3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getConexiones3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getTiempoLimite3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getclTipoPago()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getNumeroTC()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getExpira()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getSecC()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getNumConfirmacion()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCancelacion()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getNUInfo()).append("'");

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
                strSQL.append("st_CSUpdateAvionOneWay '").append(clAsistenciaG).append("'");               
                strSQL.append(",'").append(conciergeaviononeway.getComentarios()).append("'");
    
                strSQL.append(",'").append(conciergeaviononeway.getNoVuelo()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getClase()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getOperadox()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdOrigen()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdDestino()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptOrigen()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptDestino()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaSalida()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaArribo()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getConexiones()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getTiempoLimite ()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdOrigen1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdDestino1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptOrigen1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptDestino1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaSalida1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaArribo1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getConexiones1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getTiempoLimite1()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdOrigen2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdDestino2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptOrigen2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptDestino()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaSalida2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaArribo2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getConexiones2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getTiempoLimite2()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdOrigen3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCdDestino3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptOrigen3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getAptDestino3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaSalida3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getFechaArribo3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getConexiones3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getTiempoLimite3()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getclTipoPago()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getNumeroTC()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getExpira()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getSecC()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getNumConfirmacion()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getCancelacion()).append("'");
                strSQL.append(",'").append(conciergeaviononeway.getNUInfo()).append("'");

                strSQL.append(",'").append(conciergeaviononeway.getclEstatus()).append("'");

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
                    conciergeaviononeway=null;
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
