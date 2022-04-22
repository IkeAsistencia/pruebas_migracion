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
    
    

    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp= session.getAttribute("clUsrApp").toString(); 
    }
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%
        return;
    }
    
    String strclMenu = "0";
    if (request.getParameter("clMenu")!= null){
        strclMenu = request.getParameter("clMenu").toString(); 
    }
    %><script>fnCloseFilters() </script><%
    //out.println("<script>fnOpenLinks(window.parent.frames.InfoRelacionada.height) </script>");
    
    StringBuffer StrSQL = new StringBuffer();

    StrSQL.append("SELECT M.clMenu,M.dsMenu,M.clPaginaWeb,P.NombreLogicoWeb,M.clMenuParent,PAR.dsMenu dsParent,M.EsMenuBase, ");
    StrSQL.append("M.TipoMenu,M.clPaginaRel,REL.NombreLogicoWeb ");
    StrSQL.append("FROM cMenu M ");
    StrSQL.append("LEFT JOIN cPaginaWeb P ON P.clPaginaWeb = M.clPaginaWeb ");
    StrSQL.append("LEFT JOIN cMenu PAR ON PAR.clMenu = M.clMenuParent ");
    StrSQL.append("LEFT JOIN cPaginaWeb REL ON REL.clPaginaWeb = M.clPaginaRel ");
    StrSQL.append("WHERE M.clMenu = ").append(strclMenu);
    StrSQL.append(" ORDER BY M.dsMenu ");
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSQL.toString());
    StrSQL.delete(0,StrSQL.length());
    
    String StrclPaginaWeb = "111";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    
    MyUtil.InicializaParametrosC(111,Integer.parseInt(StrclUsrApp)); 
    
    %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>DetalleMenu.jsp?'>                
    <%
    if (rs.next()) {
        %><INPUT id='clMenu' name='clMenu' type='hidden' value='<%=rs.getString("clMenu")%>'>
        <%=MyUtil.ObjInput("Nombre","dsMenu",rs.getString("dsMenu"),true,true,50,100,"",true,true,30)%>
        <%=MyUtil.ObjComboC("Pagina Web","clPaginaWeb",rs.getString("NombreLogicoWeb"),true,true,270,100,"","select clPaginaWeb,NombreLogicoWeb from cPaginaWeb","","",40,true,true)%>
        <%=MyUtil.ObjComboC("Menu Padre","clMenuParent",rs.getString("dsParent"),true,true,50,140,"","select clMenu, dsMenu dsMenuParent from cMenu where clPaginaWeb is Null","","",40,true,true)%>
        <%=MyUtil.ObjChkBox("Menu Base","EsMenuBase",rs.getString("EsMenuBase"),true,true,270,140,"","SI","NO","")%>
        <%=MyUtil.ObjChkBox("Tipo Menu","TipoMenu",rs.getString("TipoMenu"),true,true,50,180,"","SUBMENU","PRINCIPAL","")%>
        <%
    } else {
        %>
        <INPUT id='clMenu' name='clMenu' type='hidden' value='0'>
        <%=MyUtil.ObjInput("Nombre","dsMenu","",true,true,50,100,"",true,true,30)%>
        <%=MyUtil.ObjComboC("Pagina Web","clPaginaWeb","",true,true,270,100,"","select clPaginaWeb,NombreLogicoWeb from cPaginaWeb","","",40,true,true)%>
        <%=MyUtil.ObjComboC("Menu Padre","clMenuParent","",true,true,50,140,"","select clMenu, dsMenu from cMenu","","",40,true,true)%>
        <%=MyUtil.ObjChkBox("Menu Base","EsMenuBase","",true,true,270,140,"","SI","NO","")%>
        <%=MyUtil.ObjChkBox("Tipo Menu","TipoMenu","",true,true,50,180,"","SUBMENU","PRINCIPAL","")%>
        <%
    }
    rs.close();
    rs=null;
    
    %><%=MyUtil.DoBlock("Detalle de Menúes",110,0)%>
    <%=MyUtil.GeneraScripts()%>
</body>
</html>
