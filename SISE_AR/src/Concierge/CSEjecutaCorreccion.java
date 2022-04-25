   /*
 * EjecutaAltaAfiliado.java
 *
 * Created on 4 de Mayo de 2005, 04:27 PM
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

/*
 *
 * @author
 * @version
 */
public class CSEjecutaCorreccion extends HttpServlet {
    
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
        //cAfiliado
        String StrUsrApp = "0";
        String StrclTipo = "0";
        String StrPermiteEliminarSeg = "0";
        String StrclEstatus = "0";
        String StrclAsistencia = "0";
        String StrFecha = "";
        String StrclSeguimientoProveedor = "0";
        String StrclProveedor ="0";
        String StrMensaje="";
        ResultSet rsEx = null;
        
        
        
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servicio de Correciones</title>");
        out.println("</head>");
        out.println("<body>");
        
        if (sessionH.getAttribute("clUsrApp")!=null){
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }
        
        if(request.getParameter("clTipo")!=null){
            StrclTipo = request.getParameter("clTipo");
        }
        
        if(request.getParameter("PermiteEliminarSeg")!=null){
            StrPermiteEliminarSeg = request.getParameter("PermiteEliminarSeg");
        }
        
        if(request.getParameter("clEstatus")!=null){
            StrclEstatus = request.getParameter("clEstatus");
        }
        
        if(request.getParameter("clAsistencia")!=null){
            StrclAsistencia = request.getParameter("clAsistencia");
        }
        
        
        
        if(request.getParameter("Fecha")!=null){
            StrFecha  = request.getParameter("Fecha").toString();
            
        }
        
        
        if(request.getParameter("clSeguimientoProveedor")!=null){
            StrclSeguimientoProveedor = request.getParameter("clSeguimientoProveedor");
        }
        
        if(request.getParameter("clProveedor")!=null){
            StrclProveedor = request.getParameter("clProveedor");
        }
        
        
        
        
        try{
            StringBuffer strSQL = new StringBuffer();
            if (StrclTipo.equalsIgnoreCase("1")) {
                if(StrPermiteEliminarSeg.equalsIgnoreCase("1")) {
                    strSQL.append("st_CSCorrigeSeg ").append(StrclAsistencia).append(",").append(StrclEstatus).append(",").append(StrUsrApp);
                    rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                    strSQL.delete(0,strSQL.length());
                    if (rsEx.next()) {
                        StrMensaje=rsEx.getString("Mensaje");
                        if (StrMensaje.equalsIgnoreCase("1")) {
                            out.println("<script> location.href='../Operacion/Concierge/BitacoraAsistencia.jsp?clAsistencia="+ StrclAsistencia +"';</script>");
                        } else {
                            out.println("No cuenta con Privilegios suficientes para realizar la Operacion");
                        }
                    }
                }
            }
            
            if (StrclTipo.equalsIgnoreCase("2"))  {
                if(StrPermiteEliminarSeg.equalsIgnoreCase("1")) {
                    strSQL.append("st_CSCorrigeSegProv ").append(StrclSeguimientoProveedor).append(",").append(StrclAsistencia).append(",").append(StrclEstatus).append(",");
                    strSQL.append(StrclProveedor).append(",").append(StrUsrApp);
                    rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                    strSQL.delete(0,strSQL.length());
                    if (rsEx.next()) {
                        StrMensaje=rsEx.getString("Mensaje");
                        if (StrMensaje.equalsIgnoreCase("1")) {
                            out.println("<script> location.href='../Operacion/Concierge/BitacoraAsistencia.jsp?clAsistencia="+ StrclAsistencia +"';</script>");
                        } else {
                            out.println("No cuenta con Privilegios suficientes para realizar la Operacion");
                        }
                    }
                    
                }
            }
            strSQL=null;
        } catch(Exception e){
            out.close();
            e.printStackTrace();
        } finally {
            try{
                if (rsEx!=null) {
                    rsEx.close();
                    rsEx=null;
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