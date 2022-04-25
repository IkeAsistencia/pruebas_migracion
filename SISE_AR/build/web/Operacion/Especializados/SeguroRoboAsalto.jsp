<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.asistencias.DAOAsistenciaProteccionRobo,com.ike.asistencias.to.AsistenciaProteccionRobo,java.sql.ResultSet,Utilerias.UtileriasBDF,Combos.cbPais,Combos.cbEntidad,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />

        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <%
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");

        String StrclUsrApp = "0";
        String StrclExpediente = "0";
        String StrclPaginaWeb = "332";

        String StrFecha = "";

        String StrclPais = "";
        String StrdsPais = "";
        String StrdsEntFed = "";
        String StrCodEnt = "";
        String StrdsMunDel = "";
        String StrCodMD = "";



        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (session.getAttribute("clExpediente") != null) {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%

            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaWeb = null;

            StrFecha = null;

            StrclPais = null;
            StrdsPais = null;
            StrdsEntFed = null;
            StrCodEnt = null;
            StrdsMunDel = null;
            StrCodMD = null;

            return;
        }

        StringBuffer StrSql = new StringBuffer();

        DAOAsistenciaProteccionRobo daoAPR = null;
        AsistenciaProteccionRobo APR = null;

        ResultSet rsf = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) FechaApertura ");
        if (rsf.next()){
            StrFecha = rsf.getString("FechaApertura");
        }

        StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        if (rs.next()) {

            daoAPR = new DAOAsistenciaProteccionRobo();
            APR = daoAPR.getAsistenciaProteccionRobo(StrclExpediente);

            StrclPais = APR != null ? APR.getClPais() : "";
            StrdsPais = APR != null ? APR.getDsPais() : "";
            StrCodEnt = APR != null ? APR.getCodEnt() : "";
            StrdsEntFed = APR != null ? APR.getDsEntFed() : "";
            StrCodMD = APR != null ? APR.getCodMD() : "";
            StrdsMunDel = APR != null ? APR.getDsMunDel() : "";
            
            if (StrclPais.equalsIgnoreCase("")) {
                StrclPais = "10";
            }                     
        } else {
        %>El expediente no existe<%

            rs.close();
            rs = null;
            rsf.close();
            rsf = null;

            StrFecha = null;

            StrclPais = null;
            StrdsPais = null;
            StrdsEntFed = null;
            StrCodEnt = null;
            StrdsMunDel = null;
            StrCodMD = null;
            return;
        }

        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %>

        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(332, Integer.parseInt(StrclUsrApp));%>   <!--se checan permisos de alta,baja,cambio,consulta de esta pagina-->
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="SeguroRoboAsalto.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Persona que Reporta", "PersonaReporta", APR != null ? APR.getPersonaReporta() : "", true, true, 30, 70, "", true, true, 85)%>
        <%=MyUtil.ObjComboC("Tipo Persona Reporta", "clTipoPerReporta", APR != null ? APR.getDsTipoPersonaRep() : "", true, true, 510, 70, "", "Select clTipoPerReporta,dsTipoPersonaRep from cTipoPersonaReporta", "", "", 140, true, true)%>
        <%=MyUtil.ObjTextArea("Detalle de lo Robado", "DetalleRobado", APR != null ? APR.getDetalleRobado() : "", "122", "3", true, true, 30, 110, "", false, false)%>
        <%=MyUtil.ObjInput("Valor", "Valor", APR != null ? APR.getValor() : "", true, true, 30, 180, "", true, true, 15, "EsNumerico(document.all.Valor)")%>
        <%=MyUtil.ObjInput("Fecha de Siniestro<br>AAAA/MM/DD", "FechaSiniestro", APR != null ? APR.getFechaSiniestro() : "", true, true, 220, 170, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), false, false, 410, 180, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), true, true, 30, 220, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), true, true, 510, 220, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.ObjChkBox("Envio de Abogado", "EnvioAbogado", APR != null ? APR.getEnvioAbogado() : "", true, true, 30, 260, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjComboC("Tipo de Reclamación", "clTipoReclamacion", APR != null ? APR.getDsTipoReclamacion() : "", true, true, 190, 260, "", "SELECT clTipoReclamacion,dsTipoReclamacion FROM cTipoReclamacion", "", "", 140, true, true)%>
        <%=MyUtil.ObjInput("No. de Cuenta para Pago o Depósito", "NumCuentaDep", APR != null ? APR.getNumCuentaDep() : "", true, true, 390, 260, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Sucursal", "Sucursal", APR != null ? APR.getSucursal() : "", true, true, 30, 300, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Banco", "Banco", APR != null ? APR.getBanco() : "", true, true, 390, 300, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Nombre del Titular", "NombreTitular", APR != null ? APR.getNombreTitular() : "", true, true, 30, 340, "", false, false, 70)%>
        <%=MyUtil.ObjInput("Clabe", "Clabe", APR != null ? APR.getClabe() : "", true, true, 490, 340, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Fecha de Pago <br>AAAA/MM/DD", "FechaPago", APR != null ? APR.getFechaPago() : "", true, true, 30, 380, "", true, true, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Costo Pagado", "CostoPagado", APR != null ? APR.getCostoPagado() : "", true, true, 170, 390, "", false, false, 20, "EsNumerico(document.all.CostoPagado)")%>
        <%=MyUtil.ObjInput("Fecha de Apertura", "FechaApertura", APR != null ? APR.getFechaApertura() : "", false, false, 305, 390, StrFecha, false, false, 30)%>
        <%=MyUtil.ObjInput("Fecha de Registro", "FechaRegistroVTR", APR != null ? APR.getFechaRegistro() : "", false, false, 490, 390, "", false, false, 30)%>
        <%=MyUtil.DoBlock("Detalle de Seguro por Robo o Asalto a Persona", -10, 0)%>
                   
        <%=MyUtil.ObjChkBox("Copia de la Denuncia", "DenunciaCopia", APR != null ? APR.getDenunciaCopia() : "", true, true, 30, 480, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("Comprobante de Uso de Tarjeta", "ComprobanteUso", APR != null ? APR.getComprobanteUso() : "", true, true, 210, 480, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("Copia de Identificacion Oficial", "IdentOficialCopia", APR != null ? APR.getIdentOficialCopia() : "", true, true, 450, 480, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("Copia de la Tarjeta de Reclamación", "TarjetaReclama", APR != null ? APR.getTarjetaReclama() : "", true, true, 30, 540, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("Carta de Solicitud de Reclamación", "CartaReclama", APR != null ? APR.getCartaReclama() : "", true, true, 450, 540, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Otro Documento: Especificar", "OtroDocto", APR != null ? APR.getOtroDocto() : "", true, true, 30, 590, "", false, false, 100)%>
        <%=MyUtil.DoBlock("Envio de documentación", 50, 0)%>

        <%=MyUtil.GeneraScripts()%>

        <%
            daoAPR = null;
            APR = null;

            rs.close();
            rs = null;
            rsf.close();
            rsf = null;

            StrSql = null;

            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaWeb = null;
            StrFecha = null;
            StrclPais = null;
            StrdsPais = null;
            StrdsEntFed = null;
            StrCodEnt = null;
            StrdsMunDel = null;
            StrCodMD = null;

        %>

        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

        <script type="text/javascript">

            function fnLlenaEntidadAjaxFn(cod){  // Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo= 'CodEnt';
                Label='Provincia';
                IdDiv='CodEntDiv';
                FnCombo='fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value){
                IDCombo= 'CodMD';
                Label='Localidad';
                IdDiv='LocalidadDiv';
                FnCombo='';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            document.all.PersonaReporta.maxLength=100;
            document.all.OtroDocto.maxLength=150;
            document.all.NumCuentaDep.maxLength=50;
            document.all.Sucursal.maxLength=50;
            document.all.Banco.maxLength=50;
            document.all.NombreTitular.maxLength=100;
            document.all.Clabe.maxLength=50;


        </script>
    </body>
</html>

