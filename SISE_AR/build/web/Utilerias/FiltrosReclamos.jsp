<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Fitros Búsqueda de Afiliado</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <script src='../Utilerias/Util.js'></script>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

        <%
                String strDNI = "";
                String strclGpoCuenta = "";
                String strNomAfil = "";

                StringBuffer strSql = new StringBuffer();

                if (request.getParameter("DNI") != null) {
                    strDNI = request.getParameter("DNI").toString().trim();
                }

                if (request.getParameter("nomAfil") != null) {
                    strNomAfil = request.getParameter("nomAfil").toString().trim();
                }

                if (request.getParameter("clGpoCuenta") != null) {
                    strclGpoCuenta = request.getParameter("clGpoCuenta").trim();
                }

                strSql.append("st_BuscaClaveAfilReclamo '").append(strclGpoCuenta).append("','").append(strDNI).append("','").append(strNomAfil).append("'");

                ResultSet rs = null;
                if (!strDNI.equalsIgnoreCase("") || !strNomAfil.equalsIgnoreCase("")) {
                    rs = UtileriasBDF.rsSQLNP(strSql.toString());
                }

                MyUtil.InicializaParametrosC(6053, Integer.parseInt("1"));
        %>
        <form id='Forma' name ='Forma' action='FiltrosReclamos.jsp' method='get'>
            <input type='hidden' id='strSQL' name='strSQL' value="st_BuscaClaveAfilReclamo ">
            <input type='hidden' id = 'clGpoCuenta' name = 'clGpoCuenta' value ="<%=strclGpoCuenta%>"/>         
            <%=MyUtil.ObjInput("DNI", "DNI", strDNI, true, true, 25, 90, "", false, false, 50, "fnLimpianomAfil();")%>
            <%=MyUtil.ObjInput("Nombre Afiliado", "nomAfil", strNomAfil, true, true, 25, 130, "", false, false, 50, "fnLimpiaDNI();")%>
            <p align='left'><input type='button' value='BUSCAR...' onClick='document.all.Forma.submit()' class='cBtn'></p>

        </form>
        <%=MyUtil.GeneraScripts()%>

        <script>
            // document.all.Clave.readOnly=false;
            document.all.DNI.readOnly=false;
            document.all.nomAfil.readOnly=false;
            window.resizeTo(700,500);
        </script>
        <br><br><br><br><br><br>
        <%
                StringBuffer strSalida = new StringBuffer();
                UtileriasBDF.rsTableNP(strSql.toString(), strSalida);
        %>
        <%=strSalida.toString()%>

        <script>

            function fnLimpiaDNI(){
                document.all.DNI.value='';
            }      
            function fnLimpianomAfil(){
                document.all.nomAfil.value='';
            }

        </script>
    </body>
</html>