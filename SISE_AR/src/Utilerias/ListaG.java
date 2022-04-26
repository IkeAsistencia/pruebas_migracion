package Utilerias;

import java.io.PrintWriter;
import java.io.IOException;
import UtlHash.Pagina;
import UtlHash.Filtro;
import java.util.List;
import java.sql.ResultSet;
import UtlHash.LoadPagina;
import Seguridad.SeguridadC;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ListaG extends HttpServlet {

    private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

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
        out.println("<link href=\"../StyleClasses/Global.css\" rel=\"stylesheet\" type=\"text/css\">");
        out.println("<title>Listado</title>");
        out.println("</head>");
        out.println("<body class='cssBody' topmargin='25' >");
        out.println("<script src='../Utilerias/Util.js'></script>");

        if (sessionH.getAttribute("clUsrApp") != null) {
            StrUsrApp = sessionH.getAttribute("clUsrApp").toString();
        }


        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrUsrApp)) != true) {
            out.println("Fuera de Horario");
            return;
        }

        String clPaginaWeb = "0";
        String clInicio = "0";

        if (request.getParameter("P") != null) {
            clPaginaWeb = request.getParameter("P").toString();
        } else {
            out.println("Falta Informar Página (Consulte a su administrador)");
            StrUsrApp = null;
            clPaginaWeb = null;
            return;
        }

        if (request.getParameter("I") != null) {
            clInicio = request.getParameter("I").toString();
        }

        if (request.getParameter("Apartado") == null && request.getParameter("Filtros") == null) {
            out.println("<script>fnCloseLinks()</script>");
        }

        sessionH.setAttribute("clPaginaWeb", clPaginaWeb);

        StringBuffer StrSql = new StringBuffer();
        StringBuffer StrSqlSent = new StringBuffer();
        StringBuffer StrSqlSentG = new StringBuffer();
        Filtro FiltroI = null;
        Pagina PaginaI = LoadPagina.getPagina(clPaginaWeb);

        ResultSet rs = null;
        StringBuffer strSalida = new StringBuffer();

        StringBuffer strParamProc = new StringBuffer();
        strSalida.append("<b><center><table ><tr><td><font color='#423A9E'><b>");
        strSalida.append(PaginaI.getStrTituloRPT()).append("</b></font></td></tr></table></center></b>");

        StrSqlSent.append(PaginaI.getStrSentenciaRPT());

        //Valida si tiene permisos de Alta para la Pagina de Detalle

        try {

            StrSql.append("select AxP.clPaginaWeb, case when sum(cast(AxP.Alta as tinyint)) > 0 then 1 else 0 end Alta, PW.NombrePaginaWeb ");
            StrSql.append("from AccesoGpoxPag AxP ");
            StrSql.append("inner join UsrxGpo UxG on (AxP.clGpoUsr = UxG.clGpoUsr) ");
            StrSql.append("inner join cPaginaWeb PW on (PW.clPaginaWeb = AxP.clPaginaWeb) ");
            StrSql.append("inner join (select PD.clPaginaWeb, PD.PaginaDetalle ");
            StrSql.append("            from cPaginaWeb PD ");
            StrSql.append("            Where PD.clPaginaWeb = ").append(clPaginaWeb).append(") ConsPags ON PW.NombrePaginaWeb = ConsPags.PaginaDetalle ");
            StrSql.append(" where UxG.clUsrApp = ").append(StrUsrApp).append(" group by AxP.clPaginaWeb, PW.NombrePaginaWeb");

            rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            strSalida.append("<input class='cBtn' type='button' value='Buscar' onClick=\"window.open('../Utilerias/FiltrosG.jsp','','resizable=yes,menubar=0,status=0,toolbar=0,height=250,width=250,screenX=0,screenY=0')\"></input>");

            if (rs.next()) {
                if (rs.getInt("Alta") == 1) {
                    strSalida.append("<input class='cBtn' type='button' value='Nuevo' onClick=\"top.document.all.Contenido.src='").append(rs.getString("NombrePaginaWeb")).append("'\"></input><br><br>");
                } else {
                    strSalida.append("<br><br>");
                }
            } else {
                strSalida.append("<br><br>");
            }
            rs.close();
            rs = null;

            List lstFiltros = null;
            lstFiltros = PaginaI.getLstFiltros();
            String strclTipografica = "";

            if (lstFiltros != null) {

                int x = 0;
                int xR = 1;
                for (x = 0; x < lstFiltros.size(); x++, xR++) {
                    FiltroI = (Filtro) lstFiltros.get(x);

                    if (FiltroI.getStrVarVal().compareToIgnoreCase("") == 0) {
                        return;
                    }
                    if (!FiltroI.getStrTipoDato().equalsIgnoreCase("Grafico")) {
                        if (strParamProc.toString().length() != 0) {
                            strParamProc.append(",");
                        }
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
                            if (request.getParameter(FiltroI.getStrVarVal()).toString().equalsIgnoreCase("")) {
                                if (FiltroI.getStrTipoDato().equalsIgnoreCase("Entero")) {
                                    strParamProc.append("0");
                                }
                            } else {
                                if (!FiltroI.getStrTipoDato().equalsIgnoreCase("Grafico")) {
                                    strParamProc.append(request.getParameter(FiltroI.getStrVarVal()).toString());
                                }
                            }
                        }
                    }

                    if (FiltroI.getStrTipoGet().equalsIgnoreCase("Estatico")) {
                        strParamProc.append(FiltroI.getStrVarVal());
                    }

                    if (FiltroI.getStrTipoDato().equalsIgnoreCase("Texto")) {
                        strParamProc.append("'");
                    }

                    if (FiltroI.getStrTipoDato().equalsIgnoreCase("Grafico")) {
                        //strclTipografica = "2";
                        if (request.getParameter(FiltroI.getStrVarVal()) != null) {
                            strclTipografica = request.getParameter(FiltroI.getStrVarVal()).toString();
                        } else {
                            strclTipografica = "0";
                        }
                        //strclTipografica = "2";
                    }

                    FiltroI = null;
                }
            }
            StrSqlSent.append(" ").append(strParamProc);
            StrSqlSentG.append(StrSqlSent.toString().trim());
            out.print(strSalida);
            if (clInicio.equalsIgnoreCase("0")) {
                strSalida.delete(0, strSalida.length());
                UtileriasBDF.rsTableNP(StrSqlSent.toString(), strSalida);

                out.print(strSalida);
            } else {
                if (clInicio.equalsIgnoreCase("1")) {
                    Grafica gr = new Grafica();
                    gr.sentenciaSQL = StrSqlSentG.toString().trim();
                    gr.clPagina = clPaginaWeb.toString().trim();
                    gr.clTipoGrafica = strclTipografica;
                    out.println(gr.doGet1(request, response));
                    out.println("<br>");
                    strSalida.delete(0, strSalida.length());
                    UtileriasBDF.rsTableNP(StrSqlSent.toString(), strSalida);
                    out.print(strSalida);
                }
            }


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
            out.println("</html>");
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
}
