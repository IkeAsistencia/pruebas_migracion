<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<script src='../Utilerias/Util.js'></script>

<%  
    String StrclUsrApp = "0";
    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp= session.getAttribute("clUsrApp").toString(); 
    }  
    
    

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
    {
        %><%="Fuera de Horario"%><%
        
        return;
    }
    
    String StrclPaginaWeb = "93";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    
    String StrclBanco = "0";
    if (request.getParameter("clBanco")!= null){
        StrclBanco = request.getParameter("clBanco").toString(); 
    }  
    session.setAttribute("clBanco",StrclBanco);
    StringBuffer StrSql1 = new StringBuffer();
    StrSql1.append("select clBanco, Nombre ");
    StrSql1.append("from cBanco ");
    StrSql1.append("Where clBanco = ").append(StrclBanco);
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
    
    MyUtil.InicializaParametrosC(93,1); 
    %>
    <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleBanco.jsp?'>"%>  
    <%
    if (rs.next()) {
        %>
        <INPUT id='clBanco' name='clBanco' type='hidden' value='<%=rs.getInt("clBanco")%>'>
        <%=MyUtil.ObjInput("Nombre del Banco","Nombre",rs.getString("Nombre"),true,true,50,100,"",true,true,50)%>
        <%=MyUtil.DoBlock("Detalle Banco",150,0)%>
        <%
    } else {
        %>
        <INPUT id='clBanco' name='clBanco' type='hidden' value='0'>
        <%=MyUtil.ObjInput("Nombre del Banco","Nombre","",true,true,50,100,"",true,true,50)%>
        <%=MyUtil.DoBlock("Detalle Banco",150,0)%>
    <%
    }
    rs.close();
    rs=null;
    
    StrSql1=null;
    StrclUsrApp=null;
    StrclPaginaWeb=null;
    StrclBanco=null;
    %>
    <%=MyUtil.GeneraScripts()%>
</body>
</html>
