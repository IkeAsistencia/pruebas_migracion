<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%  
    	String strPaginaWeb = "";
    	String strclPaginaWeb = "";
        String strGpoUsr= "";
        StringBuffer strSql= new StringBuffer(); 
    
    

      	if (request.getParameter("Pagina")!= null) 
      	{
             strPaginaWeb = request.getParameter("Pagina").toString().trim();
        }  
        
      	if (request.getParameter("Grupo")!= null) 
      	{
             strGpoUsr = request.getParameter("Grupo").toString().trim();
        } 
        
        if (!strPaginaWeb.equalsIgnoreCase("")){
	strSql.append( " SELECT NombreLogicoWeb,clPaginaWeb");
	strSql.append( " FROM cPaginaWeb");
	strSql.append( " WHERE NombreLogicoWeb like '%").append(strPaginaWeb).append("%'");
        strSql.append( " and clPaginaWeb not in (select clPaginaWeb from AccesoGpoxPag where clGpoUsr='").append(strGpoUsr).append("')");
	strSql.append( " ORDER BY NombreLogicoWeb");

            ResultSet rsPagina = UtileriasBDF.rsSQLNP( strSql.toString());
            
            if(rsPagina.next()){
                if(rsPagina.isLast()){
                    %><script>top.opener.fnActualizaDatosPaginaWeb('<%=rsPagina.getString("NombreLogicoWeb")%>','<%=rsPagina.getString("clPaginaWeb")%>');window.close()</script>
                    <%
                    strSql.delete(0,strSql.length());
                    return;
                }
            }
            rsPagina.close();
        }
        
        strSql.delete(0,strSql.length());
        if (request.getParameter("strSQL")!= null)
      	{
            strSql.append(request.getParameter("strSQL").toString()); 
            strSql.append(" '").append(strPaginaWeb).append("','").append(strGpoUsr).append("'");
       	}

       	MyUtil.InicializaParametrosC(167,Integer.parseInt("1")); 

	%><form id='Forma' name ='Forma' action='FiltrosPaginaWeb.jsp' method='get'>
	<input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaPagina"></input>
        <input type='hidden' id='Grupo' name='Grupo' value='<%=strGpoUsr%>'></input>
        <%=MyUtil.ObjInput("Pagina","Pagina",strPaginaWeb,true,true,25,90,"",false,false,50)%>
        <P align='left'><input type='button' value='BUSCAR...' onClick='document.all.Forma.submit()' class='cBtn'></input></p>
	</form>
        <script>document.all.Pagina.readOnly=false;window.resizeTo(700,500);</script><br><br><br><br><br>
        <%
        if (strPaginaWeb!="" && (strSql.length()>0)){
            StringBuffer strSalida = new StringBuffer();
            UtileriasBDF.rsTableNP(strSql.toString(),strSalida);
            %>
               <%=strSalida.toString()%>
            <%
            strSalida.delete(0,strSalida.length());
        }
        
        strSql.delete(0,strSql.length());
        
%>

</body>
</html>