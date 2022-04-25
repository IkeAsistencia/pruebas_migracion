<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head><b><center><table><tr><td><font color='#423A9E'><b>LISTADO DE PERMISOS DE PáGINA POR GRUPO</b></font></td></tr></table></center></b> 
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<br><br>

<%  

    String StrclGpoUsr = "0";
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
    if (session.getAttribute("clGpoUsr")!= null)
     {
       StrclGpoUsr = session.getAttribute("clGpoUsr").toString(); 
     }  
    else  
     {      
       StrclGpoUsr = "1";
     }   

    String StrclPaginaWeb = "10";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);

    MyUtil.InicializaParametrosC(10,Integer.parseInt(StrclUsrApp));    // se checan permisos de consulta de la pag. LISTADO PAGINA x GRUPO para el "USUARIO"
    if (MyUtil.blnAccess[3] == false) {%> 
        No tiene permisos para consultar la página o su sesión ya caducó
        <%return; }
    
    StringBuffer StrSql = new StringBuffer();

    StrSql.append( "Select '<a href=DetallePaginaxGrupo.jsp?clPaginaWeb=' + convert(varchar(12),P.clPaginaWeb) + '&clGpoUsr=' + convert(varchar(12),A.clGpoUsr) + '>' + P.NombreLogicoWeb + '</a>' as Pagina, ");
    StrSql.append( " case A.Alta when 1 then 'SI' else 'NO' end as 'ALTA', ");
    StrSql.append( " case A.Baja when 1 then 'SI' else 'NO' end as 'BAJA', ");
    StrSql.append( " case A.Cambio when 1 then 'SI' else 'NO' end as 'CAMBIO', ");
    StrSql.append( " case A.Consulta when 1 then 'SI' else 'NO' end as 'CONSULTA' ");
    StrSql.append( " From AccesoGpoXPag A ");
    StrSql.append( " Inner Join cPaginaWeb P on A.clPaginaWeb = P.clPaginaWeb ");
    StrSql.append( " Where A.clGpoUsr =").append(StrclGpoUsr).append(" Order By P.NombreLogicoWeb ");
      %>
    <input type='button' id='btnNuevo' value='Nuevo' onClick='fnNuevo(<%=StrclGpoUsr%>)'</input>
        <% StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableNP( StrSql.toString(),strSalida);
        %>
        <%=strSalida.length()%>
        <%strSalida.delete(0,strSalida.length());
        strSalida = null;
        %>

    <%StrSql=null; %>
 <script>
    function fnNuevo(Grupo){
        location.href='DetallePaginaxGrupo.jsp?clGpoUsr=' + Grupo;
    }
 </script>

</body>
</html>
 