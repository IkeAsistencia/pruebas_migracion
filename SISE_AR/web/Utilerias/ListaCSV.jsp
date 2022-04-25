<%@ page contentType="vnd.ms-excel" language="java" import="java.sql.ResultSet,Utilerias.UtileriasObj,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%
    String StrclUsrApp="0";
    
    
    response.setHeader("Content-Disposition","attachment; filename=\"reporte.csv\"");
    response.setHeader("Accept-Encoding","mod_gzip");
    
// attachment;filename=\"" + "test.csv" + "\"    
    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     } 
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<% return; 
     } 
     
    %>
    <%
    
    String clPaginaWeb="0";
    
    if (request.getParameter("P")!=null){
        clPaginaWeb=request.getParameter("P").toString();
    }
    
    if (request.getParameter("Apartado")==null && request.getParameter("Filtros")==null){
        %><script>fnCloseLinks() </script><%
    }
    
    session.setAttribute("clPaginaWeb",clPaginaWeb);
    
%>

<%

    StringBuffer StrSql = new StringBuffer();
    StringBuffer StrSqlSent = new StringBuffer();
    StrSql.append("sp_ObtenSentenciaRpt ").append(clPaginaWeb);
    
    ResultSet rs = null;
    StringBuffer strParamProc = new StringBuffer();
    String strTipoDato = "";
    String strTipoFiltro = "";
    String strCampoValor = "";
    try{
        rs = UtileriasBDF.rsSQLNP( StrSql.toString());		
        StrSql.delete(0,StrSql.length());
        
        if (rs.next()) {	
            StrSqlSent.append(rs.getString("SentenciaRPT"));
        }
        rs.close();
        rs=null;
    } catch(Exception e) {
        e.printStackTrace();
        return;
    }	

    try{
        rs = UtileriasBDF.rsSQLNP ("Select coalesce(cFiltrosWeb.CampoValor, FiltroxPagWeb.VarVal) CampoValor, coalesce(cFiltrosWeb.TipoDato, FiltroxPagWeb.TipoDato)  TipoDato, FiltroxPagWeb.TipoFiltro  from FiltroxPagWeb left join cFiltrosWeb on (cFiltrosWeb.clFiltroWeb = FiltroxPagWeb.clFiltroWeb) where FiltroxPagWeb.clPaginaWeb = " + clPaginaWeb + " order by Secuencia ");
        // Arma los parámetros de llamada al procedure de obtención de datos
        
        while(rs.next()){ 
            strCampoValor=rs.getString("CampoValor");
            
            if (strCampoValor==null){
                return;
            }

            if (strParamProc.toString().length() != 0){
                strParamProc.append(",");
            }
            
            strTipoDato = rs.getString("TipoDato");
            
            if (strTipoDato!=null){
                if (strTipoDato.equalsIgnoreCase("Texto")){
                    strParamProc.append("'");
                }
            }else{
                return;
            }
            
            strTipoFiltro = rs.getString("TipoFiltro");
            
            if (strTipoFiltro!=null){
                if(strTipoFiltro.equalsIgnoreCase("Session")){
                    if (session.getAttribute(strCampoValor)==null){
                       return;
                    }else{
                       strParamProc.append(session.getAttribute(strCampoValor).toString());
                    }
                }
            }else{
                return;
            }
            
            if(strTipoFiltro.equalsIgnoreCase("Post") || strTipoFiltro.equalsIgnoreCase("Get") ){
                if (request.getParameter(strCampoValor)==null){
                    if (strTipoDato.equalsIgnoreCase("Entero")){
                        strParamProc.append("0");
                    }
                } else{
                    if (request.getParameter(strCampoValor).toString().equalsIgnoreCase("")){
                        if (strTipoDato.equalsIgnoreCase("Entero")){
                            strParamProc.append("0") ;
                        }
                    } else{
                        strParamProc.append(request.getParameter(strCampoValor).toString());
                    }
                }   
            }
            
            if(strTipoFiltro.equalsIgnoreCase("Estatico")){
                strParamProc.append(strCampoValor);
            }
            
            if (strTipoDato.equalsIgnoreCase("Texto")){
                strParamProc.append("'");
            }
        }
        rs.close();
        rs=null;
    }catch(Exception e){
      e.printStackTrace();
      return;
    }System.out.println("Pagina:" + clPaginaWeb + " " + StrSqlSent.toString() + " " + strParamProc.toString());
    StringBuffer strCadena=new StringBuffer();
    
    UtileriasBDF.rsCSVCNP (StrSqlSent.toString() + "  " + strParamProc.toString(),strCadena);
    %>
    <%=strCadena.toString()%><%
    StrSql.delete(0,StrSql.length());
    strCadena.delete(0,strCadena.length());
    StrSqlSent.delete(0,StrSqlSent.length());
    strParamProc.delete(0,strParamProc.length());
/*	
//echo $row[1]." ".$strParamProc;
$usuariobit = $HTTP_SESSION_VARS['clUsrApp'];
$rowBitIni = $SEACN->Execute("sp_InsertaBitacoraWeb " . $HTTP_SESSION_VARS["clPaginaWeb"] . ",\"" .  $row[1]." ".$strParamProc . "\"," . $usuariobit . ", 0");
$rowBitacora = mssql_fetch_row($rowBitIni);

$SEACN->Execute($row[1]." ".$strParamProc);
echo "<strong>Registros Encontrados: ".mssql_num_rows($SEACN->consulta_ID)."<br></strong>";
if ($SEACN->fnVerificaAccessPag(basename($HTTP_SERVER_VARS['PHP_SELF'])."?T=".$SEACN->clPaginaWeb, "alta",$HTTP_SESSION_VARS["clUsrApp"])==1){
	echo "<td align='left' colspan = '6'><img  class='cssMouseOverptr'  src='Imagenes/Botones/btnNuevo.jpg' onClick=\"top.document.all.contenido.src='".$row[3]."?".$clParam."=0".$clParam2."'\"></img></td>";
}
if (mssql_num_rows($SEACN->consulta_ID) ==0) {
$SEACN->Execute("sp_InsertaBitacoraWeb " . $HTTP_SESSION_VARS["clPaginaWeb"] . ",\"" .  $row[1]." ".$strParamProc . "\"," . $usuariobit . "," . $rowBitacora[0] );
exit;
}
//$SEACN->fnQueryToTable($row[2]);
$SEACN->fnQueryToTable($row[2],1,20,80,70,300);

/*            $rs =  $SEACN->Execute("sp_WebrptExpedientesEnTramite '01/01/2001','31/10/2001',1,0,14,1053" );
            $SEACN->fnQueryToTable("Reporte &nbsp de &nbsp Expedientes &nbsp en &nbsp Tramite (Siniestralidad por Estado/Municipio)");
			break;

            $rs =  $SEACN->Execute("sp_WebrptExpedientesEnTramite '01/01/2001','31/10/2001',1,1797,0,0" );
            $SEACN->fnQueryToTable("Reporte &nbsp de &nbsp Expedientes &nbsp en &nbsp Tramite (Siniestralidad por Proveedor)");
			break;
			*/

 //$rs =  $SEACN->Execute("sp_WebrptExpedientesEnTramite '".$FechaInicio."','".$FechaFin."'," .$HTTP_SESSION_VARS["clUsrApp"] );
/*$SEACN->Execute("sp_InsertaBitacoraWeb " . $HTTP_SESSION_VARS["clPaginaWeb"] . ",\"" .  $row[1]." ".$strParamProc . "\"," . $usuariobit . "," . $rowBitacora[0] );
$SEACN->closeCN() ;

?>
*/
%>


