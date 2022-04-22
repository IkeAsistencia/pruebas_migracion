<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

<%  
    	String strFolioAfianzadora = "0"; 
    
    

        StringBuffer StrSql = new StringBuffer();
       	StrSql.append("Select convert(varchar(10), FxA.FechaExpedicion,120) FechaExpedicion");
       	StrSql.append(" from FolioxAfianzadora FxA ");
       	StrSql.append(" where FxA.clFolioAfianzadora =").append(strFolioAfianzadora);
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());

      	if (request.getParameter("clFolioAfianzadora")!= null)
      	{
             strFolioAfianzadora = request.getParameter("clFolioAfianzadora").toString().trim();
        }  
        
        StrSql.append("Select convert(varchar(10), FxA.FechaExpedicion,120) FechaExpedicion ");
        StrSql.append(" from FolioxAfianzadora FxA ");
        StrSql.append(" where FxA.clFolioAfianzadora = ").append(strFolioAfianzadora);
        rs.close();
        rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());        

        if(rs.next()){
           %><script>top.opener.fnActualizaDatFianza('<%=rs.getString("FechaExpedicion")%>');window.close()</script><%
        }
        else{
           %><script>window.close()</script><%
        }
        rs.close();   
        rs=null;
        
        StrSql=null;
        strFolioAfianzadora=null;
%>

</body>
</html>


