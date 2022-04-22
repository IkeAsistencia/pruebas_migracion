package Utilerias;

import Seguridad.SeguridadC;
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

public class LlenaCombos extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {      super.init(config);   }
    public void destroy() {   }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        PrintWriter out = response.getWriter();
        Connection con = UtileriasBDF.getConnection();
        StringBuilder strSelectHTML = new StringBuilder();
        String StrclUsrApp = "";
        String strSQL = "";
        response.setContentType("text/html");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Llena Combos</title>");
        out.println("</head>");
        out.println("<body>");
        if (sessionH.getAttribute("clUsrApp") == null) {
            out.println("La sesion Expiro");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        } else {
            StrclUsrApp = sessionH.getAttribute("clUsrApp").toString();        }
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
            out.println("Su session expiró");
            out.println("</body>");
            out.println("</html>");
            return;
        }
        out.println("<script>");
        ResultSet rs = null;
        try {
            strSQL = request.getParameter("strSQL").toString();
            strSQL = strSQL.toUpperCase();
            strSQL = strSQL.replace("SELECT ", "");
            strSQL = strSQL.replace("INSERT ", "");
            strSQL = strSQL.replace("UPDATE ", "");
            strSQL = strSQL.replace("DELETE ", "");
            strSQL = strSQL.replace("TRUNCATE ", "");
            strSQL = strSQL.replace("DROP ", "");
            strSQL = strSQL.replace(" FROM ", "");
            strSQL = strSQL.replace(" WHERE ", "");
            strSQL = strSQL.replace(" IN ", "");
            strSQL = strSQL.replace(" BEGIN ", "");
            strSQL = strSQL.replace(" END ", "");
            strSQL = strSQL.replace("EXECUTE ", "");
            strSQL = strSQL.replace(" DECLARE ", "");
            strSQL = strSQL.replace("WAITFOR", "");
            strSQL = strSQL.replace("DELAY", "");
            strSQL = strSQL.replace(" AS ", "");
            strSQL = strSQL.replace("EXEC ", "");
            strSQL = strSQL.replace("TRANSACTION", "");
            strSQL = strSQL.replace("@", "");
            strSQL = strSQL.replace("%", "");
            strSQL = strSQL.replace(".", "");
            strSQL = strSQL.replace("/", "");
            strSQL = strSQL.replace("*", "");
            strSQL = strSQL.replace("|", "");
            strSQL = strSQL.replace("||", "");
            strSQL = strSQL.replace("(", "");
            strSQL = strSQL.replace(")", "");
            rs = UtileriasBDF.rsSQLNP("SET QUOTED_IDENTIFIER ON EXEC " + strSQL);
            while (rs.next()) {
                strSelectHTML.append("<option value='").append(rs.getString(1)).append("'>").append(rs.getString(2)).append("</option>");
            }
            out.println("top.opener.fnReplaceSelect('" + request.getParameter("strName") + "',\"" + strSelectHTML.toString() + "\");");
            strSelectHTML.delete(0, strSelectHTML.length());
            out.println("window.close();</script></body>");
            out.println("</html>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                    }
                if (con != null) {
                    con.close();
                    con = null;
                }
            } catch (Exception ee) {     ee.printStackTrace();        }
            out.close();
            this.destroy();
        }
    }
//------------------------------------------------------------------------------
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {   processRequest(request, response);    }
//------------------------------------------------------------------------------
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {   processRequest(request, response);    }
//------------------------------------------------------------------------------
    public String getServletInfo() {   return "Short description";  }
//------------------------------------------------------------------------------
    }
