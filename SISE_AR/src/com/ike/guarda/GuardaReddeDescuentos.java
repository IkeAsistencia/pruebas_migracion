/*
 * GuardaReddeDescuentos.java
 *
 * Created on 13 de MAYO de 2008, 11:00 AM
 * 
 */
package com.ike.guarda;

import com.ike.asistencias.to.ReddeDescuentos;
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
public class GuardaReddeDescuentos extends HttpServlet {

    /*
     * Creates a new instance of GuardaReddeDescuentos
     */
    public GuardaReddeDescuentos() {
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

        ReddeDescuentos RED = new ReddeDescuentos();

        PrintWriter out = response.getWriter();

        String clReddeDescuentos = "0";

        out.println("<html>");
        out.println("<head>");
        out.println("<title>GUARDA ASISTENCIA</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("clReddeDescuentos") != null) {
            RED.setClReddeDescuentos(request.getParameter("clReddeDescuentos"));
        } else {
            RED.setClReddeDescuentos("");
        }

        if (request.getParameter("FechadeCaptura") != null) {
            RED.setFechadeCaptura(request.getParameter("FechadeCaptura"));
        } else {
            RED.setFechadeCaptura("");
        }

        if (request.getParameter("Contacto") != null) {
            RED.setContacto(request.getParameter("Contacto"));
        } else {
            RED.setContacto("");
        }

        if (request.getParameter("NombreComercial") != null) {
            RED.setNombreComercial(request.getParameter("NombreComercial"));
        } else {
            RED.setNombreComercial("");
        }

        if (request.getParameter("RazonSocial") != null) {
            RED.setRazonSocial(request.getParameter("RazonSocial"));
        } else {
            RED.setRazonSocial("");
        }

        if (request.getParameter("clGiroRed") != null) {
            RED.setClGiroRed(request.getParameter("clGiroRed"));
        } else {
            RED.setClGiroRed("");
        }

        if (request.getParameter("CodEnt") != null) {
            RED.setCodEnt(request.getParameter("CodEnt"));
        } else {
            RED.setCodEnt("");
        }

        if (request.getParameter("CodMD") != null) {
            RED.setCodMD(request.getParameter("CodMD"));
        } else {
            RED.setCodMD("");
        }

        if (request.getParameter("Beneficios") != null) {
            RED.setBeneficios(request.getParameter("Beneficios"));
        } else {
            RED.setBeneficios("");
        }

        if (request.getParameter("Correo") != null) {
            RED.setCorreo(request.getParameter("Correo"));
        } else {
            RED.setCorreo("");
        }

        if (request.getParameter("Telefono1") != null) {
            RED.setTelefono1(request.getParameter("Telefono1"));
        } else {
            RED.setTelefono1("");
        }

        if (request.getParameter("Telefono2") != null) {
            RED.setTelefono2(request.getParameter("Telefono2"));
        } else {
            RED.setTelefono2("");
        }

        if (request.getParameter("clTipoDescuento") != null) {
            RED.setClTipoDescuento(request.getParameter("clTipoDescuento"));
        } else {
            RED.setClTipoDescuento("");
        }

        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) { ///Alta
                strSQL.append("'").append(RED.getFechadeCaptura()).append("',");
                strSQL.append("'").append(RED.getContacto()).append("',");
                strSQL.append("'").append(RED.getNombreComercial()).append("',");
                strSQL.append("'").append(RED.getRazonSocial()).append("',");
                strSQL.append("'").append(RED.getClGiroRed()).append("',");
                strSQL.append("'").append(RED.getCodEnt()).append("',");
                strSQL.append("'").append(RED.getCodMD()).append("',");
                strSQL.append("'").append(RED.getBeneficios()).append("',");
                strSQL.append("'").append(RED.getCorreo()).append("',");
                strSQL.append("'").append(RED.getTelefono1()).append("',");
                strSQL.append("'").append(RED.getTelefono2()).append("',");
                strSQL.append("'").append(RED.getClTipoDescuento()).append("'");

                //System.out.println(strSQL.toString());

                try {
                    rsEx = UtileriasBDF.rsSQLNP("st_GuardaReddeDescuentos " + strSQL.toString());
                } catch (Exception sql) {
                    System.out.println("Error GuardaReddeDescuentos.java");
                    sql.printStackTrace();
                }

                System.out.println(" st_GuardaReddeDescuentos " + strSQL.toString());

                if (rsEx.next()) {
                    //Se utiliza para indicarle al usuario que la clave ya existe
                    Error = rsEx.getString("Error");

                    if (Error.equalsIgnoreCase("0")) {
                        clReddeDescuentos = rsEx.getString("clReddeDescuentos");
                        strUrlBack = strUrlBack + "clReddeDescuentos=" + clReddeDescuentos;

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
                    strSQL.append("'").append(RED.getClReddeDescuentos()).append("',");
                    strSQL.append("'").append(RED.getContacto()).append("',");
                    strSQL.append("'").append(RED.getNombreComercial()).append("',");
                    strSQL.append("'").append(RED.getRazonSocial()).append("',");
                    strSQL.append("'").append(RED.getClGiroRed()).append("',");
                    strSQL.append("'").append(RED.getCodEnt()).append("',");
                    strSQL.append("'").append(RED.getCodMD()).append("',");
                    strSQL.append("'").append(RED.getBeneficios()).append("',");
                    strSQL.append("'").append(RED.getCorreo()).append("',");
                    strSQL.append("'").append(RED.getTelefono1()).append("',");
                    strSQL.append("'").append(RED.getTelefono2()).append("',");
                    strSQL.append("'").append(RED.getClTipoDescuento()).append("'");


                    System.out.println("st_ActualizaReddeDescuentos " + strSQL.toString());
                    rsEx = UtileriasBDF.rsSQLNP("st_ActualizaReddeDescuentos " + strSQL.toString());

                    if (rsEx.next()) {
                        //System.out.println("Entra try");
                        if (rsEx.getString("Error").equalsIgnoreCase("0")) {
                            clReddeDescuentos = rsEx.getString("clReddeDescuentos");
                            strUrlBack = strUrlBack + "clReddeDescuentos=" + clReddeDescuentos;//
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