<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Información de Promoción</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            table.sample {
                border-width: 1px;
                border-spacing: 1px;
                border-style: solid;
                border-color: black;
                border-collapse: separate;
                text-align: justify;
            }
            table.sample th {
                border-width: 1px;
                padding: 1px;
                border-style: outset;
                border-color: black;
                text-align: justify;
            }
            table.sample td {
                border-width: 1px;
                padding: 1px;
                border-style: outset;
                border-color: black;
                text-align: justify;
            }
        </style>
    </head>
    <script src='../Utilerias/Util.js'></script>
    <%
            String StrclPromocion = "0";
            String StrclAsistencia = "";
            String StrclUsr = "0";
            String StrSemaforoPrioridad = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clAsistencia") != null) {
                StrclAsistencia = session.getAttribute("clAsistencia").toString();
            }

            if (request.getParameter("clPromocion") != null) {
                StrclPromocion = request.getParameter("clPromocion").toString();
            }

            StringBuffer StrSql = new StringBuffer();
            StrSql.append(" sp_DetallePromocion ").append(StrclPromocion);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
    %>

    <body class="cssBody">
        <center>
            <%if (rs.next()) {
                        if (rs.getString("PriorityOffer").equalsIgnoreCase("1") || rs.getString("PriorityOffer").equalsIgnoreCase("YES")) {
                            StrSemaforoPrioridad = "cssRojoFuerte";
                        } else {
                            StrSemaforoPrioridad = "VTable";
                        }
            %>
			<tr><td><input class='cBtn' type='button' value='Asignar' onClick='window.open("AsignaPromocion.jsp?clAsistencia=<%=StrclAsistencia%>&clPromocion=<%=StrclPromocion%>","winPromo","resizable=no,menubar=0,width=100,height=100");window.close();'></input></td></tr>
            <table class="sample">
                <tbody>
                    <tr>
                        <td colspan="15" class="TTable"><b>Merchant Partner</b></td>
                    </tr>
                    <tr>
                        <td colspan="15" class="VTable"><%=rs.getString("MerchantPartner")%></td>
                    </tr>

                    <tr>
                        <td colspan="15"></td>
                    </tr>

                    <tr>
                        <td colspan="5" class="TTable"><b>INICIO DE VIGENCIA:</b></td>
                        <td colspan="5" class="TTable"><br><b>DIRECCIÓN:</b></td>
                        <td colspan="5" class="TTable"><b>FIN DE VIGENCIA:</b></td>
                    </tr>
                    <tr>
                        <td colspan="5" class="<%=rs.getString("Semaforo")%>"><%=rs.getString("StartDate")%></td>
                        <td rowspan="3" colspan="5" class="VTable"><%=rs.getString("MerchantAddress")%></td>
                        <td colspan="5" class="<%=rs.getString("Semaforo")%>"><%=rs.getString("EndDate")%></td>
                    </tr>

                    <tr>
                        <td colspan="5" class="TTable"><b>PAÍS:</b></td>
                        <td colspan="5" class="TTable"><b>CATEGORÍA:</b></td>
                    </tr>

                    <tr>
                        <td colspan="5" class="VTable"><%=rs.getString("Country")%></td>
                        <td colspan="5" class="VTable"><%=rs.getString("Category")%></td>
                    </tr>

                    <tr>
                        <td colspan="5" class="TTable"><b>CIUDAD:</b></td>
                        <td colspan="5" class="TTable"><b>WEB SITE:</b></td>
                        <td colspan="5" class="TTable"><b>SUB CATEGORÍA:</b></td>
                    </tr>
                    <tr>
                        <td colspan="5" class="VTable"><%=rs.getString("CityState")%></td>
                        <td colspan="5" class="VTable"><%=rs.getString("MerchantWebsite")%></td>
                        <td colspan="5" class="VTable"><%=rs.getString("SubCategory")%></td>
                    </tr>

                    <tr>
                        <td colspan="15"></td>
                    </tr>

                    <tr>
                        <td colspan="15" class="TTable"><b>DETALLES DE PROMOCIÓN:</b></td>
                    </tr>
                    <tr>
                        <td colspan="15" class="VTable"><%=rs.getString("OfferDetails")%></td>
                    </tr>

                    <tr>
                        <td colspan="15" class="TTable"><b>TÉRMINOS Y CONDICIONES:</b></td>
                    </tr>                    
                    <tr>
                        <td colspan="15" class="VTable"><%=rs.getString("TermsConditions")%></td>
                    </tr>

                    <tr>
                        <td colspan="15" class="TTable"><b>PROCESO DE REDENCIÓN:</b></td>
                    </tr>
                    <tr>
                        <td colspan="15" class="VTable"><%=rs.getString("RedemptionChannel")%></td>
                    </tr>

                    <tr>
                        <td colspan="15"></td>
                    </tr>

                    <tr>
                        <td colspan="15">
                            <table style="WIDTH: 100%;">
                                <tbody>
                                    <tr>
                                        <td colspan="3" class="TTable"><b>PRODUCTOS ELEGIBLES</b></td>
                                    </tr>
                                    <tr>
                                        <td class="VTable"><b>GOLD:</b></td>
                                        <td class="VTable"><b>PLATINUM:</b></td>
                                        <td class="VTable"><b>BLACK/WE:</b></td>
                                    </tr>
                                    <tr>
                                        <td class="VTable"><%=rs.getString("Gold")%></td>
                                        <td class="VTable"><%=rs.getString("Platinum")%></td>
                                        <td class="VTable"><%=rs.getString("BlackWorldElite")%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="15"></td>
                    </tr>

                    <tr>
                        <td colspan="10" class="TTable"><b>PARTICIPACIÓN DEL CONCIERGE:</b></td>
                        <td colspan="5" class="TTable"><b>PRIORIDAD:</b></td>
                    </tr>
                    <tr>
                        <td colspan="10" class="VTable"><%=rs.getString("ConciergeRole")%></td>
                        <td colspan="5" class="<%=StrSemaforoPrioridad%>"><%=rs.getString("PriorityOffer")%></td>
                    </tr>

                    <tr>
                        <td colspan="15"></td>
                    </tr>
                </tbody>
            </table>
            <%
                        rs.close();
                        rs = null;
                    }%>
        </center>
    </body>
</html>
