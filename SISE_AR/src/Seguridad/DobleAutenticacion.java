package Seguridad;

import com.ike.model.DAOUsuarioAutenticacion;
import com.ike.model.to.AutenticacionError;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DobleAutenticacion extends HttpServlet {
//----------------------------------------------------------------
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
		}
//----------------------------------------------------------------
    public void destroy() { }
//----------------------------------------------------------------
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAOUsuarioAutenticacion daoUser = new DAOUsuarioAutenticacion();
        AutenticacionError autError = new AutenticacionError();
        PrintWriter out = response.getWriter();
        String codigoVerificacion = "";
        String sessionID = "";
        Random rdm = new Random();
        int rl = rdm.nextInt();
        String hash1 = Integer.toHexString(rl);
        String ValidaSession = hash1.substring(0, 7);
        if (request.getParameter("codigoVerificacion") != null && session.getAttribute("ValidaSessionA") != null) {
            codigoVerificacion = request.getParameter("codigoVerificacion");
            sessionID = session.getAttribute("ValidaSessionA").toString();
        } else {
            out.println("<script>");
            out.println("alert(\"Error.\");history.go(-1);");
            out.println("</script>");
            return;
        }
        response.setContentType("text/html");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servicio Seguridad</title>");
        out.println("</head>");
        out.println("<link href='../StyleClasses/Global.css' rel='stylesheet' type='text/css'>");
        out.println("<body class='cssBody'>");
        codigoVerificacion = codigoVerificacion.trim();
        sessionID = sessionID.trim();
        codigoVerificacion = codigoVerificacion.replaceAll("['\"\\*\\, ]", "");
        sessionID = sessionID.replaceAll("['\"\\*\\, ]", "");
        if (codigoVerificacion.length() > 6) {
            codigoVerificacion = codigoVerificacion.substring(0, 6);     }
        if (codigoVerificacion.equalsIgnoreCase("select") || codigoVerificacion.equalsIgnoreCase("insert") || codigoVerificacion.equalsIgnoreCase("update") || codigoVerificacion.equalsIgnoreCase("delete") || codigoVerificacion.equalsIgnoreCase("truncate")
                || codigoVerificacion.equalsIgnoreCase("drop") || codigoVerificacion.equalsIgnoreCase("from") || codigoVerificacion.equalsIgnoreCase("where") || codigoVerificacion.equalsIgnoreCase("in") || codigoVerificacion.equalsIgnoreCase("begin")
                || codigoVerificacion.equalsIgnoreCase("end") || codigoVerificacion.equalsIgnoreCase("execute") || codigoVerificacion.equalsIgnoreCase("as") || codigoVerificacion.equalsIgnoreCase("exec") || codigoVerificacion.equalsIgnoreCase("'")
                || codigoVerificacion.equalsIgnoreCase("@") || codigoVerificacion.equalsIgnoreCase("%") || codigoVerificacion.equalsIgnoreCase(".") || codigoVerificacion.equalsIgnoreCase(",") || codigoVerificacion.equalsIgnoreCase("/")
                || codigoVerificacion.equalsIgnoreCase("*") || codigoVerificacion.equalsIgnoreCase("|") || codigoVerificacion.equalsIgnoreCase("||")
                || sessionID.equalsIgnoreCase("select") || sessionID.equalsIgnoreCase("insert") || sessionID.equalsIgnoreCase("update") || sessionID.equalsIgnoreCase("delete") || sessionID.equalsIgnoreCase("truncate")
                || sessionID.equalsIgnoreCase("drop") || sessionID.equalsIgnoreCase("from") || sessionID.equalsIgnoreCase("where") || sessionID.equalsIgnoreCase("in") || sessionID.equalsIgnoreCase("begin")
                || sessionID.equalsIgnoreCase("end") || sessionID.equalsIgnoreCase("execute") || sessionID.equalsIgnoreCase("as") || sessionID.equalsIgnoreCase("exec") || sessionID.equalsIgnoreCase("'")
                || sessionID.equalsIgnoreCase("@") || sessionID.equalsIgnoreCase("%") || sessionID.equalsIgnoreCase(".") || sessionID.equalsIgnoreCase(",") || sessionID.equalsIgnoreCase("/")
                || sessionID.equalsIgnoreCase("*") || sessionID.equalsIgnoreCase("|") || sessionID.equalsIgnoreCase("||")) {
            out.println("<script>");
            out.println("alert(\"Uso inadecuado del sistema.\");history.go(-1);");
            out.println("</script>");
            return;
            }
        try {
            if (codigoVerificacion.isEmpty()) {
                session.setAttribute("errorMsg", "Ingrese un valor valido");
                response.sendRedirect("../DobleAutenticacion.jsp");
                }
            autError = daoUser.verificaCodigo(sessionID, codigoVerificacion);
            if (autError.getCodigo() != null) {
                if ("1".equals(autError.getCodigo()) || "2".equals(autError.getCodigo())) {
                    session.setAttribute("errorMsg", autError.getMensaje());
                    session.setAttribute("redirectToLogin", '1');
                    response.sendRedirect("../DobleAutenticacion.jsp");
                    }
                if ("3".equals(autError.getCodigo())) {
                    session.setAttribute("errorMsg", autError.getMensaje());
                    response.sendRedirect("../DobleAutenticacion.jsp");
                    }
            } else {
                session.setAttribute("ValidaSessionR", ValidaSession);
                session.setAttribute("ValidaSessionS", ValidaSession);
                response.sendRedirect("../Main.jsp");
		}
        } catch (Exception e) {
            out.println("error 02 : Problemas con la base de datos al validar el Host, consulte a su administrador .");
            out.println("</body>");
            out.println("</html>");
            e.printStackTrace();
            }
        out.close();
    }
//----------------------------------------------------------------
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);   }
//----------------------------------------------------------------
    public String getServletInfo() {     return "Short description";    }
//----------------------------------------------------------------
}