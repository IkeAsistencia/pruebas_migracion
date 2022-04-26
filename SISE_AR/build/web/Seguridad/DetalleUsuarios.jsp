<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Utilerias.UtileriasObj,com.ike.catalogos.DAOUsuarios,com.ike.catalogos.to.Usuarios"%>
<html>
    <head>
        <title>Detalle del Usuario</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload='fnValidaPermisos();'>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilStore.js'></script>

        <%
            String StrclUsrApp = "0";    // usuario logeado
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();            }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                StrclUsrApp = null;
                return;
                }
            String StrclUsrApp2 = "0";   // usuario al que se le dan permisos (parametro)
            String StrPermiteDesb = "0";
            if (request.getParameter("clUsrApp2") != null) {  StrclUsrApp2 = request.getParameter("clUsrApp2");
            }else{  if (session.getAttribute("clUsrApp2") != null) {   StrclUsrApp2 = session.getAttribute("clUsrApp2").toString(); }    }
            DAOUsuarios daoUsuarios = null;
            Usuarios usuarios = null;
            session.setAttribute("clUsrApp2", StrclUsrApp2);        // usuario al que se le dan permisos (parametro)
            session.setAttribute("clUsrAppParam", StrclUsrApp2);
            if (!StrclUsrApp2.equalsIgnoreCase("")) {
                daoUsuarios = new DAOUsuarios();
                usuarios = daoUsuarios.getUsuarios(StrclUsrApp2);
                }
            if (usuarios != null) {
                if (usuarios.getFechaAlta().equals("1900-01-01 00:00")) {     usuarios.setFechaAlta("");                }
                if (usuarios.getFechaBaja().equals("1900-01-01 00:00")) {     usuarios.setFechaBaja("");                }
                if (usuarios.getFechaUltAcceso().equals("1900-01-01 00:00")) {usuarios.setFechaUltAcceso("");           }
                if (usuarios.getFechaCambioPwd().equals("1900-01-01 00:00")) {usuarios.setFechaCambioPwd("");           }
                }
            //  REVISA PERMISOS PARA DESBLOQUEO / ACTUALIZADO DE MENUS
            ResultSet rs = UtileriasBDF.rsSQLNP("Select 1 from UsrxGpo where clGpousr in (1,209) and clUsrApp = " + StrclUsrApp);
            if (rs.next()) {    StrPermiteDesb = "1";            }
            //SERVLET GENERICO
            String Store = "";
            Store = "st_CreaUsuario,st_ActualizaUsr";
            session.setAttribute("sp_Stores", Store);
            String Commit = "";
            Commit = "clUsrApp2";
            session.setAttribute("Commit", Commit);
            // TERMINA SERVLET GENERICO
            String StrclPaginaWeb = "9";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(9, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP", "", "fn_importa();", "validaCorreoAntesGuardar();fnsp_Guarda();")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleUsuarios.jsp?"%>'>
        <INPUT id='Secuencia' name='Secuencia' type ='hidden' value=''>
        <INPUT id='SecuenciaG' name='SecuenciaG' type='hidden' value="NombreCompleto,Activo,clTipoHorario,clAreaC,RestringeProv,RestringeClie,NumEmpleado,StrclUsrApp,ValidaDobleFactor,Correo">
        <INPUT id='SecuenciaA' name='SecuenciaA' type='hidden' value="clUsrApp2,NombreCompleto,Activo,clTipoHorario,clAreaC,RestringeProv,RestringeClie,NumEmpleado,clPerfilOperativoC,ValidaDobleFactor,Correo">
        <INPUT id='StrclUsrApp' name='StrclUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
        <INPUT id='clUsrApp2' name='StrclUsrApp2' type='hidden' value='<%=StrclUsrApp2%>'>
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=StrclPaginaWeb%>'>
        <INPUT id='PermiteDesb' name='PermiteDesb' type='hidden' value='<%=StrPermiteDesb%>'>
        <INPUT id='btnActMnu' name='btnActMnu' type='button' class='cBtn' value='ACTUALIZAR MENUS' onclick='fnActualizaMenus();'>
        <INPUT id='btnDesbUsr' name='btnDblUsr' type='button' class='cBtn' value='DESBLOQUEAR USUARIO' onclick='fnDesbloquearUsr();'>
        <%=MyUtil.ObjInput("Id. Usuario", "clUsrApp", usuarios != null ? usuarios.getClUsrApp() : "", false, false, 50, 100, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Usuario", "clUsr", usuarios != null ? usuarios.getUsuario() : "", false, false, 140, 100, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("Activo", "Activo", usuarios != null ? usuarios.getActivo() : "", true, true, 300, 100, "1", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Usuarios", -110, 0)%>
        <div id ="divPerfil" name ="divPerfil" >
            <%=MyUtil.ObjInput("Usuario a Importar", "UsrModel", "", false, true, 410, 100, "", false, false, 20, "if(this.readOnly==false){fnBuscaModelo();}")%>
            <div class='VTable' style='position:absolute; z-index:100; left:530px; top:112px;'>
                <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaModelo();' WIDTH=20 HEIGHT=20>
            </div>
            <%=MyUtil.ObjInput("Nombre de Usuario a Importar", "NombreUsrModel", "", false, false, 570, 100, "", false, false, 45)%>
            <div id="divBtnPerfil" name="divBtnPerfil"  style='position:absolute; z-index:101; left:820px; top:110px;'>
                <INPUT id='btnImportarPerfil' name='btnImportarPerfil' type='button'  class='cBtn' value='IMPORTAR PERFIL' onclick='fnImportarPerfl();' >
            </div>
            <%=MyUtil.DoBlock("Importacion de Perfil", 230, 0)%>
        </div>

        <%=MyUtil.ObjInput("Nombre del Usuario", "NombreCompleto", usuarios != null ? usuarios.getNombre() : "", true, true, 50, 190, "", true, true, 65)%>
        <%=MyUtil.ObjInput("Correo Electr�nico", "Correo", usuarios != null ? usuarios.getCorreo(): "", true, true, 700, 190, "", true, true, 65, "validaCorreo();")%>
        <%=MyUtil.ObjComboC("Tipo de Horario", "clTipoHorario", usuarios != null ? usuarios.getTipoHorario() : "", true, true, 50, 235, "", "select clTipoHorario, TipoHorario from cTipoHorario", "", "", 40, true, true)%>
        <%=MyUtil.ObjComboC("�REA", "clArea", usuarios != null ? usuarios.getDsAreaUsuario() : "", true, true, 220, 235, "", "select clAreaUsuario, dsAreaUsuario from cAreaUsuario order by dsAreaUsuario", "", "", 40, true, true)%>
        <%=MyUtil.ObjComboC("Perfil Operativo", "clPerfilOperativo", usuarios != null ? usuarios.getDsPerfilOperativo(): "", true, true, 390, 235, "", "select clPerfilOperativo, dsPerfilOperativo from cPerfilOperativo order by 2", "", "", 40, true, true)%>
        <%=MyUtil.ObjChkBox("Restringe Proveedor", "RestringeProv", usuarios != null ? usuarios.getRestringeProv() : "", true, true, 50, 280, "", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("Restringe Cliente", "RestringeClie", usuarios != null ? usuarios.getRestringeClie() : "", true, true, 220, 280, "", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("No. Empleado", "NumEmpleado", usuarios != null ? usuarios.getNumEmpleado() : "", true, false, 470, 280, "", true, false, 10)%>
        <%=MyUtil.ObjChkBox("Valida Doble Factor", "ValidaDobleFactor", usuarios != null ? usuarios.getValidaDobleFactor() : "", true, true, 600, 280, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Fecha de Alta", "FechaAlta", usuarios != null ? usuarios.getFechaAlta() : "", false, false, 50, 330, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Fecha de Baja", "FechaBaja", usuarios != null ? usuarios.getFechaBaja() : "", false, false, 190, 330, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Fecha Ultimo Acceso", "FechaUltAcceso", usuarios != null ? usuarios.getFechaUltAcceso() : "", false, false, 330, 330, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Fecha Cambio Password", "FechaCambioPwd", usuarios != null ? usuarios.getFechaCambioPwd() : "", false, false, 480, 330, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos del Usuario", 200, 50)%>
        <img src="../Imagenes/exclamation.png" style="position:absolute; z-index:26; left:397px; top:204px;">
        <div id="InstDesc" name="InstDesc" style='position:absolute; z-index:34; left:430px; top:200px;'>
            <p class='vtable'><-- EL NOMBRE DEBE CONTENER<br>AL MENOS DOS PALABRAS.</p>
        </div>
        <%=MyUtil.GeneraScripts()%>

        <%
            StrclUsrApp = null;
            StrclUsrApp2 = null;
            StrPermiteDesb = null;
            StrclPaginaWeb = null;
            Store = null;
            Commit = null;
            daoUsuarios = null;
            usuarios = null;
            rs.close();
            rs = null;
        %>
        <script>
//------------------------------------------------------------------------------            
            var clusrmodelo;
//------------------------------------------------------------------------------
            function fnValidaPermisos() {
                if (document.all.PermiteDesb.value == "1") {
                    document.all.btnActMnu.style.visibility = "visible";
                    document.all.btnDesbUsr.style.visibility = "visible";
                } else {
                    document.all.btnActMnu.style.visibility = "hidden";
                    document.all.btnDesbUsr.style.visibility = "hidden";
                    document.all.divPerfil.style.visibility = "hidden";
                }
            }
//------------------------------------------------------------------------------
            function fn_importa() {
                document.all.divPerfil.style.visibility = "visible";       }
//------------------------------------------------------------------------------
            function fnActualizaMenus() {
                WSave = window.open('ActualizaMenus.jsp?clUsrApp=' + document.all.clUsrApp.value, 'WSave', 'resizable=no,menubar=0,status=1,toolbar=0,height=260,width=250,screenX=1,screenY=1');
                if (WSave != null) {  if (WSave.opener == null)     WSave.opener = self;      }
                }
//------------------------------------------------------------------------------
            function fnDesbloquearUsr() {
                WSave = window.open('DesbloquearUsr.jsp?clUsrApp=' + document.all.clUsrApp.value, 'WSave', 'resizable=no,menubar=0,status=1,toolbar=0,height=260,width=250,screenX=1,screenY=1');
                if (WSave != null) {   if (WSave.opener == null)    WSave.opener = self;    }
                }
//------------------------------------------------------------------------------
            function fnBuscaModelo() {
                if (document.all.UsrModel.value != '') {
                    var pstrCadena = "BusquedaUsuario.jsp?strSQL=st_BuscaUsuario ";
                    pstrCadena = pstrCadena + "&Usuario= " + document.all.UsrModel.value;
                    window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=400,height=300');
                    }
                }
//------------------------------------------------------------------------------
            function fnLlenaDatos(usurario, nomus, clusrapp) {
                document.all.UsrModel.value = usurario;
                document.all.NombreUsrModel.value = nomus;
                clusrmodelo = clusrapp;
                }
//------------------------------------------------------------------------------
            function fnImportarPerfl() {
                if (document.all.UsrModel.value != '') {
                    if (confirm("Los privilegios del usuario: " + document.all.UsrModel.value + " se asignaran al usuario, "+ document.all.clUsr.value + "�Desea continuar?")) {
                        var pstrCadena = "ImportarPerfil.jsp?strlSQL=st_ImportaPerfil";
                        pstrCadena = pstrCadena + "&usrActual=" + document.all.clUsrApp.value + "&usrModelo=" + clusrmodelo;
                        window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=400,height=300')
                        document.all.UsrModel.value = '';
                        document.all.NombreUsrModel.value = '';
                        }
                } else {     alert("Debe indicar un nombre de usuario...");     }
                }
            clusrmodelo = null;
//------------------------------------------------------------------------------
          function validaCorreoAntesGuardar() {
                var Cadena;
                var PosArroba;
                var usuario;
                var dominio;
                if (document.all.Correo.value != '') {
                    if (document.all.Correo.value.indexOf('@', 0) == -1) {
                        msgVal = msgVal + " La direcci�n de correo no es valida.";
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    } else {
                        PosArroba = document.all.Correo.value.lastIndexOf('@');
                        usuario = document.all.Correo.value.substring(0, PosArroba);
                        dominio = document.all.Correo.value.substring(PosArroba + 1, Cadena);
                        if (usuario == '' || dominio == '') {
                            msgVal = msgVal + " La direcci�n de correo no es valida.";
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                        }
                        //Valida el nombre de usuario y verifica que no existan dos @
                        if (usuario.indexOf('@', 0) != -1) {
                            msgVal = msgVal + " La direcci�n de correo no es valida.";
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                        }
                        //valida el dominio
                        if (!dominio.includes("ikeasistencia.com")) {
                            msgVal = msgVal + "La direcci�n de correo no es valida. Utilice un dominio @ikeasistencia.com.ar o @ikeasistencia.com";
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                        }
                    }
                } else {
                    if (document.all.Correo.value == '') {
                        var r = confirm("�Esta seguro que desea dejar el campo de correo en blanco?.");
                        if (r == true) {
                            return true;
                        } else {
                            msgVal = "Correo.";
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                        }
                    }
                }
            }
//------------------------------------------------------------------------------
            function validaCorreo() {
                var Cadena;
                var PosArroba;
                var usuario;
                var dominio;
                if (document.all.Correo.value != '') {
                    if (document.all.Correo.value.indexOf('@', 0) == -1) {
                        alert("La direcci�n de correo no es valida.");
                    } else {
                        PosArroba = document.all.Correo.value.lastIndexOf('@');
                        usuario = document.all.Correo.value.substring(0, PosArroba);
                        dominio = document.all.Correo.value.substring(PosArroba + 1, Cadena);
                        if (usuario == '' || dominio == '') {
                            alert("La direcci�n de correo no es valida.");                    }
                        //Valida el nombre de usuario y verifica que no existan dos @
                        if (usuario.indexOf('@', 0) != -1) {
                            alert("La direcci�n de correo no es valida.");                     }
                        //valida el dominio
                        if (!dominio.includes("ikeasistencia.com")) {
                            alert("La direcci�n de correo no es valida. Utilice un dominio @ikeasistencia.com.ar o @ikeasistencia.com");                   }
                        }
                    }
                }
//------------------------------------------------------------------------------
        </script>
    </body>
</html>
