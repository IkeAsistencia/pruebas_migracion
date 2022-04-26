<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
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
    }

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%
        return;
    }
    
    String strclCuenta = "0";
    if (request.getParameter("clCuenta")!= null){
        strclCuenta = request.getParameter("clCuenta").toString(); 
    }

    
    StringBuffer StrSQL = new StringBuffer();
    StrSQL.append("select CxU.clUsrApp, CxU.clCuenta, C.Nombre ");
    StrSQL.append("from CtaxUsr CxU ");
    StrSQL.append("inner join cCuenta C on (C.clCuenta = CxU.clCuenta) ");
    StrSQL.append("Where CxU.clCuenta = ").append(strclCuenta).append(" and CxU.clUsrApp = ").append(StrclUsrAppParam);
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSQL.toString());
    StrSQL.delete(0,StrSQL.length());
    
    String StrclPaginaWeb = "129";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    
    MyUtil.InicializaParametrosC(129,Integer.parseInt(StrclUsrApp)); 
    %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>CtaxUsr.jsp?'>                
    <%
    if (rs.next()) {
        %><INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrAppParam%>'>
        <%=MyUtil.ObjComboC("Cuenta","clCuenta",rs.getString("Nombre"),true,true,50,100,"","select clCuenta, Nombre from cCuenta where dsCuenta is not null and activo = 1 order by Nombre","","",30,true,true)%>
        <%
    } else {
        %><INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrAppParam%>'>
        <%=MyUtil.ObjComboC("Cuenta","clCuenta","",true,true,50,100,"","select clCuenta, Nombre from cCuenta where dsCuenta is not null and activo = 1 order by Nombre","","",30,true,true)%>
        <%
    }
    rs.close();
    rs=null;
    
    %><%=MyUtil.DoBlock("Cuentas",120,0)%>
    <%=MyUtil.GeneraScripts()%><%
%>
</body>
</html>
