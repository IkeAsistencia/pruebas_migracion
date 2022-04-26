<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script src="../Utilerias/Util.js" ></script>
        <%  
            String StrclAsistente="";
            String strclReunion="0";
            String strclUsrAppSession="0";
            
            if (request.getParameter("clReunion")!= null) {
                strclReunion = request.getParameter("clReunion").toString();
            }
            
            if (request.getParameter("clAsistente")!= null) {
                StrclAsistente = request.getParameter("clAsistente").toString();
            }

            if (session.getAttribute("clUsrApp")!= null) {
                strclUsrAppSession = session.getAttribute("clUsrApp").toString();
            }
            
            StringBuffer StrSql = new StringBuffer();

            //StrSql.append("delete from rcasistentesike where clAsistente=").append(StrclAsistente);
            StrSql.append("st_RCAsignarAsistenteReunion ").append("0").append(",").append(strclReunion).append(",'").append(StrclAsistente).append("','").append(strclUsrAppSession).append("'");
            
            UtileriasBDF.ejecutaSQLNP(StrSql.toString());
            StrSql=null;
        %>
        <script>
            location.href='RCDetalleReunion.jsp?clReunion=<%=strclReunion%>';
        </script>
    </body>
</html>
        