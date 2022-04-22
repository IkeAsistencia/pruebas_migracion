<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>

<%  
    String StrclPaginaWeb = "63";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    
    String StrclTipoContactante = "0";
    
    

    if (request.getParameter("clTipoContactante")!= null)
    {
        StrclTipoContactante = request.getParameter("clTipoContactante").toString(); 
    }  
    session.setAttribute("clTipoContactante",StrclTipoContactante);
    
    StringBuffer StrSql = new StringBuffer();
    StrSql.append("select clTipoContactante, dsTipoContactante ");
    StrSql.append("from cTipoContactante ");
    StrSql.append("Where clTipoContactante = ").append(StrclTipoContactante);
    
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());    
    
    MyUtil.InicializaParametrosC(63,1); 
    %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
    
    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleTipoContactante.jsp?'>"%><%
        
    if (rs.next()) {
        %><INPUT id='clTipoContactante' name='clTipoContactante' type='hidden' value='<%=rs.getString("clTipoContactante")%>'>
        <%=MyUtil.ObjInput("Nombre del Contactactante","dsTipoContactante",rs.getString("dsTipoContactante"),true,true,50,100,"",true,true,50)%>
        <%=MyUtil.DoBlock("Detalle Tipos de Contactante",150,0)%><%
    } else {
        %><INPUT id='clTipoContactante' name='clTipoContactante' type='hidden' value='0'>
        <%=MyUtil.ObjInput("Nombre del Contactactante","dsTipoContactante","",true,true,50,100,"",true,true,50)%>
        <%=MyUtil.DoBlock("Detalle Tipos de Contactante",150,0)%><%
    }
    %><%=MyUtil.GeneraScripts()%><%
    rs.close();
    rs=null;
    
    StrSql=null;
    StrclPaginaWeb=null;
    StrclTipoContactante=null;
%>
</body>
</html>
