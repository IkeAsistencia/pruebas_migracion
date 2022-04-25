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
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrCodEnt = "0";
        String strclUsr = "";
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if (request.getParameter("CodEnt")!= null)
        {
            StrCodEnt= request.getParameter("CodEnt").toString();
        }
        
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("select CodEnt, dsEntFed, Prefijo from cEntFed ");
        StrSql.append(" Where CodEnt = '").append(StrCodEnt).append("' Order by dsEntFed");
        
        
        String StrclPaginaWeb = "52";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        %>
        <SCRIPT>fnCloseLinks()</script><%
        
        MyUtil.InicializaParametrosC(52,Integer.parseInt(strclUsr));
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>  		        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="EntidadFederativa.jsp?'>"%><%
        
        if (rs.next())
        {
        %><INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%=rs.getString("CodEnt")%>'>
        <%=MyUtil.ObjInput("Descripción","dsEntFed",rs.getString("dsEntFed"),true,true,25,80,"",true,true,30)%>
        <%=MyUtil.ObjInput("Prefijo","Prefijo",rs.getString("Prefijo"),true,true,25,120,"",true,true,3)%><%                
        }
        else
        {
        %><INPUT id='CodEnt' name='CodEnt' type='hidden' value='0'>
        <%=MyUtil.ObjInput("Descripción","dsEntFed","",true,true,25,80,"",true,true,30)%>
        <%=MyUtil.ObjInput("Prefijo","Prefijo","",true,true,25,120,"",true,true,3)%><%
        }			 
        %><%=MyUtil.DoBlock("Detalle de " + i18n.getMessage("message.title.entidad"),25,0)%>
        <%=MyUtil.GeneraScripts()%><% 
        
        rs.close();
        rs=null;
        
        StrSql=null;
        StrclPaginaWeb=null;
        StrCodEnt = null;
        strclUsr = null;
        
        %>
        
    </body>
</html>