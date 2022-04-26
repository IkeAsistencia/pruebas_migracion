<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Actualiza Fecha Proveedor</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <%
            StringBuffer StrSql = new StringBuffer();
            String StrclUsrApp = "0";
            String StrProveedor = "0";
            String StrclExpediente = "0";
            String StrCentro = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (request.getParameter("Proveedor") != null) {
                StrProveedor = request.getParameter("Proveedor").toString().trim();
            }

            if (request.getParameter("Centro") != null) {
                StrCentro = request.getParameter("Centro").toString().trim();
            }

            String sModo = (request.getParameter("modo")!=null?request.getParameter("modo"):null);
            int iModo = ( request.getParameter("modo") != null? ( "GEOVIAL".equalsIgnoreCase(sModo )?1: 0 ): 0 );
            if ( sModo!=null)  {
                System.out.println("Se Crea MODO en Session: " + sModo);
                session.setAttribute("MODO", sModo );
            }else{            
              
                session.removeAttribute("MODO");

            }
            
            if (StrProveedor != "0") {
                UtileriasBDF.ejecutaSQLNP("sp_AsignaProveedor '" + StrclUsrApp + "', " + StrclExpediente + ", " + StrProveedor + ", '', '" +StrCentro + "', " + iModo + ",'" + sModo + "'");
            %>
                <script>
                    location.href = '<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=187&Apartado=S';
                </script>
            <%
            }
            StrSql.delete(0, StrSql.length());
            StrclUsrApp = null;
            StrProveedor = null;
            StrclExpediente = null;
        %>
    </body>
</html>
