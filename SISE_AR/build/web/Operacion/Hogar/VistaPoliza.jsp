<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head><title></title></head>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<body class="cssBody">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
<script src='Util.js'></script>
<%
    String strClave = request.getParameter("Clave").trim();
    
    StringBuffer StrSql = new StringBuffer();
    
    

    StrSql.append(" Select replace(convert(varchar(800),AI.Referencia),'|','-') as Referencia from cAfiliadoBMX A");
    StrSql.append(" inner join AfiliadoInfoAdicionalBMX AI on (A.clAfiliado=AI.clAfiliado)");
    StrSql.append(" where Clave='").append(strClave).append("'");
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
    %><table width='600px' class='cssTitDet'><tr><td>Poliza</td></tr></table>
    <TABLE width='600' Border=1 Class='vTable'>
    <%
    if(rs.next()){
        %>
    <TR><TD><%=rs.getString("Referencia").replaceAll("-","<br>")%></TD></TR>
        <%
    }else{
        %>
        <TR><TD>No existe Poliza para esta Clave</TD></TR>
        <%
    }
    rs.close();
    rs = null;
    
    %></table>
</body>
</html>

