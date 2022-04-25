<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><b><center><table><tr><td><font color='#423A9E'><b>LISTADO DE CAMPOS EXTRA POR CUENTA</b></font></td></tr></table></center></b> 
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<br><br>

<%  

    String StrclCuenta = "0";
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
    if (session.getAttribute("clCuenta")!= null)
     {
       StrclCuenta = session.getAttribute("clCuenta").toString(); 
     }  
    else  
     {      
       StrclCuenta = "1";
     }

    String StrclPaginaWeb = "14";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);

    MyUtil.InicializaParametrosC( 14,Integer.parseInt(StrclUsrApp));    // se checan permisos de consulta de la pag. LISTADO CAMPOS EXTRA para el "USUARIO"
    if (MyUtil.blnAccess[3] == false) { %><%="No tiene permisos para consultar la página o su sesión ya caducó"%><% return; }
  StringBuffer StrSql1 = new StringBuffer();
StrSql1.append( "Select '<a href=CamposExtraxCuenta.jsp?clCampoExtra=' + convert(varchar(12),CxC.clCampoExtra) + '&clCuenta=' + convert(varchar(12),CxC.clCuenta) + '>' + E.Nombre + '</a>' as Campo, ");
StrSql1.append( " C.Nombre  as ' Cuenta ', ");
StrSql1.append( " Obj.TipoObjeto as ' Tipo de Objeto ', ");
StrSql1.append( " Cam.TipoCampo as ' Tipo del Campo ', ");    
StrSql1.append( " E.Longitud as ' Longitud' ");
StrSql1.append( " From CampoExtraxCuenta CxC  ");
StrSql1.append( " Inner Join cCampoExtra E on (E.clCampoExtra=CxC.clCampoExtra) ");
StrSql1.append( " Inner Join cCuenta C on (C.clCuenta = CxC.clCuenta) ");
StrSql1.append( " Inner Join cTipoObjeto Obj on (Obj.clTipoObjeto = E.clTipoObjeto) ");
StrSql1.append( " Inner Join cTipoCampo Cam on (Cam.clTipoCampo = E.clTipoCampo) ");
StrSql1.append( " Where CxC.clCuenta =").append(StrclCuenta).append(" Order By E.Nombre");

        %>
    <input type='button' id='btnNuevo' value='Nuevo' onClick='fnNuevo(<%=StrclCuenta %>)'</input>
    <%
    StringBuffer strSalida = new StringBuffer();
    UtileriasBDF.rsTableNP(StrSql1.toString(), strSalida);
%><%=strSalida.toString()%>
    <%
     strSalida.delete(0,strSalida.length());
     StrSql1.delete(0,StrSql1.length());
    
     StrSql1 =null;
     strSalida=null;
     StrclCuenta= null;
     StrclPaginaWeb= null;
     StrclUsrApp= null;
     
    %>
 <script>
    function fnNuevo(Cuenta){
        location.href='CamposExtraxCuenta.jsp?clCuenta=' + Cuenta;
    }
 </script>

</body>
</html>
 