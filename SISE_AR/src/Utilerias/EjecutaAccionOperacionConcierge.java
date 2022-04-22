/*
 * EjecutaAccion.java
 *
 * Created on 3 de diciembre de 2004, 04:27 PM
 */
package Utilerias;

import com.ike.view.ViewHelperBase;
import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.Hashtable;

/*
 *
 * @author  rfernandez
 * @version
 */
public class EjecutaAccionOperacionConcierge extends HttpServlet {

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
        StringBuffer StrSentence = new StringBuffer();
//        StringBuffer StrSQLBitacora = new StringBuffer();
        String strTablaBitacora = "";
        StringBuffer StrFields = new StringBuffer();
        StringBuffer StrVals = new StringBuffer();
        String StrType = "";
        StringBuffer StrWhere = new StringBuffer();
        String strBack = "";
        String strLlave = "";
        String strNamIdentity = "";


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
            out.close();
            return;
        }

        if (sessionH.getAttribute("clPaginaWebC") == null) {
            out.println("No se definió variable de session para la página");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }

        ResultSet rs = null;
        ResultSet rsInfo = null;
        ResultSet rsLlave = null;

        try {
            System.out.println("Pagina: " + sessionH.getAttribute("clPaginaWebC"));
            rs = UtileriasBDF.rsSQLNP("select Tabla, coalesce(TablaBitacora,'') TablaBitacora from cPaginaWeb where clPaginaWeb = " + sessionH.getAttribute("clPaginaWebC"));
            String strNameF = "";

            if (rs.next()) {

                strTablaBitacora = rs.getString("TablaBitacora");
                rsInfo = UtileriasBDF.rsSQLNP("sp_GetInfoTabla " + rs.getString("Tabla"));

                // rsInfo = UtileriasBDF.rsSQLNP( "sp_GetInfoTabla 'mitabla'" );

                if (Integer.parseInt(request.getParameter("Action")) == 1) {

//                    StrSQLBitacora.append("Insert into ").append(rs.getString("TablaBitacora")).append(" (clExpediente, FechaBitacora, clUsrApp, Bitacora) values (").append(sessionH);

                    StrSentence.append("Insert into ").append(rs.getString("Tabla"));

                    while (rsInfo.next()) {
                        strNameF = rsInfo.getString("NameF");
                        if (request.getParameter(strNameF) != null) {
                            // No es un campo identity, en un insert se debe omitir
                            if (rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                if (StrFields.toString().compareToIgnoreCase("") != 0) {
                                    StrFields.append(",");
                                    StrVals.append(",");
                                }
                                StrFields.append(strNameF);

                                StrType = rsInfo.getString("TypeData").toString();
                                if (StrType.equalsIgnoreCase("tinyint") || StrType.equalsIgnoreCase("bigint") || StrType.equalsIgnoreCase("binary") || StrType.equalsIgnoreCase("bit") || StrType.equalsIgnoreCase("decimal") || StrType.equalsIgnoreCase("float") || StrType.equalsIgnoreCase("int") || StrType.equalsIgnoreCase("money") || StrType.equalsIgnoreCase("numeric") || StrType.equalsIgnoreCase("real") || StrType.equalsIgnoreCase("smallint") || StrType.equalsIgnoreCase("smallmoney") || StrType.equalsIgnoreCase("uniqueidentifier") || StrType.equalsIgnoreCase("varbinary")) {
                                    if (request.getParameter(strNameF).toString().equalsIgnoreCase("")) {
                                        StrVals.append("null");
                                    } else {
                                        StrVals.append(request.getParameter(strNameF));
                                    }
                                } else {
                                    if (request.getParameter(strNameF).toString().equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si"))) {
                                        StrVals.append("null");
                                    } else {
                                        StrVals.append("'").append(request.getParameter(strNameF).replaceAll("'", " ")).append("'");
                                    }
                                }
                                if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                    if (strBack.equalsIgnoreCase("")) {
                                        strBack = strNameF + "=" + request.getParameter(strNameF);
                                    } else {
                                        strBack = strBack + "&" + strNameF + "=" + request.getParameter(strNameF);
                                    }

                                //Llave Bitacora
                                  /*  strKeyName=strNameF;
                                strKeyValue=request.getParameter(strNameF);*/

                                }
                            } else {
                                strBack = strNameF;
                                strNamIdentity = strNameF;
                                blnBackId = true;
                            }
                        } else {
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si") && rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                                out.close();
                                strNameF = null;
                                return;
                            }
                        }
                    }
                    StrSentence.append("(").append(StrFields).append(") values (").append(StrVals).append(")");
                }

                if (Integer.parseInt(request.getParameter("Action")) == 2) {
                    StrSentence.append("Update ").append(rs.getString("Tabla")).append(" set ");
                    while (rsInfo.next()) {
                        if (request.getParameter(rsInfo.getString("NameF")) != null) {
                            // No es un campo identity, en un insert se debe omitir
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("No") && rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                if (StrFields.toString().compareToIgnoreCase("") != 0) {
                                    StrFields.append(",");
                                }
                                StrFields.append(rsInfo.getString("NameF"));
                                StrType = rsInfo.getString("TypeData").toString();
                                if (StrType.equalsIgnoreCase("tinyint") || StrType.equalsIgnoreCase("bigint") || StrType.equalsIgnoreCase("binary") || StrType.equalsIgnoreCase("bit") || StrType.equalsIgnoreCase("decimal") || StrType.equalsIgnoreCase("float") || StrType.equalsIgnoreCase("int") || StrType.equalsIgnoreCase("money") || StrType.equalsIgnoreCase("numeric") || StrType.equalsIgnoreCase("real") || StrType.equalsIgnoreCase("smallint") || StrType.equalsIgnoreCase("smallmoney") || StrType.equalsIgnoreCase("uniqueidentifier") || StrType.equalsIgnoreCase("varbinary")) {
                                    if (request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("")) {
                                        StrFields.append("=null");
                                    } else {
                                        StrFields.append("=").append(request.getParameter(rsInfo.getString("NameF")));
                                    }
                                } else {
                                    if (request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si"))) {
                                        StrFields.append("=null");
                                    } else {
                                        StrFields.append("='").append(request.getParameter(rsInfo.getString("NameF")).replaceAll("'", " ")).append("'");
                                    }
                                }
                            }
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                if (strBack.equalsIgnoreCase("")) {
                                    strBack = strBack + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                } else {
                                    strBack = strBack + "&" + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                }

                                //Llave Bitacora
                                /*strKeyName=rsInfo.getString("NameF");
                                strKeyValue=request.getParameter(rsInfo.getString("NameF"));*/

                                if (StrWhere.toString().equalsIgnoreCase("")) {
                                    StrWhere.append("Where ");
                                } else {
                                    StrWhere.append(" and ");
                                }
                                StrWhere.append(rsInfo.getString("NameF")).append("=").append(request.getParameter(rsInfo.getString("NameF")));
                            }
                        } else {
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si") && rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                                out.close();
                                strNameF = null;
                                return;
                            }
                        }
                    }
                    if (StrWhere.toString().equalsIgnoreCase("")) {
                        out.println("La llave primaria no debe quedar en blanco, verifique con su administrador");
                        out.close();
                        strNameF = null;
                        return;
                    }
                    StrSentence.append(" ").append(StrFields).append(" ").append(StrWhere);
                }

                if (Integer.parseInt(request.getParameter("Action")) == 3) {
                    StrSentence.append("Delete from ").append(rs.getString("Tabla"));
                    while (rsInfo.next()) {
                        if (request.getParameter(rsInfo.getString("NameF")) != null) {
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                if (strBack.equalsIgnoreCase("")) {
                                    strBack = strBack + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                } else {
                                    strBack = strBack + "&" + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                }

                                if (StrWhere.toString().equalsIgnoreCase("")) {
                                    StrWhere.append("Where ");
                                } else {
                                    StrWhere.append(" and ");
                                }
                                StrWhere.append(rsInfo.getString("NameF")).append("=").append(request.getParameter(rsInfo.getString("NameF")));
                            }
                        } else {
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                            }
                        }
                    }
                    if (StrWhere.toString().equalsIgnoreCase("")) {
                        out.println("La llave primaria no debe quedar en blanco, verifique con su administrador");
                        out.close();
                        return;
                    }
                    StrSentence.append(" ").append(StrWhere);
                }
                if ((Integer.parseInt(request.getParameter("Action")) == 1) && (blnBackId == true)) {
                    //System.out.println(StrSentence);
                    rsLlave = UtileriasBDF.rsSQLNP(StrSentence.append(" Select @@Identity Llave ").toString());
                    if (rsLlave.next()) {
                        strLlave = rsLlave.getString("Llave");
                        if (rs.getString("Tabla").equalsIgnoreCase("Expediente")) {
                            UtileriasBDF.ejecutaSQLNP("Update Expediente set clExpedienteOrigen=" + strLlave + " where clExpediente=" + strLlave);
                        }
                        strBack = strBack + "=" + strLlave;
                    }
                } else {
                    UtileriasBDF.ejecutaSQLNP(StrSentence.toString());
                }

                if (strTablaBitacora.compareToIgnoreCase("") != 0) {
//                  //// **************BITACORA *************////
                    System.out.println("entra al servlet EjecutaAccion/Bitacora");
                    System.out.println("val strBack:" + strBack);

                    String bitclUsrApp = "0";
                    String datasent = "";
                    String keys = "";
                    Hashtable ht = null;
                    String strKeyName = "";
                    String strKeyValue = "";


                    keys = strBack; //obtengo del urlback la llave y su valor correspondiente

                    if (strBack.startsWith("&")) {
                        keys = strBack.substring(1);
                    }

                    strKeyName = strBack.substring(0, keys.indexOf("="));
                    strKeyValue = strBack.substring(keys.indexOf("=") + 1);

                    if (sessionH.getAttribute("clUsrApp") != null) {
                        bitclUsrApp = sessionH.getAttribute("clUsrApp").toString();
                    }

                    try {
                        System.out.println("RES ---: " + strKeyName + "," + strKeyValue);

                        ht = ViewHelperBase.getUserData(request);

                        ht.put("llave", strKeyName.toString());
                        ht.put("llaveVal", strKeyValue.toString());
                        ht.put("clUsrApp", bitclUsrApp);

                        try {
                            // si es alta de Expediente utilizo el clExpediente del UrlBack
                            /*if ((sessionH.getAttribute("clPaginaWebP").toString().equalsIgnoreCase("155"))&&(Integer.parseInt(request.getParameter("Action"))==1)){
                            ht.put("clExpediente",strBack.substring(strBack.length()-7));
                            }*/

                            ViewHelperBase.bitacoraHt(ht);
                        //datasent= ViewHelperBase.hash2String(ht);
                        //System.out.println("Data: " + datasent);

                        } catch (Exception par) {
                            System.out.println("trono alta expediente");
                            par.printStackTrace();
                        }

                    } catch (Exception bit) {
                        System.out.println("Error EjecutaAccion.java: Bitacora");
                        bit.printStackTrace();
                    } finally {
                        datasent = null;
                        ht = null;

                        strKeyName = null;
                        strKeyValue = null;
                    }
                    bitclUsrApp = null;
                ////*************
                }




                String strUrlBack = "";
                if (request.getParameter("URLBACK") != null) {
                    strUrlBack = request.getParameter("URLBACK");
                    //out.println("<script> //'"+ strUrlBack + strBack +"'</script>");
                    out.println("<script> window.opener.fnValidaResponse(1,'" + strUrlBack + strBack + "')</script>");
                }

            } else {
                out.println("Problemas al obtener información de la página solicitada");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script> window.opener.fnValidaResponse(-1,'')</script>");
            out.println("Problema al registrar el movimiento (verifique formato de fechas y campos numéricos sin separador de coma)");
        } finally {
            out.println("</body>");
            out.println("</html>");

            StrSentence.delete(0, StrSentence.length());
            StrFields.delete(0, StrFields.length());
            StrVals.delete(0, StrVals.length());
            StrWhere.delete(0, StrWhere.length());

            StrSentence = null;
            StrFields = null;
            StrVals = null;
            StrWhere = null;

            StrType = null;
            strTablaBitacora = null;
            strBack = null;
            strLlave = null;
            strNamIdentity = null;

            try {
                if (rsInfo != null) {
                    rsInfo.close();
                    rsInfo = null;
                }
                if (rsLlave != null) {
                    rsLlave.close();
                    rsLlave = null;
                }
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
            out.close();
        }
    }

    private void InsertaBitacora(HttpServletRequest request, String pstrTabla, String pstrValIdentity, String pStrNamIdentity)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        String StrSentence = "";
        String StrFields = "";
        String StrVals = "";
        String StrType = "";
        String strNameF = "";

        if (request.getParameter("Bitacora") != null) {
            if (request.getParameter("Bitacora").toString().compareToIgnoreCase("") == 0) {
                return;
            }
        }
        try {
            ResultSet rsInfo = UtileriasBDF.rsSQLNP("sp_GetInfoTabla " + pstrTabla);

            StrSentence = "Insert into " + pstrTabla;

            while (rsInfo.next()) {
                strNameF = rsInfo.getString("NameF");

                if (request.getParameter(strNameF) != null) {
                    // No es un campo identity, en un insert se debe omitir
                    if (rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                        if (StrFields != "") {
                            StrFields = StrFields + ",";
                            StrVals = StrVals + ",";
                        }
                        StrFields = StrFields + strNameF;
                        StrType = rsInfo.getString("TypeData").toString();
                        if (StrType.equalsIgnoreCase("tinyint") || StrType.equalsIgnoreCase("bigint") || StrType.equalsIgnoreCase("binary") || StrType.equalsIgnoreCase("bit") || StrType.equalsIgnoreCase("decimal") || StrType.equalsIgnoreCase("float") || StrType.equalsIgnoreCase("int") || StrType.equalsIgnoreCase("money") || StrType.equalsIgnoreCase("numeric") || StrType.equalsIgnoreCase("real") || StrType.equalsIgnoreCase("smallint") || StrType.equalsIgnoreCase("smallmoney") || StrType.equalsIgnoreCase("uniqueidentifier") || StrType.equalsIgnoreCase("varbinary")) {
                            if ((Integer.parseInt(request.getParameter("Action")) == 1) && (pStrNamIdentity.compareToIgnoreCase(strNameF) == 0)) {
                                if (pstrValIdentity.equalsIgnoreCase("")) {
                                    StrVals = StrVals + "null";
                                } else {
                                    StrVals = StrVals + pstrValIdentity;
                                }
                            } else {
                                if (request.getParameter(strNameF).toString().equalsIgnoreCase("")) {
                                    StrVals = StrVals + "null";
                                } else {
                                    StrVals = StrVals + request.getParameter(strNameF);
                                }
                            }
                        } else {
                            if ((Integer.parseInt(request.getParameter("Action")) == 1) && (pStrNamIdentity.compareToIgnoreCase(strNameF) == 0)) {
                                if (pstrValIdentity.equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si"))) {
                                    StrVals = StrVals + "null";
                                } else {
                                    StrVals = StrVals + "'" + pstrValIdentity.replaceAll("'", " ") + "'";
                                }
                            } else {
                                if (request.getParameter(strNameF).toString().equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si"))) {
                                    StrVals = StrVals + "null";
                                } else {
                                    StrVals = StrVals + "'" + request.getParameter(strNameF).replaceAll("'", " ") + "'";
                                }
                            }
                        }
                    }
                } else {
                    if (sessionH.getAttribute(rsInfo.getString("NameF")) != null) {
                        // No es un campo identity, en un insert se debe omitir
                        if (rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                            if (StrFields != "") {
                                StrFields = StrFields + ",";
                                StrVals = StrVals + ",";
                            }
                            StrFields = StrFields + rsInfo.getString("NameF");
                            StrType = rsInfo.getString("TypeData").toString();
                            if (StrType.equalsIgnoreCase("tinyint") || StrType.equalsIgnoreCase("bigint") || StrType.equalsIgnoreCase("binary") || StrType.equalsIgnoreCase("bit") || StrType.equalsIgnoreCase("decimal") || StrType.equalsIgnoreCase("float") || StrType.equalsIgnoreCase("int") || StrType.equalsIgnoreCase("money") || StrType.equalsIgnoreCase("numeric") || StrType.equalsIgnoreCase("real") || StrType.equalsIgnoreCase("smallint") || StrType.equalsIgnoreCase("smallmoney") || StrType.equalsIgnoreCase("uniqueidentifier") || StrType.equalsIgnoreCase("varbinary")) {
                                if (sessionH.getAttribute(rsInfo.getString("NameF")).toString().equalsIgnoreCase("")) {
                                    StrVals = StrVals + "null";
                                } else {
                                    StrVals = StrVals + sessionH.getAttribute(rsInfo.getString("NameF"));
                                }
                            } else {
                                if (sessionH.getAttribute(rsInfo.getString("NameF")).toString().equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si"))) {
                                    StrVals = StrVals + "null";
                                } else {
                                    StrVals = StrVals + "'" + sessionH.getAttribute(rsInfo.getString("NameF")) + "'";
                                }
                            }
                        }
                    }
                }
            }
            rsInfo.close();
            rsInfo = null;
            StrSentence = StrSentence + "(" + StrFields + ") values (" + StrVals + ")";
            UtileriasBDF.ejecutaSQLNP(StrSentence);
            StrSentence = null;
            StrFields = null;
            StrVals = null;
            StrType = null;
            strNameF = null;
        } catch (Exception e) {
            e.printStackTrace();
        }


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
