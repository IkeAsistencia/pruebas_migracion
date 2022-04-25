/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilerias;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 *
 * @author mescobar
 */
public class LlenaCombosAjax extends HttpServlet {

    /*
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            //System.out.println("Entra servlet LlenaCombosAjax");

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

            if (request.getParameter("strSQL") != null) {
                StrQry = request.getParameter("strSQL").toString();
            }

            System.out.println("Opc=" + Opcion + " Id=" + StrIdCombo + " Label=" + StrLabel + " SqlQry=" + StrQry);

            ResultSet rs = null;
            StringBuffer op = new StringBuffer();
            // String op = null;



            op.append("<p class='FTable'>").append(StrLabel).append("<br>");
            op.append("<select class='VTable' id='").append(StrIdCombo).append("C' name='").append(StrIdCombo).append("C' onChange='document.all.").append(StrIdCombo).append(".value = this.value; ").append(StrFnCombo).append("' label='").append(StrLabel).append("' >");
            op.append("<option value='' >SELECCIONE OPCION</option>");

            try {

                rs = UtileriasBDF.rsSQLNP("execute " + StrQry);

                while (rs.next()) {
                    //// el order de las columnas en la salida del qry debe ser clave, descripcion ej: CodMD,dsMunDel                    
                    op.append(" <option value='").append(rs.getString(1)).append("'>").append(rs.getString(2)).append("</option>");
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            } finally {

                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                    rs = null;
                }
            }

            op.append("</select>");
            op.append("<input type='hidden' id='").append(StrIdCombo).append("' name='").append(StrIdCombo).append("' value=''></p>");

            //System.out.println(op.toString());

            out.print(op.toString());

            Opcion = null;
            StrIdCombo = null;
            StrLabel = null;
            StrFnCombo = null;
            StrQry = null;
            op = null;

        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /*
     * Handles
     * the
     * HTTP
     * <code>GET</code>
     * method.
     *
     * @param
     * request
     * servlet
     * request
     * @param
     * response
     * servlet
     * response
     * @throws
     * ServletException
     * if
     * a
     * servlet-specific
     * error
     * occurs
     * @throws
     * IOException
     * if
     * an
     * I/O
     * error
     * occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /*
     * Handles
     * the
     * HTTP
     * <code>POST</code>
     * method.
     *
     * @param
     * request
     * servlet
     * request
     * @param
     * response
     * servlet
     * response
     * @throws
     * ServletException
     * if
     * a
     * servlet-specific
     * error
     * occurs
     * @throws
     * IOException
     * if
     * an
     * I/O
     * error
     * occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /*
     * Returns
     * a
     * short
     * description
     * of
     * the
     * servlet.
     *
     * @return
     * a
     * String
     * containing
     * servlet
     * description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}