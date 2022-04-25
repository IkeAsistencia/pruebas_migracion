<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF,java.sql.ResultSet"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;">
        <title>Duplica Asistencia</title>
    </head>
    <body>
        <%
                String StrclUsrApp = "";
                String StrclAsistencia = "";
                String StrclAsistenciaD = "0";
                String StrTabla = "";
                String StrPaginaWeb = "";
                String StrInsert = "";
                String StrSelect = "";

                if (session.getAttribute("clAsistencia") != null) {
                    StrclAsistencia = session.getAttribute("clAsistencia").toString();
                }

                if (session.getAttribute("clUsrApp") != null) {
                    StrclUsrApp = session.getAttribute("clUsrApp").toString();
                }

                ResultSet rsDuplica = null,
                        rsInfoTabla = null,
                        rsInfoColumnas = null,
                        rsInfoAsist = null;

                //<<<<<<<<<<<<<<<<<<<<<<< Duplicar la Asistencia >>>>>>>>>>>>>>>>>>>>>>>>

                rsDuplica = UtileriasBDF.rsSQLNP("st_CSDuplicaAsistencia '" + StrclAsistencia + "','" + StrclUsrApp + "'");

                if (rsDuplica.next()) {
                    StrclAsistenciaD = rsDuplica.getString("clAsistenciaD");
                }

                if (!StrclAsistenciaD.equalsIgnoreCase("0")) {
                    rsInfoTabla = UtileriasBDF.rsSQLNP("st_CSGetTablaAsist '" + StrclAsistencia + "'");

                    if (rsInfoTabla.next()) {
                        StrTabla = rsInfoTabla.getString("Tabla");
                        StrPaginaWeb = rsInfoTabla.getString("PaginaWeb");
                    }

                    rsInfoTabla.close();
                    rsInfoTabla = null;

                    rsInfoColumnas = UtileriasBDF.rsSQLNP("sp_GetInfoTabla '" + StrTabla + "'");

                    StrInsert = " Insert into " + StrTabla + " ( ";

                    while (rsInfoColumnas.next()) {
                        if (rsInfoColumnas.getString("Identit").equalsIgnoreCase("NO")) {
                            StrInsert = StrInsert + rsInfoColumnas.getString("NameF") + ",";

                            if (rsInfoColumnas.getString("NameF").equalsIgnoreCase("clAsistencia")) {
                                StrSelect = StrSelect + StrclAsistenciaD + ",";
                            } else {
                                StrSelect = StrSelect + rsInfoColumnas.getString("NameF") + ",";
                            }
                        }

                    }

                    StrInsert = StrInsert.substring(0, StrInsert.length() - 1);
                    StrSelect = StrSelect.substring(0, StrSelect.length() - 1);

                    StrInsert = StrInsert + " )";

                    rsInfoColumnas.close();
                    rsInfoColumnas = null;

                    rsInfoAsist = UtileriasBDF.rsSQLNP("st_CSInfoAsistencia '" + StrclAsistencia + "'");

                    if (rsInfoAsist.next()) {

                        StrInsert = StrInsert + "select " + StrSelect + " from " + rsInfoAsist.getString("Asistencia") + " ";
                    }
                    rsInfoAsist.close();
                    rsInfoAsist = null;

                    StrclAsistencia = null;

                    UtileriasBDF.ejecutaSQLNP(StrInsert);

                    StrclUsrApp = null;
                    StrclAsistencia = null;
                    StrTabla = null;
                    StrInsert = null;
                    StrSelect = null;
                } else {
        %>
        <script>alert('Ocurrio un error. Consulte a su administrador.');</script>
        <% }%>
        <script>
            top.opener.fnActualizaAsist('<%=StrclAsistenciaD%>','<%=StrPaginaWeb%>');
            window.close();
        </script>
    </body>
</html>
