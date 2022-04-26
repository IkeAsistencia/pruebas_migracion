<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.concierge.DAOConciergeAltaNU,com.ike.concierge.Conciergealtanu,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>

<html>
    <head>
        <title>CAMBIOS CONCIERGE</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onLoad="">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilStore.js'></script>
        <%
            String StrclConcierge = "0";
            String strclUsrApp = "0";
            String strNuestroUsuario = "";
            String strClave = "";
            String strclCuenta = "";

            if (request.getParameter("clConcierge") != null) {
                StrclConcierge = request.getParameter("clConcierge").toString();
            } else {
                if (session.getAttribute("clConcierge") != null) {
                    StrclConcierge = session.getAttribute("clConcierge").toString();
                }
            }

            ResultSet rs = UtileriasBDF.rsSQLNP("st_InfoDatosConcierge '" + StrclConcierge + "'");

            if (rs.next()) {
                strNuestroUsuario = rs.getString("NuestroUsuario");
                strClave = rs.getString("Clave");
                strclCuenta = rs.getString("clCuenta");
            }

            rs.close();
            rs = null;

            if (session.getAttribute("clUsrApp") != null) {
                strclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
        %><b>Fuera de Horario</b><%
                strclUsrApp = null;
                return;
            }

            DAOConciergeAltaNU daos = null;
            Conciergealtanu conciergealtanu = null;

            if (StrclConcierge.compareToIgnoreCase("0") != 0) {
                daos = new DAOConciergeAltaNU();
                conciergealtanu = daos.getConciergeNU(StrclConcierge);
            }

            String StrclPaginaWeb = "1261";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
            String Store = "";
            Store = "st_nohay,st_CSGuardaCambioDatos";
            session.setAttribute("sp_Stores", Store);

            String Commit = "";
            Commit = "clConcierge";
            session.setAttribute("Commit", Commit);
        %>

        <script>fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(1261, Integer.parseInt(strclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "", "fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CSActualizaDatos.jsp?"%>'>

        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden"  VALUE="">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden"  VALUE="clConcierge,NuestroUsuario,Clave,clCuenta,clUsrApp">
        <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=strclUsrApp%>" >
        <input id="clConcierge" name="clConcierge" type="hidden" value="<%=StrclConcierge%>" >
        <input id="NuestroUsuario" name="NuestroUsuario" type="hidden" value="<%=strNuestroUsuario%>">
        <input id="Clave" name="Clave" type="hidden" value="<%=strClave%>">
        <input id="clCuenta" name="clCuenta" type="hidden" value="<%=strclCuenta%>">
        <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>">

        <%=MyUtil.ObjInput("Nombre a Corregir", "NuestroUsuarioA", strNuestroUsuario, false, false, 30, 80, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Clave a Cambiar", "ClaveA", strClave, false, false, 310, 80, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Cuenta a Cambiar", "clCuentaA", strclCuenta, false, false, 450, 80, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Nombre Correcto", "NuestroUsuarioN", "", true, true, 30, 130, "", false, false, 50, "fnActualizaDatos(this.id,this.value);")%>
        <%=MyUtil.ObjInput("Clave Correcta", "ClaveN", "", true, true, 310, 130, "", false, false, 20, "fnActualizaDatos(this.id,this.value);")%>
        <%=MyUtil.ObjInput("Cuenta", "NombreVTR", "", true, true, 450, 130, "", false, false, 40, "if(this.readOnly==false){fnBuscaCuenta();}")%>
        <INPUT id='clCuentaN' name='clCuentaN' type='hidden' value="<%=conciergealtanu != null ? conciergealtanu.getClCuenta().trim() : ""%>">

        <%
            if (MyUtil.blnAccess[4] == true) {
        %><div class='VTable' style='position:absolute; z-index:25; left:650px; top:145px;'>
            <IMG SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>
            <%}%>
            <%=MyUtil.DoBlock("CAMBIO DE DATOS CONCIERGE", 40, 0)%>

        <%=MyUtil.GeneraScripts()%>

        <%
            StrclPaginaWeb = null;
            strclUsrApp = null;
        %>

        <script>
            fnLlenaCamposDefault();
            //if action=2;
            //document.all.NuestroUsuarioVTR.value = document.all.NuestroUsuario.value;

            function fnBuscaCuenta() {
                if (document.all.NombreVTR.value != '') {
                    if (document.all.Action.value == 2) {
                        var pstrCadena = "../../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                        pstrCadena = pstrCadena + "&Cuenta= " + document.all.NombreVTR.value;
                        document.all.clCuentaN.value = '';
                        window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                    }
                }
            }

            function fnActualizaDatosCuenta(dsCuenta, clCuenta) {
                document.all.NombreVTR.value = dsCuenta;
                document.all.clCuentaN.value = clCuenta;
                //alert(document.all.clCuenta.value);
                document.all.clCuenta.value = clCuenta;
            }

            function fnActualizaDatos() {
                if (document.all.NuestroUsuarioN.value != '') {
                    document.all.NuestroUsuario.value = document.all.NuestroUsuarioN.value;
                } else {
                    document.all.NuestroUsuario.value = document.all.NuestroUsuarioA.value;
                }

                if (document.all.ClaveN.value != '') {
                    document.all.Clave.value = document.all.ClaveN.value;
                } else {
                    document.all.Clave.value = document.all.ClaveA.value;
                }
            }

            function fnLlenaCamposDefault() {

                document.all.clCuenta.value = document.all.clCuentaA.value
                document.all.NuestroUsuario.value = document.all.NuestroUsuarioA.value
                document.all.Clave.value = document.all.ClaveA.value
            }

        </script>
    </body>
</html>
