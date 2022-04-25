/*
 * LlenaMDAjax.java
 *
 * Created on 20 de abril de 2010, 09:19 PM
 */
package Combos;

import java.io.*;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

/*
 *
 * @author mescobar
 * @version
 */
public class LlenaMDAjax extends HttpServlet {

    /* Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        System.out.println("Entra servlet LlenaMDAjax");
        PrintWriter out = response.getWriter();

        String Opcion = "";
        String StrIdCombo = "";
        String StrLabel = "";
        String StrFnCombo = "";
        String StrQry = "";

        if (request.getParameter("Opcion") != null) {
            Opcion = request.getParameter("Opcion").toString();

        }

        if (request.getParameter("IdCombo") != null) {
            StrIdCombo = request.getParameter("IdCombo").toString();
        }

        if (request.getParameter("Label") != null) {
            StrLabel = request.getParameter("Label").toString();
        }

        if (request.getParameter("FnCombo") != null) {
            StrFnCombo = request.getParameter("FnCombo").toString();
        }

        if (request.getParameter("SqlQry") != null) {
            StrQry = request.getParameter("SqlQry").toString();
        }

        System.out.println("Opc=" + Opcion + " Id=" + StrIdCombo + " Label=" + StrLabel + " FnCombo=" + StrFnCombo + " SqlQry=" + StrQry);

        Entidad hshObj = (Entidad) (cbEntidad.getComboHash().get(Opcion));
        StringBuffer strSelectHTML = new StringBuffer();


        if (hshObj != null) {
            List tempList = hshObj.getLstMunicipio();
            int x = 0;
            int xR = 1;
            if (tempList != null) {
                for (x = 0; x < tempList.size(); x++, xR++) {
                    Municipio cbMun = (Municipio) tempList.get(x);
                    strSelectHTML.append("<option value='").append(cbMun.getStrCodMD()).append("'>").append(cbMun.getStrDescripcion()).append("</option>");
                }
            }
        }

        out.print("<p class='FTable'>" + StrLabel + "<br>");
        out.print("<select class='VTable' id='" + StrIdCombo + "C' name='" + StrIdCombo + "C' onChange='document.all." + StrIdCombo + ".value = this.value; " + StrFnCombo + "' label='" + StrLabel + "' >");
        out.print("<option value='' >SELECCIONE OPCIÓN</option>");
        out.print(" " + strSelectHTML.toString());
        out.print("</select>");
        out.print("<input type='hidden' id='" + StrIdCombo + "' name='" + StrIdCombo + "' value=''></p>");

        Opcion = null;
        StrIdCombo = null;
        StrLabel = null;
        StrFnCombo = null;
        StrQry = null;
        strSelectHTML.delete(0, strSelectHTML.length());
        strSelectHTML = null;

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
