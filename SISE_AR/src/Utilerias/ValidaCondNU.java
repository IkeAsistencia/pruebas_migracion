package Utilerias;

import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class ValidaCondNU extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void destroy() {
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);

        String StrclCuenta = "";
        String StrClave = "";
        String StrclTipoServicio = "";
        String StrAgente = "";
        String StrUsr = "";
        String StrPwd = "";
        String strBack = "";
        String strMess = "";

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Validar la condición del Nuestro Usuario</title>");
        out.println("</head>");
        out.println("<link href=\"../StyleClasses/Global.css\" rel=\"stylesheet\" type=\"text/css\">");
        out.println("<body class='cssBody' BGSOUND='../Music/UTOPIA.WAV' onload=\"setInterval('blinkIt()',300);\">");

        if (request.getParameter("Clave") != null) {
            StrClave = request.getParameter("Clave").toString();
        }
        if (request.getParameter("clCuenta") != null) {
            StrclCuenta = request.getParameter("clCuenta").toString();
        }
        if (request.getParameter("clTipoServicio") != null) {
            StrclTipoServicio = request.getParameter("clTipoServicio");
        }
        if (request.getParameter("Agente") != null) {
            StrAgente = request.getParameter("Agente").toString();
        }
        if (request.getParameter("Usr") != null) {
            StrUsr = request.getParameter("Usr").toString();
        }
        if (request.getParameter("Pwd") != null) {
            StrPwd = request.getParameter("Pwd").toString();
        }

        if ((StrClave.compareToIgnoreCase("") == 0) || (StrclCuenta.compareToIgnoreCase("") == 0)) {
            out.println("<p class='TTable'>Falta informar la clave de Nuestro Usuario o la cuenta</p>");
            out.println("<script> window.opener.fnValidaResponse(-1,'');window.focus()</script>");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }
        ResultSet rs = null;
        ResultSet rsAut = null;
        try {
            //System.out.println("Query"+"sp_VerificaCondNU " + StrclCuenta + ",'" + StrClave +"','"+StrclTipoServicio+"','" + StrAgente + "'");
            rs = UtileriasBDF.rsSQLNP("sp_VerificaCondNU " + StrclCuenta + ",'" + StrClave + "','" + StrclTipoServicio + "','" + StrAgente + "'");
            if (rs.next()) {
                if (rs.getString("Response").compareToIgnoreCase("0") == 0) {
                    //String strUsuario ="";
                    boolean blnAutorizado = false;
                    rsAut = null;

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
                    if (blnAutorizado == false) {
                        out.println("<p class='TTable'>REGISTRO DE EXPEDIENTE NO AUTORIZADO, MOTIVO:" + rs.getString("MessageHTML"));
                        out.println("<br>" + strMess + "</p>");
                        out.println("<form action='../servlet/Utilerias.ValidaCondNU' method='post'>");
                        out.println("<table><tr><td class='cssTitDet' colspan=2>Clave de autorización...</td></tr>");
                        out.println("<tr><td class='FTable'>Usuario:</td><td class='FTable'><input id='Usr' name = 'Usr'></input></td><tr>");
                        out.println("<tr><td class='FTable'>Contraseña:</td><td class='FTable'><input type=password id='Pwd' name = 'Pwd'></input></td><tr>");
                        out.println("<tr><td class='FTable'><input class='cBtn' VALUE='Autorizar' type='submit'></input></td><td class='FTable'><input value ='Cancelar' class='cBtn' type='button' onClick='window.close()'></input></td><tr>");
                        out.println("<input id='Clave' name='Clave' type='hidden' value='" + StrClave + "'></input>");
                        out.println("<input id='clCuenta' name='clCuenta' type='hidden' value='" + StrclCuenta + "'></input>");
                        out.println("<input id='clTipoServicio' name='clTipoServicio' type='hidden' value='" + StrclTipoServicio + "'></input>");
                        out.println("<script>window.opener.fnValidaResponse(-1,'');window.focus();window.resizeTo(400,310);window.moveTo(300,150)</script>");
                        out.println("<script>");
                        out.println("function blinkIt() {");
                        out.println("if (!document.all)return;");
                        out.println("else {for(i=0;(i<document.all.tags('blink').length);i++){");
                        out.println("s=document.all.tags('blink')[i];");
                        out.println("s.style.visibility=(s.style.visibility=='visible')?'hidden':'visible';      }      }    }   ");
                        out.println("</script>");
                        out.println("<BGSOUND SRC='../Music/UTOPIA.WAV'>");
                    } else {
                        out.println("<script>window.opener.fnSubmitOK(" + rsAut.getString("clUsrApp") + ",'" + rs.getString("Message") + "')</script>");
                    }
                } else {
                    out.println("<script>window.opener.fnSubmitOK(0,'')</script>");
                }
                out.println("</body>");
                out.println("</html>");
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.close();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (rsAut != null) {
                    rsAut.close();
                    rsAut = null;
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        StrclCuenta = null;
        StrClave = null;
        StrAgente = null;
        StrUsr = null;
        StrPwd = null;
        strBack = null;
        strMess = null;
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
