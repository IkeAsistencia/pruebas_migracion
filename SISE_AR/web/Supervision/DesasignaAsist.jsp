<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script src='../Utilerias/Util.js' ></script>
        
        <%  
        
        String StrclUsrApp = "0";
        String StrExpedElegidos = "";
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (request.getParameter("Resultados")!= null) {
            StrExpedElegidos = request.getParameter("Resultados").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario
        <%return; 
        }     
        try{
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("delete from SCSAsignacionAsistxUsr where clAsistencia in (").append(StrExpedElegidos).append(")");
        UtileriasBDF.ejecutaSQLNP(StrSql.toString());
        StrSql=null;
        %>
        <script> window.opener.fnValidaResponse(1,'DesasignarAsist.jsp?');window.close();</script>
        <%}catch(Exception e){
        e.printStackTrace();
        }
        
        %>
    </body>
</html>
