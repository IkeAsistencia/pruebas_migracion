<%@ page contentType="text/html;charset=windows-1252" import="java.sql.ResultSet,Utilerias.UtileriasObj,Utilerias.UtileriasBDF,Seguridad.SeguridadC"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>untitled</title>
  </head>
  <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
  <body class='cssBody'>

<%
    String StrclUsrApp="0";
    String StrCorreo="";
    
    

    if (session.getAttribute("Correo")!= null){
        StrCorreo = session.getAttribute("Correo").toString(); 
     } 
     
     if(StrCorreo.compareToIgnoreCase("")==0){
     %>
      <p class='cssTitDet'>No tiene cuenta de correo configurada, debe configurarla haciendo click al botón de Correo en sus datos generales</p>     
     <%
      return;
     }
    
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
    }
    StrSql.delete(0,StrSql.length());
    StrSql.append("set quoted_identifier off set dateformat mdy Insert into HDMailRptMonitor (SentenciaSQL, clUsrApp, clPaginaWeb) values(");
    StrSql.append("\"").append(StrSqlSent.toString()).append("  ").append(strParamProc.toString()).append(", 0 \"");
    StrSql.append(",").append(StrclUsrApp).append(",").append(clPaginaWeb).append(")");
    UtileriasBDF.ejecutaSQLNP(StrSql.toString());
    
    StrSql.delete(0,StrSql.length());
    StrSqlSent.delete(0,StrSqlSent.length());
    strParamProc.delete(0,strParamProc.length());
    if (rs!=null){
      rs.close();
      rs=null;
    }
        
%>
  <SCRIPT>alert('Su archivo de reporte será enviado a la cuenta de correo: <%=StrCorreo%>');
    location.href='../servlet/Utilerias.Lista?P=509'</script>
  </body>
</html>


