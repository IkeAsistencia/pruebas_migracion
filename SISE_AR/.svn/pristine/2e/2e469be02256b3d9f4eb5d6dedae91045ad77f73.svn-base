<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 

        <script src='../../Utilerias/Util.js' ></script>
        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrEnvio = "0";
            String StrclPaginaWeb = "0";



            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            StrclPaginaWeb = "185";
            MyUtil.InicializaParametrosC(185, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            if (request.getParameter("Envio") != null && request.getParameter("Envio") != "") {
                StrEnvio = request.getParameter("Envio").toString().trim();
                //StrSql = " Update EnvioGuiaRoji Set Estatus = 3, FechaToma = getdate(), clUsrAppToma =" + StrclUsrApp + " Where clEnvio = " + StrEnvio;
                UtileriasBDF.ejecutaSQLNP(" Update EnvioGuiaRoji Set Estatus = 3, FechaToma = getdate(), clUsrAppToma =" + StrclUsrApp + " Where clEnvio = " + StrEnvio);
            }

            StringBuffer StrSql = new StringBuffer();
            // Obteniendo los envíos ya realizados para ese Expediente
            StrSql.append(" SELECT '<input type=\"button\" class=\"cBtn\" value=\"CANCELA\" name=\"Env\" onClick=\"fnCancelaEnvio(' + convert(varchar(12),Env.clEnvio) + ');\"></input>' as 'Cancela Envio',");
            StrSql.append(" Env.clEnvio as Envio, P.NombreRZ AS Proveedor, coalesce(convert(varchar(20), AAP.FechaPub,120),'') as 'Fecha de Publicación', coalesce(AAP.Observaciones,'') as Observaciones ");
            StrSql.append(" FROM EnvioGuiaRoji Env INNER JOIN AsigAutProv AAP ON Env.clEnvio = AAP.clEnvio ");
            StrSql.append(" INNER JOIN cProveedor P ON AAP.clProveedor = P.clProveedor ");
            StrSql.append(" WHERE Env.Estatus = 1 AND Env.clExpediente =").append(StrclExpediente).append(" ORDER BY AAP.FechaPub");
        %>
        <form  id='Forma' name ='Forma' action='CancelaEnvio.jsp?' method='get'>
            <INPUT id='Envio' name='Envio' type='hidden' value=''>
            <div class='VTable' style='position:absolute; z-index:25; left:2px; top:10px;'>
                <%   StringBuffer strSalida = new StringBuffer();
                    UtileriasBDF.rsTableNP(StrSql.toString(), strSalida);
                %>
                <%=strSalida.toString()%>
                <% strSalida.delete(0, strSalida.length());%>

        </form>
        <%
            StrSql.delete(0, StrSql.length());
            StrSql = null;
            StrclUsrApp = null;
            StrclExpediente = null;
            StrEnvio = null;
            StrclPaginaWeb = null;

        %>
        <script>
            function fnCancelaEnvio(iEnvio)
            {
                document.all.Envio.value = iEnvio;
                document.all.Forma.submit();
            }
        </script>
    </body>
</html>