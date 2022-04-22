package Seguridad;

import Utilerias.UtileriasBDF;
import com.ike.model.DAOSeguridad;
import com.ike.model.DAOUsuarioAutenticacion;
import com.ike.model.to.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Random;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class Login extends HttpServlet {
//------------------------------------------------------------------------------
    public Login() {    }
//------------------------------------------------------------------------------
    public void init(ServletConfig config)     throws ServletException {
        super.init(config);    }
//------------------------------------------------------------------------------
    public void destroy() {    }
//------------------------------------------------------------------------------
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        HttpSession sessionH = request.getSession(true);
        ResultSet rsHost = null;
        DAOSeguridad daos = new DAOSeguridad();
        DAOUsuarioAutenticacion daoUser = new DAOUsuarioAutenticacion();
        PrintWriter out = response.getWriter();
        String usr = "";
        String pas = "";
        String StrOKext = "0";
        String ext = "0";
        String SAgenteIn = "0";
        String SExtensionIn = "0";
        String strIP = "";
        strIP = request.getRemoteAddr();
        sessionH.setAttribute("IP", strIP);
        if (request.getParameter("OKext") != null) {
            StrOKext = request.getParameter("OKext").toString();        }
        if (request.getParameter("Extension") != null) {
            ext = request.getParameter("Extension").toString();        }
        if (request.getParameter("AgenteIn") != null) {
            SAgenteIn = request.getParameter("AgenteIn").toString();        }
        if (request.getParameter("ExtensionIn") != null) {
            SExtensionIn = request.getParameter("ExtensionIn").toString();        }
        if (request.getParameter("Usr") != null) {
            usr = request.getParameter("Usr").toString();
        } else {
            out.println("<script>");
            out.println("alert(\"Error.\");history.go(-1);");
            out.println("</script>");
            return;
        }
        if (request.getParameter("Pass") != null) {   pas = request.getParameter("Pass").toString();
        } else {
            out.println("<script>");
            out.println("alert(\"Error.\");history.go(-1);");
            out.println("</script>");
            return;
        }
        Random rdm = new Random();
        int rl = rdm.nextInt();
        String hash1 = Integer.toHexString(rl);
        String ValidaSession = hash1.substring(0, 7);
        response.setContentType("text/html");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servicio Seguridad</title>");
        out.println("</head>");
        out.println("<link href='../StyleClasses/Global.css' rel='stylesheet' type='text/css'>");
        out.println("<body class='cssBody'>");
        usr = usr.trim();
        pas = pas.trim();
        usr = usr.replaceAll("['\"\\*\\, ]", "");
        pas = pas.replaceAll("['\"\\*\\, ]", "");
        if (usr.length() > 17) {      usr = usr.substring(0, 17);        }
        if (pas.length() > 10) {      pas = pas.substring(0, 10);        }
        if (usr.equalsIgnoreCase("select") || usr.equalsIgnoreCase("insert") || usr.equalsIgnoreCase("update") || usr.equalsIgnoreCase("delete") || usr.equalsIgnoreCase("truncate")
                || usr.equalsIgnoreCase("drop") || usr.equalsIgnoreCase("from") || usr.equalsIgnoreCase("where") || usr.equalsIgnoreCase("in") || usr.equalsIgnoreCase("begin")
                || usr.equalsIgnoreCase("end") || usr.equalsIgnoreCase("execute") || usr.equalsIgnoreCase("as") || usr.equalsIgnoreCase("exec") || usr.equalsIgnoreCase("'")
                || usr.equalsIgnoreCase("@") || usr.equalsIgnoreCase("%") || usr.equalsIgnoreCase(".") || usr.equalsIgnoreCase(",") || usr.equalsIgnoreCase("/")
                || usr.equalsIgnoreCase("*") || usr.equalsIgnoreCase("|") || usr.equalsIgnoreCase("||")
                || pas.equalsIgnoreCase("select") || pas.equalsIgnoreCase("insert") || pas.equalsIgnoreCase("update") || pas.equalsIgnoreCase("delete") || pas.equalsIgnoreCase("truncate")
                || pas.equalsIgnoreCase("drop") || pas.equalsIgnoreCase("from") || pas.equalsIgnoreCase("where") || pas.equalsIgnoreCase("in") || pas.equalsIgnoreCase("begin")
                || pas.equalsIgnoreCase("end") || pas.equalsIgnoreCase("execute") || pas.equalsIgnoreCase("as") || pas.equalsIgnoreCase("exec") || pas.equalsIgnoreCase("'")
                || pas.equalsIgnoreCase("@") || pas.equalsIgnoreCase("%") || pas.equalsIgnoreCase(".") || pas.equalsIgnoreCase(",") || pas.equalsIgnoreCase("/")
                || pas.equalsIgnoreCase("*") || pas.equalsIgnoreCase("|") || pas.equalsIgnoreCase("||")) {
            out.println("<script>");
            out.println("alert(\"Uso inadecuado del sistema.\");history.go(-1);");
            out.println("</script>");
            return;
        }
        try {
            Usuario usuario = daos.getUsuario(usr, pas, strIP);
            if (usuario != null) {
                if (usuario.getMess().compareToIgnoreCase("") == 0) {
                    if (usuario.getActivo().equals("0")) {
                        out.println("<script>");
                        out.println("alert(\"Usuario Inactivo\");history.go(-1);");
                        out.println("</script>");
                    } else if (usuario.getActivo().equals("2")) {
                        if (usuario.getPermisoDesbloqueo().equals("1")) {
                            out.println("<script>");
                            out.println("alert(\"Usuario Bloqueado\");");
                            out.println("</script>");
                            out.println("<tr><td><button onclick='fnNewWindow();'>Haz clic si olvidaste tu Password.</button></td></tr>");
                            out.println("<tr><td><button onclick='history.go(-1);'>Regresar</button></td></tr>");
                            out.println(" <script>");
                            out.println("function fnNewWindow() {");
                            out.println((new StringBuilder()).append("mywindow=window.open('../servlet/Seguridad.DesbloqueoWeb?Usr=").append(usr).append("','WinSave','resizable=yes,menubar=0,status=0,toolbar=0,height=1,width=1,screenX=1,screenY=1');").toString());
                            out.println("iX=(screen.width)/2 - 135;");
                            out.println("iY=(screen.height)/2 - 120;");
                            out.println("mywindow.moveTo(iX,iY);");
                            out.println("mywindow.focus()");
                            out.println("}");
                            out.println("</script>");
                        } else {
                            out.println("<script>");
                            out.println("alert(\"Usuario Bloqueado\");history.go(-1);");
                            out.println("</script>");
                        }
                    } else if (usuario.getCambioPwd().equals("1")) {
                        response.sendRedirect((new StringBuilder()).append("../Seguridad/CambiaPasswd.jsp?Expiro=1&clUsrApp=").append(usuario.getClUsrApp()).append("&Usuario=").append(usr).toString());
                    } else if (pas.equalsIgnoreCase(usuario.getPassword())) {
                        if (SeguridadC.verificaHorarioC(Integer.parseInt(usuario.getClUsrApp()))) {
                            rsHost = UtileriasBDF.rsSQLNP((new StringBuilder()).append("spValidaHost ").append(usuario.getClUsrApp()).append(" ,'").append(request.getRemoteAddr()).append("'").toString());
                            if (rsHost.next()) {
                                if (rsHost.getString("AccesoPermitido").compareToIgnoreCase("1") == 0) {
                                    sessionH.setAttribute("NombreUsuario", usuario.getNombre());
                                    sessionH.setAttribute("clUsrApp", usuario.getClUsrApp());
                                    sessionH.setAttribute("Usr", usr);
                                    sessionH.setAttribute("FechaAlta", usuario.getFechaAlta());
                                    sessionH.setAttribute("FechaInicio", usuario.getFechaInicio());
                                    sessionH.setAttribute("Correo", usuario.getCorreo());
                                    sessionH.setAttribute("Agente", usuario.getAgente());
                                    sessionH.setAttribute("WebPhone", usuario.getWebPhone());
                                    sessionH.setAttribute("PhoneClass", usuario.getPhoneClass());
                                    sessionH.setAttribute("AccesoId", usuario.getAccesoID());
                                    sessionH.setAttribute("alertaApp", usuario.getAlertaApp());
                                    if (!usuario.getAgente().equalsIgnoreCase("0")) {
                                        if (ext.equalsIgnoreCase("0")) {
                                            out.println("<form id='Forma' name ='Forma' action='Seguridad.Login' method='post'>");
                                            out.println((new StringBuilder()).append("<INPUT id='Usr' name='Usr' type='hidden' value='").append(usr).append("'>").toString());
                                            out.println((new StringBuilder()).append("<INPUT id='Pass' name='Pass' type='hidden' value='").append(pas).append("'>").toString());
                                            out.println("<p class='FTable'>Por Favor Ingrese su Extension: <br></p><INPUT class='VTable' label='Extension'  size=5 id='Extension' name='Extension' value='' maxlength='4'></INPUT>");
                                            out.println("<input class='cBtn' type='button' value='Entrar' onClick='fnValExt();' ></input>");
                                            out.println("<script>function fnValExt(){if(document.Forma.Extension.value.length < 4){alert('La Extensi\363n tiene que ser de 4 D\355gitos');document.Forma.Extension.focus();}else{this.disabled=true;document.all.Forma.submit();}   }</script>");
                                            out.println("</form>");
                                        } else if (StrOKext.equalsIgnoreCase("1")) {
                                            sessionH.setAttribute("Extension", ext);
                                            UtileriasBDF.rsSQLNP((new StringBuilder()).append("spInsertaMap '").append(usuario.getAgente().trim()).append("','").append(ext).append("','1','").append(SAgenteIn.trim()).append("','").append(SExtensionIn).append("'").toString());
                                            response.sendRedirect("../Main.jsp");
                                        } else {
                                            ResultSet rsExtension = UtileriasBDF.rsSQLNP((new StringBuilder()).append("spValidaExtension '").append(usuario.getAgente().trim()).append("','").append(ext).append("'").toString());
                                            if (rsExtension.next()) {
                                                String StrAccesoExt = rsExtension.getString("Acceso");
                                                String StrAgenteIn = rsExtension.getString("Agente");
                                                String StrExtensionIn = rsExtension.getString("Extension");
                                                String StrMensaje = rsExtension.getString("Mensaje");
                                                if (StrAccesoExt.equalsIgnoreCase("2")) {
                                                    out.println("<script>");
                                                    out.println("alert(\"No existe la extensi\363n, Por favor llame a Soporte T\351cnico\");history.go(-1);");
                                                    out.println("</script>");
                                                } else if (StrAccesoExt.equalsIgnoreCase("1")) {
                                                    UtileriasBDF.rsSQLNP((new StringBuilder()).append("spInsertaMap '").append(usuario.getAgente().trim()).append("','").append(ext).append("','0','0','0'").toString());
                                                    response.sendRedirect("../Main.jsp");
                                                } else {
                                                    out.println("<form id='Forma' name ='Forma' action='Seguridad.Login' method='post'>");
                                                    out.println((new StringBuilder()).append("<INPUT id='Usr' name='Usr' type='hidden' value='").append(usr).append("'>").toString());
                                                    out.println((new StringBuilder()).append("<INPUT id='Pass' name='Pass' type='hidden' value='").append(pas).append("'>").toString());
                                                    out.println((new StringBuilder()).append("<INPUT id='Extension' name='Extension' type='hidden' value='").append(ext).append("'>").toString());
                                                    out.println((new StringBuilder()).append("<INPUT id='AgenteIn' name='AgenteIn' type='hidden' value='").append(StrAgenteIn).append("'>").toString());
                                                    out.println((new StringBuilder()).append("<INPUT id='ExtensionIn' name='ExtensionIn' type='hidden' value='").append(StrExtensionIn).append("'>").toString());
                                                    out.println("<INPUT id='OKext' name='OKext' type='hidden' value='1'>");
                                                    out.println((new StringBuilder()).append("<p class='FTable'>Mensaje: ").append(StrMensaje).append("<br>Presiona Entrar para Continuar<br></p>").toString());
                                                    out.println("<input class='cBtn' type='button' value='Regresar' onClick='history.go(-1)'></input>");
                                                    out.println("<input class='cBtn' type='button' value='Entrar' onClick='if(confirm(\"Quieres Continuar\")==true) { document.all.Forma.submit();  }'></input>");
                                                    out.println("</form>");
                                                }
                                            }
                                        }
                                    } else {  
                                        //Doble autenticacion - Para eliminar dejar solo lo que esta dentro del if
                                        if(usuario.getValidaDobleFactor().equalsIgnoreCase("0")){
                                            usuario = null;
                                            sessionH.setAttribute("ValidaSessionR", ValidaSession);
                                            sessionH.setAttribute("ValidaSessionS", ValidaSession);
                                            response.sendRedirect("../Main.jsp");
                                        }else{  
                                            String sessionID = daoUser.insertUsuarioAutenticaion(usuario);
                                            sessionH.setAttribute("ValidaSessionA", sessionID);
                                            response.sendRedirect("../DobleAutenticacion.jsp");
                                        }
                                    }
                                } else {
                                    out.println((new StringBuilder()).append("<script>alert('Acceso no Permitido:").append(rsHost.getString("Razon")).append("');history.go(-1)</script>").toString());
                                    out.println("</body>");
                                    out.println("</html>");
                                }
                            } else {
                                out.println("error 01 : Problemas con la base de datos al validar el Host, consulte a su administrador .");
                                out.println("</body>");
                                out.println("</html>");
                            }
                        } else {
                            out.println("error : Fuera de horario");
                            out.println("</body>");
                            out.println("</html>");
                        }
                    } else {
                        out.println("error : Acceso no v\341lido");
                        out.println("</body>");
                        out.println("</html>");
                    }
                } else {
                    out.println(usuario.getMess());
                    out.println("</body>");
                    out.println("</html>");
                }
            } else {
                out.println("<script>");
                out.println("alert(\"Usuario Inexistente\");history.go(-1);");
                out.println("</script>");
            }
        } catch (Exception e) {
            out.println("error 02 : Problemas con la base de datos al validar el Host, consulte a su administrador .");
            out.println("</body>");
            out.println("</html>");
            e.printStackTrace();
        } finally {
            try {
                if (rsHost != null) {
                    rsHost.close();
                    rsHost = null;
                }
            } catch (Exception e) {        e.printStackTrace();       }
        }
        out.close();
        daos = null;
        usr = null;
        pas = null;
        StrOKext = null;
        ext = null;
        SAgenteIn = null;
        SExtensionIn = null;
        strIP = null;
    }
//------------------------------------------------------------------------------
    protected void doPost(HttpServletRequest request, HttpServletResponse response)    throws ServletException, IOException {
        processRequest(request, response);   }
//------------------------------------------------------------------------------    
    public String getServletInfo() {        return "Short description";    }
//------------------------------------------------------------------------------
}