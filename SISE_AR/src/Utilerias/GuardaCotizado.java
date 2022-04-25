/*
 * GuardaCotizado.java
 *
 * Created on 5 de Marzo de 2006, 04:27 PM
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
public class GuardaCotizado extends HttpServlet {

    /* Initializes the servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

    }

    /* Destroys the servlet.
     */
    public void destroy() {
    }

    /* Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        //cAfiliado
        String StrUsrAut = "";
        String StrclUsrApp = "0";
        String StrPwd = "0";
        String StrCotizado = "0";
        String StrVerificar = "1";
        String StrclExpediente = "0";
        String strMess = "";
        boolean blnAutorizado = false;
        ResultSet rsAut = null;
        ResultSet rsEx = null;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servicio de Correciones</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("cUsrAut") != null) {
            StrUsrAut = request.getParameter("cUsrAut");
        }

        if (request.getParameter("clUsrApp") != null) {
            StrclUsrApp = request.getParameter("clUsrApp");
        }

        if (request.getParameter("Password") != null) {
            StrPwd = request.getParameter("Password");
        }

        if (request.getParameter("Verificar") != null) {
            StrVerificar = request.getParameter("Verificar");
        }
        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente");
        }
        if (request.getParameter("CotizarC") != null) {
            StrCotizado = request.getParameter("CotizarC");  //CotizadoC valor del checkbox
            if (StrCotizado.equalsIgnoreCase("on")) {
                StrCotizado = "1";
            } else {
                StrCotizado = "0";
            }
        }

        try {
            if (StrVerificar.equalsIgnoreCase("1")) {
                //blnAutorizado = false;
                //strMess = "Debe informar fecha de cita";
                // }else{

                if (StrUsrAut.compareToIgnoreCase("") == 0) {
                    // No entró por la página de autorización, es directamente del expediente
                    blnAutorizado = false;
                    strMess = "Debe informar usuario para autorizar el servicio";
                } else {
                    if (StrPwd.compareToIgnoreCase("") == 0) {
                        blnAutorizado = false;
                        strMess = "Debe informar contraseña para autorizar el servicio";
                    } else {
                        rsAut = UtileriasBDF.rsSQLNP("sp_EncriptDesEncriptPassword '" + StrUsrAut + "',0,'', 0");
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
            } else {

                if (StrCotizado.equalsIgnoreCase("1")) {
                    strMess = "El Expediente ya esta siendo cotizado";
                    out.println("<script> alert('" + strMess + "');location.href='../Operacion/MarcarCotizado.jsp?clExpediente=" + StrclExpediente + "';</script>");
                } else {
                    blnAutorizado = true;
                }
            }

            if (blnAutorizado == false) {
                out.println("<script> alert('" + strMess + "');location.href='../Operacion/MarcarCotizado.jsp?clExpediente=" + StrclExpediente + "';</script>");
            } else {
                //out.println(StrCita);
                rsEx = UtileriasBDF.rsSQLNP("sp_GuardaCotizado " + StrclExpediente + "," + StrclUsrApp + ",'" + StrUsrAut + "'," + StrCotizado);
                //rsEx = UtileriasBDF.rsSQL("Update Expediente set Cotizacion='" + StrCotizado + "' where clExpediente="+ StrclExpediente);
                out.println("<script> window.opener.document.location.reload();window.close();</script>");
            }
            out.println("</body>");
            out.println("</html>");

            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.close();
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