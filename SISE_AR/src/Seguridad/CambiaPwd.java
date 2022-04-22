/*
 * CambiaPwd.java
 *
 * Created on 30 de octubre de 2017
 */
package Seguridad;

import Utilerias.ResultList;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;
import javax.servlet.ServletConfig;

/**
 *
 * @author lopgui
 * @version
 */
public class CambiaPwd extends HttpServlet {

    /**
     * Initializes the servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

    }

    /**
     * Destroys the servlet.
     */
    public void destroy() {

    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        response.setContentType("text/html");
        
        response.setHeader("Cache-control", "no-cache,no-store");
        response.setHeader("Pragma", "no-cache");
        
        PrintWriter out = response.getWriter();
        ResultList rs =null;
        String Password = "";
              
        Password=request.getParameter("Password");

        Password=Password.replaceAll("(?i)"+"waitfor delay","");  
        Password=Password.replaceAll("(?i)"+"waitfor","");
        Password=Password.replaceAll("(?i)"+"delay",""); 
        Password=Password.replaceAll("(?i)"+"select","");  
        Password=Password.replaceAll("(?i)"+"insert",""); 
        Password=Password.replaceAll("(?i)"+"into",""); 
        Password=Password.replaceAll("(?i)"+"values",""); 
        Password=Password.replaceAll("(?i)"+"delete",""); 
        Password=Password.replaceAll("(?i)"+"update",""); 
        Password=Password.replaceAll("(?i)"+"drop",""); 
        Password=Password.replaceAll("(?i)"+"exec",""); 
        Password=Password.replaceAll("(?i)"+"execute",""); 
        Password=Password.replaceAll("(?i)"+"truncate",""); 
        Password=Password.replaceAll("(?i)"+"from","");         
        Password=Password.replaceAll("(?i)"+"'",""); 
        Password=Password.replaceAll("(?i)"+"\"",""); 
        Password=Password.replaceAll("(?i)"+"<",""); 
        Password=Password.replaceAll("(?i)"+">",""); 
        
        String usr = (request.getParameter("clUsrApp")!=null?request.getParameter("clUsrApp"):"");
        
        usr=usr.replaceAll("(?i)"+"waitfor delay","");  
        usr=usr.replaceAll("(?i)"+"waitfor","");
        usr=usr.replaceAll("(?i)"+"delay",""); 
        usr=usr.replaceAll("(?i)"+"select","");  
        usr=usr.replaceAll("(?i)"+"insert",""); 
        usr=usr.replaceAll("(?i)"+"into",""); 
        usr=usr.replaceAll("(?i)"+"values",""); 
        usr=usr.replaceAll("(?i)"+"delete",""); 
        usr=usr.replaceAll("(?i)"+"update",""); 
        usr=usr.replaceAll("(?i)"+"drop",""); 
        usr=usr.replaceAll("(?i)"+"exec",""); 
        usr=usr.replaceAll("(?i)"+"execute",""); 
        usr=usr.replaceAll("(?i)"+"truncate",""); 
        usr=usr.replaceAll("(?i)"+"from","");         
        usr=usr.replaceAll("(?i)"+"'",""); 
        usr=usr.replaceAll("(?i)"+"\"",""); 
        usr=usr.replaceAll("(?i)"+"<",""); 
        usr=usr.replaceAll("(?i)"+">",""); 
        
        String Conf = (request.getParameter("Confirma")!=null?request.getParameter("Confirma"):"");
        
        Conf=Conf.replaceAll("(?i)"+"waitfor delay","");  
        Conf=Conf.replaceAll("(?i)"+"waitfor","");
        Conf=Conf.replaceAll("(?i)"+"delay",""); 
        Conf=Conf.replaceAll("(?i)"+"select","");  
        Conf=Conf.replaceAll("(?i)"+"insert",""); 
        Conf=Conf.replaceAll("(?i)"+"into",""); 
        Conf=Conf.replaceAll("(?i)"+"values",""); 
        Conf=Conf.replaceAll("(?i)"+"delete",""); 
        Conf=Conf.replaceAll("(?i)"+"update",""); 
        Conf=Conf.replaceAll("(?i)"+"drop",""); 
        Conf=Conf.replaceAll("(?i)"+"exec",""); 
        Conf=Conf.replaceAll("(?i)"+"execute",""); 
        Conf=Conf.replaceAll("(?i)"+"truncate",""); 
        Conf=Conf.replaceAll("(?i)"+"from","");         
        Conf=Conf.replaceAll("(?i)"+"'",""); 
        Conf=Conf.replaceAll("(?i)"+"\"",""); 
        Conf=Conf.replaceAll("(?i)"+"<",""); 
        Conf=Conf.replaceAll("(?i)"+">",""); 
        
        if ( sessionH == null || usr.isEmpty() ) {
            out.println("Error de sesion");
        } 
        else 
        {
        
       // System.out.println("Hola1 "+Password);
        
        /* Ejecuta el Procedure de cambio de password */
        try {
            String StrCodeResponse = "";
            String StrMsg = "";
            StringBuffer StrSql = new StringBuffer();
            String StrIP = "";
            if (sessionH.getAttribute("IP") != null) {
                StrIP = sessionH.getAttribute("IP").toString();
            }            
            StrSql.append("sp_CambiaPassword '");
            StrSql.append(usr);
            StrSql.append("' ,'', '");
            StrSql.append(Password);
            StrSql.append("','");
            StrSql.append(Conf);
            //StrSql.append(request.getParameter("Confirma").toUpperCase());
            StrSql.append("'");
            StrSql.append(",'");
            StrSql.append(StrIP);
            StrSql.append("'");
            
           // System.out.println("Hola2 "+StrSql);
            
            rs=new ResultList();
            rs.rsSQL(StrSql.toString());
            if(rs!=null){
                while(rs.next()){
                    StrCodeResponse = rs.getString("CodeResponse");
                    StrMsg = rs.getString("msg");
                }
                rs.close();
                rs = null;
            }
            StrSql.delete(0, StrSql.length());                        
            out.println("<script> window.opener.fnValidaResponse( " + StrCodeResponse + ",'" + request.getRequestURI().substring(0, request.getRequestURI().lastIndexOf(":") + 1) + "/SIAIKE/Seguridad/CambiaPwd.jsp','" + StrMsg + "')</script>");
            sessionH.removeAttribute("Pass");
            sessionH.removeAttribute("Confirma");
            StrCodeResponse = null;
            StrMsg = null;
            StrIP = null;
            out.close();
        } catch (Exception e) {
            out.close();
            e.printStackTrace();
        }

      }
        
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }

}
