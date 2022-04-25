<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Utilerias.UtileriasObj,Combos.cbEntidad" errorPage="" %>
<html>
    <head>
        <title>Detalle Cobertura del Proveedor Ambulancia</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnValidaCobertura();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript"  src='../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilDireccion.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilAjax.js'></script>

        <%
                String StrclProveedor = "0";
                String StrclCoberturaxProveedor = "0";
                String StrNomOpe = "0";
                String StrclUsrApp = "0";

                if (session.getAttribute("clUsrApp") != null) {
                    StrclUsrApp = session.getAttribute("clUsrApp").toString();
                }

                if (session.getAttribute("clProveedor") != null) {
                    StrclProveedor = session.getAttribute("clProveedor").toString();
                }

                if (request.getParameter("clCoberturaxProveedor") != null) {
                    if (request.getParameter("clCoberturaxProveedor") != "") {
                        StrclCoberturaxProveedor = request.getParameter("clCoberturaxProveedor").toString();
                    }
                }

                if (session.getAttribute("NombreOpe") != null) {
                    StrNomOpe = session.getAttribute("NombreOpe").toString();
                }

                if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                    StrclProveedor = null;
                    StrclCoberturaxProveedor = null;
                    StrNomOpe = null;
                    StrclUsrApp = null;

                    return;
                }
                String StrclPaginaWeb = "364";

                // se checan permisos de alta,baja,cambio,consulta de esta pagina
                MyUtil.InicializaParametrosC(364, Integer.parseInt(StrclUsrApp));
        %>
        <form id ="formaAsigna" target='VistaPrevia' method='post' action='AsignarCobertura.jsp'>
            <input id='StrAsignar' name='StrAsignar' type='hidden'>
            <div style='position:absolute; z-index:303; left:30px; top:175px' id="btnVistaPrevia">
                <input type='button' value='Vista Previa' name="VistaPrevia" onclick="fn_Validacion();">
            </div>
            <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleCobxProvA.jsp?"%>'>
            <input id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <input id='clCoberturaxProveedor' name='clCoberturaxProveedor' type='hidden' value='<%=StrclCoberturaxProveedor%>'>

            <%=MyUtil.ObjInput("Nombre Operativo", "NombreOpe", StrNomOpe, false, false, 30, 80, StrNomOpe, false, false, 70)%>
            <%=MyUtil.ObjComboC("Tipo de Cobertura", "clTipoCobertura", "", true, true, 30, 125, "0", "select '1' as 'clTipoCobertura', 'POR PROVINCIA' as 'dsTipoCobertura' union select '2' as 'clTipoCobertura', 'POR LOCALIDAD' as 'dsTipoCobertura'union select '3' as 'clTipoCobertura', 'TODO EL PAIS' as 'dsTipoCobertura'", "fn_MuestraCampos();", "", 50, true, true)%>
            <%=MyUtil.ObjComboCDiv("Pais", "clPais", "", true, true, 200, 125, "0", "sp_getPaisCobertura", "fnLlenaEntidadAjaxFn(this.value);", "", 50, true, true, "clPaisDiv")%>
            <%=MyUtil.ObjComboCDiv("Provincia", "CodEnt", "", true, false, 200, 165, "", "Select CodEnt, dsEntFed from cEntFed where clPais = 10", "", "", 25, false, false, "CodEntDiv")%>
            <%=MyUtil.DoBlock("Detalle de Cobertura Regional del Proveedor", 190, 0)%>

            <%
                    StrclProveedor = null;
                    StrclCoberturaxProveedor = null;
                    StrNomOpe = null;
                    StrclUsrApp = null;
                    //StrclPaginaWeb = null;
%>
        </form>

        <script type="text/javascript">
            document.all.clTipoCoberturaC.disabled=false;
            document.all.clPaisC.disabled=false;
            document.all.CodEntC.disabled=false;

            document.getElementById('btnVistaPrevia').style.visibility = 'hidden';
            document.all.clPaisDiv.style.visibility="hidden";
            document.all.CodEntDiv.style.visibility="hidden";

            function fnValidaCobertura(){
                //parent.VistaPrevia.location.reload(true);
                if(document.all.clTipoCoberturaC.value==1 || document.all.clTipoCoberturaC.value==2 || document.all.clTipoCoberturaC.value==3){
                    document.getElementById('btnVistaPrevia').style.visibility = 'visible';
                    if(document.all.clTipoCoberturaC.value==2){
                        document.all.CodEntDiv.style.visibility="visible";
                    } else {
                        document.all.CodEntDiv.style.visibility="hidden";
                    }
                } else {
                    document.getElementById('btnVistaPrevia').style.visibility = 'hidden';
                    document.all.CodEntDiv.style.visibility="hidden";
                }
            }

            function fn_MuestraCampos(){
                //alert("clTipoCoberturaC: "+document.all.clTipoCoberturaC.value+ "  clPais: "+ document.all.clPais.value +"   CodEnt: "+ document.all.CodEnt.value);
                if(document.all.clTipoCoberturaC.value==1){ //Provincia
                    document.all.clPaisDiv.style.visibility="visible";
                    document.getElementById('btnVistaPrevia').style.visibility = 'visible';

                    document.all.CodEntC.value="";
                    document.all.CodEnt.value="";
                    document.all.CodEntDiv.style.visibility="hidden";
                }

                if(document.all.clTipoCoberturaC.value==2){ //Localidad
                    document.all.clPaisDiv.style.visibility="visible";
                    document.all.CodEntDiv.style.visibility="visible";
                    document.getElementById('btnVistaPrevia').style.visibility = 'visible';
                }

                if(document.all.clTipoCoberturaC.value==3){ //Pais
                    document.all.clPaisDiv.style.visibility="visible";
                    document.getElementById('btnVistaPrevia').style.visibility = 'visible';

                    document.all.CodEntC.value="";
                    document.all.CodEnt.value="";
                    document.all.CodEntDiv.style.visibility="hidden";
                }
            }

            function fn_Validacion(){
                Error = 0;
                //alert("clTipoCoberturaC: "+document.all.clTipoCoberturaC.value+ "  clPais: "+ document.all.clPais.value +"   CodEnt: "+ document.all.CodEnt.value);
                if(document.all.clTipoCoberturaC.value==1){ //Provincia
                    if(document.all.clPais.value==""){
                        alert("Error: Debe informar el Pais ");
                        Error = 1;
                    }
                }

                if(document.all.clTipoCoberturaC.value==2){ //Localidad
                    if(document.all.clPais.value=="" || document.all.CodEnt.value==""){
                        alert("Error: Debe informar Pais y Provincia ");
                        Error = 1;
                    }
                }

                if(document.all.clTipoCoberturaC.value==3){ //Pais
                    if(document.all.clPais.value==""){
                        alert("Error: Debe informar el Pais ");
                        Error = 1;
                    }
                }

                if(Error==0){
                    document.all.StrAsignar.value=1;
                }else{
                    document.all.StrAsignar.value=0;
                }
                document.all.formaAsigna.submit();
            }
        </script>
    </body>
</html>