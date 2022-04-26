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
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrclUsrApp = "0";
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            StrclUsrApp= session.getAttribute("clUsrApp").toString();
        }
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
        {
        %>Fuera de Horario<%
        
        return;
        }
        
        String StrclPaginaWeb = "66";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        String StrCodMD = "";
        String StrCodEnt = "";
        
        if (request.getParameter("CodMD")!= null)
        {
            StrCodMD = request.getParameter("CodMD").toString();
        }
        
        session.setAttribute("CodMD",StrCodMD);
        
        if (request.getParameter("CodEnt")!= null)
        {
            StrCodEnt = request.getParameter("CodEnt").toString();
        }
        session.setAttribute("CodEnt",StrCodEnt);
        
        StringBuffer StrSql = new StringBuffer();
        StrSql.delete(0,StrSql.length());
        
        StrSql.append(" select MD.CodMD, E.CodEnt, E.dsEntFed,  MD.dsMunDel ");
        StrSql.append(" from cMunDel MD ");
        StrSql.append(" inner join cEntFed E on (E.CodEnt = MD.CodEnt) ");
        StrSql.append(" Where MD.CodMD = '").append(StrCodMD).append("'");
        StrSql.append(" and MD.CodEnt = '").append(StrCodEnt).append("'");
        
        System.out.print(StrSql.toString());
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        MyUtil.InicializaParametrosC(66,Integer.parseInt(StrclUsrApp)); 
        %>    
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleMunDel.jsp?'>"%>
        <%
        if (rs.next())
        {
        %>
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=rs.getInt("CodMD")%>'>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt",rs.getString("dsEntFed"),true,true,50,100,"","select CodEnt, dsEntFed from cEntFed","","",50,true,true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel",rs.getString("dsMunDel"),true,true,50,140,"",true,true,50)%>
        <%=MyUtil.DoBlock("Detalle de " + i18n.getMessage("message.title.municipio"),150,0)%>
        <%
        }
        else
        {
        %>
        <INPUT id='CodMD' name='CodMD' type='hidden' value='0'>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt","",true,true,50,100,"","select CodEnt, dsEntFed from cEntFed","","",50,true,true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel","",true,true,50,140,"",true,true,50)%>
        <%=MyUtil.DoBlock("Detalle de " + i18n.getMessage("message.title.municipio"),150,0)%>
        <%
        }
        StrclUsrApp=null;
        StrCodMD=null;
        StrSql=null;
        rs.close();
        rs=null;
        
        %>
        <%=MyUtil.GeneraScripts()%>
    </body>
</html>