<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%  
    	String strFechaActual = "0";

    
    

        StringBuffer strSql= new StringBuffer();
        strSql.append("Select convert(varchar(16),getdate(),120) Fecha");
        
        ResultSet rs = UtileriasBDF.rsSQLNP( strSql.toString());
                
        if (rs.next()){
            strFechaActual = rs.getString("Fecha");%>
            <script>top.opener.fnActualizaFechaActual('<%=strFechaActual%>');window.close();</script>
             <%}else{%>
            Error al Actuializar Fecha
        <%}
        
        strSql.delete(0,strSql.length());
        rs.close();
        rs=null;
        
%>
</body>
</html>