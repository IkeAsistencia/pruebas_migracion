<%@ page contentType="text/html; charset=iso-8859-1" language="java"  import="com.ike.asistencias.DAOAsistenciaTrasladoEsp,com.ike.asistencias.to.AsistenciaTransladoRestosEsp,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Traslado de Restos Especializados</title>           
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>

        <%            
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrclPaginaWeb = "6160";
            int StrClTrasladoRestos = 0;

            String StrclPais = "10";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";

            String StrdsEntFedDest = "";
            String StrCodEntDest = "";
            String StrdsMunDelDest = "";
            String StrCodMDDest = "";
            
            String StrclCausaMuerte = "";
            String StrclLugarFallecimiento = "";
            String StrFechaMuerte = "";
            String StrdsEntFedFa = "";
            String StrCodEntFa = "";
            String StrdsMunDelFa = "";
            String StrCodMDFa = "";
            

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            if (session.getAttribute("clPais") != null) {
                StrclPais = session.getAttribute("clPais").toString();
            }
            if (session.getAttribute("CodEnt") != null){
                StrCodEnt = session.getAttribute("CodEnt").toString();
            }
            if (session.getAttribute("CodMD") != null){
                StrCodMD = session.getAttribute("CodMD").toString();
            }
            
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrclPais = null;
                StrdsPais = null;
                StrdsEntFed = null;
                StrCodEnt = null;
                StrdsMunDel = null;
                StrCodMD = null;
                StrdsEntFedDest = null;
                StrCodEntDest = null;
                StrdsMunDelDest = null;
                StrCodMDDest = null;
                
                StrclCausaMuerte = null;
                StrclLugarFallecimiento = null;
                StrFechaMuerte = null;
                StrdsEntFedFa = null;
                StrCodEntFa = null;
                StrdsMunDelFa = null;
                StrCodMDFa = null;
                return;
            }

            StringBuffer StrSql = new StringBuffer();

            DAOAsistenciaTrasladoEsp daoATRE = new DAOAsistenciaTrasladoEsp();
            AsistenciaTransladoRestosEsp asistenciaTRE = new AsistenciaTransladoRestosEsp();

            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                asistenciaTRE = daoATRE.getDetalleAsistenciaTrasladoEsp(StrclExpediente);
                if (asistenciaTRE != null) {
                    StrClTrasladoRestos = asistenciaTRE.getClAsistenciaTraslado();
                    StrCodEntDest = asistenciaTRE.getCodEntDestino();
                    StrdsEntFedDest = asistenciaTRE.getDsCodEntDestino();
                    StrCodMDDest = asistenciaTRE.getCodMDDestino();
                    StrdsMunDelDest = asistenciaTRE.getDsCodMDDestino();
                    StrdsPais = asistenciaTRE.getDsPaisOrigen();
                    StrdsEntFed = asistenciaTRE.getDsCodEntOrigen();
                    StrCodEnt = asistenciaTRE.getCodEntOrigen();
                    StrdsMunDel = asistenciaTRE.getDsCodMDOrigen();
                    StrCodMD = asistenciaTRE.getCodMDOrigen();
                    StrclCausaMuerte = asistenciaTRE.getClCausaMuerte();
                    StrclLugarFallecimiento = asistenciaTRE.getClLugarFallecimiento();
                    StrFechaMuerte = asistenciaTRE.getFechaMuerte(); 

                    StrCodEntFa = asistenciaTRE.getCodEntFallecimiento();
                    StrdsEntFedFa = asistenciaTRE.getDsCodEntFallecimiento();
                    StrdsMunDelFa = asistenciaTRE.getDsCodMDFallecimiento();
                    StrCodMDFa = asistenciaTRE.getCodMDFallecimiento();

                }
            }
            
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(6160, Integer.parseInt(StrclUsrApp));%>

        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="TrasladoRestosEspecializados.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clTrasladoRestos' name='clTrasladoRestos' type='hidden' value='<%=StrClTrasladoRestos%>'>

        <%=MyUtil.ObjComboMemDiv("Provincia", "codEntOrigen", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), false, false, 30, 80, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "codMDOrigen", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), false, false, 345, 80, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.ObjInput("Calle y Número", "direccionOrigen", asistenciaTRE != null ? asistenciaTRE.getDireccionOrigen() : "", true, true, 30, 130, "", false, false, 100)%>
        <%=MyUtil.DoBlock("Ubicación del Evento", 25, 20)%>
  
        <%=MyUtil.ObjComboC("Causa de la Muerte","clCausaMuerte",asistenciaTRE != null ? asistenciaTRE.getDsCausaMuerte() : "" ,true,true,30,250,"","st_getCausaMuerte","","",25,true,true)%>
        <%=MyUtil.ObjComboC("Lugar del Fallecimiento","clLugarFallecimiento",asistenciaTRE != null ? asistenciaTRE.getDsLugarFallecimiento() : "" ,true,true,270,250,"","st_getLugarFall","","",25,true,true)%>        
        <%=MyUtil.ObjComboMemDiv("Provincia Deceso", "CodEntFallecimiento", StrdsEntFedFa, StrCodEntFa, cbEntidad.GeneraHTML(40, StrdsEntFedFa, Integer.parseInt(StrclPais)), true, true, 30, 300, StrCodEntFa, "fnLLenaComboMDFaAjax(this.value);", "", 20, false, false, "CodEntDivFa")%> 
        <%=MyUtil.ObjComboMemDiv("Localidad Deceso", "CodMDFallecimiento", StrdsMunDelFa, StrCodMDFa, cbEntidad.GeneraHTMLMD(40, StrCodEntFa, StrdsMunDelFa), true, true, 270, 300, StrCodMDFa, "", "", 40, false, false, "LocalidadDivFa")%>
        <%=MyUtil.ObjInputF("Fecha Deceso (AAAA-MM-DD)","FechaMuerte",asistenciaTRE != null ? asistenciaTRE.getFechaMuerte() : "",true,true,550,300,"",true,true,17,2,"")%>
        <%=MyUtil.DoBlock("Información del Fallecimiento",25,25)%>  

        <%=MyUtil.ObjComboMemDiv("Provincia Destino", "codEntDestino", StrdsEntFedDest, StrCodEntDest, cbEntidad.GeneraHTML(40, StrdsEntFedDest, Integer.parseInt(StrclPais)), true,true, 30, 420, StrdsEntFedDest, "fnLLenaComboMDAjaxDest(this.value);", "", 20, false, false, "CodEntDivDest")%>
        <%=MyUtil.ObjComboMemDiv("Localidad Destino", "codMDDestino", StrdsMunDelDest, StrCodMDDest, cbEntidad.GeneraHTMLMD(40, StrCodEntDest, StrdsMunDelDest), true, true, 400, 420, "", "", "", 20, false, false, "LocalidadDivDest")%>
        <%=MyUtil.ObjInput("Calle y Número", "direccionDestino", asistenciaTRE != null ? asistenciaTRE.getDireccionDestino() : "", true, true, 30, 470, "", false, false, 106)%>
        <%=MyUtil.DoBlock("Ubicación de Destino", 25, 10)%>
        
        <%=MyUtil.GeneraScripts()%>

      <input id="FechaProgMomAux" name="FechaProgMomAux" value="FechaProgMom" type="hidden"/>       
        <input name='FechaProgMomMsk' id='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F'/>
        <script>

            function fnLlenaEntidadAjaxFn(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'codEntOrigen';
                Label = 'Provincia';
                IdDiv = 'CodEntDiv';
                FnCombo = 'fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value) {
                IDCombo = 'codMDOrigen';
                Label = 'Localidad';
                IdDiv = 'LocalidadDiv';
                FnCombo = '';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }
            
            //Funciones para Combos de Fallecimiento 
            function fnLlenaEntidadAjaxFaFn(cod) {  
                IDCombo = 'CodEntFallecimiento';
                Label = 'Provincia Deceso';
                IdDiv = 'CodEntDivFa';
                FnCombo = 'fnLLenaComboMDFaAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDFaAjax(value) {
                IDCombo = 'CodMDFallecimiento';
                Label = 'Localidad Deceso';
                IdDiv = 'LocalidadDivFa';
                FnCombo = '';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLlenaEntidadAjaxFnDest(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'codEntDestino';
                Label = 'Provincia Destino';
                IdDiv = 'CodEntDivDest';
                FnCombo = 'fnLLenaComboMDAjaxDest(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjaxDest(value) {
                IDCombo = 'codMDDestino';
                Label = 'Localidad Destino';
                IdDiv = 'LocalidadDivDest';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

           document.all.btnElimina.disabled = true;
        </script>

        <%
            if (asistenciaTRE != null) {
        //si hay asiistencia
        %>
        <script>
            document.all.btnAlta.disabled = true;
        </script>
        <%
        } else {
        %>
        <script>
            document.all.btnCambio.disabled = true;
        </script>
        <%
        } %>

    
    <%
        
        daoATRE = null;
        asistenciaTRE = null;
        
        rs.close();
        rs = null;

        StrclUsrApp = null;
        StrclExpediente = null;
        StrclPaginaWeb = null;
        StrclPais = null;
        StrdsPais = null;
        StrdsEntFed = null;
        StrCodEnt = null;
        StrdsMunDel = null;
        StrCodMD = null;

        StrclCausaMuerte = null;
        StrclLugarFallecimiento = null;
        StrFechaMuerte = null;
        StrdsEntFedFa = null;
        StrCodEntFa = null;
        StrdsMunDelFa = null;
        StrCodMDFa = null;
    %>
    </body>
</html>