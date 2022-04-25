<%-- 
    Document   : ImportarPerfil
    Created on : 18/10/2011, 04:01:05 PM
    Author     : fcerqueda
--%>

<%@page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%@page import="java.sql.ResultSet,Utilerias.UtileriasBDF" %>

<html>
    <head>
        <title>Importacion de Perfil</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style>
            .principal{
                font-size:14px;
                font-family:sans-serif;
                font-weight:bold;
            }

            .instrucciones{
                font-size:12px;
                font-weight:bold;
                font-family:sans-serif;
            }
        </style>
    </head>
    <body bgcolor="#004B85" >
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
        String StrclUsrApp = "0";
        String clusract = "";
        String clusrModelo = "";
        StringBuffer strSql = new StringBuffer();
        String resultado = "";

        if(session.getAttribute("clUsrApp") != null){
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if(request.getParameter("usrActual") != null){
            clusract = request.getParameter("usrActual");
        }

        if(request.getParameter("usrModelo") != null){
            clusrModelo = request.getParameter("usrModelo");
        }

        strSql.delete(0, strSql.length());
          if(request.getParameter("strlSQL") != null){
            strSql.append(request.getParameter("strlSQL").toString());
            strSql.append(" '").append(clusract).append("', ");
            strSql.append(" '").append(clusrModelo).append("', ");
            strSql.append(" '").append(StrclUsrApp).append("' ");
        }

       ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());
       strSql.delete(0, strSql.length());
            if(rs.next()){
               resultado = rs.getString("Mensaje").toString();                   //System.out.println(cadena);

            }
        rs.close();
        rs = null;

        %>
        <INPUT id='resultado' name='resultado' type ='hidden' value='<%=resultado%>'>

        <script>
            var res = document.all.resultado.value;
            if(res == 1)
            {
                alert("El Area operativa del usuario a importar no coincide favor de verificar ..!!!");
                this.window.close();
            }else if(res == 2){
                aler("Error al importar perfil...");
                this.window.close();
            }else if(res == 3){
                alert("Error al enviar correo...");
                this.window.close();
            }else if(res == 4 ){
                alert("Importacion exitosa...");
                this.window.close();
            }
        </script>


    </body>
</html>



