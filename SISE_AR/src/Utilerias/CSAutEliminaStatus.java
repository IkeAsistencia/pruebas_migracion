/*
 *
 * @author rfernandez
 */
package Utilerias;

import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.Connection;

public class CSAutEliminaStatus extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void destroy() {
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);

        String StrUsrApp = "";
        String StrUsr = "0";
        String StrPwd = "";
        String StrclTipo = "0";
        String StrclEstatus = "0";
        String StrclUsrApp = "";
        String StrNombreUsr = "";
        String StrFecha = "";
        String StrclAsistencia = "";
        String StrclProveedor = "0";
        String StrclSeguimientoProveedor = "0";

        Connection con = null;
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Concierge - Elimina Estatus</title>");
        out.println("</head>");
        out.println("<link href=\"../StyleClasses/Global.css\" rel=\"stylesheet\" type=\"text/css\">");
        out.println("<body class='cssBody'>");

        if (request.getParameter("Usr") != null) {
            StrUsr = request.getParameter("Usr").toString();
        }

        if (request.getParameter("Pwd") != null) {
            StrPwd = request.getParameter("Pwd").toString();
        }

        if (request.getParameter("clTipo") != null) {
            StrclTipo = request.getParameter("clTipo").toString();
            sessionH.setAttribute("clTipo", StrclTipo);
        } else {
            if (sessionH.getAttribute("clTipo") != null) {
                StrclTipo = sessionH.getAttribute("clTipo").toString();
            }
        }

        if (sessionH.getAttribute("clEstatus") != null) {
            StrclEstatus = sessionH.getAttribute("clEstatus").toString();
        } else {
            if (request.getParameter("clEstatus") != null) {
                StrclEstatus = request.getParameter("clEstatus").toString();
                sessionH.setAttribute("clEstatus", StrclEstatus);
            }
        }

        if (request.getParameter("clAsistenciaCSAut") != null) {
            StrclAsistencia = request.getParameter("clAsistenciaCSAut").toString();
        } else {
            if (sessionH.getAttribute("clAsistenciaCSAut") != null) {
                StrclAsistencia = sessionH.getAttribute("clAsistenciaCSAut").toString();
            }
        }
        sessionH.setAttribute("clAsistenciaCSAut", StrclAsistencia);

        if (request.getParameter("clSeguimientoProveedor") != null) {
            StrclSeguimientoProveedor = request.getParameter("clSeguimientoProveedor");
        }

        if (request.getParameter("clProveedor") != null) {
            StrclProveedor = request.getParameter("clProveedor");
        }

        String strMess = "";
        boolean blnAutorizado = false;
        con = UtileriasBDF.getConnection();
        ResultSet rsAut = null;
        ResultSet rsCS = null;
        String PermisoSCS = "";
        StringBuilder strSQL = new StringBuilder();
        String StrMensaje = "";
        ResultSet rsEx = null;

        try {
            blnAutorizado = false;
            String strUsuario = "";
            if (StrUsr.equalsIgnoreCase("")) {
                // No entró por la página de autorización, es directamente del expediente
                blnAutorizado = false;
                strMess = "Debe informar usuario";
            } else {
                if (StrPwd.compareToIgnoreCase("") == 0) {
                    blnAutorizado = false;
                    strMess = "Debe informar un Password";
                } else {
                    rsAut = UtileriasBDF.rsSQLNP("sp_EncriptDesEncriptPassword '" + StrUsr + "',0,'', 0");
                    if (rsAut.next()) {
                        StrclUsrApp = rsAut.getString("clUsrApp");
                        StrNombreUsr = rsAut.getString("Nombre").toString().trim();
                        StrFecha = rsAut.getString("FechaInicio").toString().trim();

                        rsCS = UtileriasBDF.rsSQLNP("st_SCSupervisorConcierge '" + StrclUsrApp + "'");
                        if (rsCS.next()) {
                            PermisoSCS = rsCS.getString("PermisoSupervisorCS").toString().trim();

                        }


                        if (StrPwd.compareToIgnoreCase(rsAut.getString("password")) == 0) {
                            if (PermisoSCS.compareToIgnoreCase("0") == 0) {
                                blnAutorizado = false;
                                strMess = "Usuario no Autorizado";
                            } else {
                                blnAutorizado = true;
                            }
                        } else {
                            blnAutorizado = false;
                            strMess = "Password Incorrecto";
                        }
                    } else {
                        blnAutorizado = false;
                        strMess = "Usuario Incorrecto";
                    }
                }
            }

            if (blnAutorizado == false) {
                out.println("<p class='TTable'>Para autorizar la eliminación del estatus: " + strMess);
                out.println("</p>");
                out.println("<form action='../servlet/Utilerias.CSAutEliminaStatus' method='post'>");
                out.println("<table align='center'><tr><td class='cssTitDet' colspan=2>Clave de Autorización</td></tr>");
                out.println("<tr><td class='FTable'>Usuario:</td><td class='FTable'><input id='Usr' name = 'Usr'></input></td><tr>");
                out.println("<tr><td class='FTable'>Contraseña:</td><td class='FTable'><input type=password id='Pwd' name = 'Pwd'></input></td><tr>");
                out.println("<tr><td class='FTable' align='center'><input class='cBtn' VALUE='Autorizar' type='submit'></input></td><td class='FTable'><input value ='Cancelar' class='cBtn' type='button' onClick='window.close()'></input></td><tr>");
                out.println("<script>window.focus();window.resizeTo(400,280);window.moveTo(300,150);</script>");
                out.println("<BGSOUND SRC='../Music/UTOPIA.WAV'>");
            } else {
                if (StrclTipo.equalsIgnoreCase("1")) {
                    if (PermisoSCS.equalsIgnoreCase("1")) {
                        strSQL.append("st_CSCorrigeSeg ").append(StrclAsistencia).append(",").append(StrclEstatus).append(",").append(StrclUsrApp);
                        rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                        strSQL.delete(0, strSQL.length());
                        if (rsEx.next()) {
                            StrMensaje = rsEx.getString("Mensaje");
                            if (StrMensaje.equalsIgnoreCase("1")) {
                                out.println("<script>top.opener.location.reload();</script>");
                                //out.println("<script> location.href='../Operacion/Concierge/BitacoraAsistencia.jsp?clAsistencia="+ StrclAsistencia +"';</script>");
                            } else {
                                out.println("No cuenta con Privilegios suficientes para realizar la Operacion");
                            }
                        }
                    }
                }

                if (StrclTipo.equalsIgnoreCase("2")) {
                    if (PermisoSCS.equalsIgnoreCase("1")) {
                        strSQL.append("st_CSCorrigeSegProv ").append(StrclSeguimientoProveedor).append(",").append(StrclAsistencia).append(",").append(StrclEstatus).append(",");
                        strSQL.append(StrclProveedor).append(",").append(StrclUsrApp);
                        rsEx = UtileriasBDF.rsSQLNP(strSQL.toString());
                        strSQL.delete(0, strSQL.length());
                        if (rsEx.next()) {
                            StrMensaje = rsEx.getString("Mensaje");
                            if (StrMensaje.equalsIgnoreCase("1")) {
                                out.println("<script>top.opener.location.reload();</script>");
                                //out.println("<script> location.href='../Operacion/Concierge/BitacoraAsistencia.jsp?clAsistencia="+ StrclAsistencia +"';</script>");
                            } else {
                                out.println("No cuenta con Privilegios suficientes para realizar la Operacion");
                            }
                        }

                    }
                }
                out.println("<script>window.close();</script>");
            }

            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
            out.println("Problema al registrar el movimiento 1");
        } finally {
            try {
                if (rsAut != null) {
                    rsAut.close();
                    rsAut = null;
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception ee) {
                ee.printStackTrace();
                out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
                out.println("Problema al registrar el movimiento 2");
            }
            out.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public String getServletInfo() {
        return "Short description";
    }
}
