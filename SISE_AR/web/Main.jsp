<%@ page import="Utilerias.UtileriasBDF,java.sql.ResultSet,Seguridad.SeguridadC" %>
<html>
    <head>
        <title>.: SISE Argentina :.</title>
        <meta http-equiv="Content-Type">
        <link rel="shortcut icon" href="Imagenes/IkeIcon.ico" type="image/x-icon"/>
    </head>
    <%
        String StrclUsrApp = "0";
        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();        }
        if(SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
            %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
            StrclUsrApp=null;
            return;
            } 
        String strFinalizaSession = "";
        String ValidaSessionR = "";
        String ValidaSessionS = "0";
        if (session.getAttribute("clUsrApp") == null) {
            StrclUsrApp = request.getParameter("clUsr");
        } else {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();     }
        ResultSet rsFs = null;
        rsFs = UtileriasBDF.rsSQLNP("sp_FinalizaSession " + StrclUsrApp);
        if (rsFs.next()) {
            strFinalizaSession = rsFs.getString("onunload");        }
        rsFs.close();
        rsFs = null;
        if (session.getAttribute("ValidaSessionR") != null) {
            ValidaSessionR = session.getAttribute("ValidaSessionR").toString();
            session.removeAttribute("ValidaSessionR");
        }
        if (session.getAttribute("ValidaSessionS") != null) {
            ValidaSessionS = session.getAttribute("ValidaSessionS").toString();     }
        if (!ValidaSessionR.equals(ValidaSessionS)) {
            String redirectURL = request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1);
            response.sendRedirect(redirectURL);
        } else {
    %>
    <!-- CAMBIAR POR IFRAME -->
    <frameset framespacing='0' noresize frameborder='no' id='topm' rows='70,*' <%=strFinalizaSession%>>
        <frame frameborder='no' name='encabezado' noresize id='encabezado' src='FrameEncabezado.jsp' scrolling='no'/>
        <frameset framespacing='0' noresize frameborder='no' id='topPO' cols='17%,*,10%' >
            <frameset framespacing='0' noresize frameborder='no' id='leftPO' rows='80,*,0'>
                <frame frameborder='no' scrolling='no' name='DatosUsuario' noresize id='DatosUsuario' src='DatosUsuario.jsp' />
                <frame frameborder='no' name='Menu' noresize id='Menu' src='Menu.jsp' />
                <frame frameborder='no' name='InfoRelacionada' noresize id='InfoRelacionada' src='InfoRelacionada.jsp?Load=0' />
            </frameset>
            <frameset framespacing='0' noresize frameborder='no' id='rightPO' rows='70,*'>            
                <frame  frameborder='no' scrolling='auto' name='DatosExpediente' noresize id='DatosExpediente' src='DatosExpediente.jsp?Load=0' ></frame>
                <frame frameborder='no' name='Contenido' noresize id='Contenido' src='Bienvenido.jsp' ></frame>
            </frameset>
            <frameset framespacing='0' noresize frameborder='no' id='rightPO2' scrolling='no'>
                <frame frameborder='no' name='AlertaCostos' noresize id='Servicios' scrolling='no' src='AlertaCostos.jsp' ></frame>           
            </frameset>
        </frameset>
    </frameset>
    <% }%>
</html>