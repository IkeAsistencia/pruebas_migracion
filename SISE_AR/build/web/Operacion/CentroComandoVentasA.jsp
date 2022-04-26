<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Centro de Comando</title>
<meta http-equiv="refresh" content= "20; url=CentroComandoVentasA.jsp"> 
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body topmargin=80 leftmargin=0 class="cssBody">
<div style='position:absolute; z-index:50; left:0px; top:0px;'><img src="../Imagenes/EncabezadoLogoIke.jpg"></img></div>
<%  
    StringBuffer StrSql = new StringBuffer(); 
    String pTipoInfo ="2";
    
    String StrclUsrApp="1";
    String StrclPaginaWeb="0";
    String StrFecha="";
    
    
/*
    if (request.getParameter("Tipo")!=null){
      if (request.getParameter("Tipo").compareToIgnoreCase("")!=0){
        pTipoInfo=request.getParameter("Tipo");
      }
    }
    */
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

 /*   if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     { */
       %><!--Fuera de Horario--><%
 /*      return;  
     }    */
     StringBuffer strSalida = new StringBuffer();
    // if (pTipoInfo.compareToIgnoreCase("2")==0){
        // AMBULANCIAS
        
        StringBuffer StrSql2 = new StringBuffer();

        
       	StrSql2.append("set language spanish select  datename(weekday,getdate()) + ' ' + datename(d,getdate()) + ' de '+ datename(month,getdate()) + ' de '+ convert(varchar,year(getdate())) 'FechaHoy'");
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql2.toString());
        StrSql2.delete(0,StrSql2.length());
        
         if (rs.next()) { 
            StrFecha = rs.getString("FechaHoy");
       }
       %>
<div style='position:absolute; z-index:51; left:250px; top:0px;'>
  <table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Ventas por Clientes</td>
    </tr>
  </table>
</div>
       
       <!--   <div class='VTable' style='position:absolute; z-index:25; left:10px; top:120px;'>
            <table><tr><td><input class='cBtnPlasma' value='Cerrar...' onClick='top.window.close()' type='button'></input>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 >
                    <td class="R2TablePlasma">Asignación</td>
                    <td>0 a 5</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>6 a 10</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 11</td><td width=30 class="cssPlasmaRojo"></td>
                    <td width="100"></td>
                    <td class="R2TablePlasma">Contacto</td>
                    <td>0 a 15</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>16 a 20</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 21</td><td width=30 class="cssPlasmaRojo"></td>
                    </tr>
                </tr>
              </table>
              </td></tr></table></div>
         -->
              <div class='VTable' style='position:absolute; z-index:25; left:10px; top:170px;'>
             <%
              // Expedientes sin asignación
              StrSql.delete(0,StrSql.length());
              StrSql.append("exec TMK_AR.dbo.st_VentasxCliente");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),50,"Ventas al día de hoy "+ StrFecha,strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

             
      //}%>
     <%
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);  
    try{
    
    }catch(Exception e){
    }
    
 %> </div>
</body>
</html>

