<%-- 
    Document   : CSPromocionesConcierge
    Created on : 14/01/2011, 11:33:42 AM
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Promociones Concierge</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script src='../../Utilerias/Util.js'></script>
        <style>
            .ratonEncima{
                background: #9AACD1;
                font-family: Verdana, Arial, Helvetica, sans-serif;
                color: #FFFFFF;
                font-size: 9px;
                text-transform: uppercase;
                cursor: default;
            }
        </style>
    </head>
    <body class="cssBody">
        <script src='Util.js'></script>
        <table width='500px' class='cssTitDet'><tr><td><font style="font-size: 10pt; color:white ">Promociones Disponibles</font></td></tr></table>
        <table width='500px' Border=1 Class='vTable'></table>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <%
                String StrclAsistencia = "";
                String StrclCuenta = "";
                String StrclSubservicio = "";
                String StrPromocion = "";
                String StrclPais = "";
                String StrclCategoria = "";
                String StrCiudad = "";
                String StrclSubCategoria = "";
                int R = 1;

                if (session.getAttribute("clAsistencia") != null) {
                    StrclAsistencia = session.getAttribute("clAsistencia").toString();
                }

                if (session.getAttribute("clSubservicio") != null) {
                    StrclSubservicio = session.getAttribute("clSubservicio").toString();
                }

                if (request.getParameter("Promocion") != null) {
                    StrPromocion = request.getParameter("Promocion").toString();
                }

                if(StrPromocion.equalsIgnoreCase("")){
                    if(request.getParameter("PromocionA")!=null){
                        StrPromocion = request.getParameter("PromocionA").toString();
                    }
                }


                if (request.getParameter("clCategoria") != null) {
                    StrclCategoria = request.getParameter("clCategoria").toString();
                }

                if (request.getParameter("clPais") != null) {
                    StrclPais = request.getParameter("clPais").toString();
                }

                if (request.getParameter("Ciudad") != null) {
                    StrCiudad = request.getParameter("Ciudad").toString();
                }

                if (request.getParameter("clSubCategoria") != null) {
                    StrclSubCategoria = request.getParameter("clSubCategoria");
                }

                String StrSQL = "st_CSPromociones '" + StrclAsistencia + "','" + StrPromocion + "','" + StrclCategoria + "','" + StrclSubCategoria + "','" + StrclPais + "','" + StrCiudad + "'";
                System.out.println("StrSQL:         "+StrSQL);
                ResultSet rs = UtileriasBDF.rsSQLNP(StrSQL.toString());

                MyUtil.InicializaParametrosC(1, 1);
        %>
        <form id='Forma' name ='Forma' action='CSPromocionesConcierge.jsp' method='get'>
            <%=MyUtil.ObjInput("Promoción", "PromocionA", "", true, true, 25, 50, "", false, false, 40, "")%>
            <%=MyUtil.ObjComboC("Promoción", "Promocion", "", true, true, 25, 90, "", "st_CSPromoMerchantPartner", "", "", 30, false, false)%>
            <%=MyUtil.ObjComboC("Categoría", "clCategoria", "", true, true, 25, 130, "", "st_CSPromoCategorias", "fnLlenaSubCategorias();", "", 30, false, false)%>
            <%=MyUtil.ObjComboC("SubCategoría", "clSubCategoria", "", true, true, 25, 170, "", "st_CSPromoSubCategorias", "", "", 30, false, false)%>
            <%=MyUtil.ObjComboC("País", "clPais", "", true, true, 25, 210, "", "st_CSPromoPaises", "fnLlenaCiudades();", "", 30, false, false)%>
            <%=MyUtil.ObjComboC("Ciudad", "Ciudad", "", true, true, 25, 250, "", "st_CSPromoCiudades", "", "", 30, false, false)%>
            <input type="submit" class="cBtn" value="Buscar..." style="position:absolute; z-index:250; left:400px; top:260px;">
            <p></p><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
            <%%>
        </form>

            <%if(rs.next()){
                System.out.println("Codsalida       "+rs.getString("CodSalida"));
                if(rs.getString("CodSalida").equalsIgnoreCase("0")){
                    rs.beforeFirst();
                    while(rs.next()){
                    %>
                        <table style="WIDTH:500px; HEIGHT: 71px" border="2">
                              <tr >
                                <td rowspan="3" width="122" class="<%=rs.getString("Semaforo")%>">VIGENCIA<br><%=rs.getString("Vigencia")%><br><%//=rs.getString("Ver")%></td>

                                <td width="200" class="TTable">PAÍS</td>

                                <td width="200" class="TTable">CIUDAD</td>

                                <td width="200" class="TTable">CATEGORÍA</td>

                                <td width="200" class="TTable">SUBCATEGORÍA</td>

                                <td rowspan="3" width="119" class="cssNaranja" align="Center"><%=rs.getString("Ver")%><br><br><br>INFO</td>
                              </tr>

                              <tr>
                                <td width="200" class="R1Table"><%=rs.getString("Pais")%></td>

                                <td width="200" class="R1Table"><%=rs.getString("Ciudad")%></td>

                                <td width="200" class="R1Table"><%=rs.getString("Categoria")%></td>

                                <td width="200" class="R1Table"><%=rs.getString("SubCategoria")%></td>
                              </tr>

                              <tr>
                                <td width="783" colspan="4" class="R1Table"><%=rs.getString("MerchantPartner")%></td>
                              </tr>
                          </table>
                          <br>

                    <%
                    }
                }else{
                    rs.getString("Titulo");
                }
            }
            
            rs.close();
            rs = null;
            %>
    </body>
    <script>
        document.all.PromocionC.disabled=false;
        document.all.clCategoriaC.disabled = false;
        document.all.clSubCategoriaC.disabled = false;
        document.all.Ciudad.readOnly=false;
        document.all.clPaisC.disabled = false;
        document.all.CiudadC.disabled = false;
        document.all.PromocionA.readOnly=false;
        
        function fnLlenaSubCategorias(){
            var strConsulta = "st_CSLlenaSubCategorias '" + document.all.clCategoria.value + "'";
            var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
            pstrCadena = pstrCadena + "&strName=clSubCategoriaC";
            fnOptionxDefault('clSubCategoriaC',pstrCadena);
        }
        
        function fnLlenaCiudades(){
            var strConsulta = "st_CSLlenaCiudades '" + document.all.clPais.value + "'";
            var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
            pstrCadena = pstrCadena + "&strName=CiudadC";
            fnOptionxDefault('CiudadC',pstrCadena);
        }
    </script>
</html>