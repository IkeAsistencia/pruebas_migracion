/*
 * EjecutaCBGuardarExpediente.java
 *
 * Created on 14 de diciembre de 2006, 09:45 AM
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
 * @author zamoraed
 * @version
 */
public class EjecutaCBGuardarExpediente extends HttpServlet {
    

/*
 *
 * @author  zamoraed
 * @version
 */    
    /* Initializes the servlet.
     */ 
    private static Correo Cor = new Correo();
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

        //VARIABLES DECLARADAS SEGUN LOS CAMPOS QUE LA PÁGINA VENTAACUMULADOR.JSP CAPTURA
        
        String StrclExpediente = "0";
        String StrObservaciones ="";
        String StrclEstatus="0";
        String StrCopiaNum="0";
      
        ResultSet rsEx = null;
        ResultSet rsSx = null;
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Archivo de Expedientes</title>");
        out.println("</head>");
        out.println("<body>");
        
        if (request.getParameter("clUsrApp")!= null)
      	{ 
       		StrUsrApp = request.getParameter("clUsrApp").toString(); 
        }

       if (request.getParameter("clExpediente")!=null){
                   StrclExpediente = request.getParameter("clExpediente").toString();
                }
        
        if (request.getParameter("Observaciones")!=null){
            StrObservaciones = request.getParameter("Observaciones"); 
        }
 
       if (request.getParameter("clEstatusArch")!=null){
            StrclEstatus = request.getParameter("clEstatusArch");
        }
        
       if (request.getParameter("CopiaNum")!=null){
            StrCopiaNum = request.getParameter("CopiaNum");
        }
                
              try{
                    String strUrlBack=""; 
                    if(request.getParameter("URLBACK")!=null)
                    {
                          strUrlBack = request.getParameter("URLBACK");
                          
                    }
                   if (Integer.parseInt(request.getParameter("Action"))==2)
                   {   
                        
                    UtileriasBDF.ejecutaSQLNP("update CBArchivoExp set  Observaciones='" + StrObservaciones + "', clEstatusArch='" + StrclEstatus + "'  where clExpediente = " + StrclExpediente + " and CopiaNum=" + StrCopiaNum);  
                    System.out.println("update CBArchivoExp set  Observaciones='" + StrObservaciones + "', clEstatusArch='" + StrclEstatus + "'  where clExpediente = " + StrclExpediente  + " and CopiaNum=" + StrCopiaNum);
                    strUrlBack= strUrlBack + "&clExpediente=" + StrclExpediente + "&clUsrApp=" + StrUsrApp + "&CopiaNum=" + StrCopiaNum ;
                    out.println("<script>window.opener.fnValidaResponse(1,'"+ strUrlBack +"')</script>");     
                   }
              }    
               catch(Exception e){
                            out.println("<script>");
                            out.println("alert(\"Error al insertar, Favor verifique los datos e intentelo nuevamente\");");
                            out.println("</script>");
                            out.println("<script>window.opener.fnValidaError()</script>");
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
        
        try{
            if (rsSx!=null)
            {
              rsSx.close();
              rsSx=null;
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