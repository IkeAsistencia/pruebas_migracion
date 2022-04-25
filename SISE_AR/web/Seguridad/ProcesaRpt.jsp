<%@page contentType="text/html" import="Utilerias.UtileriasBDF,java.sql.ResultSet,Utilerias.UtlFiles,Utilerias.Correo,Utilerias.Zip"%>
<%@page pageEncoding="ISO-8859-1"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Procesando...</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" >
        
        <%
        String StrclMailRpt = request.getParameter("clMailRpt") != null ? request.getParameter("clMailRpt").toString() : "0";

        %>
        <center>
            <!--table border="0">
                <tr>
                    <td>
                        <p class='cssTitDet'> Reporte: <=StrclMailRpt%></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="../Imagenes/procesa.gif">
                    </td>
                </tr>
            </table-->

            <%

        boolean isStarted = false;
        ResultSet rs = null;
        Utilerias.UtlFiles UtlFilesObj = new Utilerias.UtlFiles();
        Correo MailRpt = new Correo();
        Utilerias.Zip ZipObj = new Utilerias.Zip();

        System.out.println("<<<<<<<<<<<<<<<< Procesando Reporte " + StrclMailRpt + " >>>>>>>>>>>>>>>");
        StringBuffer StrSQL = new StringBuffer();
        String StrPath = "";
        StringBuffer StrContent = new StringBuffer();
        String strclMail = "";
        String strMail = "";

        try {
            StrSQL.append("sp_GetHostMail ");
            rs = UtileriasBDF.rsSQLNP(StrSQL.toString());
            //String strHost="172.21.16.18";
            String strHost = "172.21.16.18";
            if (rs.next()) {
                strHost = rs.getString("host");
            }
            rs.close();
            rs = null;
            StrSQL.delete(0, StrSQL.length());

            StrSQL.append(" Select top 1 HDM.clMailRpt, HDM.SentenciaSQL, U.Correo ");
            StrSQL.append(" from HDMailRptMonitor HDM ");
            StrSQL.append(" inner join cUsrApp U on (HDM.clUsrApp = U.clUsrApp) ");
            StrSQL.append(" where U.Correo is not null and HDM.FechaInicio is null and HDM.clMailRpt = " + StrclMailRpt);
            rs = UtileriasBDF.rsSQLNP(StrSQL.toString());
            StrSQL.delete(0, StrSQL.length());

            StrContent.delete(0, StrContent.length());
            if (rs.next()) {
                strclMail = rs.getString("clMailRpt");

                //StrPath = UtlFilesObj.creaPath("/File" + strclMail);
                StrPath = "File" + strclMail;
                System.out.println(StrPath);

                UtileriasBDF.actSQLNP("set dateformat mdy update HDMailRptMonitor set FechaInicio = getdate() where clMailRpt = " + strclMail);
                StringBuffer strSalida = new StringBuffer();
                UtileriasBDF.rsCSVCNP(rs.getString("SentenciaSQL"), strSalida);
                StrContent.append(strSalida);
                strSalida.delete(0, strSalida.length());
                UtileriasBDF.actSQLNP("set dateformat mdy update HDMailRptMonitor set FechaFin = getdate() where clMailRpt = " + strclMail);
                UtlFilesObj.escribeContenido(StrPath + ".csv", StrContent.toString());
                ZipObj.ZipFile(StrPath, ".csv");
                StrContent.delete(0, StrContent.length());
                MailRpt.EnviaMail("rptservices", rs.getString("Correo"), "Reporte", StrPath + ".zip", strHost);
                UtileriasBDF.actSQLNP("set dateformat mdy update HDMailRptMonitor set FechaEnvio = getdate() where clMailRpt = " + strclMail);
                UtlFilesObj.borraArchivo(StrPath + ".csv");
                UtlFilesObj.borraArchivo(StrPath + ".zip");
            }
            rs.close();
            rs = null;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ee) {
            }
        }

        StrPath = null;
        strclMail = null;
        strMail = null;
            %>

        </center>

        <script>
            alert('Reporte Enviado.');
            top.opener.location.reload();
            window.close();
        </script>
    </body>
</html>
