<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
    <title>Desasignar Expedientes a Supervision</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<script src='../Utilerias/Util.js' ></script>
<%  
    String StrclUsrApp="0";
    if (session.getAttribute("clUsrApp")!= null)  {
       StrclUsrApp = session.getAttribute("clUsrApp").toString();    }  
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
        return; 
        }
    String StrExpedElegidos="";
    if (request.getParameter("Resultados")!= null)    {
       StrExpedElegidos = request.getParameter("Resultados").toString();      }  
    try{
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("DELETE AsignacionSupUsr WHERE clExpediente IN (").append(StrExpedElegidos).append(")");
        System.out.println(StrSql.toString());
        UtileriasBDF.ejecutaSQLNP(StrSql.toString());
        StrSql=null;
        %>
        <script> window.opener.fnValidaResponse(1,'DesasignarExped.jsp?');window.close();</script>
    <%}catch(Exception e){    e.printStackTrace();  }
%>
</body>
</html>
