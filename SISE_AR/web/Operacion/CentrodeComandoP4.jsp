<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Centro de Comando</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body topmargin=80 leftmargin=0 class="cssBody">
<div style='position:absolute; z-index:50; left:0px; top:0px;'><img src="../Imagenes/EncabezadoLogoIke.jpg"></img></div>
<%  
    StringBuffer StrSql = new StringBuffer(); 
    String pTipoInfo ="1";
    
    String StrclUsrApp="1";
    String StrclPaginaWeb="0";
    
    

    if (request.getParameter("Tipo")!=null){
      if (request.getParameter("Tipo").compareToIgnoreCase("")!=0){
        pTipoInfo=request.getParameter("Tipo");
      }
    }
    
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
     if (pTipoInfo.compareToIgnoreCase("1")==0){
        // SERVICIOS VIALES
       %>
<div style='position:absolute; z-index:51; left:200px; top:0px;'>
  <table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Asistencia Vial</td>
    </tr>
  </table>
</div>

            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:830px;'>
            <table><tr><td><input class='cBtnPlasma' value='Cerrar...' onClick='top.window.close()' type='button'></input>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 ><tr>
                    <td class="R2TablePlasma">Asignación Carretero</td>
                    <td>0 a 15</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>16 a 20</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 20</td><td width=30 class="cssPlasmaRojo"></td>
                    </tr>
<!--                 <tr>
                   <td class="R2TablePlasma">Asignación No Carretero</td>
                    <td>0 a 7</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>8 a 10</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 10</td><td width=30 class="cssPlasmaRojo"></td>
                </tr> -->
              </table>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 ><tr>
                    <td class="R2TablePlasma">Contacto Carretero</td>
                    <td>0 a 60</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>61 a 90</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 91</td><td width=30 class="cssPlasmaRojo"></td>
                    </tr>
 <!--                <tr>
                    <td class="R2TablePlasma">Contacto No Carretero</td>
                    <td>0 a 45</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>46 a 60</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 61</td><td width=30 class="cssPlasmaRojo"></td>
                </tr>  -->
              </table>
              </td></tr></table></div>
             <%
              // Expedientes sin asignación
              StrSql.append("sp_PlasmaExpSinProvxServicioPru 1");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Asignación de Proveedor",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              // Expedientes sin asignación
              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaAsisAbSPMonitPru 1");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Contacto",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaCitasSinContacto 1");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Citas Sin Contacto (vs Fecha Programada) ",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              pTipoInfo = "8";
      }
     else  if (pTipoInfo.compareToIgnoreCase("8")==0){
        // SERVICIOS VIALES
       %>
<div style='position:absolute; z-index:51; left:200px; top:0px;'>
  <table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Asistencia Vial</td>
    </tr>
  </table>
</div>

            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:830px;'>
            <table><tr><td><input class='cBtnPlasma' value='Cerrar...' onClick='top.window.close()' type='button'></input>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 > <!-- <tr>
                    <td class="R2TablePlasma">Asignación Carretero</td>
                    <td>0 a 15</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>16 a 20</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 20</td><td width=30 class="cssPlasmaRojo"></td>
                    </tr> -->
                <tr>
                    <td class="R2TablePlasma">Asignación No Carretero</td>
                    <td>0 a 7</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>8 a 10</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 10</td><td width=30 class="cssPlasmaRojo"></td>
                </tr>
              </table>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 > <!-- <tr>
                    <td class="R2TablePlasma">Contacto Carretero</td>
                    <td>0 a 60</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>61 a 90</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 91</td><td width=30 class="cssPlasmaRojo"></td>
                    </tr> -->
                <tr>
                    <td class="R2TablePlasma">Contacto No Carretero</td>
                    <td>0 a 45</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>46 a 60</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 61</td><td width=30 class="cssPlasmaRojo"></td>
                </tr>
              </table>
              </td></tr></table></div>
             <%
              // Expedientes sin asignación
              StrSql.append("sp_PlasmaExpSinProvxServicioPru 8");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Asignación de Proveedor",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              // Expedientes sin asignación
              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaAsisAbSPMonitPru 8");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Contacto",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaCitasSinContacto 8");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Citas Sin Contacto (vs Fecha Programada) ",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              pTipoInfo = "1";
      }
     
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);  
    try{
    
    }catch(Exception e){
    }
    
 %>
</body>
</html>

