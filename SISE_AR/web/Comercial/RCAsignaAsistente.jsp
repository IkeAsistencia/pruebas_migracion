<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script src="../Utilerias/Util.js" ></script>
        <%  
            String strclReunion="0";
            String StrAsistentesElegidos="";
            String strclUsrAppSession="0";
            String StrAsignar="";

            if (session.getAttribute("clUsrApp")!=null)
            {
                strclUsrAppSession = session.getAttribute("clUsrApp").toString();
            }

            
            if (request.getParameter("Asignar")!= null) {
                StrAsignar = request.getParameter("Asignar").toString();
            }

            if (request.getParameter("Resultados")!= null) {
                StrAsistentesElegidos = request.getParameter("Resultados").toString();
            }

            if (request.getParameter("clReunion")!= null)
            {
                strclReunion= request.getParameter("clReunion").toString();
            }
            

            StringBuffer StrSql = new StringBuffer();

            StrSql.append("st_RCAsignarAsistenteReunion ").append(StrAsignar).append(",").append(strclReunion).append(",'").append(StrAsistentesElegidos).append("','").append(strclUsrAppSession).append("'");

            UtileriasBDF.ejecutaSQLNP(StrSql.toString());
            StrSql=null;
        %>
        <script>
        window.opener.fnRelocate('../Comercial/RCDetalleReunion.jsp?clReunion=<%=strclReunion%>');
        window.close();
        </script>
            
    </body>
</html>
        