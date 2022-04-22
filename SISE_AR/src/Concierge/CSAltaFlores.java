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
import com.ike.concierge.to.Conciergeflores;

/*
 *
 * @author  perezern
 * @version
 */
public class CSAltaFlores extends HttpServlet {
    
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
        Conciergeflores conciergeflores = new Conciergeflores();
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
        
        conciergeflores.setDestinatario(request.getParameter("Destinatario").toString().trim());
        conciergeflores.setDireccion(request.getParameter("Direccion").toString().trim());
        conciergeflores.setCiudad(request.getParameter("Ciudad").toString().trim());
        conciergeflores.setEstado(request.getParameter("Estado").toString().trim());
        conciergeflores.setPais(request.getParameter("Pais").toString().trim());
        conciergeflores.setTelefonoD(request.getParameter("TelefonoD").toString().trim());
        conciergeflores.setCelularD(request.getParameter("CelularD").toString().trim());
        conciergeflores.setFechaE(request.getParameter("FechaE").toString().trim());
        conciergeflores.setRemitente(request.getParameter("Remitente").toString().trim());
        conciergeflores.setTelefonoR(request.getParameter("TelefonoR").toString().trim());
        conciergeflores.setCelularR(request.getParameter("CelularR").toString().trim());
        conciergeflores.setEvento(request.getParameter("Evento").toString().trim());
        conciergeflores.setCargoT(request.getParameter("CargoT").toString().trim());
        conciergeflores.setArreglo(request.getParameter("Arreglo").toString().trim());
        conciergeflores.setAdicionales(request.getParameter("Adicionales").toString().trim());
        conciergeflores.setDescripcion(request.getParameter("Descripcion").toString().trim());
        conciergeflores.setMensaje(request.getParameter("Mensaje").toString().trim());
        conciergeflores.setClTipoPago(request.getParameter("clTipoPago").toString().trim());
        conciergeflores.setNomBanco(request.getParameter("NomBanco").toString().trim());
        conciergeflores.setNombreTC(request.getParameter("NombreTC").toString().trim());
        conciergeflores.setNumeroTC(request.getParameter("NumeroTC").toString().trim());
        conciergeflores.setExpira2(request.getParameter("Expira").toString().trim());
        conciergeflores.setSecC(request.getParameter("SecC").toString().trim());
        conciergeflores.setFloristaC(request.getParameter("FloristaC").toString().trim());
        conciergeflores.setRecibio(request.getParameter("Recibio").toString().trim());
        conciergeflores.setComentarios(request.getParameter("Comentarios").toString().trim());
        conciergeflores.setEstatus(request.getParameter("clEstatus").toString().trim());
        
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
                
                strSQL.append("st_CSAltaFlores '").append(clConcierge).append("','").append(FechaApAsist).append("','").append(StrUsrApp).append("'");
                strSQL.append(",'").append(conciergeflores.getDestinatario()).append("'");
                strSQL.append(",'").append(conciergeflores.getDireccion()).append("'");
                strSQL.append(",'").append(conciergeflores.getCiudad()).append("'");
                strSQL.append(",'").append(conciergeflores.getEstado()).append("'");
                strSQL.append(",'").append(conciergeflores.getPais()).append("'");
                strSQL.append(",'").append(conciergeflores.getTelefonoD()).append("'");
                strSQL.append(",'").append(conciergeflores.getCelularD()).append("'");
                strSQL.append(",'").append(conciergeflores.getFechaE()).append("'");
                strSQL.append(",'").append(conciergeflores.getRemitente()).append("'");
                strSQL.append(",'").append(conciergeflores.getTelefonoR()).append("'");
                strSQL.append(",'").append(conciergeflores.getCelularR()).append("'");
                strSQL.append(",'").append(conciergeflores.getEvento()).append("'");
                strSQL.append(",'").append(conciergeflores.getCargoT()).append("'");
                strSQL.append(",'").append(conciergeflores.getArreglo()).append("'");
                strSQL.append(",'").append(conciergeflores.getAdicionales()).append("'");
                strSQL.append(",'").append(conciergeflores.getDescripcion()).append("'");
                strSQL.append(",'").append(conciergeflores.getMensaje()).append("'");
                strSQL.append(",'").append(conciergeflores.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergeflores.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeflores.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeflores.getNumeroTC()).append("','");
                strSQL.append(conciergeflores.getExpira2()).append("'");
                strSQL.append(",'").append(conciergeflores.getSecC()).append("'");
                strSQL.append(",'").append(conciergeflores.getFloristaC()).append("'");
                strSQL.append(",'").append(conciergeflores.getRecibio()).append("'");
                strSQL.append(",'").append(conciergeflores.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeflores.getEstatus()).append("'");
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
                strSQL.append("st_CSUpdateFlores '").append(clAsistenciaG).append("'");
                            strSQL.append(",'").append(conciergeflores.getDestinatario()).append("'");
                strSQL.append(",'").append(conciergeflores.getDireccion()).append("'");
                strSQL.append(",'").append(conciergeflores.getCiudad()).append("'");
                strSQL.append(",'").append(conciergeflores.getEstado()).append("'");
                strSQL.append(",'").append(conciergeflores.getPais()).append("'");
                strSQL.append(",'").append(conciergeflores.getTelefonoD()).append("'");
                strSQL.append(",'").append(conciergeflores.getCelularD()).append("'");
                strSQL.append(",'").append(conciergeflores.getFechaE()).append("'");
                strSQL.append(",'").append(conciergeflores.getRemitente()).append("'");
                strSQL.append(",'").append(conciergeflores.getTelefonoR()).append("'");
                strSQL.append(",'").append(conciergeflores.getCelularR()).append("'");
                strSQL.append(",'").append(conciergeflores.getEvento()).append("'");
                strSQL.append(",'").append(conciergeflores.getCargoT()).append("'");
                strSQL.append(",'").append(conciergeflores.getArreglo()).append("'");
                strSQL.append(",'").append(conciergeflores.getAdicionales()).append("'");
                strSQL.append(",'").append(conciergeflores.getDescripcion()).append("'");
                strSQL.append(",'").append(conciergeflores.getMensaje()).append("'");
                strSQL.append(",'").append(conciergeflores.getClTipoPago()).append("'");
                strSQL.append(",'").append(conciergeflores.getNomBanco()).append("'");
                strSQL.append(",'").append(conciergeflores.getNombreTC()).append("'");
                strSQL.append(",'").append(conciergeflores.getNumeroTC()).append("','");
                strSQL.append(conciergeflores.getExpira2()).append("'");
                strSQL.append(",'").append(conciergeflores.getSecC()).append("'");
                strSQL.append(",'").append(conciergeflores.getFloristaC()).append("'");
                strSQL.append(",'").append(conciergeflores.getRecibio()).append("'");
                strSQL.append(",'").append(conciergeflores.getComentarios()).append("'");
                strSQL.append(",'").append(conciergeflores.getEstatus()).append("'");
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
                    conciergeflores=null;
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