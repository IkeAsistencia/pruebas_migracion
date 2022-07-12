package Utilerias;

import java.sql.ResultSet;
import java.sql.Connection;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.Map;

public class EjecutaAccionAsist extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void destroy() {
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        StringBuffer StrSentence = new StringBuffer();
        String strTablaBitacora = "";
        StringBuffer StrFields = new StringBuffer();
        StringBuffer StrVals = new StringBuffer();
        String StrType = "";
        StringBuffer StrWhere = new StringBuffer();
        String strBack = "";
        Connection con = null;

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

        if (sessionH.getAttribute("clPaginaWebP") == null) {
            out.println("No se definió variable de session para la página");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
        }

        con = UtileriasBDF.getConnection();
        ResultSet rs = null;
        ResultSet rsInfo = null;
        ResultSet rsExiste = null;
        ResultSet rsInsertada = null;
        ResultSet rsEnvMail = null;

        try {
            rs = UtileriasBDF.rsSQLNP("select Tabla , coalesce(TablaBitacora,'') TablaBitacora from cPaginaWeb where clPaginaWeb = " + sessionH.getAttribute("clPaginaWebP"));
            String strNameF = "";

            if (rs.next()) {
                strTablaBitacora = rs.getString("TablaBitacora");
                rsInfo = UtileriasBDF.rsSQLNP("sp_GetInfoTabla " + rs.getString("Tabla"));

                if (Integer.parseInt(request.getParameter("Action")) == 1) {

                    StrSentence.append(" Insert into ").append(rs.getString("Tabla"));
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
                                    StrVals.append("'").append(request.getParameter(strNameF).replaceAll("'", " ")).append("'");
                                }
                                if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                    if (strBack.equalsIgnoreCase("")) {
                                        strBack = strNameF + "=" + request.getParameter(strNameF);
                                    } else {
                                        strBack = strBack + "&" + strNameF + "=" + request.getParameter(strNameF);
                                    }
                                }
                            } else {
                                strBack = strNameF;
                            }
                        } else {
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si") && rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                                out.close();
                                return;
                            }
                        }
                    }
                    StrSentence.append("(").append(StrFields).append(") values (").append(StrVals).append(")");
                    System.out.println("StrSentence 1: " + StrSentence);
                }

                if (Integer.parseInt(request.getParameter("Action")) == 2) {
                    StrSentence.append("Update ").append(rs.getString("Tabla")).append(" set ");
                    System.out.println("Updating Table: " + rs.getString("Tabla") );
                    while (rsInfo.next()) {
                        System.out.println("EjecutaAccionAsist: Field" + rsInfo.getString("NameF") + "->" + rsInfo.getString("TypeData") );
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
                                    StrFields.append("='").append(request.getParameter(rsInfo.getString("NameF")).replaceAll("'", " ")).append("'");
                                }
                            }
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")) {
                                if (strBack.equalsIgnoreCase("")) {
                                    strBack = strBack + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                } else {
                                    strBack = strBack + "&" + rsInfo.getString("NameF") + "=" + request.getParameter(rsInfo.getString("NameF"));
                                }
                                if (StrWhere.toString().equalsIgnoreCase("")) {
                                    StrWhere.append(" Where ");
                                } else {
                                    StrWhere.append(" and ");
                                }
                                StrWhere.append(rsInfo.getString("NameF")).append("=").append(request.getParameter(rsInfo.getString("NameF")));
                            }
                        } else {
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si") && rsInfo.getString("Identit").equalsIgnoreCase("No")) {
                                out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                                out.close();
                                return;
                            }
                        }
                    }
                    if (StrWhere.toString().equalsIgnoreCase("")) {
                        out.println("La llave primaria no debe quedar en blanco, verifique con su administrador");
                        return;
                    }
                    StrSentence.append(" ").append(StrFields).append(" ").append(StrWhere);
                    System.out.println("StrSentence 2: " + StrSentence);
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
                                    StrWhere.append(" Where ");
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
                    System.out.println("StrSentence 3: " + StrSentence);
                }

                if (Integer.parseInt(request.getParameter("Action")) == 1) {
                    rsExiste = UtileriasBDF.rsSQLNP("st_TieneAsistenciaExp " + request.getParameter("clExpediente"));
                    if (rsExiste.next()) {
                        if (Integer.parseInt(rsExiste.getString("TieneAsistencia")) == 0) {
                            System.out.println("StrSentence Alta: " + StrSentence);
                            UtileriasBDF.ejecutaSQLNP(StrSentence.toString());
                            rsInsertada = UtileriasBDF.rsSQLNP("Select clExpediente From " + rs.getString("Tabla") + " Where clExpediente=" + request.getParameter("clExpediente"));
                            if (rsInsertada.next()) {
                                if (rsInsertada.getString("clExpediente").compareToIgnoreCase(request.getParameter("clExpediente").toString()) != 0) {
                                } else {
                                    UtileriasBDF.ejecutaSQLNP("Update Expediente Set FechaRegAsist = getdate() , FechaApAsist = '" + sessionH.getAttribute("FechaAp") + "', TieneAsistencia = 1, clServicio = " + sessionH.getAttribute("clServicio").toString() + ", clSubservicio = " + sessionH.getAttribute("clSubServicio").toString() + " Where clExpediente = " + request.getParameter("clExpediente"));
                                    System.out.println(" ********** ACTUALIZA TIENE ASISTENCIA DE 0 A 1 ********** ");
                                    System.out.println("Update Expediente Set FechaRegAsist = getdate() , FechaApAsist = '" + sessionH.getAttribute("FechaAp") + "', TieneAsistencia = 1, clServicio = " + sessionH.getAttribute("clServicio").toString() + ", clSubservicio = " + sessionH.getAttribute("clSubServicio").toString() + " Where clExpediente = " + request.getParameter("clExpediente"));
                                }
                                rsInsertada.close();
                            }
                            strBack = strBack + "=" + request.getParameter("clExpediente");
                            
                            String subServ = (request.getParameter("clSubservicio") == null) ? "" : request.getParameter("clSubservicio");
                            if(subServ.equals("494")){
                            System.out.println("clSubservicio  " +request.getParameter("clSubservicio")); //FUNCIONA
                            System.out.println("dsSubservicio  " +request.getParameter("dsSubservicio")); //FUNCIONA
                            System.out.println("subServicio  " +request.getParameter("subServicio"));    //FUNCIONA
                            System.out.println("Envío de Mail para ususarios de subservicio CRI  ");
                            rsEnvMail = UtileriasBDF.rsSQLNP("st_EnvioMailHDICRI " + request.getParameter("clExpediente"));
                            }
                            
                            
                        } else {
                            //Es alta pero ya tiene asistencia en expediente.
                            out.println("<script>alert('La asistencia no se puede guardar ya que está mal configurada, El último registro indica que el expediente tenía la asistencia: " + rsExiste.getString("dsSubServicio") + ", Por favor, consulte a sistemas.')</script>");
                            System.out.println("El expediente ya tenía una asistencia " + rsExiste.getString("dsSubServicio"));
                        }
                        rsExiste.close();
                    }
                } else {
                    UtileriasBDF.ejecutaSQLNP(StrSentence.toString());
                }

                if (strTablaBitacora.compareToIgnoreCase("") != 0) {
                    InsertaBitacora(con, request, strTablaBitacora);
                }

                procesarEventosQueYaNoSePuedeDesdeTrigger( request ) ;
                
                
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
        } finally {
            out.println("</body>");
            out.println("</html>");
            StrSentence.delete(0, StrSentence.length());
            strTablaBitacora = null;
            StrFields.delete(0, StrFields.length());
            StrVals.delete(0, StrVals.length());
            StrType = null;
            StrWhere.delete(0, StrWhere.length());
            strBack = null;

            try {
                if (rsExiste != null) {
                    rsExiste.close();
                    rsExiste = null;
                }

                if (rsInsertada != null) {
                    rsInsertada.close();
                    rsInsertada = null;
                }

                if (rsInfo != null) {
                    rsInfo.close();
                    rsInfo = null;
                }

                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (con != null) {
                    con.close();
                }

            } catch (Exception ee) {
                ee.printStackTrace();
            }
            out.close();
        }
    }

    private void InsertaBitacora(Connection con, HttpServletRequest request, String pstrTabla)
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
                            if (request.getParameter(strNameF).toString().equalsIgnoreCase("")) {
                                StrVals = StrVals + "null";
                            } else {
                                StrVals = StrVals + request.getParameter(strNameF);
                            }
                        } else {
                            if (request.getParameter(strNameF).toString().equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si"))) {
                                StrVals = StrVals + "null";
                            } else {
                                StrVals = StrVals + "'" + request.getParameter(strNameF).replaceAll("'", " ") + "'";
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
            StrSentence = StrSentence + "(" + StrFields + ") values (" + StrVals + ")";
            UtileriasBDF.ejecutaSQLNP(StrSentence);

        } catch (Exception e) {
            e.printStackTrace();
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

    public String getServletInfo() {
        return "Short description";
    }
    
    private void procesarEventosQueYaNoSePuedeDesdeTrigger( HttpServletRequest req ) {
        try {
            //Si es una asistencia Hogar, actualizar el  CoeEnt y CodMD en Expediente
            if ( req != null && req.getParameter("URLBACK") != null  && req.getParameter("URLBACK").indexOf("DetalleAHogar")>-1 ) {
                UtileriasBDF.ejecutaSQLNP( "st_UpdProvinciLocalidadFromExpediente " + req.getParameter("clExpediente") + ", '" + req.getParameter("CodEnt")  + "', '" + req.getParameter("CodMD")  + "'" );
            }
         }
        catch (Exception e ){ 
            System.out.println("EjecutaAccionAsist.Error:" + e.toString() );
        }
    }
    
}