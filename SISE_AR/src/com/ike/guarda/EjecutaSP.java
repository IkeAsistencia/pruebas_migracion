/*
 * EjecutaSP.java
 *
 * Created on 22 de mayo de 2008, 18:05
 */
package com.ike.guarda;

import Utilerias.UtileriasBDF;
import com.ike.view.ViewHelperBase;
import java.io.*;
import java.net.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.StringTokenizer;

import javax.servlet.*;
import javax.servlet.http.*;

/*
 *
 * @author vsampablo
 * @version
 */
public class EjecutaSP extends HttpServlet {

    /* Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    private static StringTokenizer st, stStores;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession sessionH = request.getSession(false);

        //Obtener el usuario de la sesi�n
        String clusrApp = sessionH.getAttribute("clUsrApp").toString();

        ResultSet rsEx = null;
        ResultSet rsBitacora = null;

        StringBuffer strSQL = new StringBuffer();

        String Error = "0";
        //System.out.println("Entra");

        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>GUARDA Y ACTUALIZA Store Procedure (GENERICO)</title>");
        out.println("</head>");
        out.println("<body>");

        String StoresProcedures = "";
        String Secuencia = "";
        String Commit = "";
        String strUrlBack = "";
        String strTablaBitacora = "";

        //<<<<<<<<<<<<<<<<<   Obtener los Stores Procedures  >>>>>>>>>>>>>>>>>>
        if (sessionH.getAttribute("sp_Stores") != null) {
            StoresProcedures = sessionH.getAttribute("sp_Stores").toString();
            sessionH.removeAttribute("sp_Stores");
        }

        //<<<<<<<<<<<<<<<<  Secuencia para Guardar o Actualizar >>>>>>>>>>>>>
        if (request.getParameter("Secuencia") != null) {
            Secuencia = request.getParameter("Secuencia").toString();
        }

        //<<<<<<<<<<<<<<<<<  Columna que regresa el Commit Cuando se Guarda o Actualiza  >>>>>>>>>>>>>>>>>>
        if (sessionH.getAttribute("Commit") != null) {
            Commit = sessionH.getAttribute("Commit").toString();
            sessionH.removeAttribute("Commit");
        }

        if (request.getParameter("URLBACK") != null) {
            strUrlBack = request.getParameter("URLBACK");
        }

        //<<<<<<<<<<< Separar los Stores Procedures >>>>>>>>>>>
        ArrayList StoresProc = new ArrayList();
        stStores = new StringTokenizer(StoresProcedures, ",");

        //<<<<<<<<<<<<<<<<< Obtener los Stores Procedures >>>>>>>>>>>>>>>>>
        while (stStores.hasMoreTokens()) {
            StoresProc.add(stStores.nextToken().toString());
        }

        //<<<<<<<<<<< Separar el Commit >>>>>>>>>>>
        ArrayList CommitBack = new ArrayList();
        st = new StringTokenizer(Commit, ",");
        //System.out.println("Entra Ejecutas");

        //<<<<<<<<<<<<<<<<< Obtener los parametros que el Store va ha devolver >>>>>>>>>>>>>>>>>
        while (st.hasMoreTokens()) {
            CommitBack.add(st.nextToken().toString());
        }

        try {

            //<<<<<<<<<<<<<<<<<<<<<  Alta (1), Actualizaci�n (2)  y Eliminacion (3) >>>>>>>>>>>>>>>>>>>>
            if (Integer.parseInt(request.getParameter("Action")) == 1 || Integer.parseInt(request.getParameter("Action")) == 2 || Integer.parseInt(request.getParameter("Action")) == 3) {
                //<<<<<<<<<<<< Obtener el store dependiento del Action >>>>>>>>>>>
                strSQL.append(StoresProc.get(Integer.parseInt(request.getParameter("Action")) - 1).toString()).append(" ").append(Secuencia);
                //strSQL.append(sp_Guarda).append(" ").append(Secuencia);
                //System.out.println(strSQL);
                String[] CommitS = new String[CommitBack.size()];

                //<<<<<<<<<  Guarda el Registro >>>>>>>>
                rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());

                if (rsEx.next()) {
                    //Se utiliza para indicarle al usuario que la clave ya existe
                    Error = rsEx.getString("Error");

                    if (Error.equalsIgnoreCase("0")) {

                        //<<<<<<<<< Obtener Datos del Commit >>>>>>>>>
                        for (int i = 0; i < CommitBack.size(); i++) {
                            //System.out.println(CommitBack.get(i));
                            CommitS[i] = new String(rsEx.getString(CommitBack.get(i).toString()));
                        }

                        //<<<<<<<<<< Construir el URLBACK >>>>>>>>>>
                        for (int i = 0; i < CommitBack.size(); i++) {
                            strUrlBack = strUrlBack + "&" + CommitBack.get(i) + "=" + CommitS[i].toString() + "&";
                        }

                        //System.out.println(strUrlBack);

                        //<<<<<<<<<<<<<<<<<< Guarda en la Bit�cora >>>>>>>>>>>>>>>>>>
                        //<<<<<<<<<<<<<<< Si se envia por request la clPaginaweb se guarda en bit�cora >>>>>>>>>
                        if (request.getParameter("clPaginaWeb") != null) {
                            rsBitacora = UtileriasBDF.rsSQLNP("select coalesce(TablaBitacora,'') TablaBitacora from cPaginaWeb where clPaginaWeb =" + request.getParameter("clPaginaWeb"));


                            try {
                                //InetAddress a = InetAddress.getByName(InetAddress.getLocalHost().getHostName());
                                InetAddress addr = InetAddress.getByName(request.getRemoteAddr().toString());
                                String hostname = addr.getHostName();

                                if (rsBitacora.next()) {
                                    strTablaBitacora = rsBitacora.getString("TablaBitacora");

                                    if (strTablaBitacora.compareToIgnoreCase("") != 0) {
                                        Hashtable ht = null;

                                        try {
                                            ht = ViewHelperBase.getUserData(request);
                                            ht.put("llave", CommitBack.get(0).toString());
                                            ht.put("llaveVal", CommitS[0].toString());
                                            ht.put("clUsrApp", clusrApp.toString());
                                            ht.put("ip", request.getRemoteAddr().toString());
                                            ht.remove("Secuencia");
                                            try {
                                                ViewHelperBase.bitacoraHt(ht);
                                            } catch (Exception par) {
                                                //System.out.println(" alta expediente");
                                            }
                                        } catch (Exception bit) {
                                            //System.out.println("Error EjecutaAccion.java: Bitacora");
                                        } finally {
                                            ht = null;
                                            hostname = null;
                                            //  a=null;
                                        }
                                    }
                                }
                            } catch (SQLException ex) {
                            }
                        }
                        //<<<<<<<<<<<<<<<<<<<<<<<<<<<< >>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                        //strUrlBack=null;
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
            }
        } catch (Exception e) {
            out.println("<script>");
            out.println("alert(\"Error al Guardar...\");");
            System.out.println("Error al Guardar: " + e);
            out.println("</script>");
            out.println("<script>window.opener.fnValidaError()</script>");
            out.close();
        } finally {
            try {
                //<<<<<<<<<<<<<<<<<<<  Cerrar conexiones >>>>>>>>>>>>>>>>>>>
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;
                }

                if (rsBitacora != null) {
                    rsBitacora.close();
                    rsBitacora = null;
                }
            } catch (Exception ee) {
            }
            //<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>>>>>>>
            strSQL.delete(0, strSQL.length());
            strSQL = null;
            Error = null;

            clusrApp = null;
            Secuencia = null;
            Commit = null;
            strUrlBack = null;
            strTablaBitacora = null;

        }

        out.println("</body>");
        out.println("</html>");
        out.close();

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /* Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /* Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /* Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}
