/*
 * EjecutaGuardaBtaView.java
 *
 * Created on 17 de mayo de 2010, 08:00 AM
 */
package Utilerias;

import java.io.*;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.*;
import javax.servlet.http.*;

/*
 *
 * @author
 * mcmdelao
 * @version
 */
public class EjecutaGuardaBtaView extends HttpServlet {

    /*
     * Processes
     * requests
     * for
     * both
     * HTTP
     * <code>GET</code>
     * and
     * <code>POST</code>
     * methods.
     *
     * @param
     * request
     * servlet
     * request
     * @param
     * response
     * servlet
     * response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ResultSet rsInfo = null;
        ResultSet rs = null;

        String strLlave = "";
        String strLlaveValue = "";
        String strNameF = "";
        String StrclUsrApp = "0";
        String StrclPaginaWeb = "0";
        String StrclExpediente = "0";
        String StrContenido = "";

        HttpSession sessionH = request.getSession(false);
        ResultSet rsEx = null;
        StringBuffer strSQL = new StringBuffer();

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrclUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }

        if (sessionH.getAttribute("clPaginaWebP") != null) {
            StrclPaginaWeb = sessionH.getAttribute("clPaginaWebP").toString();
        }

        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente");
        }

        if (request.getParameter("Contenido") != null) {
            StrContenido = request.getParameter("Contenido");
        }

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet EjecutaGuardaBtaView</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("</body>");
        out.println("</html>");

        /*
         * ****************************************************
         */
        rs = UtileriasBDF.rsSQLNP("select Tabla, coalesce(TablaBitacora,'') TablaBitacora from cPaginaWeb where clPaginaWeb = " + sessionH.getAttribute("clPaginaWebP"));

        try {
            if (rs.next()) {
                rsInfo = UtileriasBDF.rsSQLNP("sp_GetInfoTabla " + rs.getString("Tabla"));

                while (rsInfo.next()) {
                    strNameF = rsInfo.getString("NameF");

                    if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                        if (strLlave.equalsIgnoreCase("")) {
                            strLlave = rsInfo.getString("NameF");
                        } else {
                            strLlave = strLlave + "&" + strNameF + "=" + rsInfo.getString("NameF");
                        }
                    }

                    if (request.getParameter(strNameF) != null) {
                        if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                            if (strLlaveValue.equalsIgnoreCase("")) {
                                strLlaveValue = request.getParameter(strNameF);
                            } else {
                                strLlaveValue = strLlaveValue + "&" + strNameF + "=" + request.getParameter(strNameF);
                            }
                        }
                    } else {
                        if (sessionH.getAttribute(rsInfo.getString("NameF")) != null) {
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                if (strLlaveValue.equalsIgnoreCase("")) {
                                    strLlaveValue = sessionH.getAttribute(rsInfo.getString("NameF")).toString();
                                } else {
                                    strLlaveValue = strLlaveValue + "&" + strNameF + "=" + sessionH.getAttribute(rsInfo.getString("NameF")).toString();
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }

        strSQL.append("'").append(StrclPaginaWeb).append("','");
        strSQL.append(StrclUsrApp).append("','");
        strSQL.append(StrclExpediente).append("','");
        strSQL.append(strLlave).append("','");
        strSQL.append(strLlaveValue).append("','");
        strSQL.append(StrContenido).append("'");

        //System.out.println(">>>>> st_GuardaBtaView " + strSQL.toString());
        rsEx = UtileriasBDF.rsSQLNP("st_GuardaBtaView " + strSQL.toString());

        try {
            if (rsEx.next()) {
                out.println("<script>window.close();</script>");
            }

        } catch (Exception e) {
            out.close();
            e.printStackTrace(System.out);
        } finally {

            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace(System.out);
            }

            StrclUsrApp = null;
            StrclPaginaWeb = null;
            strSQL = null;
        }
        out.println("</body>");
        out.println("</html>");
        out.close();
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
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}
