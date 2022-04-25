/*
 * RegistraLlamadaTMK.java
 *
 * Created on 28 de Agosto de 2006, 13:09 PM
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
import com.ike.concierge.to.Conciergebanquete;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaBanquete extends HttpServlet {
    
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
        Conciergebanquete conciergebanquete = new Conciergebanquete();
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
        
        conciergebanquete.setEvento(request.getParameter("Evento").toString().trim());
        conciergebanquete.setInvitadMos(request.getParameter("Invitados").toString().trim());
        conciergebanquete.setFechaEventoI(request.getParameter("FechaEventoI").toString().trim());
        conciergebanquete.setFechaEventoF(request.getParameter("FechaEventoF").toString().trim());
        conciergebanquete.setUbicacion(request.getParameter("Ubicacion").toString().trim());
        conciergebanquete.setCiudad(request.getParameter("Ciudad").toString().trim());
        conciergebanquete.setEstado(request.getParameter("Estado").toString().trim());
        conciergebanquete.setPais(request.getParameter("Pais").toString().trim());
        conciergebanquete.setCostoH(request.getParameter("CostoH").toString().trim());
        conciergebanquete.setHorasC(request.getParameter("HorasC").toString().trim());
        conciergebanquete.setCargoT(request.getParameter("CargoT").toString().trim());
        conciergebanquete.setCostoP(request.getParameter("CostoP").toString().trim());
        conciergebanquete.setCargosO(request.getParameter("CargosO").toString().trim());
        conciergebanquete.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergebanquete.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergebanquete.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergebanquete.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergebanquete.setExpira2(request.getParameter("Expira").toString().trim());
        conciergebanquete.setSecC(request.getParameter("SecC").toString().trim());
        conciergebanquete.setPagoO(request.getParameter("PagoO").toString().trim());
        conciergebanquete.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergebanquete.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergebanquete.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergebanquete.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergebanquete.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergebanquete.setEstatus(request.getParameter("clEstatus").toString().trim());
        conciergebanquete.setTelefono(request.getParameter("Telefono").toString().trim());
        conciergebanquete.setCelular(request.getParameter("Celular").toString().trim());
        
        
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
                
                strSQL.append("st_CSAltaBanquete '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergebanquete.getEvento()).append("'");
                strSQL.append(",'").append(conciergebanquete.getInvitadMos()).append("'");
                strSQL.append(",'").append(conciergebanquete.getFechaEventoI()).append("'");
                strSQL.append(",'").append(conciergebanquete.getFechaEventoF()).append("'");
                strSQL.append(",'").append(conciergebanquete.getUbicacion()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCiudad()).append("'");
                strSQL.append(",'").append(conciergebanquete.getEstado()).append("'");
                strSQL.append(",'").append(conciergebanquete.getPais()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCostoH()).append("'");
                strSQL.append(",'").append(conciergebanquete.getHorasC()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCargoT()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCostoP()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCargosO()).append("'");
                strSQL.append(",'").append(conciergebanquete.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergebanquete.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergebanquete.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergebanquete.getNumeroTC()).append("','").append(conciergebanquete.getExpira2()).append("'");
                strSQL.append(",'").append(conciergebanquete.getSecC()).append("'");
                strSQL.append(",'").append(conciergebanquete.getPagoO()).append("'");
                strSQL.append(",'").append(conciergebanquete.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergebanquete.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergebanquete.getPCancel()).append("'");
                strSQL.append(",'").append(conciergebanquete.getNuInf()).append("'");
                strSQL.append(",'").append(conciergebanquete.getComentarios()).append("'");
                strSQL.append(",'").append(conciergebanquete.getEstatus()).append("'");
                strSQL.append(",'").append(conciergebanquete.getTelefono()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCelular()).append("'");
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
                strSQL.append("st_CSUpdateBanquete '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergebanquete.getEvento()).append("'");
                strSQL.append(",'").append(conciergebanquete.getInvitadMos()).append("'");
                strSQL.append(",'").append(conciergebanquete.getFechaEventoI()).append("'");
                strSQL.append(",'").append(conciergebanquete.getFechaEventoF()).append("'");
                strSQL.append(",'").append(conciergebanquete.getUbicacion()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCiudad()).append("'");
                strSQL.append(",'").append(conciergebanquete.getEstado()).append("'");
                strSQL.append(",'").append(conciergebanquete.getPais()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCostoH()).append("'");
                strSQL.append(",'").append(conciergebanquete.getHorasC()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCargoT()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCostoP()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCargosO()).append("'");
                strSQL.append(",'").append(conciergebanquete.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergebanquete.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergebanquete.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergebanquete.getNumeroTC()).append("','").append(conciergebanquete.getExpira2()).append("'");
                strSQL.append(",'").append(conciergebanquete.getSecC()).append("'");
                strSQL.append(",'").append(conciergebanquete.getPagoO()).append("'");
                strSQL.append(",'").append(conciergebanquete.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergebanquete.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergebanquete.getPCancel()).append("'");
                strSQL.append(",'").append(conciergebanquete.getNuInf()).append("'");
                strSQL.append(",'").append(conciergebanquete.getComentarios()).append("'");
                strSQL.append(",'").append(conciergebanquete.getTelefono()).append("'");
                strSQL.append(",'").append(conciergebanquete.getCelular()).append("'");
                strSQL.append(",'").append(conciergebanquete.getEstatus()).append("'");
                
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
                    conciergebanquete=null;
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