<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Centro de Comando</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .TextUsConcierge{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 20px; color: #FF0022; text-transform: uppercase; text-align:center;}
        </style>
    </head>
    <body class="cssBody">
        <div style='position:absolute; z-index:50; left:0px; top:0px;'><img src="../../Imagenes/EncabezadoLogoIke.jpg"></div>

        <%
            StringBuffer StrSql = new StringBuffer();
            String pTipoInfo = "1";

            if (request.getParameter("Tipo") != null) {
                if (request.getParameter("Tipo").compareToIgnoreCase("") != 0) {
                    pTipoInfo = request.getParameter("Tipo");
                }
            }

            StringBuffer strSalida = new StringBuffer();

            //<<<<<<<<<<<<<<<<<< Citas >>>>>>>>>>>>>>>>>>>
            if (pTipoInfo.equalsIgnoreCase("1")) {
        %>

        <div style='position:absolute; z-index:51; left:200px; top:0px;'>
            <table width="800">
                <tr valign="center">
                    <td height="70" align="center" class="cssTituloPlasma" id="LabelMon">Citas</td>
                </tr>
            </table>
        </div>

        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:93%;'>
            <table><tr><td><input class='cBtnPlasma' value='Cerrar...' onClick='top.window.close()' type='button'>
                    </td><td>
                        <TABLE cellspacing=5 cellpadding=0 ><tr>
                                <td class="R2TablePlasma">Tiempos del Evento: </td>
                                <td>60 mins antes</td><td width=30 class="cssPlasmaVerde"></td>
                                <td>59 mins hasta la hora</td><td width=30 class="cssPlasmaAmarillo"></td>
                                <td>De la hora en adelante</td><td width=30 class="cssPlasmaRojo"></td>
                            </tr>
                        </table>
                    </td><td>
            </table></div>
            <%
                StrSql.append("st_PlasmaConcierge " + pTipoInfo);
            %>
            <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 20, "Sin Asignación de Proveedor", strSalida);%>
            <%=strSalida.toString()%>
            <%
                    strSalida.delete(0, strSalida.length());
                    pTipoInfo = "1";
                }

            %>

        <%           //<<<<<<<<<<<<<<<<<< Monitoreo >>>>>>>>>>>>>>>>>>>
            if (pTipoInfo.equalsIgnoreCase("2")) {
        %>

        <div style='position:absolute; z-index:51; left:200px; top:0px;'>
            <table width="800">
                <tr valign="center">
                    <td height="70" align="center" class="cssTituloPlasma" id="LabelMon">Monitoreo</td>
                </tr>
            </table>
        </div>

        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:93%;'>
            <table><tr><td><input class='cBtnPlasma' value='Cerrar...' onClick='top.window.close()' type='button'>
                    </td><td>
                        <TABLE cellspacing=5 cellpadding=0 ><tr>
                                <td class="R2TablePlasma">tiempo sin monitoreo: </td>
                                <td>De 1 hasta 3 horas</td><td width=30 class="cssPlasmaAmarillo"></td>
                                <td>Mas de 3 horas</td><td width=30 class="cssPlasmaRojo"></td>
                            </tr>
                        </table>
                    </td><td>
            </table></div>
            <%
                StrSql.append("st_PlasmaConcierge " + pTipoInfo);
            %>
            <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 20, "Sin Asignación de Proveedor", strSalida);%>
            <%=strSalida.toString()%>
            <%
                    strSalida.delete(0, strSalida.length());
                    pTipoInfo = "1";
                }

            %>

        <%              //<<<<<<<<<<<<<<<<<< Monitoreo >>>>>>>>>>>>>>>>>>>
            if (pTipoInfo.equalsIgnoreCase("3")) {
        %>

        <div style='position:absolute; z-index:51; left:200px; top:0px;'>
            <table width="800">
                <tr valign="center">
                    <td height="70" align="center" class="cssTituloPlasma" id="LabelMon">Tiempo de Contacto</td>
                </tr>
            </table>
        </div>

        <%
            StrSql.append("st_PlasmaConcierge " + pTipoInfo);
        %>
        <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(), 20, "Sin Asignación de Proveedor", strSalida);%>
        <%=strSalida.toString()%>
        <%
                strSalida.delete(0, strSalida.length());
                pTipoInfo = "1";
            }

        %>
    </body>
</html>

