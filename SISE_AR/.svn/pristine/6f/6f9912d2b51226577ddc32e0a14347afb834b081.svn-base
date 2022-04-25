<%@page contentType="text/html; charset=iso-8859-1" import="Seguridad.SeguridadC"%>
<html>
    <head>
        <script src='Utilerias/Util.js' ></script>
    </head>
    <body>
        <%
            String StrclPaginaWeb = "6107";
            String clExpediente = "0";
            clExpediente = request.getParameter("clExpediente").toString();
			String strclUsrApp = "0";
			
			if (session.getAttribute("clUsrApp") != null) {
                strclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            session.setAttribute("clExpediente", clExpediente);
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
			session.setAttribute("clUsrApp", strclUsrApp);
			
			if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
				out.println("Fuera de Horario");
				return;
			}
        %>
        <script>fnOpenLinks()</script>
        <script>
                top.document.all.DatosExpediente.src = "DatosExpediente.jsp?" +<%=clExpediente%>;
                top.document.all.rightPO.rows = "70,*";
				fnRelocate('servlet/Utilerias.Lista?P=187&Apartado=S');
        </script>

    </body>
</html>

