<%-- 
    Document   : CSObtenInfoExp
    Created on : 1/12/2009, 06:09:11 PM
    Author     : rfernandez
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>

<html>
    <head>
        <title>Gerar Referência</title>        
    </head> 
    <body>
        <%
        String StrclConcierge = "0";
        String StrclReferencia = "0";
        String StrclUsrApp = "0";

        if(session.getAttribute("clConcierge") != null){
            StrclConcierge = session.getAttribute("clConcierge").toString();
        }

        if(session.getAttribute("clUsrApp") != null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        StringBuffer Strsql = new StringBuffer();
        Strsql.append("st_CSGeneraReferencia '").append(StrclConcierge).append("','").append(StrclUsrApp).append("'");
        ResultSet rs = UtileriasBDF.rsSQLNP(Strsql.toString());

        while(rs.next()){
            if(rs.getString("CodError").equalsIgnoreCase("0")){
                StrclReferencia = rs.getString("clReferencia").toString();
                Strsql = Strsql.delete(0, Strsql.length());
                session.setAttribute("clRReferencias",StrclReferencia);
                %><script>opener.location.href=('../../Operacion/Referencias/ModuloReferencias.jsp');</script><%
            }
        }

        StrclConcierge = null;
        StrclReferencia = null;
        StrclUsrApp = null;
        rs.close();
        rs = null;
        Strsql = null;
        %>
        <script>
           window.close();
        </script>
    </body>
</html>