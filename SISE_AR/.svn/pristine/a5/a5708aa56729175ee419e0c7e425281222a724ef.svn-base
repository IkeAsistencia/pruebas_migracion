<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Nueva Categoria</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <%
                    String StrclUsrApp = "0";
                    String StrdsCategoria = "";
                    String StrUsr = "";

                    if (session.getAttribute("clUsrApp") != null) {
                        StrclUsrApp = session.getAttribute("clUsrApp").toString();
                    }

                    if (request.getParameter("Usr") != null) {
                        StrUsr = request.getParameter("Usr").toString();
                    }

                    if (request.getParameter("dsCategoria") != null) {
                        StrdsCategoria = request.getParameter("dsCategoria").toString();

                    }

                    if (StrdsCategoria.equalsIgnoreCase("0")) {
                        StrdsCategoria = "";
                    }
        %>
        <form id='Forma' name ='Forma' action='GuardaCSCategoria.jsp' method='get'>
            <%=MyUtil.ObjInput("Categoría", "dsCategoria", StrdsCategoria, true, true, 30, 40, "", false, false, 55)%>
            <div>
                <IMG alt="" SRC='../../Imagenes/warning.png' style='position:absolute; z-index:1001; left:30px; top:80px;' WIDTH='18' HEIGHT='18'/>
                <h1 id='lblRevCalidad' class='VTable' style='position:absolute; z-index:1000; left:55px; top:77px;' >RECORDÁ: verificá que la categoría a introducir<BR>no se encuentre previamente cargada.</h1>
            </div>

            <%=MyUtil.DoBlock("Nueva Categoría", 100, 20)%>
            <table style='position:absolute; z-index:16; left:20px; top:130px;'>
                <tr>
                    <td class='VTable'>USUARIO: </td>
                    <td><input id='Usr' name='Usr' type='text' value='<%=StrUsr%>' CLASS="VTable"></td>
                </tr>
                <tr>
                    <td class='VTable'>PASSWORD: </td>
                    <td><input id='Pwd' name='Pwd' type='password' value='' CLASS="VTable"></td>
                </tr>
                <tr>
                    <td>
                        <input type="button" value="GUARDAR" onClick="this.disabled=true;document.all.Forma.submit();" class="cBtn" >
                    </td>
                </tr>
            </table>
        </form>
        <%
                    StrclUsrApp = null;
        %>
        <script type="text/javascript" >
            document.all.dsCategoria.readOnly=false;
        </script>
    </body>
</html>