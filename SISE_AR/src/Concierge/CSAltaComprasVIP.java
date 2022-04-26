/*
 * CSAltaVentaVIP.java
 *
 * Created on 08 de Febrero de 2007, 13:09 PM
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
import com.ike.concierge.to.Conciergecomprasvip;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaComprasVIP extends HttpServlet {
    
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
        Conciergecomprasvip conciergecomprasvip = new Conciergecomprasvip();
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
        
        conciergecomprasvip.setDsArticulo(request.getParameter("dsArticulo").toString().trim());
        conciergecomprasvip.setCosto(request.getParameter("Costo").toString().trim());
        conciergecomprasvip.setDestinatario(request.getParameter("Destinatario").toString().trim());
        conciergecomprasvip.setDireccion(request.getParameter("Direccion").toString().trim());
        conciergecomprasvip.setCiudad(request.getParameter("Ciudad").toString().trim());
        conciergecomprasvip.setEstado(request.getParameter("Estado").toString().trim());
        conciergecomprasvip.setPais(request.getParameter("Pais").toString().trim());
        conciergecomprasvip.setTelefonoD(request.getParameter("TelefonoD").toString().trim());
        conciergecomprasvip.setOtroTelD(request.getParameter("OtroTelD").toString().trim());
        conciergecomprasvip.setFechaE(request.getParameter("FechaE").toString().trim());
        conciergecomprasvip.setMetodo(request.getParameter("Metodo").toString().trim());
        conciergecomprasvip.setMensajeria(request.getParameter("Mensajeria").toString().trim());
        conciergecomprasvip.setGuia(request.getParameter("Guia").toString().trim());
        conciergecomprasvip.setCargoT(request.getParameter("CargoT").toString().trim());
        conciergecomprasvip.setRemitente(request.getParameter("Remitente").toString().trim());
        conciergecomprasvip.setTelefono(request.getParameter("Telefono").toString().trim());
        conciergecomprasvip.setCelular(request.getParameter("Celular").toString().trim());
        conciergecomprasvip.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergecomprasvip.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergecomprasvip.setNombreTC(request.getParameter("NombreTC").toString().trim());
        //conciergecomprasvip.setClTipoTarjeta(request.getParameter("clTipoTarjeta").toString().trim());
        conciergecomprasvip.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergecomprasvip.setExpira(request.getParameter("Expira").toString().trim());
        conciergecomprasvip.setSecC(request.getParameter("SecC").toString().trim());
        conciergecomprasvip.setPagoO(request.getParameter("PagoO").toString().trim());
        conciergecomprasvip.setConfirmo(request.getParameter("Confirmo").toString().trim());
        conciergecomprasvip.setNConfirmo(request.getParameter("NConfirmo").toString().trim());
        conciergecomprasvip.setPCancel(request.getParameter("PCancel").toString().trim());
        conciergecomprasvip.setNuInf(request.getParameter("NuInf").toString().trim());
        conciergecomprasvip.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergecomprasvip.setEstatus(request.getParameter("clEstatus").toString().trim());
        
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
                
                strSQL.append("st_CSAltaCompraVip '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getDsArticulo()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getCosto()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getDestinatario()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getDireccion()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getCiudad()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getEstado()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getPais()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getTelefonoD()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getOtroTelD()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getFechaE()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getMetodo()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getMensajeria()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getGuia()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getCargoT()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getRemitente()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getTelefono()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getCelular()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getNombreTC()).append("'");
                //strSQL.append(conciergecomprasvip.getClTipoTarjeta()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getNumeroTC()).append("','");
                strSQL.append(conciergecomprasvip.getExpira()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getSecC()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getPagoO()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getPCancel()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getNuInf()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getComentarios()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getEstatus()).append("'");
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
                strSQL.append("st_CSUpdateCompraVIP '").append(clAsistenciaG).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getDsArticulo()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getCosto()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getDestinatario()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getDireccion()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getCiudad()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getEstado()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getPais()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getTelefonoD()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getOtroTelD()).append("'");                
                strSQL.append(",'").append(conciergecomprasvip.getFechaE()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getMetodo()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getMensajeria()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getGuia()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getCargoT()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getRemitente()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getTelefono()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getCelular()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getNombreTC()).append("'");
                //strSQL.append(conciergecomprasvip.getClTipoTarjeta()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getNumeroTC()).append("','");
                strSQL.append(conciergecomprasvip.getExpira()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getSecC()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getPagoO()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getConfirmo()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getNConfirmo()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getPCancel()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getNuInf()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getComentarios()).append("'");
                strSQL.append(",'").append(conciergecomprasvip.getEstatus()).append("'");
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
                    conciergecomprasvip=null;
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