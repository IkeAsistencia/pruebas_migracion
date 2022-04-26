<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title> 
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody" onLoad="fnSumaMonto();">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script>
top.document.all.rightPO.rows="70,*";
</script>
<%

    String StrclUsrApp="0";
    String StrclExpediente="0";
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     } 
    else if (request.getParameter("clUsrApp")!= null)
     {
       StrclUsrApp = request.getParameter("clUsrApp").toString(); 
     } 
    
    if (request.getParameter("clExpediente")!= null)
     {
       StrclExpediente = request.getParameter("clExpediente").toString(); 
     } 
//    StrclPaginaWeb = "592";        
//    MyUtil.InicializaParametrosC(592,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
//    session.setAttribute("clPaginaWebP",StrclPaginaWeb); %>

        <form id='Forma' name ='Forma'  action='CarritoAcumulador.jsp?' method='post'>  
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <P align='left'>  
        </div>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:50px;'>
        <%StringBuffer strSalida = new StringBuffer();
          UtileriasBDF.rsTableNP("st_CarritoVentaAcumulador '" + StrclExpediente + "','" + StrclUsrApp + "'", strSalida);
        %>        
        <%=strSalida.toString()%>
        <%strSalida.delete(0,strSalida.length());
        strSalida = null;%>
        
        
        <%
        StringBuffer StrSql = new StringBuffer();
        
            StrSql.append("st_TotalVentaAcumulador '" + StrclExpediente + "'");
            
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());
        if(rs.next()) {
%>
     <%    String StrTieneAsistencia =  rs.getString("TieneAsistencia");
           if (StrTieneAsistencia.equalsIgnoreCase("0")){
        %>
        <input type='button' value='Agregar' onClick='if (parent.InfoVenta.document.all.Action.value==1){fnVentanaLlenaventa(<%=StrclExpediente%>,<%=StrclUsrApp%>)}' class='cBtn'></input>
      <%      }
        } %> 
        <%String strTotal = rs.getString("Total");%>         
        <br><br><br>
        <p align='right'><font class='VTable'>Monto Total: </font>
        <input type='text' class='VTable' label='Total' name="Monto" id="Monto" value="<%=strTotal%>" readonly></input>  
        
        </p>
        </form>        
 <%
     rs.close();
     rs=null;
     StrSql = null; 
     StrclUsrApp=null;
     StrclExpediente=null;
%>  

<script>
function fnVentanaLlenaventa(clExpediente,clUsrApp)
   {
        window.open('LlenaVenta.jsp?clExpediente=' + clExpediente + '&clUsrApp=' + clUsrApp, 'LlenaVenta' ,'scrolling=yes, width= 820 ,height= 150'); 
   }
   
function fnSumaMonto(){
    
    parent.InfoVenta.document.forma.Monto.value = document.all.Monto.value;
}
</script> 
</body>
</html>
