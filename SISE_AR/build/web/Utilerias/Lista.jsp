<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="UtlHash.Pagina,UtlHash.Filtro,java.util.List,java.sql.ResultSet,UtlHash.LoadPagina,Utilerias.UtileriasObj,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<script src='Util.js'></script>

<%
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     } 
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<% return; 
     } 
     
    %><body class='cssBody' topmargin='25'><%
    
    String clPaginaWeb="0";
    
    if (request.getParameter("P")!=null){
        clPaginaWeb=request.getParameter("P").toString();
    }
    else{
        %>Falta Informar Página (Consulte a su administrador)<% 
        StrclUsrApp=null;
        clPaginaWeb=null;
        return; 
    }
    
    if (request.getParameter("Apartado")==null && request.getParameter("Filtros")==null){
        %><script>fnCloseLinks() </script><%
    }
    
    session.setAttribute("clPaginaWeb",clPaginaWeb);
    
%>

<%

    StringBuffer StrSql = new StringBuffer();
    StringBuffer StrSqlSent = new StringBuffer();
    Filtro  FiltroI =null;

    Pagina PaginaI=LoadPagina.getPagina(clPaginaWeb);
    
    ResultSet rs = null;
    StringBuffer strSalida = new StringBuffer();

    StringBuffer strParamProc = new StringBuffer();
        %><b><center><table><tr><td><font color='#423A9E'><b><%=PaginaI.getStrTituloRPT()%></b></font></td></tr></table></center></b>
        <%
        StrSqlSent.append(PaginaI.getStrSentenciaRPT());
    //Valida si tiene permisos de Alta para la Pagina de Detalle
    try{
        StrSql.append("select AxP.clPaginaWeb, case when sum(cast(AxP.Alta as tinyint)) > 0 then 1 else 0 end Alta, PW.NombrePaginaWeb ");
        StrSql.append("from AccesoGpoxPag AxP ");
        StrSql.append("inner join UsrxGpo UxG on (AxP.clGpoUsr = UxG.clGpoUsr) ");
        StrSql.append("inner join cPaginaWeb PW on (PW.clPaginaWeb = AxP.clPaginaWeb) ");
        StrSql.append("inner join (select PD.clPaginaWeb, PD.PaginaDetalle ");
        StrSql.append("            from cPaginaWeb PD ");
        StrSql.append("            Where PD.clPaginaWeb = ").append(clPaginaWeb).append(") ConsPags ON PW.NombrePaginaWeb = ConsPags.PaginaDetalle ");
        StrSql.append(" where UxG.clUsrApp = ").append(StrclUsrApp).append(" group by AxP.clPaginaWeb, PW.NombrePaginaWeb");
        rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        %><input class='cBtn' type='button' value='Buscar' onClick="window.open('Filtros.jsp','','resizable=yes,menubar=0,status=0,toolbar=0,height=250,width=250,screenX=0,screenY=0')"></input>
        <%
        if (rs.next()){
                if (rs.getInt("Alta")==1){%>
                    <input class='cBtn' type='button' value='Nuevo' onClick="top.document.all.Contenido.src='<%=rs.getString("NombrePaginaWeb")%>'"></input><br><br>
                <%
                }
                else{
                    %><br><br><%
                }
        }else{
            %><br><br><%
        }
        rs.close(); 
        rs=null;

        List lstFiltros = null;
        lstFiltros = PaginaI.getLstFiltros();
        if (lstFiltros !=null){
  
          int x=0;
          int xR = 1;
          for(x=0; x<lstFiltros.size(); x++, xR++)
          {
              FiltroI = (Filtro)lstFiltros.get(x);
              
              if (FiltroI.getStrVarVal().compareToIgnoreCase("")==0){
                  return;
              }
              
              if (strParamProc.toString().length() != 0){
                  strParamProc.append(",");
              }
              
              if (FiltroI.getStrTipoDato().compareToIgnoreCase("")!=0){
                  if (FiltroI.getStrTipoDato().equalsIgnoreCase("Texto")){
                      strParamProc.append("'");
                  }
              }else{
                  return;
              }
              
              if (FiltroI.getStrTipoGet().compareToIgnoreCase("")!=0){
                  if(FiltroI.getStrTipoGet().compareToIgnoreCase("Session")==0){
                      if (session.getAttribute(FiltroI.getStrVarVal())==null){
                         return;
                      }else{
                         strParamProc.append(session.getAttribute(FiltroI.getStrVarVal()).toString());
                      }
                  }
              }else{
                  return;
              }
              
              if(FiltroI.getStrTipoGet().equalsIgnoreCase("Post") || FiltroI.getStrTipoGet().equalsIgnoreCase("Get") ){
                  if (request.getParameter(FiltroI.getStrVarVal())==null){
                      if (FiltroI.getStrTipoDato().equalsIgnoreCase("Entero")){
                          strParamProc.append("0");
                      }
                  } else{
                      if (request.getParameter(FiltroI.getStrVarVal()).toString().equalsIgnoreCase("")){
                          if (FiltroI.getStrTipoDato().equalsIgnoreCase("Entero")){
                              strParamProc.append("0") ;
                          }
                      } else{
                          strParamProc.append(request.getParameter(FiltroI.getStrVarVal()).toString());
                      }
                  }   
              }
              
              if(FiltroI.getStrTipoGet().equalsIgnoreCase("Estatico")){
                  strParamProc.append(FiltroI.getStrVarVal());
              }
              
              if (FiltroI.getStrTipoDato().equalsIgnoreCase("Texto")){
                  strParamProc.append("'");
              }
          }
        }
        StrSqlSent.append(" ").append(strParamProc);
        System.out.print("Pagina:" + clPaginaWeb);
        System.out.println(StrSqlSent);
        
        %>
        <%
        //UtileriasBDF.rsTableC(con, StrSqlSent.toString(), strSalida);
        %><%=strSalida.toString()%><%
        StrclUsrApp=null;
        clPaginaWeb=null;      
        strSalida.delete(0,strSalida.length());
        StrSql.delete(0,StrSql.length());
        StrSqlSent.delete(0,StrSqlSent.length());
        strParamProc.delete(0,strParamProc.length());
        strSalida=null;
        strParamProc=null;
        StrSqlSent=null;
        StrSql=null;
        FiltroI=null;    
        PaginaI=null;    

    }catch(Exception e){
      e.printStackTrace();
      StrclUsrApp=null;
      clPaginaWeb=null;      
      StrSql.delete(0,StrSql.length());
      StrSqlSent.delete(0,StrSqlSent.length());
      StrSql=null;
      StrSqlSent=null;
      PaginaI=null;
      strSalida.delete(0,strSalida.length());
      strSalida=null;
      strParamProc.delete(0,strParamProc.length());
      StrSql=null;
      StrSqlSent=null;
      strParamProc=null;
      PaginaI=null;
      FiltroI=null;
      return;
    }
    
	    try{        
        
      }catch(Exception ee){
      }
%>
</body>
</html>


