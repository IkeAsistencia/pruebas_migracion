<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title>Detalle de IP por Usuario</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>

<%  
    String StrclUsrApp = "0";
    String StrclUsrAppParam = "0";
    
    

    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp= session.getAttribute("clUsrApp").toString(); 
    }
    if (session.getAttribute("clUsrAppParam")!= null){
        StrclUsrAppParam= session.getAttribute("clUsrAppParam").toString(); 
        if (StrclUsrAppParam.compareToIgnoreCase("1")==0){
        %>No puede restringir IPs al usuario administrador....
        <% return;
        }
    }else{
      %>Primero debe ingresar al detalle de usuario para administrar IPs restringidas<%
      return;
    }

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%
        return;
    }
    
    String strclAccesoxIPxUsr = "0";
    if (request.getParameter("clAccesoxIPxUsr")!= null){
        strclAccesoxIPxUsr = request.getParameter("clAccesoxIPxUsr").toString(); 
    }

    StringBuffer StrSQL = new StringBuffer();
    StrSQL.append("select clAccesoxIPxUsr, Mask ");
    StrSQL.append("from AccesoxIPxUsr ");
    StrSQL.append("Where clAccesoxIPxUsr = ").append(strclAccesoxIPxUsr);
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSQL.toString());
    StrSQL.delete(0,StrSQL.length());
    
    String StrclPaginaWeb = "425";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    
    MyUtil.InicializaParametrosC(425,Integer.parseInt(StrclUsrApp)); 
    %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>DetalleIPxUsr.jsp?'>                
    <%
    if (rs.next()) {
        %><INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrAppParam%>'>
        <INPUT id='clAccesoxIPxUsr' name='clAccesoxIPxUsr' type='hidden' value='<%=strclAccesoxIPxUsr%>'>
        <%=MyUtil.ObjInput("Mask IP","Mask",rs.getString("Mask"),true,true,30,70,"",true,true,30)%><%
        } else {
        %><INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrAppParam%>'>
        <INPUT id='clAccesoxIPxUsr' name='clAccesoxIPxUsr' type='hidden' value='<%=strclAccesoxIPxUsr%>'>
        <%=MyUtil.ObjInput("Mask IP","Mask","",true,true,30,70,"",true,true,30)%><%
    }
    rs.close();
    rs=null;
    
    %><%=MyUtil.DoBlock("IP",120,0)%>
    <%=MyUtil.GeneraScripts()%><%
%>
</body>
</html>
