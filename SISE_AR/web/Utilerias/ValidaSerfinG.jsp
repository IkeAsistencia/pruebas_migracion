<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,com.ike.model.DAOSantanderR,com.ike.model.to.registrosantander" errorPage="" %>
<html>
    <head><title>Supervisión Serfin</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilGM.js'></script>
        <%   
            String StrclLlamadaTMK = "0";
            StringBuffer StrSql =  new StringBuffer();
            String StrclUsrApp="0";
            String StrclPaginaWeb="0";
            String StrNombreUsuario="";
            String StrCuenta ="";
            String StrClave ="";

            if (session.getAttribute("clUsrApp")!= null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>
        Fuera de Horario
        <% 
            return;
            }

            if (request.getParameter("Cuenta")!=null){
                StrCuenta = request.getParameter("Cuenta").toString();
            }

            if(request.getParameter("Clave")!=null){
                StrClave=request.getParameter("Clave").toString();
            }
           /* out.println(StrClave);
             out.println(StrCuenta);
            return;*/
            DAOSantanderR daos = new DAOSantanderR();
            registrosantander registrosantanderG =  daos.getRegistroS(StrCuenta,StrClave);
            if (registrosantanderG==null){
        %>
        <script>top.opener.fnSerfinReg(0,'','','','','')</script>
        <script>window.close()</script>
        <%
                } else {
                
            %>
            <script></script>
            <script>top.opener.fnSerfinReg(1,'<%=registrosantanderG.getFechIni().toString()%>','<%=registrosantanderG.getFechFin()%>','<%=registrosantanderG.getNombre()%>','<%=registrosantanderG.getCuenta()%>','<%=registrosantanderG.getNomCuenta()%>')</script>
            <script>window.close()</script>
        <%
            }
        %>

    </body>
</html>