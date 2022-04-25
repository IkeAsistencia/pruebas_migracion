<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%  
    	String strdsProvedor = "";
    	//String strclCuenta = "";
        StringBuffer strSql= new StringBuffer(); 
    
    

      	if (request.getParameter("dsProvedor")!= null)
      	{
             strdsProvedor = request.getParameter("dsProvedor").toString().trim();
        }  
        
        if (!strdsProvedor.equalsIgnoreCase("")){
            strSql.append("Select ltrim(rtrim(coalesce(NombreOpe,''))) NombreOpe, ltrim(rtrim(coalesce(clProveedor,0))) clProveedor ");
            strSql.append(" from cProveedor ");
            strSql.append(" where NombreOpe like '%").append(strdsProvedor).append("%'");
            strSql.append(" order by NombreOpe ");
            ResultSet rsProv = UtileriasBDF.rsSQLNP( strSql.toString());
            if(rsProv.next()){
                if(rsProv.isLast()){
                    %><script>top.opener.fnActualizaDatosProv('<%=rsProv.getString("NombreOpe")%>','<%=rsProv.getString("clProveedor")%>');window.close()</script>
                    <%
                    strSql.delete(0,strSql.length());
                    return;
                }
            }
            rsProv.close();
        }
        
        strSql.delete(0,strSql.length());
        if (request.getParameter("strSQL")!= null)
      	{
            strSql.append(request.getParameter("strSQL").toString()); 
            strSql.append(" '").append(strdsProvedor).append("'");
       	}

       	MyUtil.InicializaParametrosC(438,Integer.parseInt("1")); 

	%><form id='Forma' name ='Forma' action='FiltrosCuentaProv.jsp' method='get'>
	<input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaProvCorrec"></input>
        <%=MyUtil.ObjInput("Proveedor","dsProvedor",strdsProvedor,true,true,25,90,"",false,false,50)%>
        <P align='left'><input type='button' value='BUSCAR...' onClick='document.all.Forma.submit()' class='cBtn'></input></p>
	</form>
        <script>document.all.dsProvedor.readOnly=false;window.resizeTo(700,500);</script><br><br><br><br><br>
        <%
        if (strdsProvedor!="" && (strSql.length()>0)){
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