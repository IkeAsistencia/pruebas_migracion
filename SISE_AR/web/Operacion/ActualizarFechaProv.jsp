<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%> 
<html>
    <head>
        <title>Actualización de Fecha</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilMask.js'></script>
        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrclProveedor = "0";
            String StrclTipo = "0";
            String StrActualizar = "0";
            StringBuffer StrSql = new StringBuffer();
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                StrclUsrApp = null;
                StrclExpediente = null;
                //String StrclPaginaWeb = "0";
                StrclProveedor = null;
                StrclTipo = null;
                StrActualizar = null;
                return;
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            if (request.getParameter("clProveedor") != null) {
                StrclProveedor = request.getParameter("clProveedor").toString();
            }
            if (request.getParameter("clTipo") != null) {
                StrclTipo = request.getParameter("clTipo").toString();
            }
            if (request.getParameter("Actualizar") != null) {
                StrActualizar = request.getParameter("Actualizar").toString();
            }
            if (request.getParameter("StrSql") != null) {
                StrSql.append(request.getParameter("StrSql").toString());
            }
            String modo = (request.getParameter("MODO")!=null?request.getParameter("MODO"):"");
            String sTEC = (request.getParameter("Tiempo")!=null?request.getParameter("Tiempo"):"");
            System.out.println("StrActualizar:" + StrActualizar);
            System.out.println("StrSql:" + StrSql);
            ResultSet rs = null;

            if (StrActualizar.equals("1") || StrActualizar.equals("2") || StrActualizar.equals("3") || StrActualizar.equals("4")) {
                rs = UtileriasBDF.rsSQLNP( StrSql.toString());
                if (rs.next()) {
                    if (rs.getString("Res").equalsIgnoreCase("0")) {
                        //Enviar a Asignacion Directa Vial si corresponde.
                        %><script type="text/javascript" >alert("<%=rs.getString("msg").toString()%>");<%
                        if ("GEOVIAL".equalsIgnoreCase(modo) && !"0".equals(sTEC) ) {
                            System.out.println("VIENE POR GEOVIAL");
                            %>
                            sUrl = "../api/v1/asignacionDirecta/enviaGeoVial.jsp?";
                            sUrl = sUrl + '&expediente=' + <%=StrclExpediente%>;
                            sUrl = sUrl + '&proveedor='    + <%=StrclProveedor%>;
                            sUrl = sUrl + '&TEC='  + <%=sTEC%> ;
                            sUrl = sUrl + '&usr='  + <%=StrclUsrApp%>;
                            WMap = window.open(sUrl, 'MapManager', 'modal=yes,resizable=yes,menubar=0,status=0,toolbar=0,height=200,width=300,screenX=1,screenY=1');
                            <%
                        }
                        %>
                        location.href = '../servlet/Utilerias.Lista?P=187&Apartado=S';</script>
                    <% } else {%>
                        <script type="text/javascript" > location.href = '../servlet/Utilerias.Lista?P=187&Apartado=S';</script>
                    <% }
                    rs.close();
                }
                rs = null;
            }
            StrSql.delete(0, StrSql.length());
            StrSql.append(" st_ValidaFechasProveedor '").append(StrclExpediente).append("','").append(StrclProveedor).append("','").append(StrclTipo).append("'");
            //System.out.println(StrSql);
            rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            if (rs.next()) {
        %>

        <form name='form' action='../Operacion/ActualizarFechaProv.jsp?Actualizar=<%=StrclTipo%>' method='post'>
            <input id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <input id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <input id='StrSql' name='StrSql' type='hidden' value='<%=StrSql.toString()%>'>
            <input id='MODO' name='MODO' type='hidden' value=''>
            

            <% if (StrclTipo.equals("1")) {%>
            <input id='FechaAnt' name='FechaAnt' type='hidden' value='<%=rs.getString("FechaLlegada")%>'>
            <table>
                <tr><td class='cssTitDet'>Fecha de Llegada</td></tr>
                <tr><td class='FTable'><input id='FechaNueva' name = 'FechaNueva' value='<%=rs.getString("FechaLlegada")%>' onblur='if (this.readOnly == false) {
                            fnValMask(this, document.all.FechaMsk.value, this.name)
                        }'></td><tr>
                <tr><td class='FTable'><input class='cBtn' VALUE='Actualizar' type='button' onclick='fnSubmit(1,<%=StrclUsrApp%>);'><input class='cBtn' VALUE='Cancelar' type='button' onclick='fnCancelar();' ></td><td class='FTable'>
            </table>
            <% }%>

            <% if (StrclTipo.equals("2")) {%>
            <input id='FechaAnt' name='FechaAnt' type='hidden' value='<%=rs.getString("FechaContacto")%>'>
            <table>
                <tr><td class='cssTitDet'>Fecha de Contacto</td></tr>
                <tr><td class='FTable'><input id='FechaNueva' name = 'FechaNueva' value='<%=rs.getString("FechaContacto")%>' onblur='if (this.readOnly == false) {
                            fnValMask(this, document.all.FechaMsk.value, this.name)
                        }'></td><tr>
                <tr><td class='FTable'><input class='cBtn' VALUE='Actualizar' type='button' onclick='fnSubmit(2,<%=StrclUsrApp%>);'><input class='cBtn' VALUE='Cancelar' type='button' onclick='fnCancelar();' ></td><td class='FTable'>
            </table>
            <% }%>

            <% if (StrclTipo.equals("3")) {%>
            <input id='FechaAnt' name='FechaAnt' type='hidden' value='<%=rs.getString("FechaTerminoP")%>'>
            <table>
                <tr><td class='cssTitDet'>Fecha de Término</td></tr>
                <tr><td class='FTable'><input id='FechaNueva' name = 'FechaNueva' value='<%=rs.getString("FechaTerminoP")%>' onblur='if (this.readOnly == false) {
                            fnValMask(this, document.all.FechaMsk.value, this.name)
                        }'></td><tr>
                <tr><td class='FTable'><input class='cBtn' VALUE='Actualizar' type='button' onclick='fnSubmit(3,<%=StrclUsrApp%>);'><input class='cBtn' VALUE='Cancelar' type='button' onclick='fnCancelar();' ></td><td class='FTable'>
            </table>
            <% }%>

            <% if (StrclTipo.equals("4")) {%>
            <table>
                <tr><td class='cssTitDet'>Tiempo Estimado de Contacto (en minutos)</td></tr>
                <tr><td class='FTable'><input id='Tiempo' name = 'Tiempo' value='<%=rs.getString("TiempoEstContacto")%>'></td><tr>
                <tr><td class='FTable'><input class='cBtn' VALUE='Guardar' type='button' onclick='fnSubmit(4,<%=StrclUsrApp%>);'><input class='cBtn' VALUE='Cancelar' type='button' onclick='fnCancelar();' ></td><td class='FTable'>
            </table>
            <% }%>
        </form>
        <% }
            rs.close();
            rs = null;
            StrclExpediente = null;

            StrSql.delete(0, StrSql.length());
            //StrclPaginaWeb = null;
            StrclProveedor = null;
            StrclTipo = null;
            StrActualizar = null;
        %>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <script type="text/javascript" >
            function fnSubmit(Tipo, StrclUsrApp) {
                form.MODO.value = parent.frames['DatosExpediente'].datos.modo.value;
                var tmpModo;
                if  (parent.frames['DatosExpediente'].datos.modo.value == 'GEOVIAL' || parent.frames['DatosExpediente'].datos.modo.value == 'GEOHOGAR')
                    tmpModo = "," + form.MODO.value;
                else
                    tmpModo = "";
        
                var StrSql;
                if (Tipo == 4) {
                    StrSql = " st_ActTiempoProv " + Tipo + "," + document.all.Tiempo.value + "," + document.all.clExpediente.value + "," + document.all.clProveedor.value + "," + StrclUsrApp + tmpModo;
                } else {
                    StrSql = " sp_ActFechaProv " + Tipo + ",'" + document.all.FechaNueva.value + "'," + document.all.clExpediente.value + "," + document.all.clProveedor.value + ",'" + document.all.FechaAnt.value + "'," + StrclUsrApp;
                }
                //alert('query: '+StrSql);
                document.all.StrSql.value = StrSql;
                document.all.form.submit();
            }

            function fnCancelar() {
                location.href = '../Utilerias/Lista.jsp?P=187&Apartado=S';
            }
        </script>
    </body>
</html>