/*
 * EjecutaEliminaPagos.java
 *
 * Created on 4 de Mayo de 2005, 04:27 PM
 */

package Utilerias;

import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException; 
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/*
 *
 * @author  perezern
 * @version
 */
public class EjecutaEliminaPagos extends HttpServlet {
    
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
        String StrclPagoProveedor = "0";
        String StrclExpediente = "0";
        ResultSet rsEx = null;
        
        
        
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Elimina Pago Proveedor</title>");
        out.println("</head>");
        out.println("<body>");

       if (sessionH.getAttribute("clUsrApp")!=null){
                   StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
                } 
        
         if(request.getParameter("clPagoProveedor")!=null){
            StrclPagoProveedor = request.getParameter("clPagoProveedor"); 
        }
       
        if(request.getParameter("clExpediente")!=null){
            StrclExpediente = request.getParameter("clExpediente");
        
        }
        
       
                
               
              try{
                    String strUrlBack="";
                    if(request.getParameter("URLBACK")!=null)
                    {
                          strUrlBack = request.getParameter("URLBACK");
                    }
                  rsEx = UtileriasBDF.rsSQLNP("sp_EliminaPago " + StrclExpediente + "," +StrclPagoProveedor );
                   strUrlBack=strUrlBack + "clExpediente=" + StrclExpediente + "&clPagoProveedor=" + StrclPagoProveedor;
                   out.println("<script>window.opener.fnValidaResponse(1,'"+ strUrlBack +"')</script>"); 
              }    
               catch(Exception e){
            out.close();
            e.printStackTrace();
//            this.destroy();
        }
        finally 
        {
          try{
            if (rsEx!=null)
            {
              rsEx.close();
              rsEx=null;
            }
          }
          catch(Exception ee)
          {
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