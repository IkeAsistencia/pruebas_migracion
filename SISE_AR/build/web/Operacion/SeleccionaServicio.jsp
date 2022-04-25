<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Selecciona Servicio</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnValidaStatus();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <%
            String StrclExpediente = "0";
            String StrclServicio = "0";
            String StrclSubServicio = "0";
            String StrdsServicio = "";
            String StrdsSubServicio = "";
            String strclUsr = "0";
            String strclEstatus = "0";
            String strTieneAsist = "0";
            String strclAreaOperativa = "0";
            String StrclPaginaWeb = "252";

            StringBuffer StrSql = new StringBuffer();

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (session.getAttribute("clEstatus") != null) {
                strclEstatus = session.getAttribute("clEstatus").toString();
            }

            if (session.getAttribute("TieneAsist") != null) {
                strTieneAsist = session.getAttribute("TieneAsist").toString();
            }
        %>      
        <INPUT id='banderaStatus' name='banderaStatus' type='hidden' value='<%=strclEstatus%>'> 
        <INPUT id='TieneAsist' name='TieneAsist' type='hidden' value='<%=strTieneAsist%>'>
        <%
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        <%
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(strclUsr));

            StrSql.append("st_getServicioExpediente '").append(StrclExpediente).append("'");

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                if (rs.getString("clSubServicio") != null) {
                    StrclSubServicio = rs.getString("clSubServicio");
                    if (StrclSubServicio.compareToIgnoreCase("") == 0) {
                        StrclSubServicio = "0";
                    }
                    session.setAttribute("clSubServicio", StrclSubServicio);
                }
                if (rs.getString("clServicio") != null) {
                    StrclServicio = rs.getString("clServicio");
                    if (StrclServicio.compareToIgnoreCase("") == 0) {
                        StrclServicio = "0";
                    }
                    session.setAttribute("clServicio", StrclServicio);
                }
                if (rs.getString("dsSubServicio") != null) {
                    StrdsSubServicio = rs.getString("dsSubServicio");
                    if (StrdsSubServicio.compareToIgnoreCase("") == 0) {
                        StrdsSubServicio = "0";
                    }
                    session.setAttribute("dsSubServicio", StrdsSubServicio);
                }
                if (rs.getString("dsServicio") != null) {
                    StrdsServicio = rs.getString("dsServicio");
                    if (StrdsServicio.compareToIgnoreCase("") == 0) {
                        StrdsServicio = "0";
                    }
                    session.setAttribute("dsServicio", StrdsSubServicio);
                }

                if (rs.getString("clAreaOperativa") != null) {
                    strclAreaOperativa = rs.getString("clAreaOperativa");
                    if (strclAreaOperativa.compareToIgnoreCase("") == 0) {
                        strclAreaOperativa = "0";
                    }
                    session.setAttribute("strclAreaOperativa", strclAreaOperativa);
                }%>
        <script>location.href = '../<%=rs.getString("NombrePaginaWeb")%>clExpediente=<%=StrclExpediente%>';</script>
        <% } else { %>
    <center>
        <p style="font-family: Verdana, Arial, Helvetica, sans-serif; color: white; background-color: #1220CD; font-size: 18px;">�rea Operativa</p>
        <div style="text-align:center;">
            <table style="alignment-adjust: center">
                <tr style="alignment-adjust: central">
                    <td ALIGN="CENTER">
                        <img src="../Imagenes/ServKM.gif" class="handM" alt='Servicios de Asistencia Vial'>
                    </td>
                    <td ALIGN="CENTER">
                        <img src="../Imagenes/ServHogar.gif" class="handM" alt='Servicios de Hogar'>
                    </td>
                    <td ALIGN="CENTER">
                        <img src="../Imagenes/ServMedico.gif" class="handM" alt='Servicios M�dicos'>
                    </td>
                    <td ALIGN="CENTER">
                        <img src="../Imagenes/ServViajes.gif" class="handM" alt='Servicios de Viajes'>
                    </td>
                    <td ALIGN="CENTER">
                        <img src="../Imagenes/ServLegal.gif" class="handM" alt='Servicios de Legal'>
                    </td>
                    <td ALIGN="CENTER">
                        <img align="" src="../Imagenes/especiali.gif" class="handM" alt='Servicios Especializados'>
                    </td>
                    <td ALIGN="CENTER">
                        <img align="" src="../Imagenes/warning.png" class="handM" alt='Siniestros'>
                    </td>
                    <td ALIGN="CENTER">
                        <img align="" src="../Imagenes/ServTecnologica.gif" class="handM" alt='Servicios de Tecnol�gia'>
                    </td>
                    <td ALIGN="CENTER">
                        <img align="" src="../Imagenes/Mascota.gif" class="handM" alt='Servicios de Mascota'>
                    </td>
                    <td ALIGN="CENTER">
                        <img src="../Imagenes/Limpieza.png" class="handM" alt='Servicios de Limpieza'>
                    </td>
                </tr>
                <tr>
                    <td ALIGN="CENTER">
                        <input type="button" class="BgT" onclick="fnSend(1)" value='Vial'>
                    </td>
                    <td ALIGN="CENTER">
                        <input type="button" class="BgT" onclick="fnSend(4)" value='Hogar'>
                    </td>
                    <td ALIGN="CENTER">
                        <input type="button" class="BgT" onclick="fnSend(5)" value='M�dico'>
                    </td>
                    <td ALIGN="CENTER">
                        <input type="button" class="BgT" onclick="fnSend(3)" value='Viajes'>
                    </td>
                    <td ALIGN="CENTER">
                        <input type="button" class="BgT" onclick="fnSend(2)" value='legal'>
                    </td>
                    <td ALIGN="CENTER">
                        <input type="button" class="BgT" onclick="fnSend(6)" value='Especializados'>
                    </td>
                    <td ALIGN="CENTER">
                        <input type="button" class="BgT" onclick="fnSend(12)" value='Siniestros'>
                    </td>
                    <td ALIGN="CENTER">
                        <input type="button" class="BgT" onclick="fnSend(13)" value='Tecnol�gica'>
                    </td>
                    <td ALIGN="CENTER">
                        <input type="button" class="BgT" onclick="fnSend(11)" value='Mascota'>
                    </td>
                    <td ALIGN="CENTER">
                        <input type="button" class="BgT" onclick="fnSend(4)" value='Limpieza'>
                    </td>
                </tr>
            </table>
        </div>
    </center>
    <%        }
        rs.close();
        rs = null;
    %>
    <script>
        function fnValidaStatus() {
            if ((document.all.TieneAsist.value.toString() == "0") && ((document.all.banderaStatus.value == "30") || (document.all.banderaStatus.value == "46"))) {
                var resp = confirm("EST� POR CARGAR UNA ASISTENCIA CON ESTATUS:\n USUARIO NO REQUIERE SERVICIO/FUERA DE COBERTURA.\n DESEA CONTINUAR?");
                if (resp == false) {
                    location.href = "DetalleExpediente.jsp?";
                }
            } else {
                if (document.all.TieneAsist.value.toString() == "1") {
                    location.href = "DetalleAsistencia.jsp?";
                }

            }
        }


        function fnSend(pArea) {
            location.href = "DetalleAsistencia.jsp?clAreaOperativa=" + pArea + "&Cond=1";
        }

    </script>
</body>
<%
    StrclExpediente = null;
    StrclServicio = null;
    StrclSubServicio = null;
    StrdsServicio = null;
    StrdsSubServicio = null;
    strclUsr = null;
    strclEstatus = null;
    strTieneAsist = null;
%>
</html>