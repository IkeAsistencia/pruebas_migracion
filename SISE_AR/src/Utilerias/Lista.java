package Utilerias;

import java.io.PrintWriter;
import java.io.IOException;
import UtlHash.Pagina;
import UtlHash.Filtro;
import java.util.List;
import java.sql.ResultSet;
import UtlHash.LoadPagina;
import Seguridad.SeguridadC;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Lista extends HttpServlet {

    private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        String StrUsrApp = "0";

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<link href=\"../StyleClasses/Global.css\" rel=\"stylesheet\" type=\"text/css\"> ");
        out.println("<script src='../Utilerias/Util.js'></script>");
        out.println("<title>Listado</title>");
        out.println("</head>");
        out.println("<body class='cssBody' topmargin='25' onload='fn_BlinkMuestra()' >");

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrUsrApp)) != true) {
            out.println("Fuera de Horario");
            return;
        }

        String clPaginaWeb = "0";
        int intclPaginaWeb = 0;

        if (request.getParameter("P") != null) {
            intclPaginaWeb = Integer.parseInt(request.getParameter("P"));
            if (intclPaginaWeb > 0) {
                clPaginaWeb = Integer.toString(intclPaginaWeb);
            }

        } else {
            out.println("Falta Informar Página (Consulte a su administrador)");
            StrUsrApp = null;
            clPaginaWeb = null;
            return;
        }

        if (request.getParameter("Apartado") == null && request.getParameter("Filtros") == null) {
            out.println("<script>fnCloseLinks()</script>");
        }

        sessionH.setAttribute("clPaginaWeb", clPaginaWeb);

        StringBuffer StrSql = new StringBuffer();
        StringBuffer StrSqlSent = new StringBuffer();
        Filtro FiltroI = null;
        Pagina PaginaI = LoadPagina.getPagina(clPaginaWeb);

        ResultSet rs = null;
        ResultList rs1 = null;
        StringBuffer strSalida = new StringBuffer();

        Statement stmt = null;
        Connection con = null;

        StringBuffer strParamProc = new StringBuffer();
        //strSalida.append("<b><center><table ><tr><td><font color='#423A9E'><b>");
        strSalida.append("<b><center><table><tr><td><font size='4'; style='text-transform: uppercase; color: #000000;'><b>");

        strSalida.append(PaginaI.getStrTituloRPT()).append("</b></font></td></tr></table></center></b>");
        StrSqlSent.append(PaginaI.getStrSentenciaRPT());

        //Valida si tiene permisos de Alta para la Pagina de Detalle, Tambien valida si tiene filtros
        try {
            StrSql.append("st_getDetallePagina ").append(StrUsrApp).append(",").append(clPaginaWeb);
            System.out.println("Utilerias/Lista: " + StrSql);
            try {
                con = UtileriasBDF.getConnection();
                if (con != null) {
                    stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    //stmtLog = con.createStatement();

                    try {
                        stmt.execute("set dateformat YMD");
                        rs = stmt.executeQuery(StrSql.toString());
                    } catch (Exception e) {
                        System.out.println("Error en Utilerias.Lista: " + e);
                    }
                } else {
                    System.out.println("No me pude conectar, SISE ARG");
                }
            } catch (SQLException sqle) {
                System.out.println("Error en Utilerias.Lista: " + sqle);
            }

            StrSql.delete(0, StrSql.length());
            //validar si tiene filtros

            if (rs.next()) {
                if (rs.getInt("TieneFiltros") == 1) {
                    strSalida.append("<input class='cBtn' type='button' value='Buscar...' onClick=\"window.open('../Utilerias/Filtros.jsp','','resizable=yes,menubar=0,status=0,toolbar=0,height=250,width=250,screenX=0,screenY=0')\"></input>");
                }
                if (rs.getInt("Alta") == 1) {
                    strSalida.append("<input class='cBtn' type='button' value='Nuevo' onClick=\"top.document.all.Contenido.src='").append(rs.getString("PaginaDetalle")).append("'\"></input>");
                }
                
                strSalida.append("<br><br>");

            } else {
                strSalida.append("<br><br>");
            }
            rs.close();
            rs = null;

            List lstFiltros = null;
            lstFiltros = PaginaI.getLstFiltros();
            if (lstFiltros != null) {

                int x = 0;
                //int xR = 1;
                for (x = 0; x < lstFiltros.size(); x++) {
                    FiltroI = (Filtro) lstFiltros.get(x);

                    if (FiltroI.getStrVarVal().compareToIgnoreCase("") == 0) {
                        return;
                    }

                    if (strParamProc.toString().length() != 0) {
                        strParamProc.append(",");
                    }

                    if (FiltroI.getStrTipoDato().compareToIgnoreCase("") != 0) {
                        if (FiltroI.getStrTipoDato().equalsIgnoreCase("Texto")) {
                            strParamProc.append("'");
                        }
                    } else {
                        return;
                    }

                    if (FiltroI.getStrTipoGet().compareToIgnoreCase("") != 0) {
                        if (FiltroI.getStrTipoGet().compareToIgnoreCase("Session") == 0) {
                            if (sessionH.getAttribute(FiltroI.getStrVarVal()) == null) {
                                return;
                            } else {
                                strParamProc.append(sessionH.getAttribute(FiltroI.getStrVarVal()).toString());
                            }
                        }
                    } else {
                        return;
                    }

                    if (FiltroI.getStrTipoGet().equalsIgnoreCase("Post") || FiltroI.getStrTipoGet().equalsIgnoreCase("Get")) {
                        if (request.getParameter(FiltroI.getStrVarVal()) == null) {
                            if (FiltroI.getStrTipoDato().equalsIgnoreCase("Entero")) {
                                strParamProc.append("0");
                            }
                        } else {
                            if (request.getParameter(FiltroI.getStrVarVal()).equalsIgnoreCase("")) {
                                if (FiltroI.getStrTipoDato().equalsIgnoreCase("Entero")) {
                                    strParamProc.append("0");
                                }
                            } else {
                                strParamProc.append(request.getParameter(FiltroI.getStrVarVal()));
                            }
                        }
                    }

                    if (FiltroI.getStrTipoGet().equalsIgnoreCase("Estatico")) {
                        strParamProc.append(FiltroI.getStrVarVal());
                    }

                    if (FiltroI.getStrTipoDato().equalsIgnoreCase("Texto")) {
                        strParamProc.append("'");
                    }
                    FiltroI = null;
                }
            }
            StrSqlSent.append(" ").append(strParamProc);
            /*impresion de sentancia*/
            //System.out.println("Pagina SISE ARG: " + clPaginaWeb);
            //System.out.println("Sent SISE ARG: " + StrSqlSent);

            /*out.print(strSalida);
             strSalida.delete(0, strSalida.length());
             UtileriasBDF.rsTableNP(StrSqlSent.toString(), strSalida);
             out.print(strSalida);
             StrSql.delete(0, StrSql.length());
             strSalida.delete(0, strSalida.length());
             StrSqlSent.delete(0, StrSqlSent.length());
             strParamProc.delete(0, strParamProc.length()); MARIO 20150709*/
            rs1 = new ResultList();
            strSalida.append(rs1.rsTable(StrSqlSent.toString()));
            System.out.println("Listado SISE: " + StrSqlSent);
            out.print(strSalida);
            StrSql.delete(0, StrSql.length());
            strSalida.delete(0, strSalida.length());
            StrSqlSent.delete(0, StrSqlSent.length());
            strParamProc.delete(0, strParamProc.length());

            StrUsrApp = null;
            clPaginaWeb = null;
            StrSql = null;
            StrSqlSent = null;
            PaginaI = null;
            strSalida = null;
            strParamProc = null;
            FiltroI = null;

        } catch (Exception e) {
            e.printStackTrace();
            StrSql.delete(0, StrSql.length());
            strSalida.delete(0, strSalida.length());
            StrSqlSent.delete(0, StrSqlSent.length());
            strParamProc.delete(0, strParamProc.length());

            StrUsrApp = null;
            clPaginaWeb = null;
            StrSql = null;
            StrSqlSent = null;
            PaginaI = null;
            strSalida = null;
            strParamProc = null;
            FiltroI = null;
            return;
        } finally {
            out.println("</body>");
            out.println("<script>");
            out.println("   function blinkIt() {");
            out.println("        if (!document.all) ");
            out.println("           return;");
            out.println("   else { ");
            out.println("       for(i=0;(i<document.all.tags('blink').length);i++) {");
            out.println("           s=document.all.tags('blink')[i]; ");
            out.println("           s.style.visibility=(s.style.visibility=='visible')?'hidden':'visible'; ");
            out.println("       } ");
            out.println("     }     ");
            out.println(" }     ");

            out.println("</script>");
            out.println("</html>");
            out.close();
            try {
                rs.close();
            } catch (Exception e) {
            }
            try {
                stmt.close();
            } catch (Exception e) {
            }
            try {
                con.close();
            } catch (Exception e) {
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
