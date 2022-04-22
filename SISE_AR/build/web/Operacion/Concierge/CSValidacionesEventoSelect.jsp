<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
            String strclCiudad = "0";
            String strclExperiencia = "0";
            ResultSet rs = null;
            String strlocDisponibles = "";
            String strfechaini = "";
            String strfechafin = "";

            if (request.getParameter("clCiudad") != null) {
                strclCiudad = request.getParameter("clCiudad").toString();
            }

            if (request.getParameter("clEventoSelect") != null) {
                strclExperiencia = request.getParameter("clEventoSelect").toString();
            }
            
            System.out.println("sp_GetCSLocalidadesDispSAN " + strclExperiencia + "," + strclCiudad);
            
            rs = UtileriasBDF.rsSQLNP("sp_GetCSLocalidadesDispSAN " + strclExperiencia + "," + strclCiudad);
            if (rs.next()) {
                strlocDisponibles = rs.getString("locDisponibles");
                strfechaini = rs.getString("fechaini");
                strfechafin = rs.getString("fechafin");
        %>
        <script>top.opener.fnRecuperaLocalidades('<%=strlocDisponibles%>', '<%=strfechaini%>', '<%=strfechafin%>');
            window.close();</script>
        <%
            }
            rs.close();
            rs = null;
        %>
    </body>
</html>
