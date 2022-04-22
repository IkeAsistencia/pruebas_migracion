<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<body class="cssBody">
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
    
    String StrclPaginaWeb = "61";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    
    String StrclTipoAuto = "0";
    
    if (request.getParameter("clTipoAuto")!= null)
    {
        StrclTipoAuto = request.getParameter("clTipoAuto").toString(); 
    }  
    session.setAttribute("clTipoAuto",StrclTipoAuto);
    StringBuffer StrSql1 = new StringBuffer();
StrSql1.append("select TA.clTipoAuto,  MA.dsMarcaAuto , " );
StrSql1.append(" TA.ClaveAmis, TA.dsTipoAuto ");
StrSql1.append("from cTipoAuto TA ");
StrSql1.append("inner join cMarcaAuto MA on (MA.CodigoMarca = TA.CodigoMarca) ");
StrSql1.append("Where TA.clTipoAuto = '").append( StrclTipoAuto).append("'");
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
    
    MyUtil.InicializaParametrosC(61,Integer.parseInt(StrclUsrApp)); 
    %>
    <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleAmis.jsp?'>"%>  
    <%
    if (rs.next()) {
    %>
        <INPUT id='clTipoAuto' name='clTipoAuto' type='hidden' value='<%= rs.getString("clTipoAuto")%>'>
        <%=MyUtil.ObjComboC("Marca","CodigoMarca",rs.getString("dsMarcaAuto"),true,true,50,100,"","select CodigoMarca, dsMarcaAuto from cMarcaAuto","","",50,true,true)%>
        <%=MyUtil.ObjInput("AMIS","ClaveAMIS",rs.getString("ClaveAMIS"),true,true,50,140,"",true,true,20)%> 
        <%=MyUtil.ObjInput("Tipo de Automovil","dsTipoAuto",rs.getString("dsTipoAuto"),true,true,250,140,"",true,true,50)%>
        <%=MyUtil.DoBlock("Detalle de Claves AMIS",150,0)%>
       <%
    } else {
        %>
        <INPUT id='clTipoAuto' name='clTipoAuto' type='hidden' value='0'>
        <%=MyUtil.ObjComboC("Marca","CodigoMarca","",true,true,50,100,"","select CodigoMarca, dsMarcaAuto from cMarcaAuto","","",50,true,true)%>
        <%=MyUtil.ObjInput("AMIS","ClaveAMIS","",true,true,50,140,"",true,true,20)%> 
        <%=MyUtil.ObjInput("Tipo de Automovil","dsTipoAuto","",true,true,250,140,"",true,true,50)%>
        <%=MyUtil.DoBlock("Detalle de Claves AMIS",150,0)%>
    <%
    }
    rs.close();
    rs=null;
    
    StrSql1=null;
    StrclUsrApp=null;
    StrclTipoAuto=null;
    %>
    <%=MyUtil.GeneraScripts()%>

</body>
</html>
