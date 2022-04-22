<%@ page contentType="text/html; charset=UTF-8" language="java" import="com.ike.concierge.DAOConcierge,Combos.cbPais,Combos.cbEntidad,com.ike.concierge.to.CSReferencia,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title> Detalle Referencia</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="/*fnChkArgentina();*/fnVerificaPais(document.all.clPais.value)">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script type="text/javascript" src='../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilConcierge.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilStore.js'></script>
        <!--script type="text/javascript" src='../Utilerias/UtilAjax.js'></script-->

        <%
            String StrclReferencia = "0";
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "0";
            String CodEnt = "0";
            String dsEntFed = "0";
            String dsMunDel = "0";
            String StrCodMD = "0";
            String strQuerySubCat = "";
            //String strQuery = "";
            String StrclPais = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) {
        %> Fuera de Horario <%
                StrclReferencia = null;
                StrclUsrApp = null;
                StrclPaginaWeb = null;
                CodEnt = null;
                dsEntFed = null;
                dsMunDel = null;
                StrCodMD = null;
                strQuerySubCat = null;
                //strQuery = null;
                StrclPais = null;
                return;
            }

            if (request.getParameter("clReferencia") != null) {
                StrclReferencia = request.getParameter("clReferencia");
            } else {
                if (session.getAttribute("clReferencia") != null) {
                    StrclReferencia = session.getAttribute("clReferencia").toString();
                }
            }
            session.setAttribute("clReferencia", StrclReferencia);

            ResultSet rs = null;
            StringBuffer StrSql = new StringBuffer();

            DAOConcierge daoc = new DAOConcierge();
            CSReferencia REF = null;

            if (StrclReferencia.compareToIgnoreCase("0") != 0) {
                REF = daoc.getReferencia(StrclReferencia);
            }

            String StrTipoImagen = "LogoR";
            session.setAttribute("TipoImagen", StrTipoImagen);

            StrclPaginaWeb = "643";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            StrclPais = REF != null ? String.valueOf(REF.getClPais()) : "";
            CodEnt = REF != null ? REF.getCodEnt().trim() : "";
            dsEntFed = REF != null ? REF.getDsEntFed().trim() : "";
            dsMunDel = REF != null ? REF.getDsMunDel().trim() : "";
            StrCodMD = REF != null ? REF.getCodMD().trim() : "";

            String strCP = REF != null ? REF.getCP() : "";

            /*if (StrclPais.equalsIgnoreCase("")) {
                StrclPais = "10";
            }*/

            if (REF != null) {
                strQuerySubCat = "select clSubCategoria, dsSubCategoria from CScSubCategoria where clCategoria=" + REF.getClCategoria() + " order by (dsSubCategoria)";
                //strQuery = "select clZona,dsZona from CScZona where clPais=" + REF.getClPais() + " order by dsZona";
            } else {
                strQuerySubCat = "select clSubCategoria, dsSubCategoria from CScSubCategoria order by (dsSubCategoria)";
                //strQuery = "select clZona, dsZona from CScZona order by dsZona";
            }

            //servlet generico
            String Store = "";
            Store = "st_GuardaConciergeReferencia,st_ActualizaConciergeReferencia";
            session.setAttribute("sp_Stores", Store);

            String Commit = "";
            Commit = "clReferencia";
            session.setAttribute("Commit", Commit);

            int Py = 140;
        %>

        <script type="text/javascript">fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(643, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuActPost("../servlet/com.ike.guarda.EjecutaSP", "fnAlta();fnVerificaPais(document.all.clPais.value);", "fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetReferencia.jsp?"%>'>
        <input id="Secuencia" name="Secuencia" type="hidden" value="">        
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" VALUE="NomEstablec,NomAlter,clCategoria,clSubCategoria,CalleNum,EntreCalles,clPais,CodEnt,CodMD,CP,Horario,Notas,VISA,MasterCard,AMEX,Dinners,TDebito,Efectivo,Contacto,Activo,Entidad,Ciudad,Telefono">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" VALUE="clReferencia,NomEstablec,NomAlter,clCategoria,clSubCategoria,CalleNum,EntreCalles,clPais,CodEnt,CodMD,CP,Horario,Notas,VISA,MasterCard,AMEX,Dinners,TDebito,Efectivo,Contacto,ActivoC,Entidad,Ciudad,Telefono">
        <INPUT id='clReferencia' name='clReferencia' type='hidden' value='<%=StrclReferencia%>'>

        <div id="DivReferencias" style='position:absolute; z-index:2000; left:0px; /*top:0px;*/ top:-150px;  width:910px;'>

            <%=MyUtil.ObjInput("Nombre / Establecimiento", "NomEstablec", REF != null ? REF.getNomEstablec() : "", true, true, 30, 80 + Py, "", false, false, 45, "")%>
            <%=MyUtil.ObjInput("Nombre Alternativo", "NomAlter", REF != null ? REF.getNomAlter() : "", true, true, 290, 80 + Py, "", false, false, 45, "")%>
            <%=MyUtil.ObjInput("Fecha Alta", "FechaAltaVTR", REF != null ? REF.getFechaAlta() : "", false, false, 560, 80 + Py, "", false, true, 22)%>
            <%=MyUtil.ObjComboC("Categoría", "clCategoria", REF != null ? REF.getDsCategoria() : "", true, true, 30, 120 + Py, "", "select * from CScCategoria order by (2) asc", "fnLlenaSubCategorias()", "", 50, true, true)%>
            <div class='VTable' style='position:absolute; z-index:20; left:30px; top:<%=160 + Py%>px;'>
                <INPUT type='button' VALUE='Nueva Categoria' onClick='fnCategoria()' class='cBtn'>
            </div>  
            <%=MyUtil.ObjComboC("Subcategoría", "clSubCategoria", REF != null ? REF.getDsSubCategoria() : "", true, true, 290, 120 + Py, "", "" + strQuerySubCat, "", "", 20, true, false)%>
            <div class='VTable' style='position:absolute; z-index:20; left:290px; top:<%=160 + Py%>px;'>
                <INPUT type='button' VALUE='Nueva SubCategoria' onClick='fnSubCategoria()' class='cBtn'>
            </div> 
            <%=MyUtil.ObjComboC("Estatus", "Activo", REF != null ? REF.getActivo() : "", true, true, 560, 120 + Py, "1", "select 0 as 'clEstatus', 'Inactiva' as 'dsEstatus' union select 1, 'Activa'", "", "", 30, true, true)%>
            <%=MyUtil.DoBlock("Detalle de Referencia", -20, 15)%>          

            <%=MyUtil.ObjComboMem("Pais", "clPais", REF != null ? REF.getDsPais() : "", REF != null ? String.valueOf(REF.getClPais()) : "", cbPais.GeneraHTML(20, REF != null ? REF.getDsPais() : ""), true, true, 30, 225 + Py, "0", "fnLlenaEntidadAjaxFn(this.value);fnVerificaPais(this.value);", "", 30, true, true)%>
            <div id="DivArgentina">
                <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", dsEntFed, CodEnt, cbEntidad.GeneraHTML(40, dsEntFed, Integer.parseInt((StrclPais==null || StrclPais.trim().isEmpty())?"10":StrclPais)), true, true, 30, 265 + Py, "", "fnLLenaComboMDAjax(this.value);", "", 40, false, false, "ProvinciaDiv")%>
                <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", dsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, CodEnt, dsMunDel), true, true, 420, 265 + Py, "", "", "", 30, false, false, "LocalidadDiv")%>
            </div>
            <div id="DivOtroPais">
                <%=MyUtil.ObjInput("Entidad / Provincia", "Entidad", REF != null ? REF.getEntidad() : "", true, true, 30, 265 + Py, "", false, false, 45, "")%>
                <%=MyUtil.ObjInput("Ciudad", "Ciudad", REF != null ? REF.getCiudad() : "", true, true, 285, 265 + Py, "", false, false, 30, "")%>
            </div>
            <%=MyUtil.ObjInput("Calle y Número", "CalleNum", REF != null ? REF.getCalleNum() : "", true, true, 30, 305 + Py, "", false, false, 75, "")%>
            <%=MyUtil.ObjInput("C.P.", "CP", strCP, true, true, 440, 305 + Py, "", false, false, 10, "")%>
            <%=MyUtil.ObjTextArea("Entre Calles", "EntreCalles", REF != null ? REF.getEntreCalles() : "", "73", "5", true, true, 30, 350 + Py, "", false, false)%>
            <%=MyUtil.ObjInput("Telefono", "Telefono", REF != null ? REF.getTelefono() : "", true, true, 440, 350 + Py, "", false, false, 12, "")%>
            <%=MyUtil.DoBlock("Ubicación", 30, 40)%>

            <%=MyUtil.ObjTextArea("Horario", "Horario", REF != null ? REF.getHorario() : "", "55", "5", true, true, 30, 480 + Py, "", false, false)%>
            <%=MyUtil.ObjTextArea("Notas", "Notas", REF != null ? REF.getNotas() : "", "55", "5", true, true, 345, 480 + Py, "", false, false)%>
            <%=MyUtil.ObjInput("Contacto", "Contacto", REF != null ? REF.getContacto() : "", true, true, 30, 570 + Py, "", false, false, 100, "")%>
            <div id='FormasPago' class='VTable' style='position:absolute; z-index:40; left:30px; top:<%=630 + Py%>px;'><p class='FTable'><b>Formas de Pago</b></div>
            <%=MyUtil.ObjChkBox("VISA", "VISA", REF != null ? REF.getVISA() : "0", true, true, 30, 650 + Py, "0", "SI", "NO", "")%>
            <%=MyUtil.ObjChkBox("MasterCard", "MasterCard", REF != null ? REF.getMasterCard() : "0", true, true, 140, 650 + Py, "0", "SI", "NO", "")%>
            <%=MyUtil.ObjChkBox("AMEX", "AMEX", REF != null ? REF.getAMEX() : "0", true, true, 250, 650 + Py, "0", "SI", "NO", "")%>
            <%=MyUtil.ObjChkBox("Diners", "Dinners", REF != null ? REF.getDinners() : "0", true, true, 360, 650 + Py, "0", "SI", "NO", "")%>
            <%=MyUtil.ObjChkBox("Tarjeta Debito", "TDebito", REF != null ? REF.getTDebito() : "0", true, true, 470, 650 + Py, "0", "SI", "NO", "")%>
            <%=MyUtil.ObjChkBox("Efectivo", "Efectivo", REF != null ? REF.getEfectivo() : "0", true, true, 580, 650 + Py, "0", "SI", "NO", "")%>
            <%=MyUtil.DoBlock("Información Adicional", -110, 20)%>

            <div class='VTable'>
                <img alt=""  src="../Imagenes/concierge/visacredito.png" style="position:absolute; z-index:60; left:50px; top:<%=662 + Py%>px;">
                <img alt=""  src="../Imagenes/concierge/mastercard.png" style="position:absolute; z-index:60; left:160px; top:<%=662 + Py%>px;">
                <img alt=""  src="../Imagenes/concierge/amex.png" style="position:absolute; z-index:60; left:270px; top:<%=662 + Py%>px;">
                <img alt=""  src="../Imagenes/concierge/dinersclub.gif" style="position:absolute; z-index:60; left:380px; top:<%=663 + Py%>px;">
                <img alt=""  src="../Imagenes/concierge/debito.png" style="position:absolute; z-index:60; left:490px; top:<%=657 + Py%>px;">
            </div>
        </div>

        <%=MyUtil.GeneraScripts()%> 
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F'>
        <input name='FechaSingleMsk' id='FechaSingleMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

        <%
            daoc = null;
            REF = null;

            StrclReferencia = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;
            CodEnt = null;
            dsEntFed = null;
            dsMunDel = null;
            StrCodMD = null;
            strQuerySubCat = null;

        %>
        <script type="text/javascript" >
            function fnAlta() {
                //if (document.all.DivRef.value == 1){
                DivReferencias.style.top = "-150px";
                //}
            }

            function fnLlenaEntidadAjaxFn(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'CodEnt';
                Label = 'Provincia';
                IdDiv = 'ProvinciaDiv';
                FnCombo = 'fnLLenaComboMDAjax(this.value);';
                URL = "../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value) {
                IDCombo = 'CodMD';
                Label = 'Localidad';
                IdDiv = 'LocalidadDiv';
                URL = "../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLlenaSubCategorias() {
                var strConsulta = "st_GetCSSubCategoria " + document.all.clCategoriaC.value;
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clSubCategoriaC";
                fnOptionxDefault('clSubCategoriaC', pstrCadena);

            }

            function fnLlenaDespuesdeGuardar(Descripcion) {
                if (Descripcion == 'Categoria') {
                    var strConsulta = "select clCategoria, dsCategoria from CScCategoria order by (2) asc ";
                    var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                    pstrCadena = pstrCadena + "&strName=clCategoriaC";
                    fnOptionxDefault('clCategoriaC', pstrCadena);

                }

                if (Descripcion == 'SubCategoria') {
                    var strConsulta = "select clSubCategoria,dsSubCategoria from CScSubCategoria where clCategoria = " + document.all.clCategoriaC.value;
                    var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                    pstrCadena = pstrCadena + "&strName=clSubCategoriaC";
                    fnOptionxDefault('clSubCategoriaC', pstrCadena);
                }
            }

            function fnChkArgentina() {
                if (document.all.clPaisC.value == 0 || document.all.clPaisC.value == "") {
                    document.all.clPaisC.value = 10;
                }
            }

            function fnCategoria() {
                document.all.clCategoriaC.value = '';
                document.all.clCategoria.value = 0;
                window.open('../Operacion/Concierge/CSCategoria.jsp?dsCategoria=' + document.all.clCategoria.value, 'WinCategoria', 'scrollbars=yes,status=yes,width=450,height=220');
            }

            function fnSubCategoria() {
                document.all.clSubCategoriaC.value = '';
                document.all.clSubCategoria.value = 0;
                window.open('../Operacion/Concierge/CSSubcategoria.jsp?clCategoria=' + document.all.clCategoria.value, 'WinSubCategoria', 'scrollbars=yes,status=yes,width=565,height=220');
            }

            function fnVerificaPais(pais) {
                /*  10 ARGENTINA; 43 COLOMBIA; 115 MEXICO; 179 VENEZUELA; */
                //<<<<<<<<<<<<< Para Argentina >>>>>>>>>>>>>>
                if (pais == 10) {
                    document.all.DivOtroPais.style.visibility = 'hidden';
                    document.all.DivArgentina.style.visibility = 'visible';

                    //Limpiar los Input
                    document.all.Entidad.value = '';
                    document.all.Ciudad.value = '';
                }
                //<<<<<<<<<<<< Resto del Mundo >>>>>>>>>>>>>>>>>>
                else {
                    document.all.DivOtroPais.style.visibility = 'visible';
                    document.all.DivArgentina.style.visibility = 'hidden';

                    document.all.CodEnt.value = '';
                    document.all.CodEntC.value = '';
                    document.all.CodMD.value = '';
                    document.all.CodMDC.value = '';

                }
            }
        </script>
    </body>    
</html>