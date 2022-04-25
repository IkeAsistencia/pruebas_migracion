/*
 * AutorizaReicideClave.java
 *
 * Created on 22 de enero de 2007, 04:50 PM
 */
package Utilerias;

import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/*
 *
 * @author zamoraed
 * @version
 */
public class AutorizaReincideClave extends HttpServlet {

    /* Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        String StrUsrAutoriza = "0";
        String StrPwd = "0";
        String StrclExpediente = "0";
        String strMess = "";
        String StrNumReincide = "";
        String StrclServicio = "0";
        String StrclSubServicio = "0";
        String StrdsServicio = "";
        String StrdsSubServicio = "";
        String StrclUsrApp = "0";
        String StrCobertura = "";
        String StrclUsrRegistra = "";

        boolean blnAutorizado = false;
        ResultSet rsAut = null;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Autorización de Aplicación de Subservicio</title>");
        out.println("</head>");
        out.println("<body>");


        if (request.getParameter("Usr") != null) {
            StrUsrAutoriza = request.getParameter("Usr");
        }

        if (request.getParameter("Pass") != null) {
            StrPwd = request.getParameter("Pass");
        }

        if (request.getParameter("NumReincide") != null) {
            StrNumReincide = request.getParameter("NumReincide");
        }

        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente");
        }

        if (request.getParameter("clServicio") != null) {
            StrclServicio = request.getParameter("clServicio");
        }

        if (request.getParameter("clSubServicio") != null) {
            StrclSubServicio = request.getParameter("clSubServicio");
        }

        if (request.getParameter("dsServicio") != null) {
            StrdsServicio = request.getParameter("dsServicio");
        }

        if (request.getParameter("dsSubServicio") != null) {
            StrdsSubServicio = request.getParameter("dsSubServicio");
        }

        if (request.getParameter("Cobertura") != null) {
            StrCobertura = request.getParameter("Cobertura").toString();
        }

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrclUsrRegistra = sessionH.getAttribute("clUsrApp").toString();
        }

        try {
            if (StrUsrAutoriza.compareToIgnoreCase("") == 0) {
                // No entró por la página de autorización, es directamente del expediente
                blnAutorizado = false;
                strMess = "Debe informar usuario para autorizar el servicio";
            } else {
                if (StrPwd.compareToIgnoreCase("") == 0) {
                    blnAutorizado = false;
                    strMess = "Debe informar contraseña para autorizar el servicio";
                } else {
                    rsAut = UtileriasBDF.rsSQLNP("sp_EncriptDesEncriptPassword '" + StrUsrAutoriza + "',0,'', 0");
                    if (rsAut.next()) {
                        StrclUsrApp = rsAut.getString("clUsrApp").toString();
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
                    }
                }
            }

            if (blnAutorizado == false) {
                out.println("<script> alert('" + strMess + "');history.go(-1);</script>");
            } else {
                if (StrCobertura.equalsIgnoreCase("1")) {
                    UtileriasBDF.ejecutaSQLNP("st_InsertaReincidencia " + StrclExpediente + "," + StrclUsrApp + "," + StrNumReincide + "," + StrclSubServicio);
                    System.out.println("st_InsertaReincidencia " + StrclExpediente + "," + StrclUsrApp + "," + StrNumReincide + "," + StrclSubServicio);
                    out.println("<script> window.opener.location.href='../Operacion/DetalleAsistencia.jsp?clSubServicio=" + StrclSubServicio + "&clServicio=" + StrclServicio + "&dsServicio=" + StrdsServicio + "&dsSubServicio=" + StrdsSubServicio + "';window.close();</script>");
                } else {
                    UtileriasBDF.ejecutaSQLNP("st_InsertaServicioNoCubierto " + StrclExpediente + ",'" + StrUsrAutoriza + "'," + StrclUsrRegistra + "," + StrclSubServicio);
                    System.out.println("st_InsertaServicioNoCubierto " + StrclExpediente + ",'" + StrUsrAutoriza + "'," + StrclUsrRegistra + "," + StrclSubServicio);
                    out.println("<script> window.opener.location.href='../Operacion/DetalleAsistencia.jsp?clSubServicio=" + StrclSubServicio + "&clServicio=" + StrclServicio + "&dsServicio=" + StrdsServicio + "&dsSubServicio=" + StrdsSubServicio + "';window.close();</script>");
                }
            }

            out.println("</body>");
            out.println("</html>");

            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.close();

            rsAut = null;

            StrUsrAutoriza = null;
            StrPwd = null;
            StrclExpediente = null;
            strMess = null;
            StrNumReincide = null;
            StrclServicio = null;
            StrclSubServicio = null;
            StrdsServicio = null;
            StrdsSubServicio = null;
            StrclUsrApp = null;
            StrCobertura = null;
            StrclUsrRegistra = null;
//            this.destroy();
        }
//        this.destroy();        

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