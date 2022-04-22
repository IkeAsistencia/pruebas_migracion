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
import com.ike.concierge.to.Conciergespa;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaSpa extends HttpServlet {
    
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
        Conciergespa conciergespa = new Conciergespa();
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
        conciergespa.setTipoServicio(request.getParameter("TipoServicio").toString().trim());
        conciergespa.setFechaD(request.getParameter("FechaD").toString().trim());
        //conciergespa.setFechaC(request.getParameter("FechaC").toString().trim());
        conciergespa.setNombre(request.getParameter("Nombre").toString().trim());
        //conciergespa.setHombre(request.getParameter("Hombre").toString().trim());
       // conciergespa.setMujer(request.getParameter("Mujer").toString().trim());
        //conciergespa.setIndistinto(request.getParameter("Indistinto").toString().trim());
        conciergespa.setDuracion(request.getParameter("Duracion").toString().trim());
        conciergespa.setCargoT(request.getParameter("CargoT").toString().trim());
        //conciergespa.setHotel(request.getParameter("Hotel").toString().trim());
        //conciergespa.setFechaI(request.getParameter("FechaI").toString().trim());
        //conciergespa.setReservacion(request.getParameter("Reservacion").toString().trim());
        //conciergespa.setFechaO(request.getParameter("FechaO").toString().trim());
        conciergespa.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergespa.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergespa.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergespa.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergespa.setExpira2(request.getParameter("Expira").toString().trim());
        conciergespa.setSecC(request.getParameter("SecC").toString().trim());
        conciergespa.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergespa.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergespa.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergespa.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergespa.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergespa.setEstatus(request.getParameter("clEstatus").toString().trim());
        conciergespa.setMasajista(request.getParameter("Masajista").toString().trim());
        conciergespa.setDesTratamiento(request.getParameter("DesTratamiento").toString().trim());
        
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
                
                strSQL.append("st_CSAltaSpa '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergespa.getTipoServicio()).append("'");
                strSQL.append(",'").append(conciergespa.getFechaD()).append("'");
                //strSQL.append(",'").append(conciergespa.getFechaC()).append("'");
                strSQL.append(",'").append(conciergespa.getNombre()).append("'");
                //strSQL.append(",'").append(conciergespa.getHombre()).append("'");
                //strSQL.append(",'").append(conciergespa.getMujer()).append("'");
                //strSQL.append(",'").append(conciergespa.getIndistinto()).append("'");
                strSQL.append(",'").append(conciergespa.getDuracion()).append("'");
                strSQL.append(",'").append(conciergespa.getCargoT()).append("'");
                //strSQL.append(",'").append(conciergespa.getHotel()).append("'");
               // strSQL.append(",'").append(conciergespa.getFechaI()).append("'");
                //strSQL.append(",'").append(conciergespa.getReservacion()).append("'");
                //strSQL.append(",'").append(conciergespa.getFechaO()).append("'");
                strSQL.append(",'").append(conciergespa.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergespa.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergespa.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergespa.getNumeroTC()).append("','");
                strSQL.append(conciergespa.getExpira2()).append("'");
                strSQL.append(",'").append(conciergespa.getSecC()).append("'");
                strSQL.append(",'").append(conciergespa.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergespa.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergespa.getPCancel()).append("'");
                strSQL.append(",'").append(conciergespa.getNuInf()).append("'");
                strSQL.append(",'").append(conciergespa.getComentarios()).append("'");
                strSQL.append(",'").append(conciergespa.getEstatus()).append("'");
                strSQL.append(",'").append(conciergespa.getMasajista()).append("'");
                strSQL.append(",'").append(conciergespa.getDesTratamiento()).append("'");

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
                strSQL.append("st_CSUpdateSpa '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergespa.getTipoServicio()).append("'");
                strSQL.append(",'").append(conciergespa.getFechaD()).append("'");
                //strSQL.append(",'").append(conciergespa.getFechaC()).append("'");
                strSQL.append(",'").append(conciergespa.getNombre()).append("'");
                //strSQL.append(",'").append(conciergespa.getHombre()).append("'");
                //strSQL.append(",'").append(conciergespa.getMujer()).append("'");
                //strSQL.append(",'").append(conciergespa.getIndistinto()).append("'");
                strSQL.append(",'").append(conciergespa.getDuracion()).append("'");
                strSQL.append(",'").append(conciergespa.getCargoT()).append("'");
                //strSQL.append(",'").append(conciergespa.getHotel()).append("'");
                //strSQL.append(",'").append(conciergespa.getFechaI()).append("'");
                //strSQL.append(",'").append(conciergespa.getReservacion()).append("'");
                //strSQL.append(",'").append(conciergespa.getFechaO()).append("'");
                strSQL.append(",'").append(conciergespa.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergespa.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergespa.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergespa.getNumeroTC()).append("','");
                strSQL.append(conciergespa.getExpira2()).append("'");
                strSQL.append(",'").append(conciergespa.getSecC()).append("'");
                strSQL.append(",'").append(conciergespa.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergespa.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergespa.getPCancel()).append("'");
                strSQL.append(",'").append(conciergespa.getNuInf()).append("'");
                strSQL.append(",'").append(conciergespa.getComentarios()).append("'");
                strSQL.append(",'").append(conciergespa.getEstatus()).append("'");
                strSQL.append(",'").append(conciergespa.getMasajista()).append("'");
               strSQL.append(",'").append(conciergespa.getDesTratamiento()).append("'");
                
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
                    conciergespa=null;
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