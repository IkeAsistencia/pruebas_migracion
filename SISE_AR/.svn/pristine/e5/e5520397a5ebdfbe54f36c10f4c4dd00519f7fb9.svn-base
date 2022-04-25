/*
 * GuardaSucursalReddeDescuentos.java
 *
 * Created on 14 de MAYO de 2008, 17:10 AM
 * 
 */
package com.ike.guarda;

import com.ike.asistencias.to.SucursalReddeDescuentos;
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
public class GuardaSucursalReddeDescuentos extends HttpServlet {

    /*
     * Creates a new instance of GuardaSucursalReddeDescuentos
     */
    public GuardaSucursalReddeDescuentos() {
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

        SucursalReddeDescuentos SuRe = new SucursalReddeDescuentos();

        PrintWriter out = response.getWriter();

        String clSucursalReddeDescuentos = "0";

        out.println("<html>");
        out.println("<head>");
        out.println("<title>GUARDA ASISTENCIA</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("clSucursalReddeDescuentos") != null) {
            SuRe.setClSucursalReddeDescuentos(request.getParameter("clSucursalReddeDescuentos"));
        } else {
            SuRe.setClSucursalReddeDescuentos("");
        }

        if (request.getParameter("clReddeDescuentos") != null) {
            SuRe.setClReddeDescuentos(request.getParameter("clReddeDescuentos"));
        } else {
            SuRe.setClReddeDescuentos("");
        }

        if (request.getParameter("Contacto") != null) {
            SuRe.setContacto(request.getParameter("Contacto"));
        } else {
            SuRe.setContacto("");
        }

        if (request.getParameter("Sucursal") != null) {
            SuRe.setSucursal(request.getParameter("Sucursal"));
        } else {
            SuRe.setSucursal("");
        }

        if (request.getParameter("CodEnt") != null) {
            SuRe.setCodEnt(request.getParameter("CodEnt"));
        } else {
            SuRe.setCodEnt("");
        }

        if (request.getParameter("CodMD") != null) {
            SuRe.setCodMD(request.getParameter("CodMD"));
        } else {
            SuRe.setCodMD("");
        }

        if (request.getParameter("Calle") != null) {
            SuRe.setCalle(request.getParameter("Calle"));
        } else {
            SuRe.setCalle("");
        }

        if (request.getParameter("CodigoPostal") != null) {
            SuRe.setCodigoPostal(request.getParameter("CodigoPostal"));
        } else {
            SuRe.setCodigoPostal("");
        }

        if (request.getParameter("Telefono1") != null) {
            SuRe.setTelefono1(request.getParameter("Telefono1"));
        } else {
            SuRe.setTelefono1("");
        }

        if (request.getParameter("Telefono2") != null) {
            SuRe.setTelefono2(request.getParameter("Telefono2"));
        } else {
            SuRe.setTelefono2("");
        }

        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) { ///Alta

                strSQL.append(" ").append(SuRe.getClReddeDescuentos()).append(",");
                strSQL.append("'").append(SuRe.getContacto()).append("',");
                strSQL.append("'").append(SuRe.getSucursal()).append("',");
                strSQL.append("'").append(SuRe.getCodEnt()).append("',");
                strSQL.append("'").append(SuRe.getCodMD()).append("',");
                strSQL.append("'").append(SuRe.getCalle()).append("',");
                strSQL.append("'").append(SuRe.getCodigoPostal()).append("',");
                strSQL.append("'").append(SuRe.getTelefono1()).append("',");
                strSQL.append("'").append(SuRe.getTelefono2()).append("'");

                //System.out.println(strSQL.toString());

                try {
                    rsEx = UtileriasBDF.rsSQLNP("st_GuardaSucursalReddeDescuentos " + strSQL.toString());
                } catch (Exception sql) {
                    System.out.println("Error GuardaSucursalReddeDescuentos.java");
                    sql.printStackTrace();

                }

                System.out.println(" GuardaSucursalReddeDescuentos " + strSQL.toString());

                if (rsEx.next()) {
                    //Se utiliza para indicarle al usuario que la clave ya existe
                    Error = rsEx.getString("Error");

                    if (Error.equalsIgnoreCase("0")) {
                        clSucursalReddeDescuentos = rsEx.getString("clSucursalReddeDescuentos");
                        strUrlBack = strUrlBack + "clSucursalReddeDescuentos=" + clSucursalReddeDescuentos;

                        out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                    }

                    if (Error.equalsIgnoreCase("1")) {
                        out.println("<script>");
                        out.println("alert(\"Falta un dato obligatorio\");");
                        out.println("</script>");
                        out.println("<script>window.opener.fnValidaError()</script>");
                    }

                    if (Error.equalsIgnoreCase("2")) {
                        out.println("<script>");
                        out.println("alert('Error al insertar los datos');");
                        out.println("</script>");
                        out.println("<script>window.opener.fnValidaError()</script>");
                    }

                }
            } else {
                if (Integer.parseInt(request.getParameter("Action")) == 2) {

                    strSQL.append("'").append(SuRe.getClSucursalReddeDescuentos()).append("',");
                    strSQL.append("'").append(SuRe.getContacto()).append("',");
                    strSQL.append("'").append(SuRe.getSucursal()).append("',");
                    strSQL.append("'").append(SuRe.getCodEnt()).append("',");
                    strSQL.append("'").append(SuRe.getCodMD()).append("',");
                    strSQL.append("'").append(SuRe.getCalle()).append("',");
                    strSQL.append("'").append(SuRe.getCodigoPostal()).append("',");
                    strSQL.append("'").append(SuRe.getTelefono1()).append("',");
                    strSQL.append("'").append(SuRe.getTelefono2()).append("'");


                    System.out.println("st_ActualizaSucursalReddeDescuentos " + strSQL.toString());
                    rsEx = UtileriasBDF.rsSQLNP("st_ActualizaSucursalReddeDescuentos " + strSQL.toString());

                    if (rsEx.next()) {

                        //System.out.println("Entra try");

                        if (rsEx.getString("Error").equalsIgnoreCase("0")) {
                            clSucursalReddeDescuentos = rsEx.getString("clSucursalReddeDescuentos");
                            strUrlBack = strUrlBack + "clSucursalReddeDescuentos=" + clSucursalReddeDescuentos;//
                            out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                        } else {
                            out.println("<script>");
                            out.println("alert(\"Error al actualizar los datos\");");
                            out.println("</script>");
                            out.println("<script>window.opener.fnValidaError()</script>");
                        }
                    }
                    //System.out.println("No Entra rs.next");
                }
            }
        } catch (Exception e) {
            out.println("<script>");
            out.println("alert(\"Error al Guardar la asistencia\");");
            out.println("</script>");
            out.println("<script>window.opener.fnValidaError()</script>");
            out.close();
            e.printStackTrace();
//            this.destroy();
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
