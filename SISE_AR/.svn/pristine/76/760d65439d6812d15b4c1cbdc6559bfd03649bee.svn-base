<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%  
    	String strNombreOpe = "";
    	String strclProveedor = "";
        StringBuffer strSql= new StringBuffer();
    
    

      	if (request.getParameter("NombreOpe")!= null)
      	{
             strNombreOpe = request.getParameter("NombreOpe").toString().trim();
        }  
        
        if (!strclProveedor.equalsIgnoreCase("")){
            strSql.append("Select P.clProveedor, P.NombreOpe ");
            strSql.append(" from cProveedor P ");
            strSql.append(" where P.NombreOpe like '%").append(strNombreOpe).append("%'");
            
            ResultSet rsProveedor= UtileriasBDF.rsSQLNP( strSql.toString());
            if(rsProveedor.next()){
                if(rsProveedor.isLast()){
                    %><script>top.opener.fnActualizaProv(<%=rsProveedor.getString("clProveedor")%>,'<%=rsProveedor.getString("NombreOpe")%>');window.close()</script>
                    <%
                    return;
                }
            }
            rsProveedor.close();
            rsProveedor=null;
        }
        
        strSql.delete(0,strSql.length());
        
        if (request.getParameter("strSQL")!= null)
      	{
            strSql.append(request.getParameter("strSQL").toString()).append(" '").append(strNombreOpe).append("'");
       	}  
        
       	MyUtil.InicializaParametrosC(283,Integer.parseInt("1")); 

	%><form id='Forma' name ='Forma' action='FiltrosProv.jsp' method='get'>
	<input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaProv"></input>
        <%=MyUtil.ObjInput("NombreOpe","NombreOpe",strNombreOpe,true,true,25,90,"",false,false,50)%>
        <P align='left'><input type='button' value='BUSCAR...' onClick='document.all.Forma.submit()' class='cBtn'></input></p>
	</form>
        <script>document.all.NombreOpe.readOnly=false;window.resizeTo(700,500);</script><br><br><br><br><br>
<%
        StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableNP(strSql.toString(),strSalida);
        %>
           <%=strSalida.toString()%>
        <%
        strSalida.delete(0,strSalida.length());
        strSql.delete(0,strSql.length());
%>

</body>
</html>

