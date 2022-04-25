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
    String pTipoInfo ="2";
    
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

  /*  if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {*/
       %><!--Fuera de Horario--><%
   /*    return;  
     }    */
     StringBuffer strSalida = new StringBuffer();

      if (pTipoInfo.compareToIgnoreCase("2")==0){
              // SERVICIOS MEDICOS
       %>
<div style='position:absolute; z-index:51; left:200px; top:0px;'>
  <table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Asistencia Médica</td>
    </tr>
  </table>
</div>
       
          <div class='VTable' style='position:absolute; z-index:25; left:10px; top:830px;'>
            <table><tr><td><input class='cBtnPlasma' value='Cerrar...' onClick='top.window.close()' type='button'></input>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 ><tr>
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
              </table>
              </td></tr></table></div>
             <%
              // Expedientes sin asignación
              StrSql.append("sp_PlasmaExpSinProvxServicio 2");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Asignación de Proveedor",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              // Expedientes sin asignación
              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaAsisAbSPMonit 2");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Contacto",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaCitasSinContacto 2");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Citas Sin Contacto (vs Fecha Programada) ",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              pTipoInfo = "3";
             
      }
      else if (pTipoInfo.compareToIgnoreCase("3")==0){
            // SERVICIOS VIAJES
       %>
<div style='position:absolute; z-index:51; left:200px; top:0px;'>
  <table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Asistencia en Viajes</td>
    </tr>
  </table>
</div>

            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:830px;'>
            <table><tr><td><input class='cBtnPlasma' value='Cerrar...' onClick='top.window.close()' type='button'></input>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 ><tr>
                    <td class="R2TablePlasma">Asignación</td>
                    <td>10 a 12</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>13 a 15</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 15</td><td width=30 class="cssPlasmaRojo"></td>
                   
                    <td width="100"></td>
                    
                    <td class="R2TablePlasma">Contacto</td>
                    <td>0 a 45</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>46 a 60</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 61</td><td width=30 class="cssPlasmaRojo"></td>

                </tr>
              </table>
              </td></tr></table></td></div>
             <%
              // Expedientes sin asignación
              StrSql.append("sp_PlasmaExpSinProvxServicio 3");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Asignación de Proveedor",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              // Expedientes sin asignación
              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaAsisAbSPMonit 3");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Contacto",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaCitasSinContacto 3");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Citas Sin Contacto (vs Fecha Programada) ",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());

              pTipoInfo = "4";

      }
     
    else  if (pTipoInfo.compareToIgnoreCase("4")==0){
            // SERVICIOS LEGAL
     %>
     
<div style='position:absolute; z-index:51; left:200px; top:0px;'>
  <table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Asistencia Legal</td>
    </tr>
  </table>
</div>

            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:830px;'>
            <table><tr><td><input class='cBtnPlasma' value='Cerrar...' onClick='top.window.close()' type='button'></input>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 ><tr>
                    <td class="R2TablePlasma">Asignación</td>
                    <td>10 a 12</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>13 a 15</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 15</td><td width=30 class="cssPlasmaRojo"></td>

                    <td width="100"></td>
                    <td class="R2TablePlasma">Contacto</td>
                    <td>0 a 45</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>46 a 60</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 61</td><td width=30 class="cssPlasmaRojo"></td>

                </tr>
              </table>
              </td></tr></table> </div>
         <%
        
         // Expedientes sin asignación
          StrSql.append("sp_PlasmaExpSinProvxServicio 4");
          %>
          <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Asignación de Proveedor",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

          // Expedientes sin asignación
          StrSql.delete(0,StrSql.length());
          StrSql.append("sp_PlasmaAsisAbSPMonit 4");
          %>
          <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Contacto",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

          // Expedientes sin asignación
          StrSql.delete(0,StrSql.length());
          StrSql.append("sp_RptPlasmaPersonaDetenida ");
          %>
          <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Detenidos (últimas 24 hrs)",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

          StrSql.delete(0,StrSql.length());
          StrSql.append("sp_PlasmaCitasSinContactoNoAHP4 4");
          %>
          <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Citas Sin Contacto (vs Fecha Programada) ",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

          StrSql.delete(0,StrSql.length());
          pTipoInfo = "5";

      }
      else if (pTipoInfo.compareToIgnoreCase("5")==0){
            // SERVICIOS HOGAR
       %>
       
<div style='position:absolute; z-index:51; left:200px; top:0px;'>
  <table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Asistencia Hogar</td>
    </tr>
  </table>
</div>

            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:830px;'>
            <table><tr><td><input class='cBtnPlasma' value='Cerrar...' onClick='top.window.close()' type='button'></input>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 ><tr>
                    <td class="R2TablePlasma">Asignación</td>
                    <td>10 a 12</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>13 a 15</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 15</td><td width=30 class="cssPlasmaRojo"></td>
                    <td width="100"></td>
                    <td class="R2TablePlasma">Contacto</td>
                    <td>0 a 45</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>46 a 60</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 61</td><td width=30 class="cssPlasmaRojo"></td>
                </tr>
              </table>
              </td></tr></table></div>
             <%
              // Expedientes sin asignación
              StrSql.append("sp_PlasmaExpSinProvxServicio 5");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Asignación de Proveedor",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              // Expedientes sin asignación
              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaAsisAbSPMonit 5");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Contacto",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaCitasSinContacto 5");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Citas Sin Contacto (vs Fecha Programada) ",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              pTipoInfo = "6";
      }
      else if (pTipoInfo.compareToIgnoreCase("6")==0){
        // SERVICIOS COLISIÓN
       %>
       
<div style='position:absolute; z-index:51; left:200px; top:0px;'>
  <table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Grúas por Colisión</td>
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
                <tr>
                    <td class="R2TablePlasma">Asignación No Carretero</td>
                    <td>0 a 7</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>8 a 10</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 10</td><td width=30 class="cssPlasmaRojo"></td>
                    </tr>

              </table>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 ><tr>
                    <td class="R2TablePlasma">Contacto Carretero</td>
                    <td>0 a 60</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>61 a 90</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 91</td><td width=30 class="cssPlasmaRojo"></td>
                    </tr>
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
              StrSql.append("sp_PlasmaExpSinProvxServicio 6");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Asignación de Proveedor",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              // Expedientes sin asignación
              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaAsisAbSPMonit 6");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Contacto",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaCitasSinContactoNoAHP4 6");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Citas Sin Contacto (vs Fecha Programada) ",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              pTipoInfo = "7";
      }
      else if (pTipoInfo.compareToIgnoreCase("7")==0){
        // SERVICIOS AJUSTE
       %>
       
<div style='position:absolute; z-index:51; left:200px; top:0px;'>
  <table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Ajustadores</td>
    </tr>
  </table>
</div>

          <div class='VTable' style='position:absolute; z-index:25; left:10px; top:830px;'>
            <table><tr><td><input class='cBtnPlasma' value='Cerrar...' onClick='top.window.close()' type='button'></input>
            </td><td>
             <TABLE cellspacing=5 cellpadding=0 ><tr>
                    <td class="R2TablePlasma">Asignación</td>
                    <td>10 a 12</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>13 a 15</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 15</td><td width=30 class="cssPlasmaRojo"></td>
                    <td width="100"></td>
                    <td class="R2TablePlasma">Contacto</td>
                    <td>0 a 45</td><td width=30 class="cssPlasmaVerde"></td>
                    <td>46 a 60</td><td width=30 class="cssPlasmaAmarillo"></td>
                    <td>> 61</td><td width=30 class="cssPlasmaRojo"></td>
                </tr>
              </table>
              </td></tr></table>
              </div>
             <%
              // Expedientes sin asignación
              StrSql.append("sp_PlasmaExpSinProvxServicio 7");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Asignación de Proveedor",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              // Expedientes sin asignación
              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaAsisAbSPMonit 7");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Sin Contacto",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              StrSql.append("sp_PlasmaCitasSinContactoNoAHP4 7");
              %>
              <%UtileriasBDF.rsTablePlasmaNP(StrSql.toString(),5,"Citas Sin Contacto (vs Fecha Programada) ",strSalida);%>
              <%=strSalida.toString()%>
             <%
              strSalida.delete(0,strSalida.length());

              StrSql.delete(0,StrSql.length());
              pTipoInfo = "2";
      }
     
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    try{
    
    }catch(Exception e){
    }
    
 %>
</body>
</html>

