/*
 * GeneraSMSAsignacion.java
 *
 * Created on 8 de febrero de 2007, 04:45 PM
 */
package com.ike.sms;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import Utilerias.UtileriasBDF;

/*
 *
 * @author pereac
 * @version
 */
public class GeneraSMSAsignacion extends HttpServlet {

    /* Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String StrclExpediente = "";
        String StrclUsrApp = "0";
        String StrclMensajeSMS = "";
        

        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente").toString();
        }

        if (request.getParameter("clUsrApp") != null) {
            StrclUsrApp = request.getParameter("clUsrApp").toString();
        }

        if (request.getParameter("clMensajeSMS") != null) {
            StrclMensajeSMS = request.getParameter("clMensajeSMS").toString();
        }
        
        /*System.out.println("st_SMSGeneraEnvioManual '" + StrclExpediente + "','" + StrclMensajeSMS + "','" + StrclUsrApp + "'");
        System.out.println("st_SMSGeneraEnvioManual '" + StrclExpediente + "','" + StrclMensajeSMS + "','" + StrclUsrApp + "'");*/
        
        UtileriasBDF.ejecutaSQLNP("st_SMSGeneraEnvioManual '" + StrclExpediente + "','" + StrclMensajeSMS + "','" + StrclUsrApp + "'");
        out.close();
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
    // </editor-fold>
}
