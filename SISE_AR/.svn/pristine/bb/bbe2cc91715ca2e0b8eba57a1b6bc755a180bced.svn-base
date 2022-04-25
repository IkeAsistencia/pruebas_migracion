/*
 * EjecutaAccion.java
 *
 * Created on 3 de diciembre de 2004, 04:27 PM
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
 * cabrerar
 * @version
 */
public class EjecutaAccionFolioAfian extends HttpServlet {

    /*
     * Initializes
     * the
     * servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

    }

    /*
     * Destroys
     * the
     * servlet.
     */
    public void destroy() {
    }

    /*
     * Processes
     * requests
     * for
     * both
     * HTTP
     * <code>GET</code>
     * and
     * <code>POST</code>
     * methods.
     *
     * @param
     * request
     * servlet
     * request
     * @param
     * response
     * servlet
     * response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        String StrSentence = "";
        String StrFields = "";
        String StrVals = "";
        String StrType = "";
        String StrWhere = "";
        String strBack = "";
        boolean blnBackId = false;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Prueba de Servicio Seguridad</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("Action") == null) {
            out.println("Problema con la definición de la acción a realizar, por favor vuelva a intentarlo");
            out.println("</body>");
            out.println("</html>");
            return;
        }

        if (sessionH.getAttribute("clPaginaWebP") == null) {
            out.println("No se definió variable de session para la página");
            out.println("</body>");
            out.println("</html>");
            return;
        }

        try {
            ResultSet rs = UtileriasBDF.rsSQLNP("select Tabla from cPaginaWeb where clPaginaWeb = " + sessionH.getAttribute("clPaginaWebP"));
            if (rs.next()) {
                ResultSet rsInfo = UtileriasBDF.rsSQLNP("sp_GetInfoTabla " + rs.getString("Tabla"));
                // Aqui antes venia la formacion de la cadena de ALTA                                 

                if (Integer.parseInt(request.getParameter("Action")) == 2) {
                    StrSentence = "Update " + rs.getString("Tabla") + " set ";
                    while (rsInfo.next()) {
                        if (request.getParameter(rsInfo.getString("NameF")) != null) {
                            // No es un campo identity, en un insert se debe omitir
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("No") && rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                if (StrFields != "") {
                                    StrFields = StrFields + ",";
                                }
                                StrFields = StrFields + rsInfo.getString("NameF");
                                StrType = rsInfo.getString("TypeData").toString();
                                if (StrType.equalsIgnoreCase("tinyint") || StrType.equalsIgnoreCase("bigint") || StrType.equalsIgnoreCase("binary") || StrType.equalsIgnoreCase("bit") || StrType.equalsIgnoreCase("decimal") || StrType.equalsIgnoreCase("float") || StrType.equalsIgnoreCase("int") || StrType.equalsIgnoreCase("money") || StrType.equalsIgnoreCase("numeric") || StrType.equalsIgnoreCase("real") || StrType.equalsIgnoreCase("smallint") || StrType.equalsIgnoreCase("smallmoney") || StrType.equalsIgnoreCase("uniqueidentifier") || StrType.equalsIgnoreCase("varbinary")) {
                                    if (request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("")) {
                                        StrFields = StrFields + "=null";
                                    } else {
                                        StrFields = StrFields + "=" + request.getParameter(rsInfo.getString("NameF"));
                                    }
                                } else {
                                    if (request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si"))) {
                                        StrFields = StrFields + "=null";
                                    } else {
                                        StrFields = StrFields + "='" + request.getParameter(rsInfo.getString("NameF")) + "'";
                                    }
                                }
                            }
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                if (strBack.equalsIgnoreCase("")) {
                                    strBack = strBack + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                } else {
                                    strBack = strBack + "&" + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                }
                                if (StrWhere.equalsIgnoreCase("")) {
                                    StrWhere = StrWhere + "Where ";
                                } else {
                                    StrWhere = StrWhere + " and ";
                                }
                                StrWhere = StrWhere + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                            }
                        } else {
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si") && rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                                return;
                            }
                        }
                    }
                    //out.println(StrSentence + " " + StrFields + " " + StrWhere);
                    if (StrWhere.equalsIgnoreCase("")) {
                        out.println("La llave primaria no debe quedar en blanco, verifique con su administrador");
                        return;
                    }
                    StrSentence = StrSentence + " " + StrFields + " " + StrWhere;
                }

                if (Integer.parseInt(request.getParameter("Action")) == 3) {
                    StrSentence = "Delete from " + rs.getString("Tabla");
                    while (rsInfo.next()) {
                        if (request.getParameter(rsInfo.getString("NameF")) != null) {
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                if (strBack.equalsIgnoreCase("")) {
                                    strBack = strBack + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                } else {
                                    strBack = strBack + "&" + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                }

                                if (StrWhere.equalsIgnoreCase("")) {
                                    StrWhere = StrWhere + "Where ";
                                } else {
                                    StrWhere = StrWhere + " and ";
                                }
                                StrWhere = StrWhere + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                            }
                        } else {
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                            }
                        }
                    }
                    if (StrWhere.equalsIgnoreCase("")) {
                        out.println("La llave primaria no debe quedar en blanco, verifique con su administrador");
                        return;
                    }
                    StrSentence = StrSentence + " " + StrWhere;
                }

                if ((Integer.parseInt(request.getParameter("Action")) == 1)) {
                    try {
                        // inicio de ALTA    
                        String StrSql = "";
                        out.println("1");
                        if (Integer.parseInt(request.getParameter("GenConsec")) == 0) {
                            out.println("2");

                            int iLong = 0;
                            String StrNoPoliza = "";
                            StrNoPoliza = request.getParameter("NoPolizaVTR");
                            iLong = StrNoPoliza.length();
                            if (iLong == 0) {
                                out.println("Verifique su Número de Póliza");
                                return;
                            }
                            if (Integer.parseInt(request.getParameter("clAfianzadora")) == 3) {  // para FIANZAS COMERCIAL AMERICA
                                out.println(" -3> ");
//  out.println(request.getParameter("NoPoliza").length()); 

                                out.println(StrNoPoliza);

                                out.println("iLONG=" + iLong);
                                if (iLong >= 6) {
                                    out.println("4");

//                                       if (request.getParameter("NoPoliza").substring(iLong-5,iLong).equals("J#0005"))
                                    if (StrNoPoliza.substring(iLong - 5, iLong) != "J#0005") {
                                        out.println("igual");
                                        out.println("Verifique su Número de Póliza");
                                        return;
                                    } else {
                                        out.println("diferente");
                                    }
                                }
                                if (iLong < 6) {
                                    out.println("6");

                                    StrNoPoliza = StrNoPoliza + "J#0005";
                                }
                                out.println("-6>");
                                switch (StrNoPoliza.length()) {
                                    case (6):
                                        out.println("7");

                                        StrNoPoliza = "000000" + StrNoPoliza;
                                        break;
                                    case (7):
                                        out.println("8");

                                        StrNoPoliza = "00000" + StrNoPoliza;
                                        break;
                                    case (8):
                                        out.println("9");

                                        StrNoPoliza = "0000" + StrNoPoliza;
                                        break;
                                    case (9):
                                        StrNoPoliza = "000" + StrNoPoliza;
                                        break;
                                    case (10):
                                        StrNoPoliza = "00" + StrNoPoliza;
                                        break;
                                    case (11):
                                        StrNoPoliza = "0" + StrNoPoliza;
                                        break;
                                }
                            }   // fin FIANZAS COMERCIAL AMERICA

                            StrSentence = "Insert into " + rs.getString("Tabla");
                            out.println("10");
                            while (rsInfo.next()) {
                                out.println(" once ");

                                if (request.getParameter(rsInfo.getString("NameF")) != null) {
                                    // No es un campo identity, en un insert se debe omitir
                                    if (rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                        if (StrFields != "") {
                                            StrFields = StrFields + ",";
                                            StrVals = StrVals + ",";
                                        }
                                        StrFields = StrFields + rsInfo.getString("NameF");
                                        StrType = rsInfo.getString("TypeData").toString();
                                        if (StrType.equalsIgnoreCase("tinyint") || StrType.equalsIgnoreCase("bigint") || StrType.equalsIgnoreCase("binary") || StrType.equalsIgnoreCase("bit") || StrType.equalsIgnoreCase("decimal") || StrType.equalsIgnoreCase("float") || StrType.equalsIgnoreCase("int") || StrType.equalsIgnoreCase("money") || StrType.equalsIgnoreCase("numeric") || StrType.equalsIgnoreCase("real") || StrType.equalsIgnoreCase("smallint") || StrType.equalsIgnoreCase("smallmoney") || StrType.equalsIgnoreCase("uniqueidentifier") || StrType.equalsIgnoreCase("varbinary")) {
                                            if (request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("")) {
                                                StrVals = StrVals + "null";
                                            } else {
                                                StrVals = StrVals + request.getParameter(rsInfo.getString("NameF"));
                                            }
                                        } else {
                                            if (request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si"))) {
                                                StrVals = StrVals + "null";
                                            } else {
                                                StrVals = StrVals + "'" + request.getParameter(rsInfo.getString("NameF")) + "'";
                                            }
                                        }
                                        if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                            if (strBack.equalsIgnoreCase("")) {
                                                strBack = rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                            } else {
                                                strBack = strBack + "&" + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                            }
                                        }
                                    } else {
                                        strBack = rsInfo.getString("NameF");
                                        blnBackId = true;
                                    }
                                } else {
                                    if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si") && rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                        out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                                        return;
                                    }
                                }
                            }
                            out.println("NUMERO POLIZA=" + StrNoPoliza);


                            StrSentence = StrSentence + "(" + StrFields + ",NoPoliza) values (" + StrVals + ",'" + StrNoPoliza + "')";
                            out.println(StrSentence);
                            UtileriasBDF.ejecutaSQLNP(StrSentence);
                        } // fin Genera Consecutivos=0
                        else {    // inicio de ALTA de Consecutivos  
                            int iFolIni = 0;
                            int iFolFin = 0;
                            int iNoPoliza = 0;
                            int i = 0;
                            String StrNoPoliza = "";

                            iNoPoliza = Integer.parseInt(request.getParameter("NoPolFolIni"));
                            iFolIni = Integer.parseInt(request.getParameter("Folio"));
                            iFolFin = Integer.parseInt(request.getParameter("FolioFin"));

                            for (i = iFolIni; i <= iFolFin; i++) {
                                out.println("1");
                                if (Integer.parseInt(request.getParameter("clAfianzadora")) == 3) {  // para FIANZAS COMERCIAL AMERICA
                                    out.println("2");
                                    StrNoPoliza = request.getParameter("PrefijoPoliza") + iNoPoliza + "J#0005";

                                    switch (StrNoPoliza.length()) {
                                        case (6):
                                            StrNoPoliza = "000000" + StrNoPoliza;
                                            break;
                                        case (7):
                                            StrNoPoliza = "00000" + StrNoPoliza;
                                            break;
                                        case (8):
                                            StrNoPoliza = "0000" + StrNoPoliza;
                                            break;
                                        case (9):
                                            StrNoPoliza = "000" + StrNoPoliza;
                                            break;
                                        case (10):
                                            StrNoPoliza = "00" + StrNoPoliza;
                                            break;
                                        case (11):
                                            StrNoPoliza = "0" + StrNoPoliza;
                                            break;
                                    }
                                } // fin FIANZAS COMERCIAL AMERICA
                                else {
                                    out.println("3");
                                    StrNoPoliza = request.getParameter("PrefijoPoliza") + iNoPoliza;
                                }
                                // insertamos cada folio 

                                StrSentence = "Insert into " + rs.getString("Tabla");
                                rsInfo = UtileriasBDF.rsSQLNP("sp_GetInfoTabla " + rs.getString("Tabla"));
                                while (rsInfo.next()) {
                                    out.println("CAMPO::" + rsInfo.getString("NameF") + "   ");
                                    if (request.getParameter(rsInfo.getString("NameF")) != null) {
                                        // No es un campo identity, en un insert se debe omitir
                                        if (rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                            out.println("4  ");
                                            if (StrFields != "") {
                                                out.println("StrFields!= ");
                                                StrFields = StrFields + ",";
                                                StrVals = StrVals + ",";
                                            }
                                            StrFields = StrFields + rsInfo.getString("NameF");
                                            StrType = rsInfo.getString("TypeData").toString();
                                            if (StrType.equalsIgnoreCase("tinyint") || StrType.equalsIgnoreCase("bigint") || StrType.equalsIgnoreCase("binary") || StrType.equalsIgnoreCase("bit") || StrType.equalsIgnoreCase("decimal") || StrType.equalsIgnoreCase("float") || StrType.equalsIgnoreCase("int") || StrType.equalsIgnoreCase("money") || StrType.equalsIgnoreCase("numeric") || StrType.equalsIgnoreCase("real") || StrType.equalsIgnoreCase("smallint") || StrType.equalsIgnoreCase("smallmoney") || StrType.equalsIgnoreCase("uniqueidentifier") || StrType.equalsIgnoreCase("varbinary")) {
                                                if (request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("")) {
                                                    out.println("5 ");
                                                    StrVals = StrVals + "null";
                                                } else {
                                                    out.println("StrVals else :::" + rsInfo.getString("NameF"));
                                                    if ((rsInfo.getString("NameF")).toString().equalsIgnoreCase("Folio")) {
                                                        out.println("6 ");
                                                        StrVals = StrVals + "'" + request.getParameter("PrefijoFolio") + i + "'";
                                                    } else {
                                                        out.println("7 ");
                                                        StrVals = StrVals + request.getParameter(rsInfo.getString("NameF"));
                                                    }
                                                }
                                            } else {
                                                out.println("8 ");
                                                if (request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si"))) {
                                                    out.println("9  ");
                                                    StrVals = StrVals + "null";
                                                } else {
                                                    out.println("10 ");
                                                    if ((rsInfo.getString("NameF")).toString().equalsIgnoreCase("Folio")) {
                                                        out.println("11 ");
                                                        StrVals = StrVals + "'" + request.getParameter("PrefijoFolio") + i + "'";
                                                    } else {
                                                        out.println("12 ");
                                                        StrVals = StrVals + "'" + request.getParameter(rsInfo.getString("NameF")) + "'";
                                                    }
                                                }
                                            }
                                            out.println("I=" + i + " ");
                                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                                out.println("LLAVEPRIMARIA=" + i + " ");
                                                if (strBack.equalsIgnoreCase("")) {
                                                    if ((rsInfo.getString("NameF")).toString().equalsIgnoreCase("Folio")) //al insertar, el folio es un consecutivo entre folio inicial y el final
                                                    {
                                                        out.println("13 ");
                                                        strBack = rsInfo.getString("NameF") + "='" + request.getParameter("PrefijoFolio") + i + "'";
                                                    } else {
                                                        out.println("14 ");
                                                        strBack = rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                                    }
                                                } else {
                                                    out.println("15 ");
                                                    if ((rsInfo.getString("NameF")).toString().equalsIgnoreCase("Folio")) //al insertar, el folio es un consecutivo entre folio inicial y el final
                                                    {
                                                        out.println("16 ");
                                                        strBack = strBack + "&" + rsInfo.getString("NameF") + "='" + request.getParameter("PrefijoFolio") + i + "'";
                                                    } else {
                                                        out.println("17 ");
                                                        strBack = strBack + "&" + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                                    }
                                                }
                                            }
                                        } else {
                                            out.println("18 ");
                                            strBack = rsInfo.getString("NameF");
                                            blnBackId = true;
                                        }
                                    } else {
                                        if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si") && rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                            out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                                            return;
                                        }
                                    }
                                }
                                out.println("19 ");

                                StrSentence = StrSentence + "(" + StrFields + ",NoPoliza) values (" + StrVals + ",'" + StrNoPoliza + "')";
                                out.println(StrSentence);
                                UtileriasBDF.ejecutaSQLNP(StrSentence);
                                StrFields = "";
                                StrVals = "";
                                strBack = "";
                                StrSentence = "";
                                out.println("iii=" + i + " ");
                                iNoPoliza = iNoPoliza + 1;
                            } // fin de FOR
                        }   //fin de ALTA de Consecutivos  
                        // fin de try 
                    } catch (Exception e) {

                        e.printStackTrace();
                    }
                    // fin de ALTA   
                } else {
                    out.println("20 ");
                    // para UPDATE y DELETE
                    UtileriasBDF.ejecutaSQLNP(StrSentence);
                }
                String strUrlBack = "";
                if (request.getParameter("URLBACK") != null) {
                    strUrlBack = request.getParameter("URLBACK");
                    //out.println("<script> //'"+ strUrlBack + strBack +"'</script>");             
                    out.println("<script> window.opener.fnValidaResponse(1,'" + strUrlBack + strBack + "')</script>");
                }
                out.println("</body>");
                out.println("</html>");

            } else {
                out.println("Problemas al obtener información de la página solicitada");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    /*
     * Handles
     * the
     * HTTP
     * <code>GET</code>
     * method.
     *
     * @param
     * request
     * servlet
     * request
     * @param
     * response
     * servlet
     * response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /*
     * Handles
     * the
     * HTTP
     * <code>POST</code>
     * method.
     *
     * @param
     * request
     * servlet
     * request
     * @param
     * response
     * servlet
     * response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /*
     * Returns
     * a
     * short
     * description
     * of
     * the
     * servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
}
