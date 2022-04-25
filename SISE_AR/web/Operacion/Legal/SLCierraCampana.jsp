<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
<head><title>Cierra Campaña</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
</head>

<body class="cssBody" onload='fndsHabilitar();'>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilAuto.js' ></script>
<script src="../../Utilerias/UtilCalendario.js"></script>
<script src='../../Utilerias/UtilMask.js'></script>
<%
StringBuffer StrSql = new StringBuffer(); 
String strclCampanaSL = "0";
String strclUsrAppCierra = "0";

    if (session.getAttribute("clUsrApp")!=null)
    {
        strclUsrAppCierra = session.getAttribute("clUsrApp").toString();
    }


    if (request.getParameter("clCampanaSL")!=null)
    {
        strclCampanaSL = request.getParameter("clCampanaSL").toString();
    }
//    out.println("Cerrada por: " + strclUsrAppCierra);
//    out.println("Campaña: " + strclCampanaSL);

           StrSql.append(" sp_SLCierraCampana ").append(strclUsrAppCierra).append(",").append(strclCampanaSL);
           UtileriasBDF.ejecutaSQLNP(StrSql.toString());
           StrSql.delete(0,StrSql.length());

           %>
<script>window.opener.fnValidaResponse(1,'<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../../servlet/Utilerias.Lista?P=588');window.close();</script>
           <%


%>
</body>
</html>