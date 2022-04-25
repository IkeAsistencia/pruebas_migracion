/*
 * LlenaSubCategorias.java
 *
 * Created on 7 de septiembre de 2006, 07:51 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package Combos;

/*
 *
 * @author cabrerar
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

public class LlenaSubCategorias extends HttpServlet {
    
    /* Creates a new instance of LlenaSubCategorias */
    public LlenaSubCategorias() {
    }
    
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
       
        PrintWriter out = response.getWriter();
        String StrCodParent = request.getParameter("clCategoria");
        String StrName = request.getParameter("strName");
        
        response.setContentType("text/html");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Llena SubCategorías</title>");
                out.println("</head>");
                out.println("<body><script>");
                
        CSCategoria hshObj = (CSCategoria)(cbCSReferencia.getComboHash().get(StrCodParent));        
        StringBuffer strSelectHTML = new StringBuffer();
        
        if (hshObj!=null){
            List tempList = hshObj.getLstSubCategoria();
            int x=0;
            int xR = 1;
            if (tempList!=null){
                for(x=0; x<tempList.size(); x++, xR++)
                {
                    CSSubCategoria cbSub = (CSSubCategoria)tempList.get(x);
                    strSelectHTML.append("<option value='").append(cbSub.getClSubCategoria()).append("'>").append(cbSub.getDescripcion()).append("</option>"); 
                }
            }
        }
        out.println("top.opener.fnReplaceSelect('"+StrName+"',\""+ strSelectHTML.toString() +"\");");
        strSelectHTML.delete(0,strSelectHTML.length());
        out.println("window.close();</script></body>");
        out.println("</html>");
        out.close();
        StrCodParent=null;
        StrName=null;
        this.destroy();
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