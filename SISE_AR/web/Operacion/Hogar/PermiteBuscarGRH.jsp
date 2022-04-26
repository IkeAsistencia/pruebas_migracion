<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>PERMITE BUSQUEDA GUIA ROJI HOGAR</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<%
   String StrclUsrApp="0";
   String StrPermite="0";
   String StrclServicio="";
    
   if (session.getAttribute("clUsrApp")!= null)
   {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
   }  

   if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
   {
       
%>
       Fuera de Horario
<%
       StrclUsrApp=null;
       return;  
   }  
   String StrclExpediente = "0";   
   String StrCodEnt = " ";     
   String StrCodMD = " ";     
  
   if (session.getAttribute("clExpediente")!= null)
   {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
   }  

   StringBuffer StrSql = new StringBuffer();
   // Para obtener el CodEnt y Servicio del expediente
   StrSql.append(" Select ltrim(rtrim(E.CodEnt)) as CodEnt, ltrim(rtrim(E.CodMD)) as CodMD, E.clServicio, E.TieneAsistencia, ' ' + coalesce(SS.dsSubServicio,'') as dsSubServicio,  P.Tabla");
   StrSql.append(" From Expediente E");
   StrSql.append(" Inner Join cSubServicio SS ON (SS.clSubServicio=E.clSubServicio) ");
   StrSql.append(" Left Join cPaginaWeb P on (SS.clPaginaWeb = P.clPaginaWeb) ");
   StrSql.append(" Where E.clExpediente=").append(StrclExpediente);
    
   ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
   StrSql.delete(0,StrSql.length());
    
   if (rs2.next())
   { 
       StrCodEnt = rs2.getString("CodEnt"); 
       StrCodMD = rs2.getString("CodMD"); 
       StrclServicio = rs2.getString("clServicio");
       
       StrSql.append("SELECT sum(cast(G.BusqProvGuiaRyNormal as tinyint)) AS Permite ");
       StrSql.append(" FROM dbo.cGpoUsr G  ");
       StrSql.append(" INNER JOIN dbo.UsrxGpo UxG ON UxG.clGpoUsr = G.clGpoUsr ");
       StrSql.append(" INNER JOIN dbo.cUsrApp U ON UxG.clUsrApp = U.clUsrApp ");
       StrSql.append(" WHERE (UxG.clUsrApp = ").append(StrclUsrApp).append(") group by UxG.clUsrApp ");
        
       ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql.toString());
       StrSql.delete(0,StrSql.length());
       if (rs3.next())  
       {
           StrPermite=rs3.getString("Permite");
           if (Integer.parseInt(StrPermite) > 0 && (StrCodEnt.equals("DF") || (StrCodEnt.equals("MC") && (!StrCodMD.equalsIgnoreCase("00106") && !StrCodMD.equalsIgnoreCase("00054") ))))
           {
               // SI ES EDO DE MEX. OPCIONAL QUE PREGUNTE POR GUIA ROJI; SI ES DF y TIENE PERMISOS OPCIONAL POR GUIA ROJI
               %><center>
                <p class='FTable'>¿Buscar por Guía Roji, Asignación Manual<br></p>
                <table><tr><td class="TTable" width="200">Asignación Automática</td><td width="100" align="right">
                <IMG class='handM' alt='Guía Roji' SRC='../../Imagenes/guiaroji.gif' onClick='fnPorGuiaRoji();' WIDTH=70 HEIGHT=14>
                </td></tr><tr><td class="TTable" width="200">Asignación Manual</td><td width="100" align="right">
                <IMG class='handM' alt='Manual' SRC='../../Imagenes/handtool.gif' onClick='fnAsigManual();' WIDTH=20 HEIGHT=20>
                </td></tr>
                </table></center>
                <%
           }
           else
           {
%>
               <center>
               <p class='FTable'>Buscar por Asignación Manual o Publicación Foránea?<br></p>                   
               <table>
                   <tr>
                      <td class="TTable" width="200">Asignación Manual</td><td width="100" align="right">
                      <IMG class='handM' alt='Manual' SRC='../../Imagenes/handtool.gif' onClick='fnAsigManual();' WIDTH=20 HEIGHT=20>
                      </td>
                   </tr>
               </table>
               </center>
<%
           }
       }     
       rs3.close(); //USUARIO DEBE PERTENECER A UN GRUPO    
       rs3=null;
   }
   else
   {
%>
       El expediente no existe
<%
       return;       
   }
   rs2.close();
   rs2=null;
   StrclExpediente = null;   
   StrSql = null; 
   StrCodEnt = null;   
   StrclUsrApp=null;  
%>
<script>
function fnPorGuiaRoji(){
   location.href='../Hogar/FrameBuscarProvH.jsp?';
}

function fnAsigManual(){
   location.href='../../Utilerias/Lista.jsp?P=184&Apartado=S';
}

function fnPorPublicacion(){
   location.href='../KM0/FrameBuscaProvHogar.jsp?';
}

</script>
</body>
</html>