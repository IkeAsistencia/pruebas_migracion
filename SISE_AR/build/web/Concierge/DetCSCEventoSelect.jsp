<%@ page contentType="text/html; charset=UTF-8" language="java" import="com.ike.concierge.DAOCSEventoSelect,com.ike.concierge.to.CSEventoSelect,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Detalle Evento Select</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnDeshabilita();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilAjax.js'></script>

        <%
            String StrclEventoSelect = "0";
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "6141";
            String strclTipoBen = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clEventoSelect") != null) {
                StrclEventoSelect = request.getParameter("clEventoSelect");
            } else if (session.getAttribute("clEventoSelect") != null) {
                    StrclEventoSelect = session.getAttribute("clEventoSelect").toString();
            }

            if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) {
                %> Fuera de Horario <%
                    //StrclExperiencia = null;
                    StrclEventoSelect = null;
                    StrclUsrApp = null;
                    StrclPaginaWeb = null;
                    strclTipoBen = null;
                    return;
            }

            DAOCSEventoSelect daoEvnt = new DAOCSEventoSelect();
            CSEventoSelect EVT = null;

            if(StrclEventoSelect.compareToIgnoreCase("0") != 0){
                EVT = daoEvnt.getCSEventoSelect(StrclEventoSelect);
            }

            strclTipoBen = EVT != null ? EVT.getClTipoBen() : "0";

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            session.setAttribute("clEventoSelect", StrclEventoSelect);

        %><script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnAccionesAlta()", "","fnGuardar();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetCSCEventoSelect.jsp?"%>'>
        <INPUT id='clEventoSelect' name='clEventoSelect' type='hidden' value='<%=StrclEventoSelect%>'>

        <%=MyUtil.ObjComboC("Beneficio Select", "clTipoBen", EVT != null ? EVT.getDsTipoBen() : "", true, false, 30, 80, "", "Select clTipoBen, dsTipoBen from CScTipoBenEvent where Activo=1 order by dsTipoBen", "fnLlenaCiudadExpAjax(this.value);", "", 20, true, false)%>
        <%=MyUtil.ObjComboCDiv("Ciudad", "clCiudad", EVT != null ? EVT.getDsCiudad() : "", true, false, 210, 80, "", "Select clCiudad,dsCiudad from CScCiudadEventSel where clTipoBen = " + strclTipoBen + " order by dsCiudad", "", "", 20, true, false, "CiudadExpDiv")%>
        <%=MyUtil.ObjInput("Experiencia / Acceso / Evento", "dsEventoSelect", EVT != null ? EVT.getDsEventoSelect() : "", true, true, 390, 80, "", true, false, 35)%>
        <%=MyUtil.ObjInput("Fecha Alta", "fechaRegistro", EVT != null ? EVT.getFechaAlta() : "", true, false, 610, 80, "", false, false, 22, "")%>
        <%=MyUtil.ObjInput("Fecha Inicio (aaaa-mm-dd)", "fechaini", EVT != null ? EVT.getFechaini() : "", true, true, 30, 130, "", true, false, 23, "fnFechai(this.value)")%>
        <%=MyUtil.ObjInput("Fecha Fin (aaaa-mm-dd)", "fechafin", EVT != null ? EVT.getFechafin() : "", true, true, 240, 130, "", true, false, 23, "fnFechaf(this.value)")%>
        <%=MyUtil.ObjChkBox("Activo", "Activo", EVT != null ? EVT.getActivo() : "", false, true, 430, 130, "1", "SI", "NO", "fnInactiva()")%>
        <%=MyUtil.ObjInput("Fecha Inactivacion", "fechaInactivacion", EVT != null ? EVT.getFechaInactivacion() : "", true, true, 540, 130, "", false, false, 23, "")%>
        <%=MyUtil.ObjChkBox("Limite de Localidades", "limiteLocalidades", EVT != null ? EVT.getLimiteLocalidades() : "", true, false, 160, 180, "0", "SI", "NO", "habilitaItem();")%>
        <%=MyUtil.ObjInput("Cantidad inicial", "localidades", EVT != null ? EVT.getNumExp() : "", true, false, 360, 180, "", false, false, 5, "")%>
        <%=MyUtil.ObjInput("Cantidad disponible", "disponibles", EVT != null ? EVT.getExpDisponibles() : "", true, false, 510, 180, "", false, false, 5, "")%>
        <%=MyUtil.DoBlock("Detalle Evento Select", -45, 0)%>
        

        <%=MyUtil.GeneraScripts()%>
        <script type="text/javascript" >
            document.all.fechaini.maxLength=8;
            document.all.fechafin.maxLength=8;

            function fnDeshabilita(){
                document.all.localidades.disabled = true;
                document.all.disponibles.disabled = true;
                document.all.btnCambio.disabled=true;
                //document.all.fechaini.disabled = true;
                //document.all.fechafin.disabled = true;

                //if(document.all.activo.value == "1"){
                if(document.all.clEventoSelect.value != "0"){
                    document.all.btnCambio.disabled=false;       
                }
            }

            /*function fnLlenaCiudadExpAjax(value){
                IDCombo= 'clCiudad';
                Label='Ciudad';
                IdDiv='CiudadExpDiv';
                FnCombo=''
                URL = "../servlet/Combos.LlenaCiudadExpCS?";
                Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }*/

             function fnLlenaCiudadExpAjax(value){
                IDCombo= 'clCiudad';
                Label='Ciudad';
                IdDiv='CiudadExpDiv';
                FnCombo=''
                URL = "../servlet/Utilerias.LlenaCombosAjax?";
                var strConsulta = "st_GetCiudadEV '" + document.all.clTipoBen.value + "'";
                var Cadena = "strSQL="+ strConsulta+ "&strName=clCiudadC";
                Cadena += "&Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnFechai(fval){                
               if(/^([0-9])*$/.test(fval)){
                   //alert("OK !! " + fval.substring(0, fval.length - 4) + "-" + fval.substring(4, fval.length - 2) + "-" + fval.substring(6, fval.length) + " 00:00:00")
                   document.all.fechaini.value = fval.substring(0,4) + "-" + fval.substring(4,6) + "-" + fval.substring(6,8) + " 00:00:00"
                }else{
                    alert("El campo debe contener solo dígitos")
                    document.all.fechaini.value = '';
                }
            }
            
            function fnFechaf(fval){
              if(/^([0-9])*$/.test(fval)){                   
                   document.all.fechafin.value = fval.substring(0,4) + "-" + fval.substring(4,6) + "-" + fval.substring(6,8) + " 23:59:59"
                }else{
                    alert("El campo debe contener solo dígitos")
                    document.all.fechafin.value = '';
                }
            }           

            function habilitaItem(){
                //alert("valor check " + document.all.limiteLocalidades.value.toString())                
                if(document.all.limiteLocalidades.value != "0"){
                    document.all.localidades.disabled = false;
                    document.all.disponibles.disabled = false;                    
                }else{
                    document.all.localidades.disabled = true;
                    document.all.localidades.value = '';
                    document.all.disponibles.disabled = true;
                    document.all.disponibles.value = '';
                }
            }

            function fnAccionesAlta(){
                //document.all.fechaini.disabled = false;
                //document.all.fechafin.disabled = false;

                if (document.all.Action.value==1){
                    var pstrCadena = "../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');                    
                }               

            }
            
            function fnGuardar(){
                if(document.all.limiteLocalidades.value != "0"){
                    if( document.all.localidades.value == ""){
                        if(msgVal == "")
                            msgVal+="Dede ingresar No. Evento."
                        else
                            msgVal+="  No. Evento.";
                    }

                    if( document.all.disponibles.value == ""){
                        if(msgVal == "")
                            msgVal+="Dede ingresar Evento Disponible."
                        else
                            msgVal+="  Evento Disponible.";
                    }
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
            }

            function fnInactiva(){ 
                if (document.all.Activo.value == "0"){
                    var pstrCadena = "../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
                }else if (document.all.Activo.value == "1"){
                    document.all.fechaInactivacion.value = '';
                }
            }

            function fnActualizaFechaActual(pFecha){
                if (document.all.Action.value==1){
                    document.all.fechaRegistro.value = pFecha;
                }
                
                if((document.all.Action.value==2) && (document.all.Activo.value == "0")){
                    document.all.fechaInactivacion.value = pFecha;
                }
            }        
        </script>
        <%
            StrclEventoSelect = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;
            strclTipoBen = null;
            daoEvnt = null;
            EVT = null;
        %>
    </body>
</html>