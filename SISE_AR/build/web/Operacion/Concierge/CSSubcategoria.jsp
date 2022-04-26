<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Nueva Subcategoría</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <%
                    String StrclCategoria = "0";
                    String StrclUsrApp = "0";
                    String StrdsCategoria = "";
                    String StrdsSubCategoria = "";
                    String StrUsr = "";

                    if (session.getAttribute("clUsrApp") != null) {
                        StrclUsrApp = session.getAttribute("clUsrApp").toString();
                    }

                    if (request.getParameter("Usr") != null) {
                        StrUsr = request.getParameter("Usr").toString();
                    }

                    if (request.getParameter("dsSubCategoria") != null) {
                        StrdsSubCategoria = request.getParameter("dsSubCategoria");
                    }

                    if (request.getParameter("clCategoria") != null) {
                        StrclCategoria = request.getParameter("clCategoria");
                    }

                    if (request.getParameter("dsCategoria") != null) {
                        StrdsCategoria = request.getParameter("dsCategoria");
                    } else {
                        StringBuffer StrSql = new StringBuffer();
                        StrSql.append(" st_getCSCategoria ").append(StrclCategoria);
                        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());

                        if (rs.next()) {
                            StrdsCategoria = rs.getString("dsCategoria");
                        }
                    }
        %>
        <form id='Forma' name ='Forma' action='GuardaCSSubCategoria.jsp' method='get'>
            <%=MyUtil.ObjInput("Categoría", "dsCategoria", StrdsCategoria, true, true, 30, 40, StrdsCategoria, false, false, 38)%>
            <%=MyUtil.ObjInput("SubCategoría", "dsSubCategoria", StrdsSubCategoria, true, true, 270, 40, "", false, false, 40)%>
            <div>
                <IMG alt="" SRC='../../Imagenes/warning.png' style='position:absolute; z-index:1001; left:245px; top:80px;' WIDTH='18' HEIGHT='18'/>
                <h1 id='lblRevCalidad' class='VTable' style='position:absolute; z-index:1000; left:270px; top:77px;' >RECORDÁ: verificá que la subcategoría a introducir<BR>no se encuentre previamente cargada.</h1>
            </div>

            <%=MyUtil.DoBlock("Nueva SubCategoría", 50, 20)%>
            <input id="clCategoria" name="clCategoria" type="hidden" value="<%=StrclCategoria%>">
            <table style='position:absolute; z-index:16; left:20px; top:130px;'>
                <tr>
                    <td class='VTable'>USUARIO: </td>
                    <td><INPUT id='Usr' name='Usr' type='text' value='<%=StrUsr%>'   CLASS="VTable"></td>
                </tr>
                <tr>
                    <td class='VTable'>PASSWORD: </td>
                    <td><INPUT id='Pwd' name='Pwd' type='password' value=''  CLASS="VTable"></td>
                </tr>
                <tr>
                    <td>
                        <input type="button" value="GUARDAR" onClick="this.disabled=true;document.all.Forma.submit();" class="cBtn" >
                    </td>
                </tr>
            </table>
        </form>
        <%
                    StrclCategoria = null;
                    StrclUsrApp = null;
        %>
        <script type="text/javascript">
            document.all.dsSubCategoria.readOnly=false;
        </script>
    </body>
</html>
