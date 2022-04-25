<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>

        <!--  NUEVA LIBRERIAS PARA EL MÓDULO HTML  -->
        <script type="text/javascript" src="../Utilerias/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>

        <!--  NUEVO SCRIPT QUE PERMITE LA CARGA DEL EDITOR HTML :: INICIO -->
        <script type="text/javascript">
            tinyMCE.init({
                // General options
                //mode: "textareas",
                mode : "exact",
                elements: "UsuariosyoBenef",
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
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) {
                %>Fuera de Horario<%
                StrclUsrApp = null;
                return;
            }

            String StrclCobertura = "0";
            String StrclCuenta = "0";
            String StrCuenta = "";

            if (request.getParameter("clCobertura") != null) {
                // LA clCobertura AQUI DEBE VENIR SIEMPRE DE REQUEST, NUNCA TOMARLA DE SESION        
                StrclCobertura = request.getParameter("clCobertura");
            }

            if (session.getAttribute("clCuenta") != null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();
            }

            StringBuffer StrSql = new StringBuffer();
            StrSql.append("Select Nombre From cCuenta Where clCuenta=").append(StrclCuenta);
            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs2.next()) {
                StrCuenta = rs2.getString("Nombre");
            }

            StrSql.append("st_getDescCobertura ").append(StrclCobertura);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            String StrclPaginaWeb = "42";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %>
        <script>fnOpenLinks()</script>
        <%            MyUtil.InicializaParametrosC(42, Integer.parseInt(StrclUsrApp));
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Cobertura.jsp?'>"%><%
        if (rs.next()) {%>
            <script>document.all.btnAlta.disabled = true;</script>
            <INPUT id='clCobertura' name='clCobertura' type='hidden' value='<%=StrclCobertura%>'>
            <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'>
            <%=MyUtil.ObjInput("Cuenta", "Cuenta", rs.getString("Nombre"), false, false, 30, 70, "", false, false, 73)%> 
            <%=MyUtil.ObjInput("Paquete", "dsPaquetex", rs.getString("dsPaquete"), false, false, 30, 110, "", false, false, 73)%> 
            <%=MyUtil.ObjTextArea("Usuarios y/o Beneficiarios", "UsuariosyoBenef", rs.getString("UsuariosyoBenef"), "73", "3", true, true, 30, 170, "", false, false)%>
            <%=MyUtil.ObjTextArea("Teléfonos de Asistencia", "TelefAsistencia", rs.getString("TelefAsistencia"), "73", "3", true, true, 30, 320, "", false, false)%>            
            <%=MyUtil.ObjTextArea("Teléfonos de Atención a Clientes", "TelefAtnCtes", rs.getString("TelefAtnCtes"), "73", "3", true, true, 30, 380, "", false, false)%>
            <%=MyUtil.ObjTextArea("Teléfonos de Validación", "TelefValidacion", rs.getString("TelefValidacion"), "73", "3", true, true, 30, 440, "", false, false)%>
            <%=MyUtil.ObjTextArea("Datos para Validación", "DatosValidacion", rs.getString("DatosValidacion"), "73", "3", true, true, 30, 500, "", false, false)%>
            <%=MyUtil.ObjTextArea("Vigencia de la Cuenta", "VigenciaCta", rs.getString("VigenciaCta"), "73", "3", true, true, 30, 560, "", false, false)%>
        <% } else { %>
            <INPUT id='clCobertura' name='clCobertura' type='hidden' value='<%=StrclCobertura%>'>
            <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'>
            <%=MyUtil.ObjInput("Cuenta", "Cuenta", StrCuenta, false, false, 30, 70, StrCuenta, false, false, 73)%> 
            <%=MyUtil.ObjInput("Paquete", "dsPaquetex", "", false, false, 30, 110, "", false, false, 73)%> 
            <%=MyUtil.ObjTextArea("Usuarios y/o Beneficiarios", "UsuariosyoBenef", "", "73", "3", true, true, 30, 170, "", false, false)%>
            <%=MyUtil.ObjTextArea("Teléfonos de Asistencia", "TelefAsistencia", "", "73", "3", true, true, 30, 320, "", false, false)%>            
            <%=MyUtil.ObjTextArea("Teléfonos de Atención a Clientes", "TelefAtnCtes", "", "73", "3", true, true, 30, 380, "", false, false)%>            
            <%=MyUtil.ObjTextArea("Teléfonos de Validación", "TelefValidacion", "", "73", "3", true, true, 30, 440, "", false, false)%>                        
            <%=MyUtil.ObjTextArea("Datos para Validación", "DatosValidacion", "", "73", "3", true, true, 30, 500, "", false, false)%>
            <%=MyUtil.ObjTextArea("Vigencia de la Cuenta", "VigenciaCta", "", "73", "3", true, true, 30, 560, "", false, false)%>
        <% } %>
            <% session.setAttribute("clCobertura", StrclCobertura); %>
        <br><br><br><br><br><br><br><br><br><br><br><br>
        <%=MyUtil.DoBlock("ANEXO", 300, 20)%>   
        <%=MyUtil.GeneraScripts()%><%
            rs2.close();
            rs2 = null;
            rs.close();
            rs = null;

            StrclCobertura = null;
            StrclCuenta = null;
            StrSql = null;
            StrclUsrApp = null;
            StrCuenta = null;
            StrclPaginaWeb = null;
        %>
    </body>
</html>
<br>