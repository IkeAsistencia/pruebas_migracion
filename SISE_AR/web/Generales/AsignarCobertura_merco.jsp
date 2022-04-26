<%@page contentType="text/html; charset=iso-8859-1" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" %>
<html>
    <head>
        <title>Asignación de Coberturas</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
    <style type="text/css">
        .elimina {color:white;
                  background-color:#FE7018;}
        </style>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <%
        
        String StrclProveedor = "";
        String StrclTipoCobertura = "0";
        String StrCodEnt = "";
        String StrAsignar = "";
        String StrclPais = "";

        int iCont = 0;
        int boton = 0;

        if (request.getParameter("clProveedor") != null) {
            if (request.getParameter("clProveedor") != "") {
                StrclProveedor = request.getParameter("clProveedor").toString();
            }
        } else {
            if (session.getAttribute("clProveedor") != null) {
                StrclProveedor = session.getAttribute("clProveedor").toString();
            }
        }

        if (request.getParameter("clTipoCobertura") != null) {
            if (request.getParameter("clTipoCobertura") != "") {
                StrclTipoCobertura = request.getParameter("clTipoCobertura").toString();
            }
        }

        if (request.getParameter("CodEnt") != null) {
            if (request.getParameter("CodEnt") != "") {
                StrCodEnt = request.getParameter("CodEnt").toString();
            }
        }

        if (request.getParameter("StrAsignar") != null) {
            if (request.getParameter("StrAsignar") != "") {
                StrAsignar = request.getParameter("StrAsignar").toString();
            }
        }

        if (request.getParameter("clPais") != null) {
            StrclPais = request.getParameter("clPais").toString();
        }

        //System.out.println("clPais:" + StrclPais);
        //System.out.println("CodEnt" + StrCodEnt);

        %>

        <form id='VistaPrevia' target='VistaPrevia' method='post' action='../servlet/Utilerias.AsignaCoberturaProv'>
        <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="AsignarCobertura.jsp?"%>'>
        <input id='clTipoCobertura' name='clTipoCobertura' type='hidden' value='<%=StrclTipoCobertura%>'>
        <input id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        <input id='boton' name='boton' type='hidden' value='<%=boton%>'>
        <input id='clPais' name='clPais' type='hidden' value='<%=StrclPais%>'>

        <!--    ASIGNACION DE COBERTURA    -->
        <div style='position:absolute; z-index:10; left:25px; top:10px'>
            <input id='btnAsignaCobertura' type='button' value='Asignar' name="AsignaCobertura" onclick='document.all.boton.value=1;fnConcatena();'>
        </div>

        <!--    ELIMINACION DE COBERTURA    -->
        <div style='position:absolute; z-index:10; left:150px; top:10px'>
            <input class="elimina" id='btnEliminaCobertura' type='button' value='ELIMINAR COBERTURA' name="EliminaCobertura" onclick='document.all.boton.value=2;fnConfirmaEliminacion();'>
        </div>

        <%
        if (StrAsignar.equalsIgnoreCase("1")) {%>
            <script>
                document.getElementById('btnAsignaCobertura').style.visibility = 'visible';
            </script>  <%
        } else { %>
            <script>
                document.getElementById('btnAsignaCobertura').style.visibility = 'hidden';
            </script> <%
        }%>

        <div id = 'TablaCobertura' name = "TablaCobertura" style ='position:absolute; z-index:10; left:25px; top:40px;'>
            <table>
                <tr>
                    <td class = 'cssTitDet' colspan=2>Tipo Cobertura</td>
                </tr>
                <tr class='TTable'>
                    <td></td>
                    <td class='TTable'>Nombre</td>
                </tr>
                <%

                StringBuffer StrSql = new StringBuffer();
                StrSql.append("st_CoberturaProv ").append(StrclTipoCobertura).append(",'").append(StrCodEnt).append("','"+StrclPais+"'");
                ResultSet rs = null;

                if (!StrclTipoCobertura.equalsIgnoreCase("3")) {
                    rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                    StrSql.delete(0, StrSql.length());
                }
                



                            // COBERTURA POR PROVINCIA
                            if (StrclTipoCobertura.equalsIgnoreCase("1")) {
                                while (rs.next()) {
                %>
                <tr>
                    <td><input id='Seleccion' name='Seleccion' type='checkbox'></td>
                    <td><input disabled='true' id='dsProvinciaBarrio' name='dsProvinciaBarrio' type='text' value='<%=rs.getString("dsProvinciaBarrio")%>'></td>
                    <td><input disabled='true' id='CodEnt' name='CodEnt' type='hidden' value='<%=rs.getString("CodEnt")%>'></td>
                </tr>
                <% iCont = iCont + 1;
                                }
                            }

                            // COBERTURA POR LOCALIDAD
                            if (StrclTipoCobertura.equalsIgnoreCase("2")) {
                                while (rs.next()) {
                %>
                <tr>
                    <td><input id='Seleccion' name='Seleccion' type='checkbox'></td>
                    <td><input disabled='true' id='dsProvinciaBarrio' name='dsProvinciaBarrio' type='text' value='<%=rs.getString("dsProvinciaBarrio")%>'></td>
                    <td><input disabled='true' id='CodEnt' name='CodEnt' type='hidden' value='<%=rs.getString("CodEnt")%>'></td>
                    <td><input disabled='true' id='CodMD' name='CodMD' type='hidden' value='<%=rs.getString("CodMD")%>'></td>
                </tr>
                <% iCont = iCont + 1;
                                }
                            }

                            // COBERTURA TODO PAIS
                            if (StrclTipoCobertura.equalsIgnoreCase("3")) {
                %>
                <tr>
                    <td>TODO EL PAIS</td>
                </tr>
                <%   }%>
            </table>
        </div>

        <div style='position:absolute; z-index:10; left:150px; top:10px'>
            <input id='Selecciones' name='Selecciones' type='hidden'>
        </div>
        <input id='Total' name='Total' type='hidden' value ='<%=iCont%>'></input>
        <%

                    StrclProveedor = null;
                    StrclTipoCobertura = null;
                    StrCodEnt = null;
                    StrAsignar = null;
                    StrclPais = null;
                    
                    StrSql = null;

                    if(rs!=null){
                        rs.close();
                        rs = null;
                    }
        %>
    </form>

    <script>
        function fnConfirmaEliminacion(){
            if(confirm("¿Desea eliminar la cobertura seleccionada? Nota:Verifique en el listado de la Cobertura, la correcta eliminación.")==true ){
                fnConcatena();
            } else {
                return;
            }
        }

        function fnConcatena(){
            i=0;
            document.all.Selecciones.value='';

            if(document.all.clTipoCobertura.value==1){
                if (document.all.Total.value>1){
                    while (i<document.all.Total.value){
                        //document.all.Seleccion(i).checked;
                        if (document.all.Seleccion(i).checked){
                            if (document.all.Selecciones.value==''){
                                document.all.Selecciones.value = document.all.CodEnt(i).value;
                            }
                            else{
                                document.all.Selecciones.value = document.all.Selecciones.value + ',' + document.all.CodEnt(i).value;
                            }
                        }
                        i++;
                    }
                }else{
                    if (document.all.Seleccion.checked){

                        if (document.all.Selecciones.value==''){
                            document.all.Selecciones.value = document.all.CodEnt.value;
                        }
                        else{
                            document.all.Selecciones.value = document.all.Selecciones.value + ',' + document.all.CodEnt.value;
                        }
                    }
                }
            }

            if(document.all.clTipoCobertura.value==2){
                if (document.all.Total.value>1){
                    while (i<document.all.Total.value){
                        //document.all.Seleccion(i).checked;
                        if (document.all.Seleccion(i).checked){
                            if (document.all.Selecciones.value==''){
                                document.all.Selecciones.value = document.all.CodMD(i).value;
                            }
                            else{
                                document.all.Selecciones.value = document.all.Selecciones.value + ',' + document.all.CodMD(i).value;
                            }
                        }
                        i++;
                    }
                }else{
                    if (document.all.Seleccion.checked){
                        if (document.all.Selecciones.value==''){
                            document.all.Selecciones.value = document.all.CodMD.value;
                        }
                        else{
                            document.all.Selecciones.value = document.all.Selecciones.value + ',' + document.all.CodMD.value;
                        }
                    }
                }
            }
            document.all.VistaPrevia.submit();

        }
    </script>
</body>
</html>
