/*
 * LlenaMD.java
 *
 * Created on 26 de septiembre de 2005, 06:01 PM
 */

package Combos;

/**
 *
 * @author  cabrerar
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import Combos.cbEntidad;    
import Combos.Municipio;
import Utilerias.ResultList;

/**
 *
 * @author  cabrerar
 * @version
 */
public class LlenaFalla extends HttpServlet {

    /** Initializes the servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    
    /** Destroys the servlet.
     */
    public void destroy() {
        
    }
    
    /** Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
       
        PrintWriter out = response.getWriter();
        String StrclUbFallaH = request.getParameter("clUbFallaH");
        String StrclSubServicio = request.getParameter("clSubServicio");
        String StrName = request.getParameter("strName");
                
        response.setContentType("text/html");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Llena Falla</title>");
                out.println("</head>");
                out.println("<body><script>");
        
        StringBuffer strSelectHTML = new StringBuffer();
    
          ResultList resultList=null;
          resultList=new ResultList();
          resultList.rsSQL("st_getTipoFalla "+ StrclUbFallaH + " , " + StrclSubServicio );
          
          System.out.println("Llena Falla");
          
          if(resultList!=null){
                      while (resultList.next()) {
                       strSelectHTML.append("<option value='").append(resultList.getString("clTipoFallaH")).append("'>").append(resultList.getString("dsTipoFallaH")).append("</option>"); 
                       //strSelectHTML.append("<option value='").append(resultList.getString("dsTipoFallaH")).append("</option>"); 
                      
                      }
                      
                      System.out.println("Ejecuta SP" + strSelectHTML);  
          }          
          out.println("top.opener.fnReplaceSelect('"+StrName+"',\""+ strSelectHTML.toString() +"\");");   
               

        strSelectHTML.delete(0,strSelectHTML.length());
        out.println("window.close();</script></body>");
        out.println("</html>");
        out.close();
        StrclUbFallaH = null;
        StrclSubServicio = null;
        StrName = null;
        this.destroy();
    }
    
    /** Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
    
}
