<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script>
top.document.all.rightPO.rows="70,*";
</script>
<%
    String StrclExpediente="0";
    String StrclPaginaWeb="0";
    String StrLista="0";
    String StrclUsrApp="0";
        if (session.getAttribute("clUsrApp")!= null)
        {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     } 
    else if (request.getParameter("clUsrApp")!= null)
     {
       StrclUsrApp = request.getParameter("clUsrApp").toString(); 
     } 
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     } 

    
    if (request.getParameter("Listado")!= null)
     {
       StrLista = request.getParameter("Listado").toString(); 
     } 
    StrclPaginaWeb = "648";   
    MyUtil.InicializaParametrosC(648,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
%>
<b><center><table><tr><td><font color='#423A9E'><b>Reporte de Expedientes en Trámite sin Intervención</b></font></td></tr></table></center></b>

    <%    StringBuffer StrSql = new StringBuffer();
        
            StrSql.append("Select convert(varchar(10),getdate(),111) 'Hoy' , convert(varchar(10),getdate()-15,111) 'Qdias' ");
                       
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());  
     if(rs.next()) {%>
        <br><font face="Arial" size="2" Color="#000033"><b>Fecha Hoy:</b> <%=rs.getString("Hoy")%></font>, 
        <font face="Arial" size="2" Color="#000033"><b>Fecha Quince días:</b> <%=rs.getString("Qdias")%></font><br>
        <%}
        rs = null;
        StrSql = null;
        %>
            
            
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:100px;'>
        <%StringBuffer strSalida1 = new StringBuffer();
          UtileriasBDF.rsTableNP("st_Estadistico_snTramite '" + StrclUsrApp + "'", strSalida1);
        %>        
        <%=strSalida1.toString()%>
        <%strSalida1.delete(0,strSalida1.length());
        strSalida1 = null;%>
        
  <%  if (StrLista.equalsIgnoreCase("1")) {%>


        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:115px;'>
        <%StringBuffer strSalida = new StringBuffer();
          UtileriasBDF.rsTableNP("st_Rpt_Exp_Tramite_snIntervencion '" + StrclUsrApp + "'", strSalida);
        %>        
        <%=strSalida.toString()%>
        <%strSalida.delete(0,strSalida.length());
        strSalida = null;%>
       
 <%
    }
    
     StrSql = null; 
     StrclUsrApp=null;
     StrclPaginaWeb=null;
     StrclExpediente=null;
%>  


</body>
</html>
