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
import com.ike.concierge.to.Conciergeresta;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaRestaurante extends HttpServlet {
    
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
        Conciergeresta conciergeresta = new Conciergeresta();
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
        
        conciergeresta.setNadultos(request.getParameter("Nadultos").toString().trim());
        conciergeresta.setNinos(request.getParameter("Ninos").toString().trim());
        conciergeresta.setEdades(request.getParameter("Edades").toString().trim());
        conciergeresta.setFechaD(request.getParameter("FechaD").toString().trim());
        conciergeresta.setCodigo(request.getParameter("Codigo").toString().trim());
        conciergeresta.setTelefono(request.getParameter("Telefono").toString().trim());
        //conciergeresta.setFechaC(request.getParameter("FechaC").toString().trim());
        conciergeresta.setOcasion(request.getParameter("Ocasion").toString().trim());
        conciergeresta.setclCallRest(request.getParameter("clCallRest").toString().trim());
        conciergeresta.setClSeccion(request.getParameter("clSeccion").toString().trim());
        conciergeresta.setHotel(request.getParameter("Hotel").toString().trim());
        //conciergeresta.setFechaI(request.getParameter("FechaI").toString().trim());
        conciergeresta.setReservacion(request.getParameter("Reservacion").toString().trim());
        //conciergeresta.setFechaO(request.getParameter("FechaO").toString().trim());
        conciergeresta.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergeresta.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergeresta.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergeresta.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergeresta.setExpira2(request.getParameter("Expira").toString().trim());
        conciergeresta.setSecC(request.getParameter("SecC").toString().trim());
        conciergeresta.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergeresta.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergeresta.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergeresta.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergeresta.setTolerancia(request.getParameter("Tolerancia").toString().trim());
        conciergeresta.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergeresta.setEstatus(request.getParameter("clEstatus").toString().trim());
        
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
                
                strSQL.append("st_CSAltaRestaurante '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergeresta.getNadultos()).append("'");
                strSQL.append(",'").append(conciergeresta.getNinos()).append("'");
                strSQL.append(",'").append(conciergeresta.getEdades()).append("'");
                strSQL.append(",'").append(conciergeresta.getFechaD()).append("'");
                strSQL.append(",'").append(conciergeresta.getCodigo()).append("'");
                strSQL.append(",'").append(conciergeresta.getTelefono()).append("'");
                //strSQL.append(",'").append(conciergeresta.getFechaC()).append("'");
                strSQL.append(",'").append(conciergeresta.getOcasion()).append("'");
                strSQL.append(",'").append(conciergeresta.getclCallRest()).append("'");
                strSQL.append(",'").append(conciergeresta.getClSeccion()).append("'");
                strSQL.append(",'").append(conciergeresta.getHotel()).append("'");
                //strSQL.append(",'").append(conciergeresta.getFechaI()).append("'");
                strSQL.append(",'").append(conciergeresta.getReservacion()).append("'");
                //strSQL.append(",'").append(conciergeresta.getFechaO()).append("'");
                strSQL.append(",'").append(conciergeresta.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergeresta.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeresta.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeresta.getNumeroTC()).append("','");
                strSQL.append(conciergeresta.getExpira2()).append("'");
                strSQL.append(",'").append(conciergeresta.getSecC()).append("'");
                strSQL.append(",'").append(conciergeresta.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeresta.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergeresta.getPCancel()).append("'");
                strSQL.append(",'").append(conciergeresta.getNuInf()).append("'");
                strSQL.append(",'").append(conciergeresta.getTolerancia()).append("'");
                strSQL.append(",'").append(conciergeresta.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeresta.getEstatus()).append("'");
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
                strSQL.append("st_CSUpdateRestaurante '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergeresta.getNadultos()).append("'");
                strSQL.append(",'").append(conciergeresta.getNinos()).append("'");
                strSQL.append(",'").append(conciergeresta.getEdades()).append("'");
                strSQL.append(",'").append(conciergeresta.getFechaD()).append("'");
                strSQL.append(",'").append(conciergeresta.getCodigo()).append("'");
                strSQL.append(",'").append(conciergeresta.getTelefono()).append("'");
                //strSQL.append(",'").append(conciergeresta.getFechaC()).append("'");
                strSQL.append(",'").append(conciergeresta.getOcasion()).append("'");
                strSQL.append(",'").append(conciergeresta.getclCallRest()).append("'");
                strSQL.append(",'").append(conciergeresta.getClSeccion()).append("'");
                strSQL.append(",'").append(conciergeresta.getHotel()).append("'");
                //strSQL.append(",'").append(conciergeresta.getFechaI()).append("'");
                strSQL.append(",'").append(conciergeresta.getReservacion()).append("'");
                //strSQL.append(",'").append(conciergeresta.getFechaO()).append("'");
                strSQL.append(",'").append(conciergeresta.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergeresta.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeresta.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeresta.getNumeroTC()).append("','");
                strSQL.append(conciergeresta.getExpira2()).append("'");
                strSQL.append(",'").append(conciergeresta.getSecC()).append("'");
                strSQL.append(",'").append(conciergeresta.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergeresta.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergeresta.getPCancel()).append("'");
                strSQL.append(",'").append(conciergeresta.getNuInf()).append("'");
                strSQL.append(",'").append(conciergeresta.getTolerancia()).append("'");
                strSQL.append(",'").append(conciergeresta.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeresta.getEstatus()).append("'");
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
                    conciergeresta=null;
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