/*
 * EjecutaAltaAfiliado.java
 *
 * Created on 4 de Mayo de 2005, 04:27 PM
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

/*
 *
 * @author
 * @version
 */
public class GuardaCita extends HttpServlet {

    /*
     * Initializes
     * the
     * servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

    }

    public void destroy() {
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        //cAfiliado
        String StrUsr = "0";
        String StrPwd = "0";
        String StrCita = "0";
        String StrFechaCita = "";
        String StrclExpediente = "0";
        String strMess = "";
        boolean blnAutorizado = false;
        ResultSet rsAut = null;
        //ResultSet rsEx = null;
        String StrclUsrApp = "0";

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Marcar Cita</title>");
        out.println("</head>");
        out.println("<body>");



        if (request.getParameter("cUsrApp") != null) {
            StrUsr = request.getParameter("cUsrApp");
        }

        if (request.getParameter("Password") != null) {
            StrPwd = request.getParameter("Password");
        }

        if (request.getParameter("FechaCita") != null) {
            StrFechaCita = request.getParameter("FechaCita");
        }
        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente");
        }
        if (request.getParameter("CitaC") != null) {
            StrCita = request.getParameter("CitaC");
            if (StrCita.equalsIgnoreCase("on")) {
                StrCita = "1";
            } else {
                StrCita = "0";
            }
        }
        if (request.getParameter("clUsrApp") != null) {
            StrclUsrApp = request.getParameter("clUsrApp");
        }



        try {
            if (StrFechaCita.compareToIgnoreCase("") == 0 && StrCita.compareToIgnoreCase("1") == 0) {
                blnAutorizado = false;
                strMess = "Debe informar fecha de cita";
            } else {

                if (StrUsr.compareToIgnoreCase("") == 0) {
                    // No entró por la página de autorización, es directamente del expediente
                    blnAutorizado = false;
                    strMess = "Debe informar usuario para autorizar el servicio";
                } else {
                    if (StrPwd.compareToIgnoreCase("") == 0) {
                        blnAutorizado = false;
                        strMess = "Debe informar contraseña para autorizar el servicio";
                    } else {
                        rsAut = UtileriasBDF.rsSQLNP("sp_EncriptDesEncriptPassword '" + StrUsr + "',0,'', 0");
                        if (rsAut.next()) {
                            if (StrPwd.compareToIgnoreCase(rsAut.getString("password")) == 0) {
                                if (rsAut.getString("AutorizaExp").compareToIgnoreCase("0") == 0) {
                                    blnAutorizado = false;
                                    strMess = "Usuario no autorizado";
                                } else {
                                    blnAutorizado = true;
                                }
                            } else {
                                blnAutorizado = false;
                                strMess = "Contraseña Incorrecta";
                            }
                        } else {
                            blnAutorizado = false;
                            strMess = "Usuario Incorrecto";
                        }
                    }
                }
            }

            if (blnAutorizado == false) {
                out.println("<script> alert('" + strMess + "');location.href='../Operacion/MarcarCita.jsp?clExpediente=" + StrclExpediente + "';</script>");
            } else {
                // UtileriasBDF.ejecutaSQLNP("Update Expediente set Cita='" + StrCita + "',FechaCita='" + StrFechaCita + "' where clExpediente="+ StrclExpediente);
                // rsEx = UtileriasBDF.rsSQLNP("Update Expediente set Cita='" + StrCita + "',FechaCita='" + StrFechaCita + "' where clExpediente="+ StrclExpediente);
                UtileriasBDF.ejecutaSQLNP("sp_SeguimientoCitas " + StrclExpediente + "," + StrclUsrApp + "," + StrUsr + "," + StrCita + ",'" + StrFechaCita + "'");

                out.println("<script> window.opener.document.location.reload();window.close();</script>");
            }
            out.println("</body>");
            out.println("</html>");

            out.close();

        } catch (Exception e) {
            e.printStackTrace();
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