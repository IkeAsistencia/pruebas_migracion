/*
 * GuardaModuloRedDescuentos.java
 *
 * Created on 30 de junio de 2008, 06:10 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.guarda;

import com.ike.asistencias.to.ModuloRedDescuentos;
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
public class GuardaModuloRedDescuentos extends HttpServlet {

    /*
     * Creates a new instance of GuardaModuloRedDescuentos
     */
    public GuardaModuloRedDescuentos() {
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

        String clusrApp = "";
        String Error = "0";

        response.setContentType("text/html");

        ModuloRedDescuentos MRD = new ModuloRedDescuentos();

        PrintWriter out = response.getWriter();

        String clModuloRedDescuentos = "0";

        out.println("<html>");
        out.println("<head>");
        out.println("<title>GUARDA ASISTENCIA</title>");
        out.println("</head>");
        out.println("<body>");

        if (sessionH.getAttribute("clUsrApp") != null) {
            clusrApp = sessionH.getAttribute("clUsrApp").toString();
        }

        if (request.getParameter("clModuloRedDescuentos") != null) {
            MRD.setClModuloRedDescuentos(request.getParameter("clModuloRedDescuentos"));
        } else {
            MRD.setClModuloRedDescuentos("");
        }
//------------------------------------------------ DATOS ----------------------------------------------            
        if (request.getParameter("FechadeApertura") != null) {
            MRD.setFechadeApertura(request.getParameter("FechadeApertura"));
        } else {
            MRD.setFechadeApertura("");
        }

        if (request.getParameter("clCuenta") != null) {
            MRD.setClCuenta(request.getParameter("clCuenta"));
        } else {
            MRD.setClCuenta("");
        }

        if (request.getParameter("NombredelUsuario") != null) {
            MRD.setNombredelUsuario(request.getParameter("NombredelUsuario"));
        } else {
            MRD.setNombredelUsuario("");
        }

        if (request.getParameter("Clave") != null) {
            MRD.setClave(request.getParameter("Clave"));
        } else {
            MRD.setClave("");
        }

        if (request.getParameter("Telefono") != null) {
            MRD.setTelefono(request.getParameter("Telefono"));
        } else {
            MRD.setTelefono("");
        }

        if (request.getParameter("CodEnt") != null) {
            MRD.setCodEnt(request.getParameter("CodEnt"));
        } else {
            MRD.setCodEnt("");
        }

        if (request.getParameter("CodMD") != null) {
            MRD.setCodMD(request.getParameter("CodMD"));
        } else {
            MRD.setCodMD("");
        }

        if (request.getParameter("InformacionSol") != null) {
            MRD.setInformacionSol(request.getParameter("InformacionSol"));
        } else {
            MRD.setInformacionSol("");
        }

        if (request.getParameter("clTipoDescuento") != null) {
            MRD.setClTipoDescuento(request.getParameter("clTipoDescuento"));
        } else {
            MRD.setClTipoDescuento("");
        }

        if (request.getParameter("clGiroRed") != null) {
            MRD.setClGiroRed(request.getParameter("clGiroRed"));
        } else {
            MRD.setClGiroRed("");
        }

        if (request.getParameter("clServicio") != null) {
            MRD.setClServicio(request.getParameter("clServicio"));
        } else {
            MRD.setClServicio("");
        }

        if (request.getParameter("clSubservicio") != null) {
            MRD.setClSubServicio(request.getParameter("clSubservicio"));
        } else {
            MRD.setClSubServicio("");
        }

        if (request.getParameter("clRedEstatus") != null) {
            MRD.setClRedEstatus(request.getParameter("clRedEstatus"));
        } else {
            MRD.setClRedEstatus("");
        }

        if (request.getParameter("Observaciones") != null) {
            MRD.setObservaciones(request.getParameter("Observaciones"));
        } else {
            MRD.setObservaciones("");
        }

//-----------------------------------------------------------------------------------------------            
        try {
            String strUrlBack = "";
            if (request.getParameter("URLBACK") != null) {
                strUrlBack = request.getParameter("URLBACK");
            }

            if (Integer.parseInt(request.getParameter("Action")) == 1) { ///Alta

                //strSQL.append("'").append(MRD.getclModuloRedDescuentos()).append("',");
                strSQL.append("'").append(MRD.getFechadeApertura()).append("',");
                strSQL.append("'").append(MRD.getClCuenta()).append("',");
                strSQL.append("'").append(MRD.getNombredelUsuario()).append("',");
                strSQL.append("'").append(MRD.getClave()).append("',");
                strSQL.append("'").append(MRD.getTelefono()).append("',");
                strSQL.append("'").append(MRD.getCodEnt()).append("',");
                strSQL.append("'").append(MRD.getCodMD()).append("',");
                strSQL.append("'").append(MRD.getInformacionSol()).append("',");
                strSQL.append("'").append(MRD.getClTipoDescuento()).append("',");
                strSQL.append("'").append(MRD.getClGiroRed()).append("',");
                strSQL.append("'").append(MRD.getClServicio()).append("',");
                strSQL.append("'").append(MRD.getClSubServicio()).append("',");
                strSQL.append("'").append(MRD.getClRedEstatus()).append("',");
                strSQL.append("'").append(MRD.getObservaciones()).append("',");
                strSQL.append("'").append(clusrApp.toString()).append("'");

                //System.out.println(strSQL.toString());

                try {
                    rsEx = UtileriasBDF.rsSQLNP("st_GuardaMReddeDescuentos " + strSQL.toString());
                } catch (Exception sql) {
                    //System.out.println("Error GuardaModuloRedDescuentos.java");
                    sql.printStackTrace();
                }

                System.out.println(" st_GuardaMReddeDescuentos " + strSQL.toString());

                if (rsEx.next()) {
                    //Se utiliza para indicarle al usuario que la clave ya existe
                    Error = rsEx.getString("Error");

                    if (Error.equalsIgnoreCase("0")) {
                        clModuloRedDescuentos = rsEx.getString("clModuloRedDescuentos");
                        strUrlBack = strUrlBack + "clModuloRedDescuentos=" + clModuloRedDescuentos;

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

                    strSQL.append("'").append(MRD.getClModuloRedDescuentos()).append("',");
                    strSQL.append("'").append(MRD.getClCuenta()).append("',");
                    strSQL.append("'").append(MRD.getNombredelUsuario()).append("',");
                    strSQL.append("'").append(MRD.getClave()).append("',");
                    strSQL.append("'").append(MRD.getTelefono()).append("',");
                    strSQL.append("'").append(MRD.getCodEnt()).append("',");
                    strSQL.append("'").append(MRD.getCodMD()).append("',");
                    strSQL.append("'").append(MRD.getInformacionSol()).append("',");
                    strSQL.append("'").append(MRD.getClTipoDescuento()).append("',");
                    strSQL.append("'").append(MRD.getClGiroRed()).append("',");
                    strSQL.append("'").append(MRD.getClServicio()).append("',");
                    strSQL.append("'").append(MRD.getClSubServicio()).append("',");
                    strSQL.append("'").append(MRD.getClRedEstatus()).append("',");
                    strSQL.append("'").append(MRD.getObservaciones()).append("'");

                    System.out.println("st_ActualizaMReddeDescuentos " + strSQL.toString());
                    rsEx = UtileriasBDF.rsSQLNP("st_ActualizaMReddeDescuentos " + strSQL.toString());

                    if (rsEx.next()) {

                        //System.out.println("Entra try");

                        if (rsEx.getString("Error").equalsIgnoreCase("0")) {
                            clModuloRedDescuentos = rsEx.getString("clModuloRedDescuentos");
                            strUrlBack = strUrlBack + "clModuloRedDescuentos=" + clModuloRedDescuentos;//
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