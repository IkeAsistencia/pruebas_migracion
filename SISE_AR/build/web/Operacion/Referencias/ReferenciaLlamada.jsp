<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Referencia Llamada</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilAuto.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");
            String StrclExpediente = "0";
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "0";
            String StrFecha = "";
            String StrclReferenciaLlamada = "0";
            String StrclAfiliado = "0";
            String strclTipoVal = "0";
            String strclTipoValida = "0";
            String StrclCuenta = "0";
            String StrclCuentaS = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario
        <%
                return;
            }

            if (request.getParameter("clReferenciaLlamada") != null) {
                StrclReferenciaLlamada = request.getParameter("clReferenciaLlamada").toString();
            } else {
                if (session.getAttribute("clReferenciaLlamada") != null) {
                    StrclReferenciaLlamada = session.getAttribute("clReferenciaLlamada").toString();
                }
            }
            session.setAttribute("clReferenciaLlamada", StrclReferenciaLlamada);

            StringBuffer StrSql = new StringBuffer();

            StrSql.append(" Select ");
            StrSql.append(" coalesce(RL.clCuenta,0) as clCuenta,");
            StrSql.append(" coalesce(RL.clReferenciaLlamada,0) as clReferenciaLlamada,");
            StrSql.append(" coalesce(RL.clUsrApp,0) as clUsrApp,");
            StrSql.append(" coalesce(E.dsEstatus,'') as dsEstatus,");
            StrSql.append(" coalesce(RL.NuestroUsuario,'') as NuestroUsuario,");
            StrSql.append(" coalesce(RL.QuienLlama,'') as QuienLlama,");
            StrSql.append(" coalesce(convert(varchar(16),RL.FechaLlamada,120),'') as FechaLlamada,");
            StrSql.append(" coalesce(C.Nombre,'') as Nombre,");
            StrSql.append(" coalesce(RL.Clave,'') as Clave,");
            StrSql.append(" coalesce(RL.LadaLoc,'') as LadaLoc,");
            StrSql.append(" coalesce(RL.TelefonoLoc,'') as TelefonoLoc,");
            StrSql.append(" coalesce(RL.clCuenta,0) as clCuenta,");
            StrSql.append(" coalesce(RL.clAfiliado,0) as clAfiliado");
            StrSql.append(" From ReferenciaLlamada RL");
            StrSql.append(" Inner join cEstatus E on (E.clEstatus=RL.clEstatus)");
            StrSql.append(" Inner join cCuenta C on (C.clCuenta=RL.clCuenta)");
            StrSql.append(" Where RL.clReferenciaLlamada =").append(StrclReferenciaLlamada);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
        %>
        <script>fnOpenLinks()</script>
        <%
            StrclPaginaWeb = "391";
            MyUtil.InicializaParametrosC(391, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion", "")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ReferenciaLlamada.jsp?'>"%>
        <%
            if (rs.next()) {
                StrclCuenta = rs.getString("clCuenta");
                if (StrclCuenta == null) {
                    StrclCuenta = "";
                }

                if (StrclCuenta != null) {
                    StrclCuentaS = StrclCuenta.toString();
                }
                session.setAttribute("clCuenta", StrclCuentaS);
        %>
        <script>document.all.btnElimina.disabled = true;</script>

        <INPUT id='clReferenciaLlamada' name='clReferenciaLlamada' type='hidden' value='<%=StrclReferenciaLlamada%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
        <INPUT id='clAfiliado' name='clAfiliado' type='hidden' value='<%=StrclAfiliado%>'>
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=StrclPaginaWeb%>'>

        <%=MyUtil.ObjComboC("Estatus", "clEstatus", rs.getString("dsEstatus"), true, true, 30, 70, "", "Select clEstatus,dsEstatus from cestatus where clEstatus in (0,10,29)", "", "", 50, true, true)%>
        <%//out.println(MyUtil.ObjInput("Nuestro Usuario","NuestroUsuario","",true,true,200,70,"",true,true,40));%>
        <%=MyUtil.ObjInput("Nuestro Usuario", "NuestroUsuario", rs.getString("NuestroUsuario"), true, true, 200, 70, "", true, true, 40, "if(this.readOnly==false){fnBuscaClienteVIP()}")%>
        <%if (MyUtil.blnAccess[4] == true) {
                out.println("<div class='VTable' style='position:absolute; z-index:25; left:430px; top:80px;'>");
                out.println("<IMG SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaAfiliado();' WIDTH=20 HEIGHT=20></div>");
                }%>
        <%=MyUtil.ObjInput("Quien Llama", "QuienLlama", rs.getString("QuienLlama"), true, true, 500, 70, "", true, true, 40)%>
        <%=MyUtil.ObjInput("Fecha de Llamada<br>AAAA/MM/DD HH:MM", "FechaLlamadaVTR", rs.getString("FechaLlamada"), false, false, 30, 120, "", false, false, 20)%>
        <%//out.println(MyUtil.ObjInput("Cuenta","clCuenta","",true,true,200,130,"",true,true,30));%>
        <%=MyUtil.ObjInput("Cuenta", "Nombre", rs.getString("Nombre"), true, false, 200, 130, "", true, true, 40, "if(this.readOnly==false){fnBuscaCuenta();}")%>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuentaS%>'>
        <%  if (MyUtil.blnAccess[4] == true) {
                out.println("<div class='VTable' style='position:absolute; z-index:25; left:430px; top:140px;'>");
                out.println("<IMG SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>");
                    }%>
        <%=MyUtil.ObjInput("Clave", "Clave", rs.getString("Clave"), true, false, 500, 130, "", true, true, 30, "if(this.readOnly==false){if (fnValMask(this,document.all.ClaveMsk.value,this.name)){//fnBuscaClave();}}")%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada"), "LadaLoc", rs.getString("LadaLoc"), true, true, 30, 180, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Telefono Localizacion", "TelefonoLoc", rs.getString("TelefonoLoc"), true, true, 100, 180, "", false, false, 20)%>
        <%
        } else {
        %>
        <script>document.all.btnCambio.disabled = true;
                document.all.btnElimina.disabled = true;</script>

        <INPUT id='clReferenciaLlamada' name='clReferenciaLlamada' type='text' value='<%=StrclReferenciaLlamada%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='text' value='<%=StrclUsrApp%>'>
        <INPUT id='clAfiliado' name='clAfiliado' type='text' value='<%=StrclAfiliado%>'>
        <INPUT id='StrclPaginaWeb' name='StrclPaginaWeb' type='text' value='<%=StrclPaginaWeb%>'>

        <%=MyUtil.ObjComboC("Estatus", "clEstatus", "", true, true, 30, 70, "", "Select clEstatus,dsEstatus from cestatus where clEstatus in (0,10,29)", "", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Nuestro Usuario", "NuestroUsuario", "", true, true, 200, 70, "", true, true, 40, "if(this.readOnly==false){fnBuscaClienteVIP()}")%>
        <% if (MyUtil.blnAccess[4] == true) {
                out.println("<div class='VTable' style='position:absolute; z-index:25; left:430px; top:80px;'>");
                out.println("<IMG SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaAfiliado();' WIDTH=20 HEIGHT=20></div>");
                   }%>
        <%=MyUtil.ObjInput("Quien Llama", "QuienLlama", "", true, true, 500, 70, "", true, true, 40)%>
        <%=MyUtil.ObjInput("Fecha de Llamada<br>AAAA/MM/DD HH:MM", "FechaLlamadaVTR", "", false, false, 30, 120, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Cuenta", "Nombre", "", true, false, 200, 130, "", true, true, 40, "if(this.readOnly==false){fnBuscaCuenta();}")%>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value=''>
        <%
            if (MyUtil.blnAccess[4] == true) {
                out.println("<div class='VTable' style='position:absolute; z-index:25; left:430px; top:140px;'>");
                out.println("<IMG SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>");
            }%>
        <%=MyUtil.ObjInput("Clave", "Clave", "", true, false, 500, 130, "", true, true, 30, "if(this.readOnly==false){if (fnValMask(this,document.all.ClaveMsk.value,this.name)){//fnBuscaClave();}}")%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada"), "LadaLoc", "", true, true, 30, 180, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Telefono Localizacion", "TelefonoLoc", "", true, true, 100, 180, "", false, false, 20)%>
        <%
                }%>         
        <%=MyUtil.DoBlock("Llamada por Referencia", 100, 0)%>
        <%=MyUtil.GeneraScripts()%>

        <p class='FTable' readonly name='ClaveMskUsr' id='ClaveMskUsr'></p></div>

    <input name='ClaveMsk' id='ClaveMsk' type='hidden' value=''>
    <script>
        function fnBuscaClienteVIP() {
            if (document.all.NuestroUsuario.value != '') {
                var pstrCadena = "../BuscaClienteVIP.jsp?strSQL=sp_BuscaClienteVIP";
                pstrCadena = pstrCadena + "&Nombre=" + document.all.NuestroUsuario.value;
                window.open(pstrCadena, 'newVIP', 'scrollbars=yes,status=yes,width=0,height=0');
            }
        }

        function fnSubmitOK(pclUsr, pMotivo) {
            document.all.clUsrAppAut.value = pclUsr;
            document.all.MotivoAut.value = pMotivo;
            document.all.forma.action = "../../servlet/Utilerias.EjecutaAccion";
            document.all.forma.submit();
        }

        function fnAccionesAlta() {

            document.all.clUsrApp.value =<%=session.getAttribute("clUsrApp")%>;

            top.document.all.rightPO.rows = "0,*";
            document.all.forma.action = "../../servlet/Utilerias.ValidaCondNU";
            if (document.all.Action.value == 1) {
                document.all.CodMD.value = "";
                document.all.CodEnt.value = "";
                document.all.clCuenta.value = "";
            }
        }

        function fnBuscaCuenta() {
            if (document.all.Nombre.value != '') {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                    pstrCadena = pstrCadena + "&Cuenta= " + document.all.Nombre.value;
                    document.all.clCuenta.value = '';
                    window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                }
            }
        }

        function fnBuscaClave() {
//        if (document.all.NuestroUsuario.value==''){

            if (document.all.Nombre.value != '') {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Utilerias/FiltrosClave.jsp?strSQL=sp_WebBuscaClaveGpo ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clCuenta= " + document.all.clCuenta.value;

                    //pstrCadena = pstrCadena + "&clCuenta= " + document.all.clCuenta.value;
                    //document.all.Nombre.value='';
                    window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=500,height=500');
                }

            } else {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Utilerias/FiltrosClave.jsp?strSQL=sp_WebBuscaClave ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value;
                    //document.all.Nombre.value='';
                    window.open(pstrCadena, 'newWin2', 'scrollbars=yes,status=yes,width=500,height=500');
                }
            }
//        } //Fin del if NuestroUsuario
        }


        function fnActualizaDatosClave(clCuenta, Nombre, Prefijo) {
            document.all.Nombre.value = Nombre;
            document.all.clCuenta.value = clCuenta;
            document.all.Clave.value = Prefijo;

        }

        function fnActualizaDatosCuenta(dsCuenta, clCuenta, clTipoVal, Msk, MskUsr, Agentes) {
            document.all.Nombre.value = dsCuenta;
            document.all.clCuenta.value = clCuenta;
            document.all.ClaveMsk.value = Msk;
            document.all.ClaveMskUsr.innerHTML = MskUsr;
            strclTipoVal = clTipoVal;
            /*	if (Agentes>0){
             document.all.D20.style.visibility='visible';
             }else{
             document.all.D20.style.visibility='hidden';
             }*/
        }

        function fnActualizaDatosNuestroUsr(dsNU, Clave, pclCuenta, pNomCuenta, Msk, MskUsr) {
            document.all.NuestroUsuario.value = dsNU;
            document.all.Clave.value = Clave;
            document.all.clCuenta.value = pclCuenta;
            document.all.Nombre.value = pNomCuenta;
            document.all.ClaveMsk.value = Msk;
            document.all.ClaveMskUsr.innerHTML = MskUsr;
        }

        function fnValidaClave(clave) {
            if (document.all.Action.value == 1) {
                var pstrCadena = "../Operacion/ValidaClave.jsp?strSQL=sp_ValidaClave ";
                pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value;
                window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
            }
        }


        function fnBuscaAfiliado() {
            if (document.all.Action.value == 1) {
                //if(document.all.clCuenta.value!=""){
                var pstrCadena = "../../Utilerias/FiltrosNuestroUsr.jsp?strSQL=sp_WebBuscaNuestroUsr ";
                pstrCadena = pstrCadena + "&NU= " + document.all.NuestroUsuario.value + "&clCuenta= " + document.all.clCuenta.value;
                window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                /*	 }else{
                 alert('Debe informar primero la cuenta');
                 }*/
            }
        }
    </script>
</body>
</html>