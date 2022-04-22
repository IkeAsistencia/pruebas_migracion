/*
 * AutorizaImprimirExp.java
 *
 * Created on 12 de enero de 2007, 12:19 PM
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
 * @author  zamoraed 
 * @version
 */
public class AutorizaImprimirExp extends HttpServlet {
    
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
        String StrUsr = "0";
        String StrPwd = "0";
        String StrCita = "0";
        String StrFechaCita = "";
        String StrclExpediente = "0";
        String strMess = "";
        boolean blnAutorizado = false;
        ResultSet rsAut = null;
        ResultSet rsEx = null;
          
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Autorización de Impresión de Expedientes Repetidos</title>");
        out.println("</head>");
        out.println("<body>");

        
         if(request.getParameter("Usr")!=null){
            StrUsr = request.getParameter("Usr");
        }
        
         if(request.getParameter("Pass")!=null){
            StrPwd = request.getParameter("Pass");
        }
 try{
          if (StrUsr.compareToIgnoreCase("")==0){
                        // No entró por la página de autorización, es directamente del expediente
                        blnAutorizado = false;
                        strMess = "Debe informar usuario para autorizar el servicio";                            
                    }
                    else{
                        if (StrPwd.compareToIgnoreCase("")==0){
                            blnAutorizado = false;
                            strMess = "Debe informar contraseña para autorizar el servicio";                            
                        }
                        else{
                            rsAut = UtileriasBDF.rsSQLNP("sp_EncriptDesEncriptPassword '" + StrUsr + "',0,'', 0");    
                            if (rsAut.next()){
                                if (StrPwd.compareToIgnoreCase(rsAut.getString("password"))==0){
                                        blnAutorizado = true;
                                }
                                else{
                                    blnAutorizado = false;
                                    strMess = "Contraseña Incorrecta";                            
                                }
                              rsEx = UtileriasBDF.rsSQLNP("if exists (select  Consulta from AccesoGpoXPag A inner join UsrxGpo UG on (A.clGpoUsr = UG.clGpoUsr) where A.clPaginaWeb=682 and UG.clUsrApp = " + rsAut.getString("clUsrApp") + " and Consulta=1) select 1 'Consulta' else select 0 'Consulta'" );
                                 if (rsEx.next()){
                                    if (rsEx.getString("Consulta").compareToIgnoreCase("0")==0){
                                    	blnAutorizado = false;
                		        strMess = "Usuario no autorizado para reimprimir Expedientes.";
                                    }
                                 }
                            }else{
                                blnAutorizado = false;
                                strMess = "Usuario Incorrecto";
                            }
                        }
                    }
               
                    if (blnAutorizado==false){
                        out.println("<script> alert('" + strMess + "');window.close();</script>");
                    }else{
                        out.println("<script> window.opener.document.Forma3.submit();window.close();</script>");
                    }
                out.println("</body>");            
                out.println("</html>");            
        
        out.close();
    
   }catch(Exception e){
            e.printStackTrace();
            out.close();
            rsAut = null;
            rsEx = null;

//            this.destroy();
        }
//        this.destroy();        
        
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