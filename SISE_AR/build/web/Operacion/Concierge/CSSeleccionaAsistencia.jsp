<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <%
        String StrclSubservicio = "0";
        String StrclAsistencia = "0";
        String StrclConcierge="0";
        String StrdsServicio = "";
        String StrdsSubServicio = "";
        String strclUsr = "0";
        StringBuffer StrSql = new StringBuffer();
        
        
        
        
        if (session.getAttribute("clUsrApp")!= null){
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if (request.getParameter("clAsistencia")!= null){
            StrclAsistencia= request.getParameter("clAsistencia").toString();
        }
        if (request.getParameter("clConcierge")!= null){
            StrclConcierge= request.getParameter("clConcierge").toString();
        }
        if (request.getParameter("clSubservicio")!= null) {
            StrclSubservicio= request.getParameter("clSubservicio").toString();
        } else{
            if (session.getAttribute("clSubservicio")!= null) {
                StrclSubservicio= session.getAttribute("clSubservicio").toString();
            }
        }
        
        String StrclPaginaWeb = "711";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        session.setAttribute("clConcierge",StrclConcierge);
        %><SCRIPT>fnOpenLinks()</script><%
        
        MyUtil.InicializaParametrosC(711,Integer.parseInt(strclUsr));
        
        StrSql.append("st_CSBuscaPagAsis ").append(StrclSubservicio);
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0, StrSql.length());
        
        if (rs.next()) {
        %>     
        <script>location.href='../../<%=rs.getString("DirPagina")%>clSubservicio=<%=StrclSubservicio%>&clAsistencia=<%=StrclAsistencia%>';</script>
        <%
        } else{
        %>
        <script>
        alert("El Evento no tiene Pagina Configurada, Favor de consultar a su Administrador")
        </script>
        <%
        }
        rs.close();
        rs=null;
        
        %>
        
    </body>
</html>

   