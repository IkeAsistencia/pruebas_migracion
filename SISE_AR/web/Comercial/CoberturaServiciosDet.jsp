<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Detalle de la Cobertura</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilServicio.js' ></script>
        <!-- BIBLIOTECAS AJAX -->
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>            
        <script type="text/javascript" src='../Utilerias/UtilAjax.js'></script>
        <!--  NUEVA LIBRERIAS PARA EL MÓDULO HTML  -->
        <script type="text/javascript" src="../Utilerias/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
        <!--  NUEVO SCRIPT QUE PERMITE LA CARGA DEL EDITOR HTML :: INICIO -->
        <script type="text/javascript">
            tinyMCE.init({
                // General options
                //mode: "textareas",
                mode: "exact",
                elements: "PtosImportantes,Exclusiones",
                theme: "advanced",
                skin: "o2k7",
                //skin_variant : "silver",
                //skin_variant : "black",
                plugins: "safari,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",
                // Theme options
                //theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,forecolor,backcolor,|,formatselect,fontselect,fontsizeselect",
                theme_advanced_buttons1: "styleselect",
                theme_advanced_buttons2: "",
                theme_advanced_buttons3: "",
                theme_advanced_buttons4: "",
                theme_advanced_toolbar_location: "top",
                theme_advanced_toolbar_align: "left",
                theme_advanced_statusbar_location: "none",
                theme_advanced_resizing: false,
                height: "50",
                width: "380",
                // Example content CSS (should be your site CSS)
                content_css: "/js/tinymce/examples/css/content.css",
                // Style formats
                style_formats: [
                    {title: 'Texto en negritas', inline: 'b', styles: {fontSize: '11px'}},
                    {title: 'Texto en rojo', inline: 'span', styles: {color: '#ff0000'}},
                    {title: 'Texto subrayado', inline: 'u', exact: true},
                    {title: 'Texto sombreado', inline: 'span', styles: {background: '#ffff00'}}
                ],
                formats: {
                    alignleft: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'left'},
                    aligncenter: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'center'},
                    alignright: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'right'},
                    alignfull: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'full'},
                    bold: {inline: 'span', 'classes': 'bold'},
                    italic: {inline: 'span', 'classes': 'italic'},
                    underline: {inline: 'span', 'classes': 'underline', exact: true},
                    strikethrough: {inline: 'del'},
                    customformat: {inline: 'span', styles: {color: '#00ff00', fontSize: '20px'}, attributes: {title: 'Pruebas'}}
                }
            });
        </script>
        <%
            String StrclUsrApp = "0";
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();            }
            if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) {
                %> Fuera de Horario <%
                StrclUsrApp = null;
                return;
                }
            String StrclCobertura = "0";
            String StrclSubServicio = "0";
            String StrclPaginaWeb = "47";
            String StrclSubServicioAsociado = "";
            String StrclServicio = "";
            if (session.getAttribute("clCobertura") != null) {
                StrclCobertura = session.getAttribute("clCobertura").toString();            }
            if (StrclCobertura.compareToIgnoreCase("0") == 0) {     %>
                <script>
                    alert('Debe ingresar primero los Datos Generales de la Cobertura');
                    location.href =<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="../Utilerias/Lista.jsp?P=44&Apartado=S';"%>
                </script>
                <%
                StrclUsrApp = null;
                StrclCobertura = null;
                StrclSubServicio = null;
                return;
                }
            if (request.getParameter("clSubServicio") != null) {
                StrclSubServicio = request.getParameter("clSubServicio");            }
            StringBuffer StrSql = new StringBuffer();
            StrSql.append("select C.Nombre From cCobertura Cob Inner Join cCuenta C ON (Cob.clCuenta=C.clCuenta) Where Cob.clCobertura = ").append(StrclCobertura);
            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            rs2.next();
            StrSql.append("sp_DetalleCoberuraSubServicios ").append(StrclCobertura).append(",").append(StrclSubServicio);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            StrSql.append("select 'si' as permiso from usrxgpo where clgpousr = 419 and clUsrApp = ").append(StrclUsrApp);
            ResultSet rs1 = UtileriasBDF.rsSQLNP(StrSql.toString());
            if(rs1.next()){
                if (rs1.getString("permiso").equalsIgnoreCase("si")) {%>  <script>document.all.btnElimina.disabled = false;</script>
                <% } else {%>  <script>document.all.btnElimina.disabled = true;</script>      <% }
                }
            StrSql.delete(0, StrSql.length());
            StrSql.append("select clServicio from cSubServicio where clSubServicio = ").append(StrclSubServicio);
            ResultSet rs3 = UtileriasBDF.rsSQLNP(StrSql.toString());
            if(rs3.next()){  StrclServicio = rs3.getString("clServicio");}
            StrSql.delete(0, StrSql.length());
            rs3.close();
            rs3 = null;
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            // se checan permisos de alta,baja,cambio,consulta de esta pagina
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp)); %>
            <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
            <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CoberturaServiciosDet.jsp?"%>'/>
            <input id='clCobertura' name='clCobertura' type='hidden' value='<%=StrclCobertura%>'/>
            <input id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='47'/>
            <% if (rs.next()) {%>
                <%=MyUtil.ObjInput("Cuenta", "Cuenta", rs2.getString("Nombre"), false, false, 30, 80, rs2.getString("Nombre"), false, false, 73)%>
                <%=MyUtil.ObjComboC("Servicio", "clServicio", rs.getString("dsServicio"), true, false, 30, 120, "", "Select clServicio,dsServicio From cServicio Order by dsServicio", "fnLlenaSubServiciosCob()", "", 60, true, false)%>
                <%=MyUtil.ObjComboC("SubServicio", "clSubServicio", rs.getString("dsSubServicio"), true, false, 30, 160, "", "Select clSubServicio, dsSubServicio From cSubServicio Where clServicio=" + rs.getString("clServicio") + " Order by dsSubServicio", "fnCargaSubAsociado();", "", 160, true, false)%>
                <%=MyUtil.ObjComboC("SubServicio asociado", "clSubServicioAsociado", rs.getString("dsSubServicioAsociado"), true, true, 300, 160, "", "Select clSubServicio ,dsSubServicio From cSubServicio Where clServicio=" + rs.getString("clServicio") +" Order by dsSubServicio", "", "", 70, false, false)%>
                <%=MyUtil.ObjInput("Límite Monto", "LimiteMonto", rs.getString("LimiteMonto"), true, true, 30, 200, "", false, false, 10, "EsNumerico(document.all.LimiteMonto)")%>
                <%=MyUtil.ObjInput("Límite Eventos", "LimiteEventos", rs.getString("LimiteEventos"), true, true, 170, 200, "", false, false, 10, "fnRango(document.all.LimiteEventos,0,255)")%>
                <%=MyUtil.ObjInput("Límite Mensual", "LimiteEventosMensual", rs.getString("LimiteEventosMensual"), true, true, 300, 200, "", false, false, 10, "fnRango(document.all.LimiteEventosMensual,0,5)")%>
                <%=MyUtil.ObjChkBox("SubServicio Opcional","SubServicioOpcional", rs.getString("SubServicioOpcional"),true,true,410,200,"0","SI","NO","")%>
                <% if (StrclServicio.equals("3") ) { %>    
                    <div id="divHogar" name="divHogar"  style="visibility: 'hidden'">
                        <%=MyUtil.ObjInput("Cobertura anual", "LimiteMontoAnual", rs.getString("LimiteMontoAnual"), true, true, 30, 240, "", false, false, 10, "EsNumerico(document.all.LimiteMontoAnual)")%>
                        <%=MyUtil.ObjInput("Límite Eventos anual", "LimiteEventosAnual", rs.getString("LimiteEventosAnual"), true, true, 170, 240, "", false, false, 10, "fnRango(document.all.LimiteEventosAnual,0,3)")%>
                    </div>
                <% } else { %>
                    <div id="div1000KM"  name="div1000KM" style="visibility: 'hidden'">
                        <%=MyUtil.ObjInput("Límite KM anual", "LimiteMontoAnual", rs.getString("LimiteMontoAnual"), true, true, 30, 240, "", false, false, 10, "EsNumerico(document.all.LimiteMontoAnual)")%>
                        <%=MyUtil.ObjInput("Límite Eventos anual", "LimiteEventosAnual", rs.getString("LimiteEventosAnual"), true, true, 170, 240, "", false, false, 10, "fnRango(document.all.LimiteEventosAnual,0,3)")%>
                    </div>
                <% } %>
                <%=MyUtil.ObjTextArea("Puntos Importantes", "PtosImportantes", rs.getString("PtosImportantes"), "55", "4", true, true, 30, 280, "", false, false)%>
                <%=MyUtil.ObjTextArea("Exclusiones", "Exclusiones", rs.getString("Exclusiones"), "55", "7", true, true, 30, 430, "", false, false)%>
            <% } else {%>
                <%=MyUtil.ObjInput("Cuenta", "Cuenta", rs2.getString("Nombre"), false, false, 30, 80, rs2.getString("Nombre"), false, false, 73)%>
                <%=MyUtil.ObjComboC("Servicio", "clServicio", "", true, false, 30, 120, "", "Select clServicio,dsServicio From cServicio Order by dsServicio", "fnLlenaSubServiciosCob()", "", 60, true, false)%>
                <%=MyUtil.ObjComboC("SubServicio", "clSubServicio", "", true, false, 30, 160, "", "Select clSubServicio, dsSubServicio From cSubServicio Order by dsSubServicio", "fnCargaSubAsociado();", "", 160, true, false)%>
                <%=MyUtil.ObjComboC("SubServicio asociado", "clSubServicioAsociado", "", true, true, 200, 160, "", "Select clSubServicio, dsSubServicio From cSubServicio Order by dsSubServicio", "", "", 70, false, false)%>
                <%=MyUtil.ObjInput("Límite Monto", "LimiteMonto", "", true, true, 30, 200, "", false, false, 10, "EsNumerico(document.all.LimiteMonto)")%>
                <%=MyUtil.ObjInput("Límite Eventos", "LimiteEventos", "", true, true, 170, 200, "", false, false, 10, "fnRango(document.all.LimiteEventos,0,255)")%>
                <%=MyUtil.ObjInput("Límite Mensual", "LimiteEventosMensual", "", true, true, 300, 200, "", false, false, 10, "fnRango(document.all.LimiteEventosMensual,0,5)")%>
                <%=MyUtil.ObjChkBox("SubServicio Opcional","SubServicioOpcional", "",true,true,410,200,"0","SI","NO","")%>
                <% if (StrclServicio.equals("3") ) { %>
                    <div id="divHogar" name="divHogar"  style="visibility: 'hidden'">
                        <%=MyUtil.ObjInput("Cobertura anual", "LimiteMontoAnual", "", true, true, 30, 240, "", false, false, 10, "EsNumerico(document.all.LimiteMontoAnual)")%>
                        <%=MyUtil.ObjInput("Límite Eventos anual", "LimiteEventosAnual", "", true, true, 170, 240, "", false, false, 10, "fnRango(document.all.LimiteEventosAnual,0,3)")%>
                    </div>
                <% } else {%>
                    <div id="div1000KM" name="div1000KM"  style="visibility: 'hidden'">
                        <%=MyUtil.ObjInput("Límite KM anual", "LimiteMontoAnual", "", true, true, 30, 240, "", false, false, 10, "EsNumerico(document.all.LimiteMontoAnual)")%>
                        <%=MyUtil.ObjInput("Límite Eventos anual", "LimiteEventosAnual", "", true, true, 170, 240, "", false, false, 10, "fnRango(document.all.LimiteEventosAnual,0,3)")%>
                    </div>
                <% } %>
                <%=MyUtil.ObjTextArea("Puntos Importantes", "PtosImportantes", "", "55", "4", true, true, 30, 280, "", false, false)%>
                <%=MyUtil.ObjTextArea("Exclusiones", "Exclusiones", "", "55", "7", true, true, 30, 430, "", false, false)%>
            <% }%>
            <%=MyUtil.DoBlock("SUBSERVICIO CUBIERTO", 10, 120)%>
            <%=MyUtil.GeneraScripts()%>
        <%
            rs.close();
            rs = null;
            rs1.close();
            rs1 = null;
            rs2.close();
            rs2 = null;
            StrSql = null;
            StrclUsrApp = null;
            StrclCobertura = null;
            StrclSubServicio = null;
            StrclPaginaWeb = null;
        %>
        <script>
//------------------------------------------------------------------------------
            document.all.LimiteEventos.maxLength = 3;
            document.all.LimiteEventosMensual.maxLength =2;            
            var subservicioSeleccionado = <%=request.getParameter("clSubServicio")%>;
            var clServicio = <%=StrclServicio%>;
            if ( subservicioSeleccionado !== 211 ) {
                document.all.div1000KM.style.visibility = 'hidden';
            } else {  
                document.all.div1000KM.style.visibility = 'visible';
            }
            if ( clServicio !== 3 ) {
                document.all.divHogar.style.visibility = 'hidden';
            } else {
                document.all.divHogar.style.visibility = 'visible';
            }
//------------------------------------------------------------------------------
            /*Función para obtener el servicio
             * asociado en caso de altas*/
            function fnCargaSubAsociado() {
          /*Guardo datos*/
                var idSubServicio = document.all.clSubServicioC.value;
                var cobertura = document.all.clCobertura.value;
		var datos ={	
                idSubServicio : idSubServicio ,
		cobertura : cobertura};
            $.when(
		$.ajax({
			type: "POST",
			url: "./BuscarSubservicioAsociado.jsp",
                        async:false,
			data: datos,
			dataType: 'json',
			success: function(responseData, status, xhr) {
                        var subServAsoc   = responseData.rclSubServicio.toString();
                        var dsSubServAsoc = responseData.rdsSubServicio.toString();
                        document.all.clSubServicioAsociadoC.value = subServAsoc;
			},
			error: function(req, status, error) {				
				if ( req.status === 404 ) {//alert("No tiene registros asociados.");
				}
				if ( req.status === 500 ) {lert("Error leyendo subservicios asociados:  " + error);				}
			}
		})).then( successFunc(), failureFunc() );
            }            
//------------------------------------------------------------------------------
        </script>
    </body>
</html>
