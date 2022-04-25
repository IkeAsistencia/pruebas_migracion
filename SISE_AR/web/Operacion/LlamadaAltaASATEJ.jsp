<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Combos.cbAMIS,Combos.cbPais,com.ike.operacion.DAOAltaNUAsatej,com.ike.operacion.to.AltaNUAsatej,com.ike.pdf.CertificadoASATEJ"%>
<html>
    <head>
        <title>Alta de Usuario ASATEJ</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnValidaReenvio();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilStore.js'></script>

        <%
        String StrclUsrApp = "0";
        String StrclPaginaWeb = "0";
        String StrclAfiliado = "";
        String StrFechaRegistro = "";
        String StrCodEnt = "";
        String StrPermiteReenvio = "0";
        String StrPermiteBaja = "0";
        String StrActivo = "0";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
            StrclUsrApp = null;
            StrclPaginaWeb = null;
            StrclAfiliado = null;
            StrFechaRegistro = null;
            StrCodEnt = null;
            StrPermiteReenvio = null;
            StrPermiteBaja = null;
            StrActivo = null;

            return;
        }

        if (request.getParameter("clAfiliado") != null) {
            StrclAfiliado = request.getParameter("clAfiliado");
        } else {
            if (session.getAttribute("clAfiliado") != null) {
                StrclAfiliado = session.getAttribute("clAfiliado").toString();
            }
        }

        ResultSet rs = UtileriasBDF.rsSQLNP("Select convert(varchar(16),getdate(),120) FechaRegistro ");
        if (rs.next()) {
            StrFechaRegistro = rs.getString("FechaRegistro");
        }

        //  REVISA PERMISOS PARA REENVIAR CERTIFICADO POR MAIL
        ResultSet rs2 = UtileriasBDF.rsSQLNP("Select clGpoUsr from UsrxGpo where clGpousr in (202,203,204,205) and clUsrApp = " + StrclUsrApp);
        if (rs2.next()) {
            StrPermiteReenvio = "1";
        }

        //  REVISA PERMISO PARA DAR DE BAJA CLIENTES (INACTIVAR)
        ResultSet rs3 = UtileriasBDF.rsSQLNP("Select clGpoUsr from UsrxGpo where clGpousr in (205) and clUsrApp = " + StrclUsrApp);
        if (rs3.next()) {
            StrPermiteBaja = "1";
        }

        DAOAltaNUAsatej daoAltaAsa = null;
        AltaNUAsatej AA = null;

        //SERVLET GENERICO CON GENERACION DE PDF
        String Store = "";
        String Commit = "";
        String StrPathPDF = "";

        Store = "st_GuardaAfiliadoAsatej, st_ActualizaAfiliadoAsatej";
        session.setAttribute("sp_Stores", Store);

        Commit = "clAfiliado";
        session.setAttribute("Commit", Commit);

        //StrPathPDF = "C:\\SISE_AR\\build\\web\\Operacion\\PDF\\CertificadoAsatej\\CertificadoAsatej.pdf";
        //StrPathPDF = "/opt/app/apache-tomcat-5.5.12/webapps/SISE_DISABLED/Operacion/PDF/CertificadoAsatej/CertificadoAsatej.pdf";
        //StrPathPDF = "/opt/app/apache-tomcat-6.0.18/webapps/SISE_DISABLED/Operacion/PDF/CertificadoAsatej/CertificadoAsatej.pdf";
        StrPathPDF = "/opt/app/apache-tomcat-6.0.18/webapps/SISE_AR/Operacion/PDF/CertificadoAsatej/CertificadoAsatej.pdf";
        session.setAttribute("Path", StrPathPDF);
        // TERMINA SERVLET GENERICO

        session.setAttribute("clAfiliado", StrclAfiliado);

        if (!StrclAfiliado.equalsIgnoreCase("0")) {
            daoAltaAsa = new DAOAltaNUAsatej();
            AA = daoAltaAsa.getAltaNUAsatej(StrclAfiliado);
        }

        if (AA != null) {
            StrCodEnt = AA.getCodEnt().toString();
            StrActivo = AA.getActivo();

            if (AA.getFechaBaja().equals("1900-01-01 00:00")) {
                AA.setFechaBaja("");
            }
        }

        %><script>fnOpenLinks()</script><%

        StrclPaginaWeb = "5049";
        MyUtil.InicializaParametrosC(5049, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSPAsatej", "", "fnsp_Guarda();")%>
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='5049'>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>LlamadaAltaASATEJ.jsp?'>
        <INPUT id="Secuencia" name="Secuencia" type="hidden" value="">
        <INPUT id="SecuenciaG" name="SecuenciaG" type="hidden" value="clCuenta,Nombre,Apellido,clTipoDocumento,Clave,Mail,clTipoProducto,ISIC,Telefono1,Telefono2,FechaIni,FechaFin,clPais,CodEnt,CodMD,PrecioPublico,PrecioAsatej,FechaAlta,Activo,FechaNac,NombreContacto">
        <INPUT id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAfiliado,Nombre,Apellido,clTipoDocumento,Clave,clCuenta,Mail,clTipoProducto,ISIC,Telefono1,Telefono2,FechaIni,FechaFin,clPais,CodEnt,CodMD,PrecioPublico,PrecioAsatej,Activo,FechaNac,NombreContacto">
        <INPUT id='clAfiliado' name='clAfiliado' type='hidden' value='<%=StrclAfiliado%>' style='position:absolute; z-index:25; left:296px; top:300px;'>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=AA != null ? AA.getClCuenta() : ""%>'>
        <INPUT id='PermiteReenvio' name='PermiteReenvio' type='hidden' value='<%=StrPermiteReenvio%>'>
        <INPUT id='PermiteBaja' name='PermiteBaja' type='hidden' value='<%=StrPermiteBaja%>'>

        <%=MyUtil.ObjInput("Número ID", "NumID", AA != null ? AA.getClAfiliado() : "", false, false, 30, 82, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Nombre Pasajero", "Nombre", AA != null ? AA.getNombre() : "", true, true, 130, 82, "", true, true, 40)%>
        <%=MyUtil.ObjInput("Apellido Pasajero", "Apellido", AA != null ? AA.getApellido() : "", true, true, 360, 82, "", true, true, 30)%>
        <%=MyUtil.ObjInput("Fecha Nacimiento<br>(aaaa/mm/dd)", "FechaNac", AA != null ? AA.getFechaNac() : "", true, true, 540, 70, "", true, true, 15, "if(this.readOnly==false){fnValMask(this,document.all.FechaCobMsk.value,this.name)};fnValidaFechaNac();")%>
        <%if (StrPermiteBaja.equalsIgnoreCase("0")) {%>
        <%=MyUtil.ObjChkBox("Activo", "Activo", AA != null ? AA.getActivo() : "", false, false, 670, 79, "1", "SI", "NO", "")%>
        <%} else {%>
        <%=MyUtil.ObjChkBox("Activo", "Activo", AA != null ? AA.getActivo() : "", true, true, 670, 79, "1", "SI", "NO", "")%>
        <%}%>
        <%if (StrActivo.equalsIgnoreCase("0")) {%>
        <%=MyUtil.ObjInput("Fecha Baja<br>(aaaa/mm/dd)", "FechaBaja", AA != null ? AA.getFechaBaja() : "", false, false, 735, 70, "", false, false, 18)%>
        <%}%>
        <%=MyUtil.ObjInput("Correo Electrónico", "Mail", AA != null ? AA.getMail() : "", true, true, 30, 125, "", true, true, 40, "validaCorreo();")%>
        <%=MyUtil.ObjInput("Teléfono 1", "Telefono1", AA != null ? AA.getTelefono1() : "", true, true, 260, 125, "", true, true, 20)%>
        <%=MyUtil.ObjComboC("DNI Tipo", "clTipoDocumento", AA != null ? AA.getDsTipoDocumento() : "", true, false, 390, 125, "", "Select clTipoDocumento, dsTipoDocumento from cTipoDocumentoASATEJ order by dsTipoDocumento", "fnBuscaClave();", "", 20, true, true)%>
        <%=MyUtil.ObjInput("DNI Número", "Clave", AA != null ? AA.getClave() : "", true, false, 555, 125, "", true, false, 30, "fnBuscaClave();")%>
        <%=MyUtil.ObjComboC("Producto", "clTipoProducto", AA != null ? AA.getDsTipoProducto() : "", true, true, 30, 185, "", "Select clTipoProducto, dsTipoProducto from cTipoProductoASATEJ", "fnLimpiaPrecios();", "", 30, true, true)%>
        <%=MyUtil.ObjChkBox("Estudiante<br>Docente", "ISIC", AA != null ? AA.getISIC() : "", true, true, 200, 170, "0", "SI", "NO", "fnBuscaPrecios();")%>
        <%=MyUtil.ObjInput("Fecha Inicio Viaje<br>(aaaa/mm/dd)", "FechaIni", AA != null ? AA.getFechaIni() : "", true, true, 300, 171, "", true, true, 15, "if(this.readOnly==false){fnValMask(this,document.all.FechaCobMsk.value,this.name)};fnBuscaPrecios();")%>
        <%=MyUtil.ObjInput("Fecha Fin Viaje<br>(aaaa/mm/dd)", "FechaFin", AA != null ? AA.getFechaFin() : "", true, true, 430, 171, "", true, true, 15, "if(this.readOnly==false){fnValMask(this,document.all.FechaCobMsk.value,this.name)};fnBuscaPrecios();")%>
        <%=MyUtil.ObjComboC("Pais de Arribo de Viaje", "clPais", AA != null ? AA.getDsPais() : "", true, true, 550, 185, "", "select clPais, dsPais from cPais order by dsPais", "", "", 20, true, true)%>
        <%=MyUtil.ObjComboC("Provincia de Residencia Permanente en Argentina", "CodEnt", AA != null ? AA.getDsEntFed() : "", true, true, 30, 235, "", "select CodEnt, dsentfed from centfed order by dsentfed asc", "fnLlenaMunicipios();", "", 50, true, false)%>
        <%=MyUtil.ObjComboC("Ciudad de Residencia Permanente en Argentina", "CodMD", AA != null ? AA.getDsMunDel() : "", true, true, 420, 235, "", "select CodMD, dsMunDel from cMunDel where CodEnt='" + StrCodEnt + "' order by dsMunDel", "", "", 50, true, true)%>

        <%=MyUtil.ObjInput("Precio al Público", "PrecioPublico", AA != null ? AA.getPrecioPublico() : "", false, false, 30, 287, "", true, true, 12)%>
        <%=MyUtil.ObjInput("Costo ASATEJ", "PrecioAsatej", AA != null ? AA.getPrecioAsatej() : "", false, false, 160, 287, "", true, true, 12)%>
        <%=MyUtil.ObjInput("Fecha Venta<br>(aaaa/mm/dd)", "FechaAlta", AA != null ? AA.getFechaAlta() : "", false, false, 420, 275, StrFechaRegistro, false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaCobMsk.value,this.name)}")%>
        <div class='VTable' style='position:absolute; z-index:25; left:296px; top:300px;'>
            <INPUT type='button' value='Obtener Tarifa' onClick='fnBuscaPrecios();' class='cBtn'>
        </div>

        <div id="btnEnvio" name="btnEnvio" class='VTable' style='position:absolute; z-index:25; left:560px; top:300px;'>
            <INPUT type='button' value='RE-ENVIAR CERTIFICADO' onClick='fnEnviaCertificado();' class='cBtn'>
        </div>
        <%=MyUtil.DoBlock("Datos del Usuario ASATEJ", -70, 0)%>

        <%=MyUtil.ObjInput("Nombre Completo del Contacto", "NombreContacto", AA != null ? AA.getNombreContacto() : "", true, true, 30, 380, "", true, true, 60)%>
        <%=MyUtil.ObjInput("Teléfono", "Telefono2", AA != null ? AA.getTelefono2() : "", true, true, 360, 380, "", true, true, 20)%>
        <%=MyUtil.DoBlock("Datos Contacto Emergencia", -50, 0)%>

        <%=MyUtil.GeneraScripts()%><%
        rs.close();
        rs = null;

        rs2.close();
        rs2 = null;

        StrclUsrApp = null;
        StrclPaginaWeb = null;
        StrclAfiliado = null;
        StrFechaRegistro = null;
        StrCodEnt = null;
        StrPermiteReenvio = null;
        StrPermiteBaja = null;
        StrActivo = null;

        daoAltaAsa = null;
        AA = null;
        %>
        <input name='FechaCobMsk' id='FechaCobMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script>
            document.all.btnEnvio.style.visibility="hidden";

            function fnValidaFechaNac(){
                if (document.all.FechaNac.value!="" && (document.all.Action.value=="1" || document.all.Action.value=="2")){
                    var pstrCadena = "ValidaFechaNacimiento.jsp?FechaNac='"+ document.all.FechaNac.value + "'";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
                }
            }

            function fnVerificaFechaNac(Mensaje){
                if (Mensaje==0){
                    alert("El Afiliado debe ser menor a 65 años.");
                    document.all.FechaNac.value='';
                    document.all.FechaNac.focus();
                    return;
                }
                if (Mensaje==2){
                    alert("Fecha no válida.");
                    document.all.FechaNac.value='';
                    document.all.FechaNac.focus();
                    return;
                }
            }

            function fnValidaReenvio(){
                if (document.all.PermiteReenvio.value=="1"){
                    document.all.btnEnvio.style.visibility="visible";
                } else {
                    document.all.btnEnvio.style.visibility="hidden";
                }
            }

            function fnLimpiaPrecios(){
                document.all.PrecioAsatej.value='';
                document.all.PrecioPublico.value='';
            }

            function fnBuscaClave(){
                if(document.all.Action.value=="1"){
                    if (document.all.Clave.value=="" && document.all.clTipoDocumento.value==""){
                        alert ("Debe ingresar DNI Tipo y DNI Número, favor de verificar.");
                    } else {
                        var pstrCadena = "VerificaAfiliadoAsatej.jsp?Clave='"+ document.all.Clave.value + "'&clTipoDocumento='"+ document.all.clTipoDocumento.value+"'";
                        window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
                        //alert('Entra a funcion.'+pstrCadena);
                    }
                }
            }

            function fnVerificacion(Mensaje){
                if (Mensaje==1){
                    alert("No se proporcionó el DNI TIPO, favor de verificar.");
                    document.all.clTipoDocumento.focus();
                }

                if (Mensaje==2){
                    alert("La Clave ya existe, favor de verificar.");
                    document.all.Clave.value='';
                    document.all.Clave.focus();
                    return;
                }
            }

            function fnEnviaCertificado(){
                if (document.all.Mail.value==""){
                    alert("Debe guardar todos los datos primero.");
                } else {
                    var pstrCadena = "EnvioCertificadoAsatej.jsp?clAfiliado="+ document.all.clAfiliado.value;
                    window.open(pstrCadena,'newWin','width=100,height=100');
                }
            }

            function fnValidaEnvio(Mensaje){
                if (Mensaje==1){
                    alert("Se ha programado un nuevo envío del Certificado a: "+document.all.Mail.value);
                }
            }

            function fnBuscaPrecios(){
                if(document.all.Action.value=="1" || document.all.Action.value=="2"){
                    if (document.all.clTipoProducto.value!="" && document.all.FechaIni.value!="" && document.all.FechaFin.value!=""){
                        //alert("Los Precios se actualizarán.");
                        var pstrCadena = "BuscaTarifa.jsp?FechaIni='"+ document.all.FechaIni.value + "'&FechaFin='"+ document.all.FechaFin.value +"'&ISIC="+ document.all.ISIC.value+"&clTipoProducto="+ document.all.clTipoProducto.value;
                        window.open(pstrCadena,'newWin','width=100,height=100');
                    } else {
                        alert("No se puede obtener una tarifa, favor de verificar Tipo de Producto y/o Fechas de Viaje.");
                    }
                }
            }

            function fnObtieneTarifas(Mensaje,PrecioAsatej,PrecioPublico){
                if (Mensaje==1){
                    alert("La Fecha de Inicio del Viaje es anterior al día de hoy, favor de verificar.");
                    document.all.PrecioAsatej.value='';
                    document.all.PrecioPublico.value='';
                    document.all.FechaIni.value='';
                    document.all.FechaIni.focus();
                }

                if (Mensaje==2){
                    alert("La Fecha de Fin del Viaje es anterior a la Fecha de Inicio, favor de verificar.");
                    document.all.PrecioAsatej.value='';
                    document.all.PrecioPublico.value='';
                    document.all.FechaFin.value='';
                    document.all.FechaFin.focus();
                }

                document.all.PrecioAsatej.value=PrecioAsatej;
                document.all.PrecioPublico.value=PrecioPublico;
            }

            function validaCorreo(){
                var Cadena
                var PosArroba
                var usuario
                var dominio

                if (document.all.Mail.value!=''){
                    if(document.all.Mail.value.indexOf('@', 0) == -1){
                        alert("Formato del Correo Electrónico incorrecto, favor de verificar.");
                    } else {
                        PosArroba = document.all.Mail.value.lastIndexOf('@')
                        usuario=document.all.Mail.value.substring(0,PosArroba)
                        dominio=document.all.Mail.value.substring(PosArroba+1,Cadena)
                        if (usuario == '' || dominio==''){
                            alert("Formato del Correo Electrónico incorrecto, favor de verificar.");
                        }

                        //  Valida el nombre de usuario y verifica que no existan dos @
                        if(usuario.indexOf('@', 0) != -1){
                            alert("Formato del Correo Electrónico incorrecto, favor de verificar.");
                            document.all.Mail.focus();
                        }

                        //  Valida el dominio
                        if(dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1){
                            alert("Formato del Correo Electrónico incorrecto, favor de verificar.");
                            document.all.Mail.focus();
                        }
                    }
                }
            }
        </script>
    </body>
</html>