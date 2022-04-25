<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.asistencias.DAOExpediente,com.ike.asistencias.to.Expediente,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Cambio de cuentas</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
            String strclExpediente = "0";
            String strNombreCuenta = "";
            String strclCuenta = "0";
            String strclUsrApp = "0";

            if (request.getParameter("clExpediente") != null) {
                strclExpediente = request.getParameter("clExpediente").toString();
            }

            if (session.getAttribute("clUsrApp") != null) {
                strclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
        %>
        <b>Fuera de Horario</b>
        <%
                strclUsrApp = null;
                return;
            }


            DAOExpediente dAOExpediente = null;
            Expediente Expediente = null;


            if (strclExpediente.compareToIgnoreCase("0") != 0) {
                dAOExpediente = new DAOExpediente();
                Expediente = dAOExpediente.getExpediente(strclExpediente);
            }


            //strclExpediente = Expediente!=null ? String.valueOf(Expediente.getclExpediente()) : "0";
            strNombreCuenta = Expediente != null ? Expediente.getNombre() : "0";

            String StrclPaginaWeb = "619";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            MyUtil.InicializaParametrosC(619, Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
        %>
        <script>fnOpenLinks()</script>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.GuardaCambioCuenta", "")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CambioCuenta.jsp?'>"%>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsrApp%>'>
        <%=MyUtil.ObjInput("Expediente", "clExpediente", strclExpediente, false, true, 30, 80, strclExpediente, false, false, 11)%>
        <%=MyUtil.ObjInput("Cuenta a corregir", "clCuentaAnteriorVTR", strNombreCuenta, false, false, 120, 80, strNombreCuenta, false, false, 35)%>
        <%=MyUtil.ObjInput("Cuenta correcta", "NombreCuenta", "", true, false, 30, 125, "", true, false, 35, "if(this.readOnly==false){fnBuscaCuenta();}")%>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value=''>
        <%=MyUtil.DoBlock("INFORMACION ACTUAL", 10, 0)%>
        <%
        //    if (MyUtil.blnAccess[4]==true)
        //    {

        %>
        <div class='VTable' style='position:absolute; z-index:25; left:225px; top:135px;'>
            <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>
            <%
            //     }
            %>


        <%=MyUtil.GeneraScripts()%>

        <script>
            function fnBuscaCuenta()
            {
                if (document.all.NombreCuenta.value != '')
                {
                    if (document.all.Action.value == 1)
                    {
                        var pstrCadena = "../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                        pstrCadena = pstrCadena + "&Cuenta= " + document.all.NombreCuenta.value;
                        document.all.NombreCuenta.value = '';
                        window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                    }
                }
            }

            function fnActualizaDatosCuenta(dsCuenta, clCuenta)
            {
                document.all.NombreCuenta.value = dsCuenta;
                document.all.clCuenta.value = clCuenta;

            }
        </script>

    </body>
</html>

