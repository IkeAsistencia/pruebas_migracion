<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<%  
    String StrclUsrApp="0";
    String StrclExpediente="0";
    String StrclPaginaWeb="0";
  
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString();  
     }     
   
    %><script>fnCloseLinks(window.parent.frames.InfoRelacionada.height) </script><%
    //out.println("<script>fnCloseLinks(window.parent.frames.InfoRelacionada.height) </script>");	
    StrclPaginaWeb = "213";        
    MyUtil.InicializaParametrosC(213,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    
    if ( request.getParameter("StrSP")!= null && request.getParameter("StrSP")!= "")
        {
          if (request.getParameter("StrSP").length() > 1) {   //toma expediente solo si oprimieron botón de tomar
              UtileriasBDF.ejecutaSQLNP(request.getParameter("StrSP")) ;
	    %><script>window.open('../KM0/ImpresionExpEntrante.jsp?Expediente=<%=request.getParameter("Exped")%>&Proveedor=<%=request.getParameter("Provee")%>','newWin','scrollbars=yes,status=yes,width=800,height=560') </script>
        <%
          } 
        }       
     
        %>
        <form id='Forma' name ='Forma'  action='ExpedientesEntrantes.jsp?' method='get'>  
        <INPUT id='StrSP' name='StrSP' type='hidden' value=''>         
        <INPUT id='Provee' name='Provee' type='hidden' value=''>         
        <INPUT id='Exped' name='Exped' type='hidden' value=''>         
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <P align='left'><input type='button' value='Actualizar' onClick='document.all.Forma.submit();' class='cBtn'></input></p>
        <table class='Table' border='1'><tr class='TTable'><th>COLOR</th><td class='Blanco'></td><td class='Amarillo'></td><td class='Rojo'></td></tr>
        <tr class='TTable'><th>TIEMPO DE PUBLICACIÓN</th><th>0 a 2 min</th><th>3 a 4 min</th><th>4 en adelante</th></tr><tr></tr><tr></tr></table>
        <% StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableGRNP("sp_WebExpedientexAsig " + StrclUsrApp, strSalida);
        %>
        <%=strSalida.toString()%>
        <%strSalida.delete(0,strSalida.length()); 
          strSalida=null;
        %>
        </form><%
        
        StrclUsrApp=null; 
        StrclExpediente=null;
        StrclPaginaWeb=null;
        try{
          
        }catch(Exception e){
        }
    %>
<script>
function fnTomarExpediente(Exp,Prov,UsrPublico,UsrToma,FechaPub,TipoAsig)
{ 
    document.all.Provee.value=Prov;
    document.all.Exped.value=Exp;    
    document.all.StrSP.value='sp_WebTomaExpediente ' + Exp + ',' + Prov + ',' + UsrPublico + ',' + UsrToma + ',"' + FechaPub + '"' + ',' + TipoAsig;
    document.all.Forma.submit();
}    
</script>
</body>
</html>