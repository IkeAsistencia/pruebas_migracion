/*
 * GuardaServicioDomVet.java
 *
 * Created on 4 de septiembre de 2007, 03:34 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.guarda;

import com.ike.asistencias.to.ServicioDomVet;
import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import Utilerias.UtileriasBDF;

/*
 *
 * @author rfernandez
 */
public class GuardaServicioDomVet extends HttpServlet {

    /*
     * Creates a new instance of GuardaServicioDomVet
     */
    public GuardaServicioDomVet() {
    }

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void destroy() {
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);

        ResultSet rsEx = null;
        StringBuffer strSQL = new StringBuffer();

        String Error = "0";
        response.setContentType("text/html");

        ServicioDomVet SeDoV = new ServicioDomVet();

        PrintWriter out = response.getWriter();

        String clExpediente = "0";
        String strclServicio = "0";
        String strclSubservicio = "0";
        String strFechaAp = "";

        out.println("<html>");
        out.println("<head>");
        out.println("<title>GUARDA ASISTENCIA</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("clExpediente") != null) {
            SeDoV.setClExpediente(request.getParameter("clExpediente"));
        } else {
            SeDoV.setClExpediente("");
        }

        if (request.getParameter("ObsServicioDom") != null) {
            SeDoV.setObsServicioDom(request.getParameter("ObsServicioDom"));
        } else {
            SeDoV.setObsServicioDom("");
        }

        if (request.getParameter("clServicioDom") != null) {
            SeDoV.setClServicioDom(request.getParameter("clServicioDom"));
        } else {
            SeDoV.setClServicioDom("");
        }


        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) { ///Alta

                strSQL.append("'").append(SeDoV.getClExpediente()).append("',");
                strSQL.append("'").append(SeDoV.getObsServicioDom()).append("',");
                strSQL.append("'").append(SeDoV.getClServicioDom()).append("'");

                System.out.println(strSQL.toString());

                //aqui va el que guarda

                System.out.println(strSQL.toString());

                rsEx = UtileriasBDF.rsSQLNP(" st_GuardaServicioDomVet " + strSQL.toString());

                System.out.println(" st_GuardaServicioDomVet " + strSQL.toString());

                if (rsEx.next()) {
                    //Se utiliza para indicarle al usuario que la clave ya existe
                    Error = rsEx.getString("Error");

                    if (Error.equalsIgnoreCase("0")) {

                        System.out.println(" error 0 ");
                        clExpediente = rsEx.getString("clExpediente");
                        strUrlBack = strUrlBack + "clExpediente=" + clExpediente;
                        out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                    }

                    if (Error.equalsIgnoreCase("1")) {

                        System.out.println(" error 1 ");
                        out.println("<script>");
                        out.println("alert(\"Falta un dato obligatorio\");");
                        out.println("</script>");
                        out.println("<script>window.opener.fnValidaError()</script>");
                    }

                    if (Error.equalsIgnoreCase("2")) {
                        System.out.println(" error 3 ");
                        out.println("<script>");
                        out.println("alert('Error al insertar los datos');");
                        out.println("</script>");
                        out.println("<script>window.opener.fnValidaError()</script>");
                    }

                }
            } else {
                if (Integer.parseInt(request.getParameter("Action")) == 2) {

                    strSQL.append("'").append(SeDoV.getClExpediente()).append("',");
                    strSQL.append("'").append(SeDoV.getObsServicioDom()).append("',");
                    strSQL.append("'").append(SeDoV.getClServicioDom()).append("'");


                    rsEx = UtileriasBDF.rsSQLNP(" st_ActualizaServicioDomVet " + strSQL.toString());

                    System.out.println(" st_ActualizaServicioDomVet " + strSQL.toString());

                    if (rsEx.next()) {

                        System.out.println("Entra try");

                        if (rsEx.getString("Error").equalsIgnoreCase("0")) {

                            System.out.println("Entra if");

                            clExpediente = rsEx.getString("clExpediente");
                            strUrlBack = strUrlBack + "clExpediente=" + clExpediente;//
                            out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                        } else {

                            System.out.println("Entra else");

                            out.println("<script>");
                            out.println("alert(\"Error al actualizar los datos\");");
                            out.println("</script>");
                            out.println("<script>window.opener.fnValidaError()</script>");
                        }
                    }
                    System.out.println("No Entra rs.next");
                }
            }
        } catch (Exception e) {
            out.println("<script>");
            out.println("alert(\"Error al Guardar la asistencia\");");
            out.println("</script>");
            out.println("<script>window.opener.fnValidaError()</script>");
            out.close();
            e.printStackTrace();
            this.destroy();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;
                }
            } catch (Exception ee) {
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
